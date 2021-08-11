	
	
// Data for subnetwork
data "google_compute_subnetwork" "cluster_subnet" {
  name    = var.subnetwork
  project = var.network_project_id
  region  = var.region
}
// Generate the IP for API proxy
resource "google_compute_address" "api-proxy-ip" {
  name         = "${var.cluster_name}-ip-address"
  project      = var.cluster_project_id
  subnetwork   = data.google_compute_subnetwork.cluster_subnet.self_link
  address_type = "INTERNAL"
  region       = var.region
}

resource "google_compute_disk" "boot_partition" {
  name                      = "${var.cluster_name}-gce-boot"
  type                      = "pd-ssd"
  zone                      = var.zone
  physical_block_size_bytes = 4096
  image                     = local.gce_image
  size                      = 100
  labels                    = local.labels
  project                   = var.cluster_project_id
}

resource "google_compute_instance" "default" {
  count                     = var.enable_bastion_host ? 1 : 0
  project                   = var.cluster_project_id
  name                      = "${var.cluster_name}-gce"
  machine_type              = "n1-standard-1"
  zone                      = var.zone
  allow_stopping_for_update = "true"
  tags                      = ["ssh", "${format("%s", element(split("-", var.zone), 0))}${format("%s", element(split("-", var.zone), 1))}-route"]

  metadata_startup_script = data.template_file.startup_script.rendered

  boot_disk {
    source = google_compute_disk.boot_partition.self_link
  }
  
  network_interface {
    subnetwork         = var.compute_subnetwork
    subnetwork_project = var.network_project_id
  }
  service_account {
    email = google_service_account.cluster_admin.*.email[0]
    scopes = [
      "compute-rw",
      "cloud-platform",
      "storage-rw",
      "userinfo-email",
    ]
  }

  labels = local.labels

  depends_on = [
    google_compute_address.api-proxy-ip,
    data.template_file.startup_script,
    google_service_account.cluster_admin
  ]
}


—————————————————

locals {
  labels = merge(var.labels, {
    terraform_module_version = "v1-8-0"
    terraform_module_git     = "github_com_equifax_7265_gl_gke_iaas"
    provisioned_by           = "terraform"
  })

  gce_images = {
    fedramp-npe = "sec-dvop-fr-crt-npe-43bb/efx-fr-centos-7"
    fedramp     = "sec-img-fr-prd-7b82/efx-fr-centos-7"
    no-fedramp  = "sec-eng-images-prd-5d4d/efx-centos-7"
  }
  gce_image = local.gce_images[var.vpcControlsBoundary]
}

———————————————————

// Render the deployment yaml file for API proxy setup
data "template_file" "api-proxy-deployment" {
  template = file("${path.module}/k8s_templates/api-proxy-deployment.yaml")

  vars = {
    k8s_api_proxy_image = "gcr.io/iaas-gcr-reg-prd-ad3d/golden/iaas/k8s-api-proxy"
    k8s_api_proxy_tag   = "1.0-alpine"
  }
}

data "template_file" "api-proxy-service" {
  template = file("${path.module}/k8s_templates/api-proxy-service.yaml")
  vars = {
    internal_loadbalancer_ip = google_compute_address.api-proxy-ip.address
  }
}

data "template_file" "pod_security_policy_yaml" {
  template = file("${path.module}/k8s_templates/psp-restricted.yaml")
}

data "template_file" "ip_masq_agent_yaml" {
  template = file("${path.module}/k8s_templates/ip-masq-agent.yaml")
}

data "template_file" "startup_script" {
  template = file("${path.module}/scripts/cluster-admin-startup.sh")

  vars = {
    cluster_name                 = var.cluster_name
    region                       = var.region
    project                      = var.cluster_project_id
    deployment_yaml              = data.template_file.api-proxy-deployment.rendered
    service_yaml                 = data.template_file.api-proxy-service.rendered
    pod_security_policy_yaml     = data.template_file.pod_security_policy_yaml.rendered
    istio_enable_namespace_set   = join(",", var.istio_enable_namespace_set)
    istio_disabled_namespace_set = join(",", var.istio_disabled_namespace_set)
    // TODO improve this step by getting the values form *data.google_compute_subnetwork.cluster_subnet.secondary_ip_range*
    non_masquerade_cidrs     = join(",", var.non_masquerade_cidrs)
    ip_masq_agent_yaml       = data.template_file.ip_masq_agent_yaml.rendered
    internal_loadbalancer_ip = google_compute_address.api-proxy-ip.address
  }
}

————————————————————————————————

variable "enable_bastion_host" {
  default = true
  type    = bool
}

variable "cluster_name" {
  description = ""
}

variable "cluster_project_id" {
  description = "The project ID to host the cluster in (required)"
}

variable "compute_subnetwork" {
}

variable "subnetwork" {
}

variable "region" {
  description = "The region to host the cluster in (required)"
}

variable "zone" {
}

variable "network_project_id" {
  description = "The project ID for the network"
}

variable "istio_enable_namespace_set" {
  type = list(string)
}

variable "istio_disabled_namespace_set" {
  type = list(string)
}

variable "non_masquerade_cidrs" {
  type = list
}

variable "labels" {
}

variable "vpcControlsBoundary" {
  default     = "no-fedramp"
  description = "Possible values 'no-fedramp' , 'fedramp', 'fedramp-npe'. Default 'no-fedramp' "
  type        = string
}

——————————————————————————————————

# ssh to VM and run this to debug
# sudo google_metadata_script_runner --script-type startup --debug

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.17.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/bin/kubectl
# Configure cluster
export KUBECONFIG="~/.kube/config"
gcloud container clusters get-credentials ${cluster_name} --region ${region} --project ${project}
export cluster_admin_user=$(gcloud config get-value account)
echo $cluster_admin_user
# Apply kubectl for API proxy
kubectl get clusterrolebinding bastion-sa-admin-binding &> /dev/null || kubectl create clusterrolebinding bastion-sa-admin-binding --clusterrole cluster-admin --user $cluster_admin_user
echo "${deployment_yaml}" > k8s_api_proxy_deployment.yaml
echo "${service_yaml}" > k8s_api_proxy_service.yaml
echo "${pod_security_policy_yaml}" > psp.yaml
echo "${ip_masq_agent_yaml}" > ip-masq-agent.yaml

# Apply policy for pod security and api-proxy
kubectl create namespace api-proxy

kubectl apply -f psp.yaml
kubectl apply -f k8s_api_proxy_deployment.yaml -n api-proxy
kubectl apply -f k8s_api_proxy_service.yaml -n api-proxy

#Wait for api-proxy to be up and allow cross region access to it
while [ $(curl -I --write-out %%{http_code} -m 4 -s -o /dev/null http://${internal_loadbalancer_ip}:8443) != 400 ]; do
  sleep 5;
done
FORWARDING_RULE_NAME=$(gcloud compute forwarding-rules list --filter="IP_ADDRESS='${internal_loadbalancer_ip}'" | tail -1 | cut -d ' ' -f 1 )
gcloud compute forwarding-rules update $FORWARDING_RULE_NAME --allow-global-access --region=${region}

# Adding ip-masq-agent configMap
sed -i "s|NONMASQUERADECIDRS|${non_masquerade_cidrs}|g" ip-masq-agent.yaml
kubectl delete configmap ip-masq-agent -n kube-system
kubectl apply -f ip-masq-agent.yaml

————————————————

resource "google_service_account" "cluster_admin" {
  count        = var.enable_bastion_host ? 1 : 0
  account_id   = "${var.cluster_name}-gce"
  display_name = "${var.cluster_name} - Bastion host"
  project      = var.cluster_project_id
}

resource "google_project_iam_member" "cluster_admin_container_admin" {
  count      = var.enable_bastion_host ? 1 : 0
  project    = var.cluster_project_id
  role       = "organizations/552306434765/roles/efx.gkeClusterAdmin"
  member     = "serviceAccount:${google_service_account.cluster_admin.*.email[0]}"
  depends_on = [google_service_account.cluster_admin]
}

resource "google_project_iam_member" "cluster_admin_container_viewer" {
  count      = var.enable_bastion_host ? 1 : 0
  project    = var.cluster_project_id
  role       = "organizations/552306434765/roles/efx.gkeViewer"
  member     = "serviceAccount:${google_service_account.cluster_admin.*.email[0]}"
  depends_on = [google_service_account.cluster_admin]
}

resource "google_project_iam_member" "loadbalancer_admin" {
  count      = var.enable_bastion_host ? 1 : 0
  project    = var.cluster_project_id
  role       = "organizations/552306434765/roles/efx.loadBalancerAdmin"
  member     = "serviceAccount:${google_service_account.cluster_admin.*.email[0]}"
  depends_on = [google_service_account.cluster_admin]
}

————————————————
output "gke_cluster_endpoint_api_proxy" {
  description = "GKE Cluster API proxy to access actual endpoint"
  value       = "http://${google_compute_address.api-proxy-ip.address}:8443"
}

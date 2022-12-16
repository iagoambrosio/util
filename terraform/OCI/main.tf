#Criação de uma máquina AMPERE A1 com 24 Gb na região selecionada com um disco de 100 GB de boot
provider "oci" {
region = var.region
tenancy_ocid = var.tenancy_ocid
user_ocid = var.user_ocid
private_key_path = var.private_key_path
fingerprint = var.fingerprint
}

resource "oci_core_instance" "generated_oci_core_instance" {
	agent_config {
		is_management_disabled = "false"
		is_monitoring_disabled = "false"
		plugins_config {
			desired_state = "DISABLED"
			name = "Vulnerability Scanning"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Bastion"
		}
	}
	availability_config {
		recovery_action = "RESTORE_INSTANCE"
	}
	availability_domain = "FNdp:SA-SAOPAULO-1-AD-1"
	compartment_id = var.tenancy_ocid
	create_vnic_details {
		assign_private_dns_record = "true"
		assign_public_ip = "true"
		subnet_id = var.subnet_ocid
	}
	display_name = "maquina-arm"
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	is_pv_encryption_in_transit_enabled = "true"
	metadata = {
		"ssh_authorized_keys" = var.sshchave
	}
	shape = "VM.Standard.A1.Flex"
	shape_config {
		memory_in_gbs = "24"
		ocpus = "4"
	}
	source_details {
		boot_volume_size_in_gbs = "100"
		boot_volume_vpus_per_gb = "10"
		source_id = "ocid1.image.oc1.sa-saopaulo-1.aaaaaaaa6enqtds2brgrjophs2oce74ez7bas5kmwb473fbzl7qhdhoca5iq"
		source_type = "image"
	}
}
#resource "oci_core_virtual_network" "vcn1" {
#  cidr_block = "10.0.0.0/24"
#  dns_label = "vcn1"
#  compartment_id = ""
#  display_name = "vcn1"
#}
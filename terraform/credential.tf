variable "user_ocid" {
default = "ocid1.user.oc1..<Seu oc id da plataforma, está em configurações>"
}
variable "tenancy_ocid" {
default = "ocid1.tenancy.oc1..<O oc id da sua tenancy>"
}
variable "private_key_path" {
default = "./<o caminho da sua chave privada>"
}
variable "fingerprint" {
default = "<sua chave de api, é uma sequencia hexadecimal>"
}
variable "region"{
default = "sa-saopaulo-1"
}
variable "sshchave" {
default = "ssh-rsa shdkfhb23lo4h2q98ru8sa9fjo42358423u85u815u2 uma chave ssh publica na qual você tenha a chave privada de par"  
}
variable "subnet_ocid " {
defadefault = "ocid1.subnet.oc1.sa-saopaulo-1....<o ocid da sua subnet se já tiver sido criada>"  
}
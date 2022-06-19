output "instance-ip" {
    description = "IP de EC2_TFG"
    value = "${aws_instance.TFG.public_ip}"
}

output "instance-dns" {
    description = "DNS de EC2_TFG"
    value = "${aws_instance.TFG.public_dns}"
}
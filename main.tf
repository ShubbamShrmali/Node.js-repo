provider "aws" {
    region = var.aws_region   
    profile = var.ec2_profile
}



resource "aws_instance" "jenkins-docker" {
    ami = var.ec2_ami
    count = var.ec2_count
    key_name   = var.key_name
    instance_type = var.instance_type
    security_groups = ["${var.ec2_sg}"]
    subnet_id = element(var.ec2_subnet_id, count.index) #element(list, index)
    tags = {
        Name = "${var.ec2_tags[0]}"
    } 
    user_data = file("docker-jenkins.sh")

}

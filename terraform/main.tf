data "aws_ami" "application_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["packer-demo-*"]
  }

  owners = ["self"]
}

resource "aws_instance" "app" {
  ami           = "${data.aws_ami.application_ami.id}"
  instance_type = "t2.micro"

  tags {
    Name      = "HelloWorld"
    CreatedOn = "${timestamp()}"
  }
}

output "address" {
  value = "${aws_instance.app.public_dns}"
}

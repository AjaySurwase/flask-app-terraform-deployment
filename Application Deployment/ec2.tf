resource "aws_instance" "server" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = "Flask"
  vpc_security_group_ids      = [aws_security_group.webSg.id]
  subnet_id                   = aws_subnet.sub1.id
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/ajays/Downloads/Flask.pem") # Path to your private key (PEM)
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "../Flask Application/app.py"
    destination = "/home/ubuntu/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /home/ubuntu/templates", # Ensure templates folder exists
    ]
  }

  provisioner "file" {
    source      = "../Flask Application/templates/index.html"
    destination = "/home/ubuntu/templates/index.html"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt-get install -y python3-pip",
      "cd /home/ubuntu",
      "sudo pip3 install flask",
      "nohup sudo python3 app.py &"
    ]
  }
}

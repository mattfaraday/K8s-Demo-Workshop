resource "aws_instance" "davidluke-worker-node-1" {
  ami                         = data.aws_ami.k8s-base-machine.id # eu-west-2
  instance_type               = "t2.medium"
  key_name                    = "k8s-server-key-davidluke"
  associate_public_ip_address = true
  security_groups             = [aws_security_group.nginx-web-facing.id]
  subnet_id                   = aws_subnet.main.id
  private_ip                  = "10.0.0.40"



  tags = {
    Name = "davidluke-worker-node-1"
  }
}

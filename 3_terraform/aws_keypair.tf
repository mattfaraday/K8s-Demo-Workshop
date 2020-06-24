resource "aws_key_pair" "controller-davidluke" {
  key_name   = "k8s-server-key-davidluke"
  public_key = file ("~/.ssh/k8s-key.pub")
}

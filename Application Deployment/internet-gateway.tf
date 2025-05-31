resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id

  depends_on = [aws_vpc.myvpc]
}

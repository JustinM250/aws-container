

# 18.1. AMI (refer to the AMI variable you created earlier)
# 18.2. Associate Public IP: true
# 18.3. AZ
# 18.4. IAM instance profile (refer to the instance profile variable you created earlier)
# 18.5. Instance type
# 18.6. Key name
# 18.7. Subnet ID (use a reference)
# 18.8. VPC Security Group ID (use a reference)
# 18.9. Tags 
# 18.10. User data (use the file function and the path.module value to refer to your user_data.sh file)

resource "aws_instance" "the_ec2_instance"{
    ami = var.ami_id
    associate_public_ip_address = true
    availability_zone = "us-east-1a"
    instance_type = "t3.micro"
    key_name = "xpix-keypair"
    subnet_id = aws_subnet.XPIX-subnet-public1-us-east-1a.id
    vpc_security_group_ids = [aws_security_group.xpix-app-server.id]    
    tags = {
        Name = "xpix-app-server"
        
    }
    user_data = file("${path.module}/user_data.sh") #path.module.user_data # "infra/user_data.sh"
}

import {
  to = aws_instance.the_ec2_instance
  id = "i-0b05caf8e27913009"
}
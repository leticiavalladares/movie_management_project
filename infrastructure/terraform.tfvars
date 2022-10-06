# ASSIGNING VALUE TO VARIABLES  # "137112412989" # "amzn2-ami-kernel-5.10-hvm*"
aws_owner_id                 = "099720109477"                     
aws_ami_name                 = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20220912"

# IPs
aws_vpc_cidr_block           = "10.0.0.0/16"
aws_priv_subnet_cidr_block_1 = "10.0.2.0/24"
aws_priv_subnet_cidr_block_2 = "10.0.3.0/24"
aws_pub_subnet_cidr_block    = "10.0.1.0/24"

aws_ec2_type                 = "t3.medium"
my_keypair                   = "talent-academy-myec2"
my_local_pub_ip              = "178.5.235.6/32"

db_name                      = "movie_db"
db_engine                    = "mysql"
db_engine_version            = "8.0.30"
db_instance_class            = "db.t2.small"
db_username                  = "root"
db_storage                   = 10
db_skip_last_snapshot        = true
                                   
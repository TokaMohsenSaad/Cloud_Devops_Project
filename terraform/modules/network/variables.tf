variable az_count {
    description = "number of required availability zones"
    type = number
    default = 1
    validation{
        condition = var.az_count > 0 && var.az_count <= length(data.aws_availability_zones.current.names)
        error_message = "number of availability zones must be greater than zero and less than ${length(data.aws_availability_zones.current.names)}"
    }
}

variable vpc_cidr {
    description = "VPC cidr block"
    type = string 
    default = "10.0.0.0/16"
}
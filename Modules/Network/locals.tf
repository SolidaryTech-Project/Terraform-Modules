locals {
  subnets_indexed = {
    for i, key in keys(var.subnets) :
    key => merge(var.subnets[key], { index = i })
  }

  public_subnets = {
    for key, subnet in var.subnets :
    key => subnet
    if subnet.type == "public"
  }

  private_subnets = {
    for key, subnet in var.subnets :
    key => subnet
    if subnet.type == "private"
  }

  public_subnet_by_az = {
    for key, subnet in var.subnets :
    subnet.az => key
    if subnet.type == "public"
  }
}

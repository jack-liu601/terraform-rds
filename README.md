## Objective:
Create a RDS instance and related resources using terraform for an application that’s deployed in the EKS cluster.

## Background: 
Assumptions: <br />
VPCS: <br />
&nbsp; EKS Cluster VPC (k8s 10.2.0.0/16) <br />
&nbsp; RDS Cluster VPC (Data 10.5.0.0/16) <br />
Consider both the above VPCs in the same network.<br />

Application assumes the following IAM role:<br />
&nbsp; arn:aws:iam::123456789101:role/application/example-app.<br />

### Task: Create a production grade terraform stack which creates the following:
1. AWS RDS Instance:<br />
      - Features required:<br />
              * Consider any compatible instance type<br />
              * Min 13000 IOPS required. (Use cost effective
method in choosing IOPS)<br />
              * Enable IAM authentication and grant required
permissions to the application to connect. <br />
3. AWS subnet group<br />
4. AWS security group with rules which allows secure connection
from the application. <br />
5. AWS RDS custom parameter group which takes some custom
parameters. <br />
   Example:<br />
   statement_timeout: 3600000 <br />
   rds.log_retention_period: 1440 <br />


### Own Assumptions: 
1. RDS VPC & EKS VPC has already been created with a VPC ID given the brief included VPC CIDRs a;already<br/>
Similarly given that VPC has already been created an min. of 1 subnet would exist already. <br /> 
Therefore the focus will be on creating & deploying a RDS instance & related resources using terraform for an EKS application instead of VPC networking.

2. Given that brief states that "Application assumes the following IAM role: arn:aws:iam::123456789101:role/application/example-app" Therefore the assumptions is that an IAM role of application/example-app has already been created.

3. Given that RDS Prod DB has yet to be created. In order to allow application to access the DB via IAM authentication and DB user will need to be created after RDS creation.



### How to Deploy 
#### Pre-requisite: 
Based on the brief there are 3 required variables in order to successfully deploy this terraform stack:. 
1. rds_vpc_id
2. rds_subnet_ids
3. app_role_name

A preferred method of deployment will be by creating an .tfvars file for a easy smooth deployment 

```
Example prod.tfvars file 

rds_vpc_id = "<RDS VPC ID>"

rds_subnet_ids = ["<subnet-id>", or "<subnet-ids>]

app_role_name = "<EKS role name>"
```

Once an .tfvars file has been created you can look to deployed required prod rds stack with the following command:
```
terraform apply -var-file="prod.tfvars" 
```






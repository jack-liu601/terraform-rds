## Background: 
Assumptions: <br />
VPCS: <br />
EKS Cluster VPC (k8s 10.2.0.0/16) <br />
RDS Cluster VPC (Data 10.5.0.0/16) <br />
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


### Pre-assumptions: 
1. 
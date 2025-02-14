## Task: Create a production grade terraform stack which creates the following:

1. AWS RDS Instnace:
      Features required:
      ■ Consider any compatible instance type
      ■ Min 13000 IOPS required. (Use cost effective
        method in choosing IOPS)
      ■ Enable IAM authentication and grant required
        permissions to the application to connect.
3. AWS subnet group
4. AWS security group with rules which allows secure connection
from the application.
5. AWS RDS custom parameter group which takes some custom parameters.
   Example:
   statement_timeout: 3600000
   rds.log_retention_period: 1440

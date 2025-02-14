## Task: Create a production grade terraform stack which creates the following:

1. AWS RDS Instnace:<br />
      - Features required:<br />
              * Consider any compatible instance type<br />
              * Min 13000 IOPS required. (Use cost effective method in choosing IOPS)<br />
              * Enable IAM authentication and grant required ermissions to the application to connect. <br />
3. AWS subnet group <br />
4. AWS security group with rules which allows secure connection from the application. <br />
5. AWS RDS custom parameter group which takes some custom parameters. <br />
   Example:<br />
   statement_timeout: 3600000 <br />
   rds.log_retention_period: 1440 <br />

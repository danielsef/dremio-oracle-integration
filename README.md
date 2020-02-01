# dremio-oracle-integration
Execution docker containers for integration tests

# Execute src/docker-compose.yml file
docker-compose up

Note: 
- use docker-compose stop in order to save modifications in docker volume
- use docker-compose down to remove containers and volume as well

# Database Login from SQL Developer Tool:

- Host: localhost
- Port: 1521
- Sid: xe
- username/password:
  - system/oracle
  - hr/hr
  - dremio/dremio

# Login into the database with system user. Execute src/dremio_if_user.sql script.
     - unlock HR schema
     - Create dremio user, add grants, add tole, add grants to role

# Login into the database with dremio user.
Execute the following query in order to make sure the modifications have been executed:

select * from  all_tables t where t.OWNER not in ('SYS','MDSYS','APEX_040000','SYSTEM','CTXSYS', 'XDB');

Dreamio user has select permission for 3 tables:

  - HR.COUNTRIES
  - HR.DEPARTMENTS
  - HR.EMPLOYEES

# Login into Dremio:

Fill in the sing-up form:

- Name: Anna Milinska
- Username: anna11
- Email: anna11@gmail.com
- Passwords: Milinska11

# After the authentication add new Oracle data source in Dremio:

- Host: database
- Port: 1521
- Sid: xe
- username/password: dremio/dremio

Dremio user can access and query the following 3 tables from HR schema (thanks for the database role and grants):

  - HR.COUNTRIES
  - HR.DEPARTMENTS
  - HR.EMPLOYEES






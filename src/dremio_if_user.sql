--Execute via system user
ALTER USER hr ACCOUNT UNLOCK;
ALTER USER hr IDENTIFIED BY hr;


CREATE USER dremio IDENTIFIED BY dremio
  DEFAULT TABLESPACE users
  TEMPORARY TABLESPACE temp
  QUOTA UNLIMITED ON users;
GRANT CONNECT, RESOURCE TO dremio;
GRANT UNLIMITED TABLESPACE TO dremio;

CREATE ROLE dremio_ro_role;
GRANT SELECT ON HR.COUNTRIES TO dremio_ro_role;
GRANT SELECT ON HR.EMPLOYEES TO dremio_ro_role;
GRANT SELECT ON HR.DEPARTMENTS TO dremio_ro_role;

--TODO: For loop for all relevant tables: add grant select to role

grant dremio_ro_role to dremio;

--Check granted tables
--Execute this query with dremio user:
select * from  all_tables t where t.OWNER not in ('SYS','MDSYS','APEX_040000','SYSTEM','CTXSYS', 'XDB');


--Execute this query with system user:
--Create test table with more than 1M rows
create table hr.EMPLOYEES_EXT as
    select * from hr.EMPLOYEES where 1=0;

begin
for i in 1 .. 10000 loop
  dbms_output.put_line(i);
insert into EMPLOYEES_EXT(    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    HIRE_DATE,
    JOB_ID,
    SALARY,
    COMMISSION_PCT,
    MANAGER_ID,
    DEPARTMENT_ID,
    EXT_ID)
  select     EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    EMAIL,
    PHONE_NUMBER,
    HIRE_DATE,
    JOB_ID,
    SALARY,
    COMMISSION_PCT,
    MANAGER_ID,
    DEPARTMENT_ID,
    i as EXT_ID from EMPLOYEES e;
  commit;
end loop;
end;


GRANT SELECT ON HR.EMPLOYEES_EXT TO dremio_ro_role;
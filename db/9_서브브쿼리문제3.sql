-- ��1.���� �ʰ� �Ի��� ������ �̸��� ����,�μ��̸���?
-- 1.where���� ���������� �־��ٰ�
select max(hire_date)
from employees;

select first_name,salary,d.department_name,salary,e.hire_date
from employees e,departments d
where (hire_date = (select max(hire_date)
                    from employees)
and e.department_id = d.department_id);

-- ��� ������ ���� ���� �μ� �������� ������ȣ,�̸�,��,����,������ ��ȸ�ϱ�
-- �μ��� ��� : A���̺�� ����
select DEPARTMENT_ID,avg(salary) avgsal
from employees
group by DEPARTMENT_ID;

-- (���..)90�� �μ��� �� �����Ƿ� 90�� �μ��� ����鸸 ����
select * from
employees
where department_id = 90;

-- ���������� ���� from���� : B���̺�� ����
select max(avgsal) maxsal
from
    (select DEPARTMENT_ID,avg(salary) avgsal
    from employees
    group by DEPARTMENT_ID);

-- A���̺�� B���̺��� �������� : ������Ǯ��
select  e.employee_id, e.first_name, e.salary
from (select DEPARTMENT_ID,avg(salary) avgsal
        from employees
        group by DEPARTMENT_ID) A,
     (select max(avgsal) maxsal
        from
            (select DEPARTMENT_ID,avg(salary) avgsal
            from employees
            group by DEPARTMENT_ID)) B,
     employees e
where A.avgsal = B.maxsal
and a.department_id = e.department_id;
-- ����
select *
from () A,
     () B
where A.avgsal = B.maxsal
and a.department_id = e.department_id;


-- ��Ǯ�� max(avg(sal)) �����ϴٰ�..
select e.employee_id ���,e.first_name �̸�,e.last_name ��,e.salary �޿�,ea.AVG_SALARY,j.job_title
from jobs j,employees e,(select max(avg(salary)) AVG_SALARY,department_id
                            from employees
                            group by DEPARTMENT_ID) ea
where e.job_id = j.job_id
and e.department_id = ea.;

-- ����3.��� �޿��� ���� ���� �μ���??
-- ��� �޿� max���ϱ�
select max(avgsal) maxsal
from(
    select department_id,avg(salary) avgsal
    from employees
    group by department_id
    );
-- sol
select distinct d.department_name
from (select DEPARTMENT_ID,avg(salary) avgsal
        from employees
        group by DEPARTMENT_ID) A,
     (select max(avgsal) maxsal
        from
            (select DEPARTMENT_ID,avg(salary) avgsal
            from employees
            group by DEPARTMENT_ID)) B,
     employees e,departments d
where A.avgsal = B.maxsal
and a.department_id = e.department_id
and d.department_id = a.department_id;

-- ����� �μ� ����Ʈ?
-- 1.���� ����� �μ� ����Ʈ
select distinct department_id
from employees
where department_id is not null;
-- 2.���� �μ����� ����, ���
select d.DEPARTMENT_NAME,l.STATE_PROVINCE,l.city,
       c.country_name, r.region_name
from locations l,
     departments d,
     COUNTRIES c,
     REGIONS r,
     (
        select distinct department_id
        from employees
        where department_id is not null
     ) emp_dep
where l.location_id = d.location_id
and emp_dep.department_id = d.department_id
and l.country_id = c.country_id
and c.region_id = r.region_id;

-- 4.�μ��� ���
select department_id,avg(salary)
from employees
group by department_id;

-- 5.Europe�� �ִ� �μ��� (70,80,40)�� ���?
select department_id,avg(salary)
from employees
group by department_id
having department_id in (70,80,40);

-- Europe �� �ִ� �μ��� �ٹ��ϴ� ������� ��� �޿� -> 8485.294117647058823529411764705882352933
SELECT avg(dep_avg)
FROM (  SELECT e.DEPARTMENT_ID, avg(e.SALARY) dep_avg
		  FROM EMPLOYEES e
	  GROUP BY e.DEPARTMENT_ID 
	    HAVING e.DEPARTMENT_ID IN (70, 80, 40 )
	 );
     
-- 6. Americas �� �ִ� �μ��� (20, 10, 30,90, 100, 110, 50, 60) �� ���?
SELECT e.DEPARTMENT_ID, avg(e.SALARY)
FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID 
HAVING e.DEPARTMENT_ID IN (20, 10, 30,90, 100, 110, 50, 60);

-- Americas �� �ִ� �μ��� �ٹ��ϴ� ������� ��� �޿� -> 8194.69444444444444444444444444444444445
SELECT avg(dep_avg)
FROM (  SELECT e.DEPARTMENT_ID, avg(e.SALARY) dep_avg
		  FROM EMPLOYEES e
	  GROUP BY e.DEPARTMENT_ID 
	    HAVING e.DEPARTMENT_ID IN (20, 10, 30,90, 100, 110, 50, 60)
	 );

-- ��� �޿�(salary)�� ���� ���� ������? 
select region_name
from regions
where region_id =  (select r.region_id
                    from employees e,
                         departments d,
                         locations l,
                         countries c,
                         regions r
                    where e.department_id = d.department_id
                    and   d.location_id = l.location_id
                    and   l.country_id = c.country_id
                    and   c.region_id = r.region_id
                    group by r.region_id
                    having avg(salary) = (select max(avg(salary))
                                          from employees e,
                                               departments d,
                                               locations l,
                                               countries c,
                                               regions r
                                          where e.department_id = d.department_id
                                          and   d.location_id = l.location_id
                                          and   l.country_id = c.country_id
                                          and   c.region_id = r.region_id
                                          group by r.region_id));
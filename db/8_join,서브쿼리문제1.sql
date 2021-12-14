select department_id, job_id, count(*), sum(salary)
from employees
group by department_id, job_id;

select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) > 20000;

select department_id, count(*), sum(salary)
from employees
group by department_id
having sum(salary) > 20000
and department_id in (100,90); 
-- �̹� having���� where���� ����ؼ� and�������� ���� �� �ִ�.

select EMPLOYEE_ID,DEPARTMENT_ID,
    case when DEPARTMENT_ID between 10 and 50 then 'A��'
        when DEPARTMENT_ID between 60 and 100 then 'B��'
        when DEPARTMENT_ID between 110 and 150 then 'C��'
         else '�� ����'
    end ��
from employees;

select first_name, department_name
from employees, departments;

select first_name, em.department_id,
department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id;

-- ���̺� 3�� ����
select *
from employees e,departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

-- ��������
Select emp.first_name, mgr.first_name
From employees emp, employees mgr
Where emp.manager_id = mgr.employee_id;

select e.department_id, e.first_name, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id ;

-- ���� �߿� �ְ� �ӱݰ� �����ӱ�, �� �ӱ��� ���̴�?? �ְ��ӱ� - �����ӱ� �̶� Ÿ��Ʋ�� ����ϱ�
select max(salary) �ְ��ӱ�,min(salary) �����ӱ�,max(salary)-min(salary) "�ְ�-����"
from employees;

select max(hire_date)
from employees;

select job_id,avg(salary)
from employees
group by job_id;

-- ���� ���� �ټ��� ��� char�������� ���
select to_char(min(hire_date),'YYYY-MM-DD')
from employees;

select employee_id,first_name,department_name,e.manager_id
from employees e,departments d
where e.manager_id=d.manager_id;

-- ����1.���,�̸�,�Ŵ����̸��� ��ȸ,�μ���
select emp.employee_id,emp.first_name,man.first_name,dep.department_name
from employees emp,employees man,departments dep
where emp.manager_id = man.employee_id
and emp.department_id = dep.department_id;

-- ����2.������ ���� ������� �����̸�,�����̸� ���� ����ϵ� �����̸�,�����̸� ������� �������� ����
select region_name,c.country_name
from regions r,countries c
where r.region_id=c.region_id;

select d.department_name,e.first_name,l.city,c.country_name,r.region_name
from departments d,employees e,locations l,countries c,regions r
where d.manager_id=e.employee_id 
AND d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id; -- ���̺� 5�� -> ���� 4��

-- ��4.public accountant�� ��å(job_title)�� ���ſ� �ٹ��� ���� �ִ� ��� ����� ����� �̸��� ����Ͻÿ�.
select * from
job_history jh;

select * from 
jobs j
where j.job_title='Public Accountant'; -- AC_ACCOUNT : Public Accountant

select e.employee_id,j.job_title,e.first_name,e.department_id
from job_history jh, jobs j,employees e
where j.job_id = jh.job_id
and jh.employee_id = e.employee_id
and j.job_title='Public Accountant';

-- �ڽ��� �Ŵ������� ä������ ���� ����� ���,��,ä������ ��ȸ�ϱ�
select e.first_name,e.hire_date,m.first_name,m.hire_date
from employees e,employees m
where e.manager_id = m.employee_id
and e.hire_date < m.hire_date;

-- ��� �޿����� ���� �޿��� �޴� ������ ����̳� �ֳ�?
select avg(salary)
from employees;

select count(*)
from employees
where salary<6472;
-- 2���� ���ĺ���
select count(*)
from employees
where salary<(select avg(salary)
from employees);

select first_name,salary
from employees
where salary > 12008
OR salary > 8300;

-- �� �μ����� �ְ� �޿��� �޴� ��� ���
select department_id,salary,first_name
from employees
where (department_id,salary) in (select department_id,max(salary) 
                                from employees 
                                group by department_id);
                                
-- M2.����
select e.department_id,e.salary,first_name
from employees e,(select department_id,max(salary) salary
                    from employees 
                    group by department_id) s
where e.department_id=s.department_id
and e.salary=s.salary; -- �������� department_id �� salary�� �����ɷ� ����

-- ���� job���� ������ ���� ���ϱ� employees ���̺�� jobs ���̺� ����
-- job_id���� group by
select e.job_id,j.job_title,sum(e.SALARY)
from employees e,jobs j
where e.job_id = j.job_id
group by e.job_id,j.job_title
order by sum(e.salary) desc;
-- �����������1
select j.job_title, t.salary
from jobs j, ( select job_id, sum(salary) salary
             from employees
             group by job_id ) t
where j.job_id = t.job_id
order by salary desc;
-- ��������2
  select j.job_title,
         SUM(e.salary)
    from jobs j,
         employees e
   where j.job_id=e.job_id
group by j.job_title
order by SUM(e.salary) desc;
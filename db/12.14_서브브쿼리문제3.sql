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

-- A���̺�� B���̺��� ��������
select *
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
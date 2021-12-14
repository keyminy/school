-- rownum������
select rownum,first_name,salary
from employees;

select rownum,first_name,salary
from (
        select first_name,salary
        from employees
        order by salary desc
     )
where rownum>=3; -- �Ұ�

select rn,first_name,salary
from (
        select rownum rn,first_name,salary
        from (
                select first_name,salary
                from employees
                order by salary desc
             )
     )
where rn between 11 and 20;

select rn,first_name,salary
from (
        select rownum rn,first_name,salary
        from (
                select first_name,salary
                from employees
                order by salary desc
             )
     )
where rn between 11 and 20;

-- 2007�� �Ի����� �޿� ���� 3~7���� �̸�,�޿�,�Ի��� ���
-- 1. 2007�� �Ի����� �޿� ��������
select salary,hire_date
from employees
where to_char(hire_date,'YYYY') = '2007'
order by salary desc;
-- 2.rownum �ο�
select rownum rn,first_name,salary,hire_date
        from (
                select first_name,salary,hire_date
                from employees
                where to_char(hire_date,'YYYY') = '2007'
                order by salary desc
             );
-- ���� : 3.rownum ���� �ڸ���
select rn,first_name,salary,hire_date
from (
        select rownum rn,first_name,salary,hire_date
        from (
                select first_name,salary,hire_date
                from employees
                where to_char(hire_date,'YYYY') = '2007'
                order by salary desc
             )
     )
where rn between 3 and 7;
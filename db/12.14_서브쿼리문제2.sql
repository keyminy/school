-- ����4.�ڽ��� �μ� ��� �޿����� �޿��� ���� ������ ������ȣ,��,�������� ��ȸ
select avg(salary),DEPARTMENT_ID
from employees
group by department_id;
-- ��Ǯ�� : �ȵ�
select EMPLOYEE_ID,LAST_NAME,SALARY,DEPARTMENT_ID
from employees
where SALARY > any (select avg(salary)
                    from employees
                    group by department_id
                    having salary>avg(salary));
-- �ַ��
-- 1.�ϴ� �μ��� ����� �ʿ��ϴ�. : �ָ� ���������� Ȱ�� where�� ���� from���� �ϴ�
select department_id,avg(salary)
from employees
group by department_id;
-- (M1)from���� �������� ��Ī : da , da.avgsal�� ������
select e.EMPLOYEE_ID,e.LAST_NAME,e.SALARY,e.DEPARTMENT_ID
from employees e,(select department_id dep_id,avg(salary) avgsal
                from employees
                group by department_id) da
where e.department_id = da.dep_id -- e.department_id = da.dep_id : ���� �μ� ��ȣ�� �ɸ�
and e.salary > da.avgsal;-- ���� ���� 2; 
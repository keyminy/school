-- 문제4.자신의 부서 평균 급여보다 급여가 많은 직원의 직원번호,성,셀러리를 조회
select avg(salary),DEPARTMENT_ID
from employees
group by department_id;
-- 내풀이 : 안됨
select EMPLOYEE_ID,LAST_NAME,SALARY,DEPARTMENT_ID
from employees
where SALARY > any (select avg(salary)
                    from employees
                    group by department_id
                    having salary>avg(salary));
-- 솔루션
-- 1.일단 부서별 평균이 필요하다. : 애를 서브쿼리로 활용 where에 쓰던 from으로 하던
select department_id,avg(salary)
from employees
group by department_id;
-- (M1)from절에 서브쿼리 별칭 : da , da.avgsal로 접근함
select e.EMPLOYEE_ID,e.LAST_NAME,e.SALARY,e.DEPARTMENT_ID
from employees e,(select department_id dep_id,avg(salary) avgsal
                from employees
                group by department_id) da
where e.department_id = da.dep_id -- e.department_id = da.dep_id : 같은 부서 번호가 걸림
and e.salary > da.avgsal;-- 조인 조건 2; 
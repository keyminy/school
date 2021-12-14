-- 문1.가장 늦게 입사한 직원의 이름과 연봉,부서이름은?
-- 1.where절에 서브쿼리로 넣어줄것
select max(hire_date)
from employees;

select first_name,salary,d.department_name,salary,e.hire_date
from employees e,departments d
where (hire_date = (select max(hire_date)
                    from employees)
and e.department_id = d.department_id);

-- 평균 연봉이 가장 높은 부서 직원들의 직원번호,이름,성,업무,연봉을 조회하기
-- 부서별 평균 : A테이블로 보고
select DEPARTMENT_ID,avg(salary) avgsal
from employees
group by DEPARTMENT_ID;

-- (사실..)90번 부서가 젤 높으므로 90번 부서인 사람들만 보자
select * from
employees
where department_id = 90;

-- 서브쿼리로 쓰기 from절로 : B테이블로 봐라
select max(avgsal) maxsal
from
    (select DEPARTMENT_ID,avg(salary) avgsal
    from employees
    group by DEPARTMENT_ID);

-- A테이블과 B테이블을 조인하자
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


-- 내풀이 max(avg(sal)) 고집하다가..
select e.employee_id 사번,e.first_name 이름,e.last_name 성,e.salary 급여,ea.AVG_SALARY,j.job_title
from jobs j,employees e,(select max(avg(salary)) AVG_SALARY,department_id
                            from employees
                            group by DEPARTMENT_ID) ea
where e.job_id = j.job_id
and e.department_id = ea.;
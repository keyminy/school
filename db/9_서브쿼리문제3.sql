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

-- A테이블과 B테이블을 조인하자 : 선생님풀이
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
-- 구조
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

-- 문제3.평균 급여가 가장 높은 부서는??
-- 평균 급여 max구하기
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

-- 대륙별 부서 리스트?
-- 1.현재 운영중인 부서 리스트
select distinct department_id
from employees
where department_id is not null;
-- 2.현재 부서들의 나라, 대륙
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

-- 4.부서별 평균
select department_id,avg(salary)
from employees
group by department_id;

-- 5.Europe에 있는 부서들 (70,80,40)의 평균?
select department_id,avg(salary)
from employees
group by department_id
having department_id in (70,80,40);

-- Europe 에 있는 부서에 근무하는 사람들의 평균 급여 -> 8485.294117647058823529411764705882352933
SELECT avg(dep_avg)
FROM (  SELECT e.DEPARTMENT_ID, avg(e.SALARY) dep_avg
		  FROM EMPLOYEES e
	  GROUP BY e.DEPARTMENT_ID 
	    HAVING e.DEPARTMENT_ID IN (70, 80, 40 )
	 );
     
-- 6. Americas 에 있는 부서들 (20, 10, 30,90, 100, 110, 50, 60) 의 평균?
SELECT e.DEPARTMENT_ID, avg(e.SALARY)
FROM EMPLOYEES e
GROUP BY e.DEPARTMENT_ID 
HAVING e.DEPARTMENT_ID IN (20, 10, 30,90, 100, 110, 50, 60);

-- Americas 에 있는 부서에 근무하는 사람들의 평균 급여 -> 8194.69444444444444444444444444444444445
SELECT avg(dep_avg)
FROM (  SELECT e.DEPARTMENT_ID, avg(e.SALARY) dep_avg
		  FROM EMPLOYEES e
	  GROUP BY e.DEPARTMENT_ID 
	    HAVING e.DEPARTMENT_ID IN (20, 10, 30,90, 100, 110, 50, 60)
	 );

-- 평균 급여(salary)가 가장 높은 지역은? 
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
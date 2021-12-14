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
-- 이미 having절이 where절을 대신해서 and조건으로 붙일 수 있다.

select EMPLOYEE_ID,DEPARTMENT_ID,
    case when DEPARTMENT_ID between 10 and 50 then 'A팀'
        when DEPARTMENT_ID between 60 and 100 then 'B팀'
        when DEPARTMENT_ID between 110 and 150 then 'C팀'
         else '팀 없음'
    end 팀
from employees;

select first_name, department_name
from employees, departments;

select first_name, em.department_id,
department_name, de.department_id
from employees em, departments de
where em.department_id = de.department_id;

-- 테이블 3개 조인
select *
from employees e,departments d, jobs j
where e.department_id = d.department_id
and e.job_id = j.job_id;

-- 셀프조인
Select emp.first_name, mgr.first_name
From employees emp, employees mgr
Where emp.manager_id = mgr.employee_id;

select e.department_id, e.first_name, d.department_name
from employees e left outer join departments d
on e.department_id = d.department_id ;

-- 직원 중에 최고 임금과 최저임금, 두 임금의 차이는?? 최고임금 - 최저임금 이란 타이틀로 출력하기
select max(salary) 최고임금,min(salary) 최저임금,max(salary)-min(salary) "최고-최저"
from employees;

select max(hire_date)
from employees;

select job_id,avg(salary)
from employees
group by job_id;

-- 가장 오래 근속한 사람 char형식으로 출력
select to_char(min(hire_date),'YYYY-MM-DD')
from employees;

select employee_id,first_name,department_name,e.manager_id
from employees e,departments d
where e.manager_id=d.manager_id;

-- 문제1.사번,이름,매니저이름을 조회,부서명
select emp.employee_id,emp.first_name,man.first_name,dep.department_name
from employees emp,employees man,departments dep
where emp.manager_id = man.employee_id
and emp.department_id = dep.department_id;

-- 문제2.지역에 속한 나라들을 지역이름,나라이름 으로 출력하되 지역이름,나라이름 순서대로 내림차순 정렬
select region_name,c.country_name
from regions r,countries c
where r.region_id=c.region_id;

select d.department_name,e.first_name,l.city,c.country_name,r.region_name
from departments d,employees e,locations l,countries c,regions r
where d.manager_id=e.employee_id 
AND d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id = r.region_id; -- 테이블 5개 -> 조건 4개

-- 문4.public accountant의 직책(job_title)로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하시오.
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

-- 자신의 매니저보다 채용일이 빠른 사원의 사번,성,채용일을 조회하기
select e.first_name,e.hire_date,m.first_name,m.hire_date
from employees e,employees m
where e.manager_id = m.employee_id
and e.hire_date < m.hire_date;

-- 평균 급여보다 적은 급여를 받는 직원은 몇명이나 있나?
select avg(salary)
from employees;

select count(*)
from employees
where salary<6472;
-- 2개를 합쳐보자
select count(*)
from employees
where salary<(select avg(salary)
from employees);

select first_name,salary
from employees
where salary > 12008
OR salary > 8300;

-- 각 부서별로 최고 급여를 받는 사원 출력
select department_id,salary,first_name
from employees
where (department_id,salary) in (select department_id,max(salary) 
                                from employees 
                                group by department_id);
                                
-- M2.조인
select e.department_id,e.salary,first_name
from employees e,(select department_id,max(salary) salary
                    from employees 
                    group by department_id) s
where e.department_id=s.department_id
and e.salary=s.salary; -- 조인조건 department_id 와 salary가 같은걸로 조인

-- 업무 job별로 연봉의 총합 구하기 employees 테이블과 jobs 테이블 조인
-- job_id별로 group by
select e.job_id,j.job_title,sum(e.SALARY)
from employees e,jobs j
where e.job_id = j.job_id
group by e.job_id,j.job_title
order by sum(e.salary) desc;
-- 서브쿼리방법1
select j.job_title, t.salary
from jobs j, ( select job_id, sum(salary) salary
             from employees
             group by job_id ) t
where j.job_id = t.job_id
order by salary desc;
-- 서브쿼리2
  select j.job_title,
         SUM(e.salary)
    from jobs j,
         employees e
   where j.job_id=e.job_id
group by j.job_title
order by SUM(e.salary) desc;
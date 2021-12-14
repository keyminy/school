-- rownum에대해
select rownum,first_name,salary
from employees;

select rownum,first_name,salary
from (
        select first_name,salary
        from employees
        order by salary desc
     )
where rownum>=3; -- 불가

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

-- 2007년 입사자중 급여 순위 3~7등의 이름,급여,입사일 출력
-- 1. 2007년 입사자의 급여 내림차순
select salary,hire_date
from employees
where to_char(hire_date,'YYYY') = '2007'
order by salary desc;
-- 2.rownum 부여
select rownum rn,first_name,salary,hire_date
        from (
                select first_name,salary,hire_date
                from employees
                where to_char(hire_date,'YYYY') = '2007'
                order by salary desc
             );
-- 최종 : 3.rownum 순위 자르기
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
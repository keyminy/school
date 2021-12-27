-- 사원 테이블을 사용하여 사번을 입력받아 해당 사원의 사번, 이름(fist_name), 월급, 입사일을 출력하세요
DECLARE 
v_empno employees.employee_id%TYPE;
v_name employees.first_name%TYPE;
v_sal employees.salary%TYPE;
v_hire_date employees.hire_date%TYPE;
BEGIN 
	SELECT employee_id,first_name,salary,to_char(hire_date,'YYYY-MM-DD')
	INTO v_empno,v_name,v_sal,v_hire_date
	FROM EMPLOYEES
	WHERE employee_id = :empno;
	dbms_output.put_line(v_empno || ' ' || v_name || ' ' || v_sal || ' ' ||v_hire_date); -- 변수들을 나열(dbms_output)
END;

-- 두개의 숫자를 입력받아 합계를 출력하시오
DECLARE
v_no1 NUMBER := :no1;
v_no2 NUMBER := :no2;
v_sum NUMBER;
BEGIN
	v_sum := v_no1 + v_no2;
	dbms_output.put_line('첫 번째 수 : ' || v_no1 || ' , 두번째 수 : ' || v_no2 ||' ,합은 : '|| v_sum ||'입니다');
END;

-- procedure 작성
CREATE OR REPLACE PROCEDURE UPDATE_SALARY
/* IN Argument */
(v_empno IN NUMBER)
IS
BEGIN 
	UPDATE EMPLOYEES 
	SET salary = salary * 1.1
	WHERE EMPLOYEE_ID = v_empno;
	COMMIT;
END UPDATE_SALARY;

call UPDATE_SALARY(114);

-- 함수 작성
CREATE OR REPLACE FUNCTION FC_UPDATE_SALARY
(v_empno IN NUMBER) -- 매개변수
RETURN NUMBER 

IS 
--변수 선언
v_salary employees.SALARY%TYPE;

BEGIN 
	UPDATE EMPLOYEES
	SET SALARY = SALARY * 1.1
	WHERE EMPLOYEE_ID = v_empno;	
	COMMIT;

	SELECT salary
	INTO v_salary
	FROM EMPLOYEES
	WHERE EMPLOYEE_ID = v_empno;

	RETURN v_salary;
END;

-- 함수실행
var salary NUMBER; -- FUNCTION 호출 결과를 저장할 변수 선언
CALL FC_UPDATE_SALARY(:v_empno);

SELECT * FROM EMPLOYEES e 
WHERE e.EMPLOYEE_ID = 114; -- 14,641


-- ��� ���̺��� ����Ͽ� ����� �Է¹޾� �ش� ����� ���, �̸�(fist_name), ����, �Ի����� ����ϼ���
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
	dbms_output.put_line(v_empno || ' ' || v_name || ' ' || v_sal || ' ' ||v_hire_date); -- �������� ����(dbms_output)
END;

-- �ΰ��� ���ڸ� �Է¹޾� �հ踦 ����Ͻÿ�
DECLARE
v_no1 NUMBER := :no1;
v_no2 NUMBER := :no2;
v_sum NUMBER;
BEGIN
	v_sum := v_no1 + v_no2;
	dbms_output.put_line('ù ��° �� : ' || v_no1 || ' , �ι�° �� : ' || v_no2 ||' ,���� : '|| v_sum ||'�Դϴ�');
END;

-- procedure �ۼ�
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

-- �Լ� �ۼ�
CREATE OR REPLACE FUNCTION FC_UPDATE_SALARY
(v_empno IN NUMBER) -- �Ű�����
RETURN NUMBER 

IS 
--���� ����
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

-- �Լ�����
var salary NUMBER; -- FUNCTION ȣ�� ����� ������ ���� ����
CALL FC_UPDATE_SALARY(:v_empno);

SELECT * FROM EMPLOYEES e 
WHERE e.EMPLOYEE_ID = 114; -- 14,641


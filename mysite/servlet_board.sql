drop table board;
drop sequence seq_board_no;

CREATE TABLE board (
  no	    NUMBER,
  title 	VARCHAR2(500),
  content   VARCHAR2(4000),
  hit       NUMBER DEFAULT 0,
  reg_date  DATE DEFAULT SYSDATE,
  user_no   NUMBER,
  PRIMARY KEY(no),
  CONSTRAINT c_board_fk FOREIGN KEY (user_no) 
  REFERENCES users(no)
);

CREATE SEQUENCE seq_board_no
INCREMENT BY 1 
START WITH 1 ;

------ [3-8] �Ϲ� �Խ���(board)
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '�� �߿� �ܿ���������..', 
'�� �ʳ��� ��������',1);
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '�Խ��Ǹ����', 
'����',1);
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '������ �����ϴ�', 
'������',1);
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '�� �����׽�Ʈ', 
'�׽�Ʈ',12);
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '�ڱ� �۸� ����� ǥ�� ����', 
'�׽�Ʈ',12);


-- �� �ø���..
INSERT INTO board(no, title, content,user_no)
(SELECT seq_board_no.nextval,title,content,1 FROM board);

select * from board;
select * from users;

-- list��� ����
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
ORDER BY no DESC;

-- �˻� ���� �����
-- title�� ��ȸ
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
AND title LIKE '%'||'�۾���'||'%'
ORDER BY no DESC;
-- �ۼ��Ϸ� ��ȸ
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
AND reg_date LIKE '%'||'22/01/06'||'%'
ORDER BY no DESC;
-- �ۼ��ڷ� ��ȸ
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
AND name LIKE '%'||'������'||'%'
ORDER BY no DESC;
-- �������� ��ȸ
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
AND content LIKE '%'||'����'||'%'
ORDER BY no DESC;


-- ����¡ ���� �����
--1.��ü �� ���� ��������
SELECT COUNT(*) FROM board;
-- rnum���� ����¡ ó��
SELECT rnum,no,title,name,hit,reg_date,user_no
FROM
(
    SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no
    FROM
        (
            SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
            FROM board b,users u
            WHERE b.user_no=u.no
            ORDER BY no DESC
        )
)
WHERE rnum BETWEEN 11 AND 20;
-- 2.�˻���� ������ ����¡ ���� �����
SELECT rnum,no,title,name,hit,reg_date,user_no
FROM
(
    SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no
    FROM
        (
            SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
            FROM board b,users u
            WHERE b.user_no=u.no
            AND title LIKE '%'||'�۾���'||'%'
            ORDER BY no DESC
        )
)
WHERE rnum BETWEEN 11 AND 20;

-- �˻� ����¡ �׽�Ʈ
SELECT rnum,no,title,name,hit,reg_date,user_no 
FROM 
( SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no 
FROM ( SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no FROM board b,users u WHERE b.user_no=u.no AND title LIKE '%'|| '�۾���' ||'%' ORDER BY no DESC ) ) 
WHERE rnum BETWEEN 11 AND 20;


-- ������ ? �ڸ��� 'title'�Ǿ� column���� ��ȸ�Ǿ� �� ����
SELECT rnum,no,title,name,hit,reg_date,user_no 
FROM 
( SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no 
FROM ( SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no FROM board b,users u WHERE b.user_no=u.no AND 'title' LIKE '%�۾���%' ORDER BY no DESC ) ) 
WHERE rnum BETWEEN 11 AND 20;

SELECT rnum,no,title,name,hit,reg_date,user_no 
FROM 
    ( SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no 
    FROM 
    ( SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no 
    FROM board b,users u WHERE b.user_no=u.no 
    ORDER BY no DESC ) ) 
WHERE rnum BETWEEN 11 AND 20;

-- �׽�Ʈ �˻��Ҷ��� JOIN�ɸ鼭 user�� �մ� name�� ��������..
SELECT COUNT(*) FROM board b,users u
WHERE b.user_no = u.no AND u.name LIKE '%�׽�Ʈ%'; 
-- regdate�� �˻��ϱ� �־ȵ���?
SELECT COUNT(*) FROM board  WHERE 1 = 0 OR TO_CHAR(reg_date,'YYYY-MM-DD') LIKE '%2022%'; 

-- AND to_char(reg_date,'YYYY-MM-DD') LIKE '%'||'2022'||'%' �̷��� �ߴ��� �˻��� �ȴ�!!
SELECT rnum,no,title,name,hit,reg_date,user_no
FROM
(
    SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no
    FROM
        (
            SELECT b.no,b.title,u.name,b.hit,TO_CHAR(b.reg_date,'YYYY-MM-DD') reg_date,b.user_no
            FROM board b,users u
            WHERE b.user_no=u.no
            AND to_char(reg_date,'YYYY-MM-DD') LIKE '%'||'2022'||'%'
            ORDER BY no DESC
        )
)
WHERE rnum BETWEEN 11 AND 20;
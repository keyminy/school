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

------ [3-8] 일반 게시판(board)
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '이 추운 겨울이지나면..', 
'꽃 필날이 오겠지요',1);
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '게시판만들기', 
'시작',1);
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '가난은 불편하다', 
'불편함',1);
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '글 삭제테스트', 
'테스트',12);
INSERT INTO board(no, title, content,user_no)
VALUES(seq_board_no.nextval, '자기 글만 지우기 표시 나옴', 
'테스트',12);


-- 글 늘리기..
INSERT INTO board(no, title, content,user_no)
(SELECT seq_board_no.nextval,title,content,1 FROM board);

select * from board;
select * from users;

-- list출력 쿼리
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
ORDER BY no DESC;

-- 검색 쿼리 만들기
-- title로 조회
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
AND title LIKE '%'||'글쓰기'||'%'
ORDER BY no DESC;
-- 작성일로 조회
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
AND reg_date LIKE '%'||'22/01/06'||'%'
ORDER BY no DESC;
-- 작성자로 조회
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
AND name LIKE '%'||'정종욱'||'%'
ORDER BY no DESC;
-- 내용으로 조회
SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
FROM board b,users u
WHERE b.user_no=u.no
AND content LIKE '%'||'불편'||'%'
ORDER BY no DESC;


-- 페이징 쿼리 만들기
--1.전체 글 갯수 가져오기
SELECT COUNT(*) FROM board;
-- rnum으로 페이징 처리
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
-- 2.검색기능 포함한 페이징 쿼리 만들기
SELECT rnum,no,title,name,hit,reg_date,user_no
FROM
(
    SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no
    FROM
        (
            SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no
            FROM board b,users u
            WHERE b.user_no=u.no
            AND title LIKE '%'||'글쓰기'||'%'
            ORDER BY no DESC
        )
)
WHERE rnum BETWEEN 11 AND 20;

-- 검색 페이징 테스트
SELECT rnum,no,title,name,hit,reg_date,user_no 
FROM 
( SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no 
FROM ( SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no FROM board b,users u WHERE b.user_no=u.no AND title LIKE '%'|| '글쓰기' ||'%' ORDER BY no DESC ) ) 
WHERE rnum BETWEEN 11 AND 20;


-- 문제점 ? 자리에 'title'되어 column으로 조회되어 빈값 떳다
SELECT rnum,no,title,name,hit,reg_date,user_no 
FROM 
( SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no 
FROM ( SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no FROM board b,users u WHERE b.user_no=u.no AND 'title' LIKE '%글쓰기%' ORDER BY no DESC ) ) 
WHERE rnum BETWEEN 11 AND 20;

SELECT rnum,no,title,name,hit,reg_date,user_no 
FROM 
    ( SELECT ROWNUM rnum,no,title,name,hit,reg_date,user_no 
    FROM 
    ( SELECT b.no,b.title,u.name,b.hit,b.reg_date,b.user_no 
    FROM board b,users u WHERE b.user_no=u.no 
    ORDER BY no DESC ) ) 
WHERE rnum BETWEEN 11 AND 20;

-- 테스트 검색할때는 JOIN걸면서 user에 잇는 name값 꺼내야지..
SELECT COUNT(*) FROM board b,users u
WHERE b.user_no = u.no AND u.name LIKE '%테스트%'; 
-- regdate로 검색하기 왜안되지?
SELECT COUNT(*) FROM board  WHERE 1 = 0 OR TO_CHAR(reg_date,'YYYY-MM-DD') LIKE '%2022%'; 

-- AND to_char(reg_date,'YYYY-MM-DD') LIKE '%'||'2022'||'%' 이렇게 했더니 검색이 된다!!
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
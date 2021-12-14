
CREATE TABLE author (
    author_id NUMBER(10),
    author_name VARCHAR2(100) NOT NULL,
    author_desc VARCHAR2(500),
    PRIMARY KEY(author_id)
);

drop sequence seq_author_id;

CREATE SEQUENCE seq_author_id
INCREMENT BY 1
START WITH 1 ;

CREATE TABLE book (
    book_id NUMBER(10),
    title VARCHAR2(100) NOT NULL,
    pubs VARCHAR2(100),
    pub_date DATE,
    author_id NUMBER(10),
    PRIMARY KEY(book_id),
    CONSTRAINT c_book_fk FOREIGN KEY (author_id)
    REFERENCES author(author_id)
);

-- insert
INSERT INTO author
VALUES (1, '박경리', '토지 작가 ' );
INSERT INTO author
VALUES (seq_author_id.nextval,'기안80','복학왕');

-- commit을 해야 db에 직접 실행이됨(commit을 안하면 세션에만 되어있음.)
commit;

select * from author;

delete author;

select book_id,title,pubs,pub_date,b.author_id,author_name,author_desc
from author a,book b
where b.author_id = a.author_id
order by b.book_id;
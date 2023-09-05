SELECT * FROM tab ; 
SELECT * FROM member ;
SELECT * FROM member1 m ;

SELECT * FROM BOARD b   ;

SELECT * FROM BOARD_REPLY br   ;

DELETE  FROM member1;

DROP TABLE member1 ;

SELECT  * FROM BOARD ;
SELECT  * FROM BOARD_REPLY br  ;


DELETE  FROM BOARD_REPLY br ;
SELECT * from

CREATE TABLE member1 (
member_id varchar(50) UNIQUE CHECK (LENGTH(member_id) > 3) ,
member_pw varchar(50) CHECK (LENGTH(member_pw) > 5),
member_name varchar(50),
member_email varchar(50) UNIQUE ,
member_profileimage varchar(100)
);

	SELECT * FROM board LEFT OUTER JOIN BOARD_REPLY ON board.board_no = board_reply.board_no  JOIN MEMBER1  ON board.member_id = member1.member_id where board.board_no =3;



CREATE TABLE board (
board_no NUMBER,
member_id varchar(50),
board_title varchar(50),
board_content varchar(4000),
board_content_file varchar(4000),
board_date varchar(50),
board_count number
);


SELECT * FROM BOARD_REPLY br ;

CREATE TABLE board_reply (
board_no NUMBER,
board_reply_member_id varchar(50),
board_reply_no NUMBER ,
board_reply_content varchar(4000),
board_reply_date varchar(50)
);

DROP TABLE BOARD_REPLY ;

INSERT INTO board_reply VALUES (3,'dsad','1','232','2023-03-11');
INSERT INTO board_reply VALUES (3,'aasdas','1','232','2023-03-11');
INSERT INTO board_reply VALUES (3,'godbuyer12','1','232','2023-03-11');
INSERT INTO board_reply VALUES (3,'godbuyer13','3','232','2023-03-11');

CREATE SEQUENCE board_no
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999
  NOCACHE
  NOCYCLE;
 
 CREATE SEQUENCE board_reply_no
  START WITH 1
  INCREMENT BY 1
  MINVALUE 1
  MAXVALUE 9999
  NOCACHE
  NOCYCLE;

SELECT * FROM BOARD b ;

	SELECT * FROM board LEFT OUTER JOIN BOARD_REPLY ON board.MEMBER_ID = board_reply.board_reply_member_id JOIN MEMBER1  ON board.member_id = member1.member_id where board.board_no =3;





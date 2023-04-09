DROP TABLE REPLY_REPORT;
DROP TABLE POST_REPORT;
DROP TABLE FILE_TABLE;
DROP TABLE REPLY_LIKE; 
DROP TABLE POST_LIKE;
DROP TABLE MEMBER_GRADE;
DROP TABLE MEMBER_REPORT;
DROP TABLE MENU_LIKE; 
DROP TABLE MENU; 
DROP TABLE STORE; 
DROP TABLE BRAND;
DROP TABLE REPLY;
DROP TABLE POST; 
DROP TABLE POST_CATEGORY; 
DROP TABLE QNA;
DROP TABLE MEMBER; 


---------------------------------------------------------------------------------
-- 1번째문자 -- 댓글 R 메뉴 ME 매장 S 브랜드 B 회원 M 게시글 P 댓글 R QNA Q 파일 F 회원 M
-- 2번째문자 -- 신고 R 카테고리 C
DROP SEQUENCE SEQ_MNO;   -- 회원 
DROP SEQUENCE SEQ_PNO;   -- 게시글
DROP SEQUENCE SEQ_SNO;   -- 매장
DROP SEQUENCE SEQ_MENO;   -- 메뉴
DROP SEQUENCE SEQ_BNO;   -- 브랜드
DROP SEQUENCE SEQ_FNO;   -- 파일
DROP SEQUENCE SEQ_PCNO;  -- 게시글 카테고리
DROP SEQUENCE SEQ_PRNO;  -- 게시글 신고넘버 발생시킬 시퀀스
DROP SEQUENCE SEQ_MRNO;  -- 멤버 신고?
DROP SEQUENCE SEQ_RNO;   -- 댓글
DROP SEQUENCE SEQ_RRNO;  -- 댓글 신고
DROP SEQUENCE SEQ_QNO;   -- QNA 

---------------------------------------------------------------------------------
-- 좋아요 테이블 --
-- 메뉴, 댓글, 게시글 + 회원등급 --> 시퀀스 X
---------------------------------------------------------------------------------
--시퀀스 생성
CREATE SEQUENCE SEQ_PNO   -- 게시글
NOCACHE;
CREATE SEQUENCE SEQ_SNO   -- 매장
NOCACHE;
CREATE SEQUENCE SEQ_MENO    -- 메뉴
NOCACHE;
CREATE SEQUENCE SEQ_BNO    -- 브랜드
NOCACHE;
CREATE SEQUENCE SEQ_MNO    -- 회원 
NOCACHE;
CREATE SEQUENCE SEQ_FNO    -- 파일
NOCACHE;
CREATE SEQUENCE SEQ_PCNO   -- 게시글 카테고리
NOCACHE;
CREATE SEQUENCE SEQ_PRNO   -- 게시글 신고넘버 발생시킬 시퀀스
NOCACHE;
CREATE SEQUENCE SEQ_MRNO   -- 회원 신고번호 발생시킬 시퀀스
NOCACHE;
CREATE SEQUENCE SEQ_RNO    -- 댓글
NOCACHE;
CREATE SEQUENCE SEQ_RRNO   -- 댓글 신고
NOCACHE;
CREATE SEQUENCE SEQ_QNO    -- QNA 
NOCACHE;


--------------------------------------------------------------------------------
--------------------------    BRAND 관련     ------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE BRAND (
    BRAND_NO VARCHAR2(15) PRIMARY KEY,
    BRAND_NAME VARCHAR2(15) NOT NULL
);

COMMENT ON COLUMN BRAND.BRAND_NO IS '브랜드코드';
COMMENT ON COLUMN BRAND.BRAND_NAME IS '브랜드이름';

INSERT INTO BRAND
VALUES (SEQ_BNO.NEXTVAL, 'BHC') ;

INSERT INTO BRAND
VALUES (SEQ_BNO.NEXTVAL, '바른치킨') ;

INSERT INTO BRAND
VALUES (SEQ_BNO.NEXTVAL, '푸라닭') ;

--------------------------------------------------------------------------------
----------------------------    STORE 관련      선주  -------------------------------
--------------------------------------------------------------------------------

CREATE TABLE STORE (
    STORE_NO NUMBER PRIMARY KEY,
    STORE_NAME VARCHAR2(90) NOT NULL,
    STORE_ADDSS	VARCHAR2(300) NOT NULL,
    STORE_PHONE	CHAR(15) NULL,
    STORE_TIME VARCHAR2(1000) NULL,
    MAP_LAT VARCHAR2(15) NULL,
    MAP_LNG VARCHAR2(15) NULL,
    BRAND_NO VARCHAR(15) NOT NULL,
    FOREIGN KEY (BRAND_NO) REFERENCES BRAND (BRAND_NO) 
);

COMMENT ON COLUMN STORE.STORE_NO IS '매장번호';
COMMENT ON COLUMN STORE.STORE_NAME IS '매장명';
COMMENT ON COLUMN STORE.STORE_ADDSS IS '주소';
COMMENT ON COLUMN STORE.STORE_PHONE IS '매장 전화번호';
COMMENT ON COLUMN STORE.STORE_TIME IS '영업시간';
COMMENT ON COLUMN STORE.MAP_LAT IS '위도';
COMMENT ON COLUMN STORE.MAP_LNG IS '경도';
COMMENT ON COLUMN STORE.BRAND_NO IS '브랜드코드';

INSERT INTO STORE
VALUES (SEQ_SNO.NEXTVAL, 'BHC치킨 당산점', '서울 영등포구 당산로49길 9 골드라인', '02-2677-9290', '매일 12:00 - 24:00', '11111111234', '2333333345', '1')  ; 

INSERT INTO STORE
VALUES (SEQ_SNO.NEXTVAL, '바른치킨 당산SK점', '서울 영등포구 당산로 41길 11 1층 110호 (당산skv1센터 1층 상가)', '02-2677-9290', '매일 16:00 - 22:00', '2233344556', '35554322133', '2');

INSERT INTO STORE
VALUES (SEQ_SNO.NEXTVAL, '푸라닭 당산점' , '서울 영등포구 당산로 41길 11', '02-2677-9290', '매일 16:00 - 22:00', '34567842455', '2456742453', '3');

--------------------------------------------------------------------------------
--------------------------    MENU 관련    선주  -------------------------------------
--------------------------------------------------------------------------------

CREATE TABLE MENU (
    MENU_NO NUMBER PRIMARY KEY,
    MENU_NAME VARCHAR2(90) NOT NULL,
    MENU_PRICE NUMBER NOT NULL,
    MENU_CATEGORY VARCHAR2(90) NOT NULL,
    STORE_NO NUMBER NOT NULL,
    FOREIGN KEY (STORE_NO) REFERENCES STORE (STORE_NO) 
);

COMMENT ON COLUMN MENU.MENU_NO IS '메뉴번호';
COMMENT ON COLUMN MENU.MENU_NAME IS '메뉴명';
COMMENT ON COLUMN MENU.MENU_PRICE  IS '메뉴가격';
COMMENT ON COLUMN MENU.MENU_CATEGORY IS '메뉴종류';
COMMENT ON COLUMN MENU.STORE_NO IS '매장번호';

INSERT INTO MENU 
VALUES (SEQ_MENO.NEXTVAL, '뿌링클치킨', 18000, '치킨', 1);

INSERT INTO MENU 
VALUES (SEQ_MENO.NEXTVAL, '크크크치킨', 20000, '치킨', 1);

INSERT INTO MENU 
VALUES (SEQ_MENO.NEXTVAL, '고추마요치킨', 22000, '치킨', 1);



----------------규태---------------------------
------- 회원 정보 테이블 -------
-----------------------------
CREATE TABLE MEMBER(
    MEMBER_NO NUMBER PRIMARY KEY,
    MEMBER_NO VARCHAR2(12) NOT NULL UNIQUE,
    MEMBER_PWD VARCHAR2(15) NOT NULL,
    MEMBER_NICKNAME VARCHAR2(30) NOT NULL UNIQUE,
    MEMBER_NAME VARCHAR2(15) NOT NULL,
    EMAIL VARCHAR2(30) NOT NULL,
    PHONE NUMBER NOT NULL,
    BIRTH DATE,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    ADDRESS VARCHAR2(150),
    BLACKLIST CHAR(1) DEFAULT 'N',
    MEMBER_POINT NUMBER DEFAULT 0,
    STATUS CHAR(1) DEFAULT 'Y'
);

COMMENT ON COLUMN MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEMBER_NO IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NICKNAME IS '회원닉네임';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.BIRTH IS '생년월일';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN MEMBER.BLACKLIST IS '블랙리스트여부';
COMMENT ON COLUMN MEMBER.MEMBER_POINT IS '회원포인트';
COMMENT ON COLUMN MEMBER.STATUS IS '탈퇴여부';

-- 더미데이터
INSERT INTO MEMBER VALUES(SEQ_MNO.NEXTVAL, 'admin', 'admin', '관리자', '관리자', 'daknawa@gmail.com', '01012345678', NULL, NULL, NULL, DEFAULT, 100, DEFAULT);
INSERT INTO MEMBER VALUES(SEQ_MNO.NEXTVAL, 'user01', 'pass01', '치킨좀먹어본놈', '홍길동', 'honggd@gmail.com', '01011112222', NULL, '남', '서울시 영등포구', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO MEMBER VALUES(SEQ_MNO.NEXTVAL, 'user02', 'pass02', '치킨쿤', '차보해', 'chickenkun@gmail.com', '01077779999', '1998-04-08', '남', '강원도 원주시', DEFAULT, DEFAULT, DEFAULT);

----------------------------------------- 
---------------- QNA 동재 -------------------
-----------------------------------------

CREATE TABLE QNA (
	ASK_NO NUMBER PRIMARY KEY NOT NULL,
	ASK_TYPE NUMBER	DEFAULT 1 NOT NULL,
	ASK_TITLE VARCHAR(100) NOT NULL,
	ASK_CONTENT	VARCHAR2(1000) NOT NULL,
	ASK_DATE DATE DEFAULT SYSDATE ,
	ANSWER_CONTENT VARCHAR2(1000) NOT NULL,
	ANSWER_DATE	DATE DEFAULT SYSDATE ,
	MEMBER_NO NUMBER NOT NULL,
	CONSTRAINT FK_MEMBER_TO_QNA FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER (MEMBER_NO)
);

INSERT INTO QNA VALUES (SEQ_QNO.NEXTVAL, 1, '문의 제목 1', '문의 내용 1', SYSDATE, '답변 내용 1', SYSDATE, 1);
INSERT INTO QNA VALUES (SEQ_QNO.NEXTVAL, 1, '문의 제목 2', '문의 내용 2', SYSDATE, '답변 내용 2', SYSDATE, 1);
INSERT INTO QNA VALUES (SEQ_QNO.NEXTVAL, 1, '문의 제목 3', '문의 내용 3', SYSDATE, '답변 내용 3', SYSDATE, 1);

-------------------------
----- 회원 등급 테이블 규태 -----
-------------------------
CREATE TABLE MEMBER_GRADE(
    MEMBER_CODE CHAR(1) PRIMARY KEY,
    GRADE_NAME VARCHAR2(12) NOT NULL UNIQUE,
    POINT_MIN NUMBER NOT NULL,
    POINT_MAX NUMBER NOT NULL
);

COMMENT ON COLUMN MEMBER_GRADE.MEMBER_CODE IS '회원등급코드';
COMMENT ON COLUMN MEMBER_GRADE.GRADE_NAME IS '회원등급명';
COMMENT ON COLUMN MEMBER_GRADE.POINT_MIN IS '최저점';
COMMENT ON COLUMN MEMBER_GRADE.POINT_MAX IS '최고점';

-- 더미데이터
INSERT INTO MEMBER_GRADE VALUES('1', '준회원', 0, 20);
INSERT INTO MEMBER_GRADE VALUES('2', '정회원', 21, 40);
INSERT INTO MEMBER_GRADE VALUES('3', '우수회원', 41, 80);
INSERT INTO MEMBER_GRADE VALUES('4', '특별회원', 81, 100);




-----------------------------------------
----------- 메뉴 좋아요 관련 소연 --------------
-----------------------------------------  
CREATE TABLE MENU_LIKE (
	MENU_NO NUMBER NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
    FOREIGN KEY(MENU_NO) REFERENCES MENU (MENU_NO),
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER (MEMBER_NO)
);

INSERT INTO MENU_LIKE 
VALUES (1, 1);

INSERT INTO MENU_LIKE 
VALUES (2, 2);

-----------------------------------------
------------- 회원 신고 관련 소연 --------------
-----------------------------------------  
CREATE TABLE MEMBER_REPORT (
	MR_NO NUMBER PRIMARY KEY,
	MR_HISTORY VARCHAR2(1000) NULL,
	MR_TYPE	NUMBER DEFAULT 1 NOT NULL,
	MR_ANSWER VARCHAR2(1000) NULL,
	MEMBER_NO NUMBER NOT NULL,
	MEMBER_NO2 NUMBER NOT NULL,
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO),
    FOREIGN KEY(MEMBER_NO2) REFERENCES MEMBER(MEMBER_NO)
);

COMMENT ON COLUMN MEMBER_REPORT.MR_NO IS '회원신고번호';
COMMENT ON COLUMN MEMBER_REPORT.MR_HISTORY IS '회원신고사유';
COMMENT ON COLUMN MEMBER_REPORT.MR_TYPE IS '회원신고상태';
COMMENT ON COLUMN MEMBER_REPORT.MR_ANSWER IS '회원신고내용답변';
COMMENT ON COLUMN MEMBER_REPORT.MEMBER_NO IS '신고자';
COMMENT ON COLUMN MEMBER_REPORT.MEMBER_NO2 IS '피신고자';

INSERT INTO MEMBER_REPORT 
VALUES (SEQ_MRNO.NEXTVAL, '욕설', 1, '욕했음 추방시켜야지', 1, 1);

INSERT INTO MEMBER_REPORT 
VALUES (SEQ_MRNO.NEXTVAL, '타인비방', 2, '타인비방은 안댕!!', 2, 2);

INSERT INTO MEMBER_REPORT 
VALUES (SEQ_MRNO.NEXTVAL, '기타', 3, '기타사유', 3, 3);
----------------------------- 현우 ----------------------------------------

CREATE TABLE POST_CATEGORY (
    POST_CAT_NO NUMBER(10) PRIMARY KEY NOT NULL,
    INSTROG VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN POST_CATEGORY.POST_CAT_NO IS '게시글 유형 NO';
COMMENT ON COLUMN POST_CATEGORY.INSTROG IS '게시판 종류';

INSERT INTO POST_CATEGORY
VALUES (1, '공지게시판');
INSERT INTO POST_CATEGORY
VALUES (2, '자유게시판');
INSERT INTO POST_CATEGORY
VALUES (3, '리뷰 게시판');


----------------------------- 현우 ----------------------------------------
----------------------------- 현우 ----------------------------------------


CREATE TABLE POST (
	POST_NO NUMBER PRIMARY KEY,
	MEMBER_NO NUMBER NOT NULL,
	POST_TITLE VARCHAR2(200) NOT NULL,
	POST_CONTENT VARCHAR2(4000) NOT NULL,
	POST_VIEW NUMBER DEFAULT 0,
	POST_DATE DATE NOT NULL,
	POST_DEL CHAR(1) DEFAULT 'N' NOT NULL,
	POST_CAT_NO NUMBER NOT NULL,
	CONSTRAINT POST_FK1 FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER (MEMBER_NO),
	CONSTRAINT POST_FK2 FOREIGN KEY (POST_CAT_NO) REFERENCES POST_CATEGORY (POST_CAT_NO)
);
COMMENT ON COLUMN POST.POST_NO IS '게시글 NO';
COMMENT ON COLUMN POST.POST_TITLE IS '게시글 제목';
COMMENT ON COLUMN POST.POST_CONTENT IS '게시글 내용';
COMMENT ON COLUMN POST.POST_VIEW IS '게시글 조회수';
COMMENT ON COLUMN POST.POST_DATE IS '게시글 작성일';
COMMENT ON COLUMN POST.POST_DEL IS '게시글 삭제여부';

INSERT INTO POST
VALUES(SEQ_PNO.NEXTVAL, 1, '잘 들어갔나?', '잘 들어갔나 모르겠네', 0, SYSDATE, 'N', 1);
INSERT INTO POST
VALUES(SEQ_PNO.NEXTVAL, 2, '들어간거 일지도?', '들어갔어!! 들어왔다고!', 0, SYSDATE, 'N', 2);
INSERT INTO POST
VALUES (SEQ_PNO.NEXTVAL, 3, '안들어갔나?', '들어갔지만 안들어간거지', 0, SYSDATE, 'Y', 3);

---------------------------------------------

-- 게시글 좋아요 DB 민수 --
CREATE TABLE POST_LIKE (
	MEMBER_NO NUMBER NOT NULL,
	POST_NO NUMBER NOT NULL
);

INSERT INTO POST_LIKE VALUES (1, 1);
INSERT INTO POST_LIKE VALUES (2, 1);
INSERT INTO POST_LIKE VALUES (2, 2);
    
-------------------------------------------




-- 게시판 종류
CREATE TABLE FILE_TABLE (
    FILE_NO NUMBER(10) NOT NULL,
    INSTROG VARCHAR2(200) NOT NULL,
    FILE_DATE DATE NOT NULL,
    THUMBNAIL CHAR(1) DEFAULT 'N',
    POST_NO NUMBER(10),
    CONSTRAINT PK_FILE PRIMARY KEY (FILE_NO),
    CONSTRAINT FK_FILE_POST FOREIGN KEY (POST_NO) REFERENCES POST(POST_NO)
);

COMMENT ON COLUMN FILE_TABLE.FILE_NO IS '파일 NO';
COMMENT ON COLUMN FILE_TABLE.INSTROG IS '파일경로/수정명';
COMMENT ON COLUMN FILE_TABLE.FILE_DATE IS '업로드일';
COMMENT ON COLUMN FILE_TABLE.THUMBNAIL IS '썸네일 여부';
COMMENT ON COLUMN FILE_TABLE.POST_NO IS '게시글 NO';

INSERT INTO FILE_TABLE
VALUES (SEQ_FNO.NEXTVAL, 'RESOURCES/..', SYSDATE, 'N', 1);
INSERT INTO FILE_TABLE
VALUES (SEQ_FNO.NEXTVAL, 'RESOURCES/..', SYSDATE, 'N', 2);


---------------- 소연 -------------------
-----------------------------------------
------------- 게시글 신고 관련 ------------
-----------------------------------------
CREATE TABLE POST_REPORT (
	REPORT_NO NUMBER PRIMARY KEY,
	REPORT_CATEGORY	VARCHAR(15) NULL,
	REPORT_HISTORY VARCHAR2(1000) NULL,
	REPORT_TYPE	NUMBER NULL,
	REPORT_ANSWER VARCHAR2(1000) NULL,
	POST_NO NUMBER NOT NULL,
	MEMBER_NO NUMBER NOT NULL,
    FOREIGN KEY(POST_NO) REFERENCES POST(POST_NO),
    FOREIGN KEY(MEMBER_NO) REFERENCES MEMBER(MEMBER_NO)
);

COMMENT ON COLUMN POST_REPORT.REPORT_NO IS '신고넘버';
COMMENT ON COLUMN POST_REPORT.REPORT_CATEGORY IS '신고카테고리';
COMMENT ON COLUMN POST_REPORT.REPORT_HISTORY IS '신고사유';
COMMENT ON COLUMN POST_REPORT.REPORT_TYPE IS '신고상태';
COMMENT ON COLUMN POST_REPORT.REPORT_ANSWER IS '신고내용답변';
COMMENT ON COLUMN POST_REPORT.POST_NO IS '게시글NO';
COMMENT ON COLUMN POST_REPORT.MEMBER_NO IS '회원번호';

INSERT INTO POST_REPORT 
VALUES (SEQ_MNO.NEXTVAL, '댓글신고', '욕설', 1, '욕설은 나쁜겁니다. 당신을 추방시키겠습니다.', 1, 1);

INSERT INTO POST_REPORT 
VALUES (SEQ_MNO.NEXTVAL, '게시글신고', '타인비방', 2, '하늘아래 다 같은 인간입니다. 타인을 비방하지 마세요', 2, 2);

INSERT INTO POST_REPORT 
VALUES (SEQ_MNO.NEXTVAL, '기타', '기타', 3, '기타', 3, 3);

-------------------------------------------------
--댓글 DB ---------------- 민수

CREATE TABLE REPLY (
	REPLY_NO NUMBER NOT NULL,
	REPLY_POST VARCHAR2(1000) NOT NULL,
	REPLY_DATE DATE	DEFAULT SYSDATE	NULL,
	REPLY_DEL CHAR(1) DEFAULT 'Y' NULL,
	POST_NO NUMBER NOT NULL,
	MEMBER_NO NUMBER NOT NULL
);

ALTER TABLE REPLY ADD CONSTRAINT PK_REPLY PRIMARY KEY (	REPLY_NO );
ALTER TABLE REPLY ADD CONSTRAINT FK_POST_TO_REPLY_1 FOREIGN KEY ( POST_NO ) REFERENCES POST (POST_NO);
ALTER TABLE REPLY ADD CONSTRAINT FK_MEMBER_TO_REPLY_1 FOREIGN KEY (	MEMBER_NO) REFERENCES MEMBER (	MEMBER_NO);

INSERT INTO REPLY (REPLY_NO, REPLY_POST, REPLY_DATE, REPLY_DEL, POST_NO, MEMBER_NO)
VALUES (SEQ_RNO.NEXTVAL, '이것은 첫 번째 더미 댓글입니다.', SYSDATE, 'N', 1, 1);

INSERT INTO REPLY (REPLY_NO, REPLY_POST, REPLY_DATE, REPLY_DEL, POST_NO, MEMBER_NO)
VALUES (SEQ_RNO.NEXTVAL, '이것은 두 번째 더미 댓글입니다.', SYSDATE, 'N', 1, 2);

INSERT INTO REPLY (REPLY_NO, REPLY_POST, REPLY_DATE, REPLY_DEL, POST_NO, MEMBER_NO)
VALUES (SEQ_RNO.NEXTVAL, '이것은 세 번째 더미 댓글입니다.', SYSDATE, 'N', 2, 1);


-- 댓글 신고 DB 민수---------------

CREATE TABLE REPLY_REPORT (
	RR_NO NUMBER NOT NULL,
	RR_HISTORY VARCHAR2(1000) NOT NULL,
	RR_TYPE	NUMBER	DEFAULT 1 NULL,
	RR_ANSWER VARCHAR2(1000) NULL,
	MEMBER_NO NUMBER NOT NULL,
	REPLY_NO NUMBER NULL
);

ALTER TABLE REPLY_REPORT ADD CONSTRAINT PK_REPLY_REPORT PRIMARY KEY (RR_NO);
ALTER TABLE REPLY_REPORT ADD CONSTRAINT FK_MEMBER_TO_REPLY_REPORT_1 FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER (MEMBER_NO);
ALTER TABLE REPLY_REPORT ADD CONSTRAINT FK_REPLY_TO_REPLY_REPORT_1 FOREIGN KEY (REPLY_NO) REFERENCES REPLY (REPLY_NO);

INSERT INTO REPLY_REPORT (RR_NO, RR_HISTORY, RR_TYPE, RR_ANSWER, MEMBER_NO, REPLY_NO)
VALUES (SEQ_RRNO.NEXTVAL, '부적절한 언어 사용', 1, NULL, 1, 1);

INSERT INTO REPLY_REPORT (RR_NO, RR_HISTORY, RR_TYPE, RR_ANSWER, MEMBER_NO, REPLY_NO)
VALUES (SEQ_RRNO.NEXTVAL, '광고 및 홍보성 내용', 1, NULL, 2, 1);

INSERT INTO REPLY_REPORT (RR_NO, RR_HISTORY, RR_TYPE, RR_ANSWER, MEMBER_NO, REPLY_NO)
VALUES (SEQ_RRNO.NEXTVAL, '욕설 및 비방성 내용', 1, NULL, 1, 2);

----------------------------------------- 
---------------- 신고 동재 -------------------
-----------------------------------------

CREATE TABLE REPLY_LIKE (
	MEMBER_NO NUMBER NOT NULL,
	REPLY_NO NUMBER NOT NULL,
	CONSTRAINT FK_REPLY_LIKE_MEMBER FOREIGN KEY (MEMBER_NO) REFERENCES MEMBER (MEMBER_NO),
	CONSTRAINT FK_REPLY_LIKE_REPLY FOREIGN KEY (REPLY_NO) REFERENCES REPLY (REPLY_NO)
);

INSERT INTO REPLY_LIKE VALUES (1, 1);
INSERT INTO REPLY_LIKE VALUES (2, 1);
INSERT INTO REPLY_LIKE VALUES (2, 2);


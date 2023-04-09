-------------------------------------------------
--댓글 DB --

CREATE TABLE "REPLY" (
	"REPLY_ID"	NUMBER		NOT NULL,
	"REPLY_POST"	VARCHAR2(1000)		NOT NULL,
	"REPLY_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"REPLY_DEL"	CHAR(1)	DEFAULT 'Y'	NULL,
	"PST_ID"	NUMBER		NOT NULL,
	"MEMBER_NO"	NUMBER		NOT NULL
);

CREATE SEQUENCE "REPLY_SEQ" 
START WITH 1 
INCREMENT BY 1 
NOCACHE 
NOCYCLE;

ALTER TABLE "REPLY" ADD CONSTRAINT "PK_REPLY" PRIMARY KEY (
	"REPLY_ID"
);

ALTER TABLE "REPLY" ADD CONSTRAINT "FK_NOTICEBOARD_POST_TO_REPLY_1" FOREIGN KEY (
	"PST_ID"
)
REFERENCES "NOTICEBOARD_POST" (
	"PST_ID"
);

ALTER TABLE "REPLY" ADD CONSTRAINT "FK_MEMBER_TO_REPLY_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

INSERT INTO "REPLY" ("REPLY_ID", "REPLY_POST", "REPLY_DATE", "REPLY_DEL", "PST_ID", "MEMBER_NO")
VALUES ("REPLY_SEQ".NEXTVAL, '이것은 첫 번째 더미 댓글입니다.', SYSDATE, 'N', 1, 1);

INSERT INTO "REPLY" ("REPLY_ID", "REPLY_POST", "REPLY_DATE", "REPLY_DEL", "PST_ID", "MEMBER_NO")
VALUES ("REPLY_SEQ".NEXTVAL, '이것은 두 번째 더미 댓글입니다.', SYSDATE, 'N', 1, 2);

INSERT INTO "REPLY" ("REPLY_ID", "REPLY_POST", "REPLY_DATE", "REPLY_DEL", "PST_ID", "MEMBER_NO")
VALUES ("REPLY_SEQ".NEXTVAL, '이것은 세 번째 더미 댓글입니다.', SYSDATE, 'N', 2, 1);

---------------------------------------------

-- 게시글 좋아요 DB --
CREATE TABLE "POST_LIKE" (
	"MEMBER_NO"	NUMBER		NOT NULL,
	"PST_ID"	NUMBER		NOT NULL
);

INSERT INTO "POST_LIKE" VALUES (1, 1);
INSERT INTO "POST_LIKE" VALUES (2, 1);
INSERT INTO "POST_LIKE" VALUES (2, 2);
    
-------------------------------------------

-- 댓글 신고 DB

CREATE TABLE "REPLY_REPORT" (
	"RR_NO"	NUMBER		NOT NULL,
	"RR_HISTORY"	VARCHAR2(1000)		NOT NULL,
	"RR_TYPE"	NUMBER	DEFAULT 1	NULL,
	"RR_ANSWER"	VARCHAR2(1000)		NULL,
	"MEMBER_NO"	NUMBER		NOT NULL,
	"REPLY_ID"	NUMBER		NULL
);

CREATE SEQUENCE "REPLY_REPORT_SEQ" 
START WITH 1 
INCREMENT BY 1 
NOCACHE 
NOCYCLE;

ALTER TABLE "REPLY_REPORT" ADD CONSTRAINT "PK_REPLY_REPORT" PRIMARY KEY (
	"RR_NO"
);

ALTER TABLE "REPLY_REPORT" ADD CONSTRAINT "FK_MEMBER_TO_REPLY_REPORT_1" FOREIGN KEY (
	"MEMBER_NO"
)
REFERENCES "MEMBER" (
	"MEMBER_NO"
);

ALTER TABLE "REPLY_REPORT" ADD CONSTRAINT "FK_REPLY_TO_REPLY_REPORT_1" FOREIGN KEY (
	"REPLY_ID"
)
REFERENCES "REPLY" (
	"REPLY_ID"
);

INSERT INTO "REPLY_REPORT" ("RR_NO", "RR_HISTORY", "RR_TYPE", "RR_ANSWER", "MEMBER_NO", "REPLY_ID")
VALUES (REPLY_REPORT_SEQ.NEXTVAL, '부적절한 언어 사용', 1, NULL, 1, 1);

INSERT INTO "REPLY_REPORT" ("RR_NO", "RR_HISTORY", "RR_TYPE", "RR_ANSWER", "MEMBER_NO", "REPLY_ID")
VALUES (REPLY_REPORT_SEQ.NEXTVAL, '광고 및 홍보성 내용', 1, NULL, 2, 1);

INSERT INTO "REPLY_REPORT" ("RR_NO", "RR_HISTORY", "RR_TYPE", "RR_ANSWER", "MEMBER_NO", "REPLY_ID")
VALUES (REPLY_REPORT_SEQ.NEXTVAL, '욕설 및 비방성 내용', 1, NULL, 1, 2);

-----------------------------------------
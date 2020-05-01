DROP TABLE TB_HISTORY;
DROP TABLE TB_CURRENT_STATE;
DROP TABLE TB_POPUP;
DROP TABLE TB_HABIT_CHECK;
DROP TABLE TB_HABIT;
DROP TABLE TB_M_TITLE;
DROP TABLE TB_WISE;
DROP TABLE TB_CATEGORY;
DROP TABLE TB_TITLE;
DROP TABLE TB_MEMBER;

-- 테이블 생성
CREATE TABLE TB_MEMBER (
    M_ID                    VARCHAR2(100 CHAR) NOT NULL,
    M_PASS                  VARCHAR2(200 CHAR) NOT NULL,
    M_NAME                  VARCHAR2(100 CHAR) NOT NULL,
    M_EMAIL                 VARCHAR2(100 CHAR) NOT NULL,
    M_NICKNAME              VARCHAR2(100 CHAR) NOT NULL,
    REPRESENTATION_TITLE    NUMBER(5),
    LOGIN_CNT               NUMBER(5),
    JOIN_DATE               DATE,
    LEAVE_YN                VARCHAR2(1 CHAR),
    ORIGINAL_FILEPATH       VARCHAR2(300 BYTE), 
	RENAME_FILEPATH         VARCHAR2(300 BYTE) 
);

-- 주 키 설정
ALTER TABLE TB_MEMBER ADD CONSTRAINT TB_MEMBER_PK PRIMARY KEY ( M_ID );

CREATE TABLE TB_CATEGORY (
    C_CODE      NUMBER(5) NOT NULL,
    C_NAME      VARCHAR2(100 CHAR)
);

ALTER TABLE TB_CATEGORY ADD CONSTRAINT TB_CATEGORY_PK PRIMARY KEY ( C_CODE );

CREATE TABLE TB_HABIT (
    H_NO            NUMBER(5) NOT NULL,
    H_SUBCATEGORY   VARCHAR2(100 CHAR),
    H_START_DATE    DATE,
    H_END_DATE      DATE,
    H_SELECTDAY     VARCHAR2(100 CHAR),
    H_MONEY         NUMBER(10),
    H_TIME          NUMBER(5),
    C_CODE          NUMBER(5) NOT NULL,
    M_ID            VARCHAR2(100 CHAR) NOT NULL
);

ALTER TABLE TB_HABIT ADD CONSTRAINT TB_HABIT_PK PRIMARY KEY ( H_NO );

CREATE TABLE TB_CURRENT_STATE (
    C_STATE_NO  NUMBER(5) NOT NULL,
    C_COUNT     NUMBER(5),
    C_COUNTALL  NUMBER(5),
    C_PERCENT   NUMBER(5),
    M_ID        VARCHAR2(100 CHAR) NOT NULL,
    H_NO        NUMBER(5) NOT NULL
);

ALTER TABLE TB_CURRENT_STATE ADD CONSTRAINT TB_CURRENT_STATE_PK PRIMARY KEY ( C_STATE_NO );

CREATE TABLE TB_HABIT_CHECK(
    H_CHECK_NO      NUMBER(5) NOT NULL,
    H_CHECK_YN      VARCHAR2(1 CHAR),
    H_CHECK_DATE    DATE,
    M_ID            VARCHAR2(100 CHAR) NOT NULL,
    H_NO            NUMBER(5) NOT NULL
);

ALTER TABLE TB_HABIT_CHECK ADD CONSTRAINT TB_HABIT_CHECK_PK PRIMARY KEY ( H_CHECK_NO );

CREATE TABLE TB_HISTORY (
    HIS_NO              NUMBER(5) NOT NULL,  
    HIS_SUBCATEGORY     VARCHAR2(1000 CHAR),
    HIS_STARTDATE       DATE,
    HIS_END_DATE        DATE,
    HIS_PERCENT         NUMBER(5),
    C_CODE              NUMBER(5) NOT NULL,
    M_ID                VARCHAR2(100 CHAR) NOT NULL,
    H_NO                NUMBER(5) NOT NULL
);

ALTER TABLE TB_HISTORY ADD CONSTRAINT TB_HISTORY_PK PRIMARY KEY ( HIS_NO );

CREATE TABLE TB_TITLE (
    T_CODE      NUMBER(5) NOT NULL,
    T_NAME      VARCHAR2(100 CHAR),
    T_COMMENT   VARCHAR2(1000 CHAR),
    T_CONDITION VARCHAR2(1000 CHAR), --타이틀 조건
    T_COLOR     VARCHAR2(20 CHAR)
);

ALTER TABLE TB_TITLE ADD CONSTRAINT TB_TITLE_PK PRIMARY KEY ( T_CODE );

CREATE TABLE TB_M_TITLE (
    M_ID        VARCHAR2(100 CHAR) NOT NULL,
    T_CODE      NUMBER(5) NOT NULL
);

ALTER TABLE TB_M_TITLE ADD CONSTRAINT TB_M_TITLE_PK PRIMARY KEY ( M_ID, T_CODE );

CREATE TABLE TB_POPUP (
    P_CODE       NUMBER(5) NOT NULL,
    P_TEXT       VARCHAR2(1000 CHAR)
);

ALTER TABLE TB_POPUP ADD CONSTRAINT TB_POPUP_PK PRIMARY KEY ( P_CODE );

CREATE TABLE TB_WISE (
    W_CODE       NUMBER(5) NOT NULL,
    W_TEXT       VARCHAR2(1000 CHAR)
);

ALTER TABLE TB_WISE ADD CONSTRAINT TB_WISE_PK PRIMARY KEY ( W_CODE );


-- 외래키 설정
ALTER TABLE TB_HABIT
    ADD CONSTRAINT TB_HABIT_TB_MEMBER_FK FOREIGN KEY ( M_ID )
        REFERENCES TB_MEMBER ( M_ID );
        
ALTER TABLE TB_HABIT
    ADD CONSTRAINT TB_HABIT_TB_CATEGORY_FK FOREIGN KEY ( C_CODE )
        REFERENCES TB_CATEGORY ( C_CODE );
        
ALTER TABLE TB_CURRENT_STATE 
    ADD CONSTRAINT TB_CURRENT_STATE_TB_MEMBER_FK FOREIGN KEY ( M_ID )
        REFERENCES TB_MEMBER ( M_ID );
        
ALTER TABLE TB_CURRENT_STATE
    ADD CONSTRAINT TB_CURRENT_STATE_TB_HABIT_FK FOREIGN KEY ( H_NO )
        REFERENCES TB_HABIT ( H_NO );

ALTER TABLE TB_HABIT_CHECK 
    ADD CONSTRAINT TB_HABIT_CHECK_TB_MEMBER_FK FOREIGN KEY ( M_ID )
        REFERENCES TB_MEMBER ( M_ID );
        
ALTER TABLE TB_HABIT_CHECK
    ADD CONSTRAINT TB_HABIT_CHECK_TB_HABIT_FK FOREIGN KEY ( H_NO )
        REFERENCES TB_HABIT ( H_NO );

ALTER TABLE TB_HISTORY
    ADD CONSTRAINT TB_HISTORY_TB_MEMBER_FK FOREIGN KEY ( M_ID )
        REFERENCES TB_MEMBER ( M_ID );
        
ALTER TABLE TB_HISTORY
    ADD CONSTRAINT TB_HISTORY_TB_HABIT_FK FOREIGN KEY ( H_NO )
        REFERENCES TB_HABIT ( H_NO );

ALTER TABLE TB_HISTORY
    ADD CONSTRAINT TB_HISTORY_TB_CATEGORY_FK FOREIGN KEY ( C_CODE )
        REFERENCES TB_CATEGORY ( C_CODE );
        
ALTER TABLE TB_M_TITLE
    ADD CONSTRAINT TB_M_TITLE_TB_TITLE_FK FOREIGN KEY ( T_CODE )
        REFERENCES TB_TITLE ( T_CODE );
        
ALTER TABLE TB_M_TITLE
    ADD CONSTRAINT TB_M_TITLE_TB_MEMBER_FK FOREIGN KEY ( M_ID )
        REFERENCES TB_MEMBER ( M_ID );
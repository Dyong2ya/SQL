2021-0512-01)테이블 객체
1. 테이블 생성(2차배열의 가장 기본)
-관계형 데이터베이스의 기본구조
-행과 열로 구성
-테이블명은 해당 데이터베이스에서 유일한 식별자이어야 함 //ex)buyer, buyprod, cart, ...
-TBL(테이블의 약자)을 앞에 붙이기도 함
(사용형식)
CREATE TABLE 테이블명(
 컬럼명1 데이터타입[(크기)][NOT NULL][DEFAULT 값][,]
 컬럼명2 데이터타입[(크기)][NOT NULL][DEFAULT 값][,]
                        :
 컬럼명n 데이터타입[(크기)][NOT NULL][DEFAULT 값][,]
 
 CONSTRAINT 기본키설정명 PRIMARY KEY(컬럼명[,컬럼명,...])[,]
 CONSTRAINT 외래키설정명 FOREIGN KEY(컬럼명[,컬럼명,...])
    REFERENCES 테이블명(컬럼명[,컬럼명,...])[,]
 CONSTRAINT 외래키설정명 FOREIGN KEY(컬럼명[,컬럼명,...])
     REFERENCES 테이블명(컬럼명[,컬럼명,...])[,]
                            :
 CONSTRAINT 외래키설정명n FOREIGN KEY(컬럼명[,컬럼명,...])
     REFERENCES 테이블명(컬럼명[,컬럼명,...]);
     
 사용예) 교안에서 주어진 한국건설의 업무를 DB로 모델링한 자료를 이용하여 테이블을 
        생성하시오
 1)사원테이블
    (1)테이블명: EMPLOYEE
    (2)컬럼 및 제약사항
        ---------------------------------------------------------------------------
        컬럼명               데이터타입            NULL       PK/FK
        ---------------------------------------------------------------------------
        EMP_ID              CHAR(4)              N.N        PK
        EMP_NAME            VARCHAR2(20)         N.N 
        EMP_ADDR            VARCHAR2(80)            
        TEL_NO              VARCHAR2(20)
        EMP_POSITION        VARCHAR2(30)
        DEPT_NAME           VARCHAR2(20)
        ----------------------------------------------------------------------------
CREATE TABLE EMPLOYEE(
 EMP_ID       CHAR(4) NOT NULL,
 EMP_NAME     VARCHAR2(20) NOT NULL,
 EMP_ADDR     VARCHAR2(80),
 TEL_NO       VARCHAR2(20),
 EMP_POSITION VARCHAR2(30),
 DEPT_NAME    VARCHAR2(20),
 CONSTRAINT pk_employee PRIMARY KEY(EMP_ID));
 
 2)사업장 테이블
    (1)테이블명: SITE
    (2)컬럼 및 제약사항
        ---------------------------------------------------------------------------
        컬럼명               데이터타입            NULL       PK/FK
        ---------------------------------------------------------------------------
        SITE_NO             CHAR(6)              N.N        PK  --사업장번호
        SITE_NAME           VARCHAR2(50)         N.N            --사업장명
        SITE_ADDR           VARCHAR2(80)                        --사업장주소
        SITE_TEL_NO         VARCHAR2(20)                        --사업장전화번호
        AMOUNT_CON          NUMBER(11)           DEFAULT 0      --공사금액
        INPUT_MAN_CNT       NUMBER(4)                           --투입인원
        START_DATE          DATE                                --시공일자
        COMPLITE_DATE       DATE                                --완공일자
        REMARKS             VARCHAR2(200)                       --비고
        ---------------------------------------------------------------------------
 CREATE TABLE SITE(
 SITE_NO        CHAR(6),      
 SITE_NAME      VARCHAR2(50) NOT NULL,
 SITE_ADDR      VARCHAR2(80),
 SITE_TEL_NO    VARCHAR2(20),
 AMOUNT_CON     NUMBER(11)   DEFAULT 0,
 INPUT_MAN_CNT  NUMBER(4),
 START_DATE     DATE,
 COMPLITE_DATE  DATE,
 REMARKS        VARCHAR2(200),
 CONSTRAINT pk_site PRIMARY KEY(SITE_NO));
 
 3)사업장자재 테이블
    (1)테이블명: SITE_ITEM
    (2)컬럼 및 제약사항
        ---------------------------------------------------------------------------
        컬럼명               데이터타입            NULL       PK/FK
        ---------------------------------------------------------------------------
        SITE_ITEM_ID        CHAR(6)             N.N         PK  --자재코드
        SITE_ITEM_NAME      VARCHAR2(30)        N.N             --자재명
        QTY                 NUMBER(3)                           --수량
        PRICE               NUMBER(8)                           --가격
        BUY_DATE            DATE                                --구입일
        SITE_NO             CHAR(6)                         FK  --사업장번호
        -----------------------------------------------------------------------------
 CREATE TABLE SITE_ITEM(
 SITE_ITEM_ID        CHAR(6),                          
 SITE_ITEM_NAME      VARCHAR2(30)        NOT NULL,             
 QTY                 NUMBER(3),                           
 PRICE               NUMBER(8),                          
 BUY_DATE            DATE,                        
 SITE_NO             CHAR(6),
 CONSTRAINT pk_site_item PRIMARY KEY(SITE_ITEM_ID),
 CONSTRAINT fk_site_item_SITE FOREIGN KEY(SITE_NO) REFERENCES SITE(SITE_NO));
 
 4)근무 테이블
    (1)테이블명: TBL_WORK
    (2)컬럼 및 제약사항
        ---------------------------------------------------------------------------
        컬럼명               데이터타입            NULL       PK/FK
        ---------------------------------------------------------------------------
        EMP_ID              CHAR(4)              N.N        PK,FK  --사원번호
        SITE_NO             CHAR(6)              N.N        PK,FK  --사업자번호
        INS_DATE            DATE           DEFAULT SYSDATE
        ----------------------------------------------------------------------------
 CREATE TABLE TBL_WORK(
 EMP_ID              CHAR(4)  NOT NULL,
 SITE_NO             CHAR(6)  NOT NULL,           
 INS_DATE            DATE     DEFAULT SYSDATE,
 CONSTRAINT pk_tblwork PRIMARY KEY(EMP_ID,SITE_NO),
 CONSTRAINT fk_tblwork_emp FOREIGN KEY(EMP_ID)
    REFERENCES EMPLOYEE(EMP_ID),
 CONSTRAINT fk_tblwork_site FOREIGN KEY(SITE_NO)
    REFERENCES SITE(SITE_NO));
    
 
 
 
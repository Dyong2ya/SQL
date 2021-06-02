2021-0513-03)데이터 타입
 -오라클에서 사용되는 데이터타입은 문자열, 숫자, 날짜, 이진자료형이 존재
 
 1. 문자열
  -문자열 자료는 ''안에 정의된 자료
  -대소문자를 구별하여 사용
  -가변길이와 고정길이 타입으로 구분
  -CHAR, VARCHAR,VARCHAR2,NVARCHAR,NVARCHAR2,LONG,CLOB(--대용량 4GB)
 1)CHAR
  . 고정길이 문자열을 저장한다
  (사용형식)
  컬럼명 CHAR(n [CHAR|BYTE]);
   -n : 확보할 기억공간의 크기로 최대 2000 BYTE까지 사용 가능
   -데이터가 작으면 남는 공간(오른쪽)은 공백으로 채워짐
   -데이터가 n보다 크면 오류
   -한글 한글자는 3BYTE로 처리됨
   -'CHAR|BYTE': n이 글자수인지 바이트인지 규정
     n이 글자수를 나타내어도 전체 2000BYTE를 초과할 수 없음
     =>한글을 2000자까지 처리하지 못 함(666글자까지 저장)
    
사용예)
CREATE TABLE TEMP01(
  COL1  CHAR(10),
  COL2  CHAR(10 BYTE),
  COL3  CHAR(10 CHAR));
 
ALTER TABLE TEMP01 RENAME COLUMN COL TO COL3;--내가 추가한 거
  
INSERT INTO TEMP01 VALUES('대전','ABCDEFGHIJ','대전 중구 성모병원');
INSERT INTO TEMP01 VALUES('대덕구','ABC','성모병원');

SELECT DISTINCT COL1, COL2, COL3 FROM TEMP01;--내가 추가한 거 
SELECT * FROM TEMP01;

SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
 FROM TEMP01; 
  
 2)VARCHAR2
  . 가변길이 문자열을 저장한다
  . 최대 4000BYTE 까지 저장 가능
  . 사용하고 남는 공간은 시스템에 반납 --빈공간 발생X, 큰 자료사용할 때 좋음
  (사용형식)
  컬럼명 VARCHAR(n [CHAR|BYTE]);
 
사용예)
CREATE TABLE TEMP02(
  COL1  VARCHAR2(100),
  COL2  VARCHAR2(100 BYTE),
  COL3  VARCHAR2(4000 CHAR));
  
INSERT INTO TEMP02 VALUES('대전','ABCDEFGHIJ','대전 중구 성모병원');
INSERT INTO TEMP02 VALUES('대덕구','ABC','성모병원');
  
SELECT * 
  FROM TEMP02
 WHERE COL3='성모병원';
 
SELECT LENGTHB(COL1),LENGTHB(COL2),LENGTHB(COL3)
 FROM TEMP02;
 
 3)LONG
  . 가변길이 문자열을 저장
  . 최대 2G 까지 저장 가능
  . 제약사항: 한테이블에 한 컬럼만 LONG으로 선언 가능 --밑에 TEMP03에 COL3에도 LONG 두 개넣으면 오류나는 거 볼 수 있어.
  . CLOB 타입으로 대체(LONG 의 기능개선 서비스는 종료)
  (사용형식)
  컬럼명 LONG;
  -LONG 타입 컬럼이 사용되는 곳
  =>SELECT문의 SELECT 절, UPDATE문의 SET절, INSERT문의 VALUES절

사용예)
CREATE TABLE TEMP03(
  COL1  LONG,
  COL2  VARCHAR2(4000),
  COL3  CLOB);
  
INSERT INTO TEMP03 VALUES('대전시','대전시 중구','대전시 중구 대흥동');

SELECT * FROM TEMP03

SELECT LENGTHB(COL2) FROM TEMP03;

 4)CLOB(Character Large Objects)
  .가변길이 문자열을 저장
  .최대 4GB까지 저장 가능
  .한 테이블에 복수개의 CLOB 타입 컬럼 설정 가능
  .일부 기능은 DBMS_LOB API의 지원을 받아야 함
  (사용형식)
  컬럼명 CLOB; 

사용예) 
CREATE TABLE TEMP04(
  COL1  CLOB,
  COL2  VARCHAR2(2000),
  COL3  CLOB,
  COL4  CLOB);
  
INSERT INTO TEMP04 VALUES('IL POSTINO','BOYHOOD','대전시 중구 대흥동 500',
                           '대한민국은 민주공화국이다');
                           
  SELECT * FROM TEMP04;
  
  SELECT SUBSTR(COL2,4,3) AS "VARCHAR2", --(자리, 길이)
         SUBSTR(COL1,3,5) AS "CLOB1",
         DBMS_LOB.SUBSTR(COL2,3,4) AS "CLOB2", --(가져올 길이, 시작위치)
         LENGTHB(COL2) AS "COL2",
         LENGTH(COL1) AS "COL1"
         FROM TEMP04;
         
         
  
 
 

  
  
  
  
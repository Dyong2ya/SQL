2021-0514-01)
2. 숫자형
  -정수 및 실수를 저장
  -NUMBER 타입 제공
  (사용형식)
  컬럼명 NUMBER[(정밀도|*[,스케일])];
   .저장범위 : 10 * e-130 ~ 9.99999...99 * e125 --약 10의 126승(e가 10이야): 거의 모든 수가 다 포함돼
   '정밀도|*' : 정밀도를 시스템에 의존할 경우 '*' 사용
 
 1) 정밀도>스케일
  .정밀도 : 전체 자리수(1~30)
  .스케일이 양수 : 소숫점이하 자리수(84~127)
  .스케일이 음수: 정수부분의 자리수
--------------------------------------------------
입력값         선언              기억값     
--------------------------------------------------
1234.5678     NUMBER            1234.5678
1234.5678     NUMBER(7,3)       1234.568
1234.5678     NUMBER(*,3)       1234.568
1234.5678     NUMBER(7)         1235
1234.5678     NUMBER(5,3)       오류발생
1234.5678     NUMBER(7,-2)      1200
--------------------------------------------------

 2) 정밀도<스케일
  .희귀한 경우
  .정밀도 : 0이 아닌 유효숫자의 개수
  .스케일 - 정밀도 : 소수점 다음에 존재해야하는 0의 개수
--------------------------------------------------
입력값         선언              기억값     
--------------------------------------------------
0.2345        NUMBER(4,5)       오류
1.2345        NUMBER(3,5)       오류
0.0123        NUMBER(3,4)       0.0123  
0.0012345     NUMBER(3,5)       0.00123
--------------------------------------------------

3. 날짜형
  -년,월,시,분,초를 저장하는 자료형
  -DATE, TIMESTAMP이 제공
 
 1)DATE
  .표준날짜형
  .'+'와'-'의 대상 : 연산결과는 날짜형 --다가올 날짜(+), 과거의 날짜(-)
  .날짜형 - 날짜형 : 경과된 일수
  (사용형식)
  컬럼명 DATE; 
   -저장되는 날짜 형식은 도구->환경설정->데이터베이스->NLS에서 설정한 형식
사용예)
CREATE TABLE TEMP05(
  COL1  DATE,
  COL2  DATE,
  COL3  DATE);
  
  INSERT INTO TEMP05 VALUES(SYSDATE,SYSDATE-20,SYSDATE+30);
  
  SELECT * FROM TEMP05;
  
  *시/분/초 등 시각정보를 표현할 때 : TO_CHAR함수 사용
SELECT TO_CHAR(COL1,'YYYY-MM-DD PM HH24:MI:SS'),
       TO_CHAR(COL2,'YYYY-MM-DD AM HH24:MI:SS'),
       TO_CHAR(COL3,'YYYY-MM-DD AM HH24:MI:SS')
    FROM TEMP05;
    
    
  SELECT TRUNC(SYSDATE)-TRUNC(COL2) FROM TEMP05;
 
  SELECT MOD((TRUNC(SYSDATE)-TO_DATE'00010101'))-1,7) FROM DUAL; 
  
  2)TIMESTAMP
  .시간대정보(TIMEZONE)와 10억분의 1초 단위의 시각정보 제공
  .응용프로그램(java나 jsp등에서 시간은 1/1000초 사용)
  (사용형식)
  컬럼명 TIMESTAMP;
  컬럼명 TIMESTAMP WITH TIME ZONE;
  컬럼명 TIMESTAMP WITH LOCAL TIME ZONE;
  .'TIMESTAMP': 시간대 정보 없음
  .'TIMESTAMP WITH TIME ZONE' : 시간대 정보 제공
  .'TIMESTAMP WITH LOCAL TIME ZONE' : 서버가 위치한 시간대 정보 =  TIME ZONE
    과 동일
사용예)
CREATE TABLE TEMP06(
  COL1  TIMESTAMP,
  COL2  TIMESTAMP WITH TIME ZONE,
  COL3  TIMESTAMP WITH LOCAL TIME ZONE);
  
  INSERT INTO TEMP06 VALUES(SYSDATE,SYSDATE,SYSDATE);
  
  SELECT * FROM TEMP06
  
4. 기타 자료형
  -이진 자료를 처리하기 위한 자료형 --주로 특수한 경우에 사용된다
  -BLOB, BFILE, RAW, LONG RAW
  1)RAW
  .작은 크기의 이진자료 저장
  .오라클에서 해석이나 변환작업을 수행하지 않음
  .최대 2000 BYTE 저장 가능
  .주로 음성, 사진 등 저장
  .16진수 및 2진수 저장 가능
  (사용형식)
  컬럼명 RAW(크기);
  
사용예)
CREATE TABLE TEMP07(
  COL1  RAW(1000),
  COL2  RAW(2000));
  
  INSERT INTO TEMP07 VALUES(HEXTORAW('7DEF'),'11001001'); 
  
  SELECT * FROM TEMP07;
  
  2)BFILE
  .이진자료 저장
  .원본자료를 테이블 '외부'에 저장하고 테이블에는 경로(디렉토리: 폴더) 정보만 저장
  .4GB까지 저장 가능           
  (사용형식)
  컬럼명 BFILE;
  
  그림저장순서
  (1)원본자료가 저장된 디렉토리 객체 생성
    .디렉토리 별칭(Alias) 30BYTE, 파일명 256BYTE 까지 사용 가능
    
  CREATE DIRECTORY TEST_DIR AS 'D:\A_TeachingMaterial\2.Oracle\workspace'
    .디렉토리 별칭: TEST_DIR
    
  (2)사진이 담겨질 테이블 생성-컬럼=>BFILE 타입으로 선언
  CREATE TABLE TEMP08(
    COL1 BFILE);
    
  (3)원본 삽입
  INSERT INTO TEMP08 VALUES(BFILENAME('TEST_DIR','SAMPLE.jpg'));
  
  SELECT * FROM TEMP08;
  
  
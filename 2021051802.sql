2021-0518-02)
1. SQL 명령의 분류
  1)DDL(Data Definition Language : 데이터 정의어)
    - 데이터구조 생성 변경 삭제
    - create, alter, drop
  2)DCL(Data Control Language : 데이터 제어어)
    - 수행순서 제어
    - commit, rollback, savepoint 등
  3)DML(Data Manipulation Language : 데이터 조작어)
    - 테이블 내의 데이터 조작 명령
    - insert, update, delete, merge
  4)SELECT (데이터 검색어)  
  
2. SELECT 문 
  - 테이블에 저장된 자료를 검색하기 위한 명령
  (사용형식)
  SELECT [DISTINCT] 컬럼명1 [[AS] 컬럼별칭][,]
                    컬럼명2 [[AS] 컬럼별칭][,]
                              :
                    컬럼명n [[AS] 컬럼별칭]
    FROM 테이블명 --FROM WHERE SELECT 순으로 처리됨
    [WHERE 조건] --WHERE절은 생략될 수 있다. WHERE절이 생략되면 모든걸 다 검색한다.
    [GROUP BY 컬럼명[,컬럼명2,...]];
 [HAVING 조건] --GROUP BY를 쓰려면 (SUM HALF AVG MIN MAX : 직계함수)가 들어가야한다.
 [ORDER BY 컬럼명|컬럼 INDEX [ASC|IDESC]; --컬럼명을 기준으로 정렬하십시오, 크기 순서대로 재배열하십시오 라는 뜻.
    .컬럼별칭 : 컬럼에 부여된 또 다른 이름, 출력에 제목으로 사용, SUBQUERY에서 컬럼의 값을 참조하기 위함
    .컬럼별칭 기술형식
     컬럼명 AS 컬럼별칭
     컬럼명  컬럼별칭 - 'AS'생략 가능
     컬럼명 AS "컬럼별칭" -컬럼명에 특수 문자(공백포함) 사용되는 경우 반드시 ""안에 기술해야함
     컬럼명 "컬럼별칭" - 'AS'생략 가능
    .'DISTINCT' : 중복을 배제하고 조회
    
사용예)상품분류테이블에 있는 모든 자료를 조회하시오.
     Alias는 순번, 분류코드, 분류명이다
     SELECT * FROM LPROD;

     SELECT LPROD_ID AS 순번,
            LPROD_GU AS 분류코드,
            LPROD_NM AS 분류명
       FROM LPROD;
       
사용예)회원테이블에서 모든 회원의 회원번호, 회원명, 주소, 마일리지를 조회하시오.
     SELECT MEM_ID AS 회원번호,
            MEM_NAME AS 회원명, 
            MEM_ADD1 || ' ' || MEM_ADD2 AS 주소,
            MEM_MILEAGE AS 마일리지
       FROM MEMBER;
    
사용예)사원테이블의 모든 사원의 사원번호와 이름, 입사일, 급여를 출력하시오.
    SELECT HR.EMPLOYEES.EMPLOYEE_ID AS 사원번호,  
           FIRST_NAME || ' ' || LAST_NAME AS 사원명,
           EMPLOYEES.HIRE_DATE AS 입사일,
           SALARY AS 급여
      FROM HR.EMPLOYEES;
      
사용예)회원테이블에서 대전에 거주하는 회원정보를 조회하시오.
     Alias는 회원번호, 회원명, 직업, 성별, 나이이다.
     SELECT MEM_ID AS 회원번호, 
            MEM_NAME AS 회원명,
            MEM_JOB AS 직업, 
            MEM_REGNO1 || '-'||MEM_REGNO2 AS 주민번호,
            CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                      SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성회원'
                 ELSE '여성회원' END AS 성별,
                 EXTRACT(YEAR FROM SYSDATE)-
                 TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900 AS 나이
        FROM MEMBER
    WHERE MEM_ADD1 LIKE '대전%';
        
        나이
    
    
    
    
    
    
    
    
    
**테이블 삭제
DROP TABLE 테이블명;


DROP TABLE TEMPO1;
DROP TABLE TEMPO2;
DROP TABLE TEMPO3;
DROP TABLE TEMPO4;
DROP TABLE TEMPO5;
DROP TABLE TEMPO6;
DROP TABLE TEMPO7;
DROP TABLE TEMPO8;
DROP TABLE TEMPO9;

DROP TABLE SITE_ITEM;--자식들이 먼저 지워져야 함
DROP TABLE TBL_WORK;
DROP TABLE EMPLOYEE;
DROP TABLE SITE;

--LGU가 붙으면 분류코드
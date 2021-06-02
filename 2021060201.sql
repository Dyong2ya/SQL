2021-0602-01)서브쿼리(Subquery)
 - 쿼리 안에 존재하는 또다른 쿼리
 - SELECT, INSERT, UPDATE, DELETE, CREATE TABLE, VIEW에서 이용
 - 최종결과를 출력하는 쿼리를 메인쿼리(또는 OUTER Query)라 하고 메인쿼리에서 사용될
   데이터를 반환하는 쿼리를 서브쿼리(또는 Inner Query)라 함
 - 서브쿼리는 SELECT절, WHERE 절, FROM 절에 올 수 있고 FROM 절에 기술된 서브쿼리를
   인라인(In-line) 서브쿼리라고함
 - 인라인(In-line) 서브쿼리는 반드시 독립 실행이 가능해야 함 --FROM이 제일 빨라.
 - 서브쿼리는 반드시 ( )안에 기술(단, INSERT문은 예외) 해야함
 - 연관성 없는 서브쿼리,연관성 있는 서브쿼리, 단일행/단일열,단일행/다중열,다중행/단일열
   다중행/다중열 서브쿼리로 분류
   
 1)연관성 없는 서브쿼리
  - 메인쿼리에 사용된 테이블과 서브쿼리에 사용된 테이블이 조인으로 연결되지 않은 서브쿼리

사용예)사원테이블에서 전체 평균급여보다 더 많은 급여를 받는 사원수를 조회하시오
  [메인쿼리:사원수를 조회]
      SELECT COUNT(*) AS 사원수
        FROM HR.EMPLOYEES
       WHERE SALARY >= (평균급여);
       
  [서브쿼리:평균급여]
      SELECT AVG(SALARY)
        FROM HR.EMPLOYEES;
        
  [결합]      
      SELECT COUNT(*) AS 사원수
        FROM HR.EMPLOYEES
       WHERE SALARY >= (SELECT AVG(SALARY)
                          FROM HR.EMPLOYEES);

      SELECT COUNT(*) AS 사원수
        FROM HR.EMPLOYEES A,(SELECT AVG(SALARY) AS ASAL
                               FROM HR.EMPLOYEES) B
       WHERE A.SALARY >= B.ASAL;
       
사용예)사원테이블의 직무코드와 직무변동테이블(JOB_HISTORY)의 직무코드가 동일한 사원정보를 
      조회하시오.Alias는 사원번호,사원명,직무코드
  [메인쿼리:사원테이블에서 사원번호,사원명,직무코드 조회]      
      SELECT EMPLOYEE_ID AS 사원번호,
             FIRST_NAME||' '||LAST_NAME AS 사원명,
             JOB_ID AS 직무코드 
        FROM HR.EMPLOYEES A
       WHERE (A.EMPLOYEE_ID, A.JOB_ID)=(직무변동테이블에서 조회) 

  [서브쿼리:직무변동테이블에서 사원번호,직무코드 조회]
      SELECT B.EMPLOYEE_ID, B.JOB_ID
        FROM HR.JOB_HISTORY B;

  [결합]
      SELECT EMPLOYEE_ID AS 사원번호,
             FIRST_NAME||' '||LAST_NAME AS 사원명,
             JOB_ID AS 직무코드 
        FROM HR.EMPLOYEES A
       WHERE (A.EMPLOYEE_ID, A.JOB_ID)=SOME(SELECT B.EMPLOYEE_ID, B.JOB_ID
                                              FROM HR.JOB_HISTORY B);    --SOME,ANY를 쓴 이유는 한 명대 여러 명이라서 

 2)연관성 있는 서브쿼리
  - 대부분의 서브쿼리가 포함되며, 메인쿼리에 사용된 테이블과 서브쿼리에서 사용하는 테이블이
    조인으로 연결되는 경우 이다.

사용예)직무변동테이블에 존재하는 부서를 조회하시오
      Alias는 부서코드,부서명이다 
      
  [메인쿼리:부서테이블에서 부서코드,부서명,관리자 성명을 조회]   
      SELECT A.DEPARTMENT_ID AS 부서코드,
             A.DEPARTMENT_NAME AS 부서명,
             B.FIRST_NAME||' '||B.LAST_NAME  AS 관리자명
        FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID IN (직무변동테이블 내의 부서코드)
         AND A.MANAGER_ID=B.EMPLOYEE_ID
         
  [서브쿼리:직무변동테이블에서 부서코드를 조회] 
     SELECT DEPARTMENT_ID
       FROM HR.JOB_HISTORY;
  [결합]

      SELECT A.DEPARTMENT_ID AS 부서코드,
             A.DEPARTMENT_NAME AS 부서명,
             B.FIRST_NAME||' '||B.LAST_NAME  AS 관리자명
        FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE (A.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM HR.JOB_HISTORY))
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;    
       
      [EXISTS 연산자 사용]
      SELECT A.DEPARTMENT_ID AS 부서코드,
             A.DEPARTMENT_NAME AS 부서명,
             B.FIRST_NAME||' '||B.LAST_NAME  AS 관리자명
        FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE EXISTS (SELECT 1
                       FROM HR.JOB_HISTORY C
                      WHERE A.DEPARTMENT_ID=C.DEPARTMENT_ID)
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;   
       
  [일반서브쿼리:SELECT절에 서브쿼리가 존재] 
      SELECT DISTINCT A.DEPARTMENT_ID AS 부서코드,
             (SELECT C.DEPARTMENT_NAME 
                FROM HR.DEPARTMENTS C
               WHERE C.DEPARTMENT_ID=A.DEPARTMENT_ID) AS 부서명,
             (SELECT E.FIRST_NAME||' '||E.LAST_NAME 
                FROM HR.DEPARTMENTS D, HR.EMPLOYEES E
               WHERE A.DEPARTMENT_ID=D.DEPARTMENT_ID
                 AND D.MANAGER_ID=E.EMPLOYEE_ID) AS 관리자명
        FROM HR.JOB_HISTORY A
       ORDER BY 1;  
  
사용예)회원테이블에서 마일리지가 많은 5명이 2005년 5월 구매한 실적을 조회하시오.
      Alias는 회원번호,회원명,구매금액
       --ROWNUM과 ORDER BY는 같이 쓰면 안된다. ROWNUM이 WHERE절을 먼저 실행시켜서 ORDER BY가 잘 안 나옴

   [마일리지가 많은 5명 추출]
      SELECT A.MEM_ID AS MID,
             A.MEM_NAME AS MNAME
        FROM (SELECT MEM_ID,
                     MEM_NAME
                FROM MEMBER
               ORDER BY MEM_MILEAGE DESC) A
       WHERE ROWNUM<=5 ;

    [2005년 5월 회원별 구매조회]
      SELECT CART_MEMBER AS CID,
             SUM(CART_QTY*PROD_PRICE) AS CSUM
        FROM CART, PROD
       WHERE CART_PROD=PROD_ID
         AND CART_NO LIKE '200505%'
       GROUP BY CART_MEMBER;  

    [결합]
      SELECT TBLA.MID AS 회원번호,
             TBLA.MNAME AS 회원명,
             TBLB.CSUM AS 구매금액
        FROM (SELECT A.MEM_ID AS MID,
                     A.MEM_NAME AS MNAME
                FROM (SELECT MEM_ID,
                             MEM_NAME
                        FROM MEMBER
                        ORDER BY MEM_MILEAGE DESC) A
               WHERE ROWNUM<=5) TBLA,
             (SELECT CART_MEMBER AS CID,
                     SUM(CART_QTY*PROD_PRICE) AS CSUM
                FROM CART, PROD
               WHERE CART_PROD=PROD_ID
                 AND CART_NO LIKE '200505%'
               GROUP BY CART_MEMBER) TBLB 
       WHERE TBLA.MID=TBLB.CID
       ORDER BY 1;
  





           
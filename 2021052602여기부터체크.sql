02021-0526-02)그룹함수
 - 데이터를 특정 컬럼값을 기준으로 그룹화(같은 값을 갖는 데이터들로 구분)하고 집계처리에 사용되는 함수
 - SUM,AVG,COUNT, MAX, MIN 등이 제공
 - SELECT절에 일반 컬럼과 그룹함수가 같이 사용되면 반드시 'GROUP BY'절을 기술해야함
 - 그룹함수에 조건이 부여된 경우 'HAVING'절로 처리해야함
 (사용형식)
 SELECT 컬럼명1[,컬럼명2,...][,.]
        그룹함수(들)
   FROM 테이블명
 [WHERE 조건]
  GROUP BY 컬럼명1[,컬럼명2,...]
[HAVING 조건]
 [ORDER BY 컬럼명|컬럼인덱스 [ASC|DESC][,컬럼명|컬럼인덱스,...][ASC|DESC]];
   . GROUP BY 컬럼명1,컬럼명2,... : 컬럼명1로 그룹화 시킨 후 각 그룹에서 컬럼명2로 세부 그룹화
     - SELECT절에 일반 컬럼은 반드시 기술되어야 함. SELECT절에 기술되지 않은 컬럼도 기술 가능 
     
1) SUM(col)
 - 'col'컬럼에 있는 값의 합을 반환
 
사용예) 사원테이블의 모든 사원의 급여합계를 구하시오
    SELECT SUM(SALARY)
      FROM HR.EMPLOYEES; --회사에서 전체적으로 지급되어지는 월급의 합계 / GROUP BY는 전체집계는 제공하지 않아 그래서 안 써
      
사용예) 사원테이블의 부서별 급여합계를 구하시오 --'~별' 이러면 GROUP으로 묶어준다고 생각하면 돼. SELECT에 그 ~컬럼을 넣어주면 돼
    SELECT DEPARTMENT_ID AS 부서코드, 
           SUM(SALARY) AS 급여합계 --그룹함수와 일반컬럼이 같이 쓰여서 그룹바이 꼭 써줘야돼
      FROM HR.EMPLOYEES
     GROUP BY ROLLUP(DEPARTMENT_ID) --ROLLUP을 쓰게 되면 전체합계도 보여줌
     ORDER BY 1;
     
사용예) 회원테이블의 성별별 마일리지합계를 구하시오
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                     SUBSTR(MEM_REGNO2,1,1)='4' THEN
                     '여성회원'
                ELSE
                      '남성회원' END AS 성별,
                      SUM(MEM_MILEAGE) AS 마일리지합계
       FROM MEMBER
            GROUP BY  CASE WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                     SUBSTR(MEM_REGNO2,1,1)='4' THEN
                     '여성회원'
                ELSE
                      '남성회원' END;
                      
사용예) 장바구니 테이블에서 2005년 4~6월 상품별 매출조회 
       Alias는 상품코드,상품명,판매수량,판맥금액
       SELECT A.CART_PROD AS 상품코드,
              B.PROD_NAME AS 상품명,
              SUM(A.CART_QTY) AS 판매수량,
              SUM(A.CART_QTY*B.PROD_PRICE) AS 판맥금액
         FROM CART A, PROD B
        WHERE A.CART_NO BETWEEN '20050401' AND '20050630'
          AND A.CART_PROD=B.PROD_ID
        GROUP BY A.CART_PROD,B.PROD_NAME --두 개를 썼지만 사실상 내용은 똑같아. 그렇지만 하나라도 생략하면 안돼. SUM함수를 제외하면 컬럼명이 2개잖아....?????????
        ORDER BY 1; 
        
문제] 2005년 1~3월 사이에 발생한 매입(BUY_PROD)정보를 이용하여 월별, 제품별 매입정보를 조회하시오
     SELECT EXTRACT(MONTH FROM BUY_DATE)||'월' AS 월,
            BUY_PROD AS 상품코드, --만약 상품명이면 다른 테이블도 필요해
            SUM(BUY_QTY) AS 매입수량, --쌓아놔야 되는 애들 몇 개인지 알아야지
            SUM(BUY_QTY*BUY_COST) AS 매입금액 --총 얼마 들었나 알아야지
       FROM BUYPROD
      WHERE EXTRACT(MONTH FROM BUY_DATE) IN(1,2,3)
      GROUP BY EXTRACT(MONTH FROM BUY_DATE),BUY_PROD --셀렉트절에서 집계함수를 제외한 모든 것들
      ORDER BY 1,2;
    
문제] 2005년 5월 매출정보를 활용하여 분류코드별 매출금액 합계를 조회하시오
    SELECT B.LPROD_GU AS 분류코드,
           B.LPROD_NM AS 분류명,
           SUM(A.CART_QTY*C.PROD_PRICE) AS "매출금액 합계"
      FROM CART A,LPROD B,PROD C --PROD는 앞에 두 개 연결
     WHERE A.CART_PROD=C.PROD_ID
       AND C.PROD_LGU=B.LPROD_GU
       AND A.CART_NO LIKE '200505%'
     GROUP BY B.LPROD_GU, B.LPROD_NM
     ORDER BY 1;
     
문제] 회원테이블을 이용하여 거주지별 회원들의 마일리지합계를 구하시오
    SELECT SUBSTR(MEM_ADD1,1,2) AS 거주지, 
           SUM(MEM_MILEAGE) AS 마일리지
      FROM MEMBER
     GROUP BY SUBSTR(MEM_ADD1,1,2)
     ORDER BY 2 DESC; --마일리지 내림차순으로 
     
 2) AVG(col)
  - 'col'컬럼에 있는 값의 평균값을 반환
  
사용예) 사원테이블에서 각 부서별 평균임금을 구하시오
    SELECT DEPARTMENT_ID AS 부서,
           ROUND(AVG(SALARY)) AS 평균임금
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID--AVG랑 일반컬럼이 동시에 사용돼서 꼭 써줘야됑
     ORDER BY 1;
     
     SELECT ROUND(AVG(SALARY)) AS 평균임금
       FROM HR.EMPLOYEES; --전체 직원들의 평균 임금
       
사용예) 장바구니테이블에서 2005년도 회원의 성별 평균 구매금액을 조회하시오
    SELECT CASE WHEN SUBSTR(B.MEM_REGNO2,1,1)='2' OR
           SUBSTR(B.MEM_REGNO2,1,1)='4' THEN --CASE WHEN THEN이 IF문이야
           '여성회원' 
      ELSE '남성회원' END AS 구분, 
    ROUND(AVG(A.CART_QTY*C.PROD_PRICE),-1) AS 평균구매금액
       FROM CART A, MEMBER B, PROD C--CART구매에 대한 정보가 들어있어/단가를 구하기 위해 PROD도 사용하는거야
      WHERE SUBSTR(A.CART_NO,1,4)='2005' --이제 날짜조건도 맞춰줘야징
        AND A.CART_MEMBER=B.MEM_ID
        AND A.CART_PROD=C.PROD_ID
      GROUP BY CASE WHEN SUBSTR(B.MEM_REGNO2,1,1)='2' OR
           SUBSTR(B.MEM_REGNO2,1,1)='4' THEN --CASE WHEN THEN이 IF문이야
           '여성회원' 
      ELSE '남성회원' END;
      
사용예) 장바구니테이블에서 2005년도 회원의 연령대별 평균 구매금액을 조회하시오
     SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM B.MEM_BIR))/10)*10||'대' AS 연령,
   ROUND(AVG(A.CART_QTY*C.PROD_PRICE),-1) AS 평균구매금액 --제품코드테이블에서 매출단가PRICE를 곱하는거야
       FROM CART A, MEMBER B, PROD C
      WHERE SUBSTR(A.CART_NO,1,4)='2005' 
        AND A.CART_MEMBER=B.MEM_ID
        AND A.CART_PROD=C.PROD_ID
      GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)-
               EXTRACT(YEAR FROM B.MEM_BIR))/10)*10
      ORDER BY 1;
        
 3)COUNT(col|*) 
  - 그룹에 속한 자료의 수(행의 수)
  - 외부 조인에서는 *를 사용해서는 안됨
  --판매건수는 COUNT인데 판매금액은 SUM을 사용해야 한다
  
사용예) 사원테이블에서 부서별 인원수를 조회하시오 --부서가 나오고 인원이 나와야지
    SELECT DEPARTMENT_ID AS 부서코드, 
           COUNT(*) AS 인원수1,
           COUNT(EMPLOYEE_ID) AS 인원수2
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;

사용예) 사원테이블에서 부서별 인원수를 조회하되 인원수가 5명 이상인 부서만 조회하시오
    SELECT DEPARTMENT_ID AS 부서코드, 
           COUNT(*) AS 인원수
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) >= 5 --그룹함수가 포함된 함수는 그룹바이 뒤에 와 그리고 HAVING으로 받아야돼
     ORDER BY 1;
     
사용예) 2005년 1~3월(기간,시간 조건 WHERE) 상품별 매입건수를 조회(상품코드, 건수)하고 매입금액합계(해당되어지는 매입수량x단가)가 500만원 이하(<-조건)의 상품만 조회하시오
    SELECT BUY_PROD AS 상품코드,
           COUNT(*) AS 매입건수,
           SUM(BUY_QTY*BUY_COST)
      FROM BUYPROD
     WHERE EXTRACT(MONTH FROM BUY_DATE) IN (1,2,3)--조건
     GROUP BY BUY_PROD
     HAVING SUM(BUY_QTY*BUY_COST) <= 5000000
     ORDER BY 1;
     
사용예) 2005년 4~7월 상품별 매출건수를 조회하고 매출금액합계가 1000만원 이상의 상품만 조회하시오
   SELECT A.CART_PROD AS 상품코드,
           COUNT(*) AS 매출건수, --GROUP BY에 의해서 묶인 행을 셀건데 어느 컬럼으로 기준으로 해서 행을 세어도 상관없다
           SUM(A.CART_QTY*B.PROD_PRICE) AS 매출금액합계 --카트의 수량 * 상품가격
      FROM CART A, PROD B
      WHERE A.CART_PROD=B.PROD_ID 
        AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200507'
     GROUP BY A.CART_PROD
    HAVING SUM(A.CART_QTY*B.PROD_PRICE) >= 10000000 
     ORDER BY 1;
    
     
     
     
     (내가 짠 거)
     SELECT A.CART_PROD AS 상품코드,
           COUNT(*) AS 매출건수, 
           SUM(A.CART_QTY*B.PROD_PRICE) AS 매출금액합계
      FROM CART A, PROD B
     WHERE A.CART_NO BETWEEN '20050401' AND '20050731'
       --TRUNC(MONTH FROM CART_NO,5,2)='04'
       --AND TRUNC(MONTH FROM CART_NO,5,2)='07'
       AND A.CART_PROD=B.PROD_ID 
     GROUP BY A.CART_PROD
    HAVING SUM(A.CART_QTY*B.PROD_PRICE) >= 10000000 
     ORDER BY 1;

 4) MAX(col), MIN(col)
  - MAX(col) : 'col' 컬럼의 값 중 가장 큰 값을 반환
  - MIN(col) : 'col' 컬럼의 값 중 가장 작은 값을 반환
  
사용예) 사원테이블에서 급여를 가장 많이 받는 사원과 가장 적게 받는 사원을 조회하시오
  
   (최고급여와 최저급여)
    SELECT MAX(SALARY),MIN(SALARY)
      FROM HR.EMPLOYEES;
      
   (부서별 최고급여와 최저급여)
    SELECT DEPARTMENT_ID,
           MAX(SALARY),
           MIN(SALARY)
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;

   (부서별 최고급여를 받는 사원의 사원명과 사원번호를 출력)
    SELECT EMPLOYEE_ID AS 사원번호,
           FIRST_NAME||' '||LAST_NAME AS 사원명,
           DEPARTMENT_ID AS 부서코드,
           MAX(SALARY)
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID,EMPLOYEE_ID,FIRST_NAME||' '||LAST_NAME--12개의 부서별로 그룹을 묶어 사원번호가 같은 사람들끼리 그룹으로 묶어.(동일시되는게 없으니까 순서대로 각각 한 그룹이 되잖아) 그래서 오류나느거야 밑에거 봐
     ORDER BY 1;
      
      
      SELECT B.DID AS 부서코드,
             A.EMPLOYEE_ID AS 사원번호,
             A.FIRST_NAME||' '||LAST_NAME AS 사원명,
             B.MSAL AS 최대급여
        FROM HR.EMPLOYEES A,(SELECT DEPARTMENT_ID AS DID, --컬럼참조는 영어로 써주는 것이 좋다
                                    MAX(SALARY) AS MSAL --B.DID/ B.MSAL
                               FROM HR.EMPLOYEES
                              GROUP BY DEPARTMENT_ID) B --안쪽 그룹바이에서 각 부서별 최대급여 ()만 묶어서 확인해봐 //(안에 셀렉트는 서브쿼리 얘부터 실행돼)
       WHERE A.SALARY=B.MSAL
         AND A.DEPARTMENT_ID=B.DID
       ORDER BY 1;
       
    SELECT EMPLOYEE_ID, SALARY
      FROM HR.EMPLOYEES
     WHERE DEPARTMENT_ID=50
     ORDER BY 2 DESC;
     
     UPDATE HR.EMPLOYEES
        SET SALARY=8200
      WHERE EMPLOYEE_ID=120;
      
      COMMIT;
      
사용예) 회원테이블에서 마일리지가 가장 많은 5명의 정보를 출력하시오
        Alias는 회원명,마일리지
        SELECT FIRST_NAME||' '||LAST_NAME AS 회원명
     **의사컬럼(PSUEDO COLUMN)
      - ROWNUM : 테이블(뷰)의 각 행에 부여된 순서 값 
SELECT A.MID AS 회원번호,
       A.MNAME AS 회원명,
       A.MILE AS 마일리지
  FROM (SELECT MEM_ID AS MID,
               MEM_NAME AS MNAME,
               MEM_MILEAGE AS MILE
          FROM MEMBER 
         ORDER BY 3 DESC) A
    WHERE ROWNUM<=5;

 5) RANK, DENSE_RANK 함수
  - 자료의 순위를 제공하는 함수
  - RANK : 동일한 값은 중복 순위를 부여, 다음 순위는 중복 순위개수만큼 건너뛰고 부여
  - DENSE_RANK : 동일한 값은 중복 순위를 부여, 다음 순위는 중복 순위와 관계없이 차례대로 부여
  
 (1)RANK() OVER(ORDER BY 기준컬럼명 DESC) AS 컬럼별칭
사용예) 회원테이블에서 마일리지가 가장 많은 5명의 정보를 출력하시오
        Alias는 회원명,마일리지
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_MILEAGE AS 마일리지,
               RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS 등수
          FROM MEMBER;
            
 (2)DENSE_RANK() OVER(ORDER BY 기준컬럼명 DESC) AS 컬럼별칭
사용예) 회원테이블에서 마일리지가 가장 많은 5명의 정보를 출력하시오
        Alias는 회원명,마일리지
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_MILEAGE AS 마일리지,
               DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS 등수
          FROM MEMBER;

 (3)ROW_NUMBER 함수
  - 중복과 관계없이 순차적인 순위를 부여
  - 동일한 값에 대한 순위는 발생된 순서에 따라 순위 부여
  - 사용형식
  ROW_NUMBER() OVER(ORDER BY 기준컬럼명 DESC) AS 컬럼별칭
        SELECT MEM_ID AS 회원번호,
               MEM_NAME AS 회원명,
               MEM_MILEAGE AS 마일리지,
               ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC,
                                          MEM_BIR ASC) AS 등수 --여러 개의 조건들을 기술할 수 있다
          FROM MEMBER;
     
     
        
   
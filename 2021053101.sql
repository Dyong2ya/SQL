2021-0531-01) 테이블 조인
 - 관계형 데이터베이스의 대표 연산 중 하나(Relationship)을 이용
 - 필요한 자료가 여러 테이블에 분산되어 있는 경우 관계의 속성을 이용하여 데이터 추출 --식별관계든 비식별관계든 반드시 연관이 되어있어야 한다
 - 크게 일반적 조인과 ANSI JOIN으로 구분 --얘는 아우터조인을 사용해서 정확한 결과를 얻을 수 있어
 - 내부조인(INNER JOIN : 조인조건에 맞지않는 자료는 제외) --부족한 쪽(데이터의 종류)을 기준으로 하여 남는 쪽을 버려 부족한 쪽에 있는 자료만을 가지고 조인
   외부조인(OUTER JOIN : 부족한 테이블에 NULL행을 추가하여 JOIN수행) --많이 사용은 안 하지만 많은 쪽을 기준으로 부족한 쪽에 NULL을 추가해서 많은 쪽하고 맞춰줘
 
 1. 내부조인
  - CARTESIAN PRODUCT, EQUI-JOIN, NON EQUI-JOIN,SELF JOIN 등이 존재 
 (사용형식)
 SELECT 컬럼list
   FROM 테이블명1 [별칭1], 테이블명2  [별칭2][,테이블명3 [별칭3],..] --두 테이블의 컬럼명이 똑같은 이름이면 별칭이 반드시 필요하다
  WHERE 조인조건 --이제는 절대 WHERE절 생략불가능해!!!!
   [AND 일반조건]
      :
 
  1) CARTESIAN PRODUCT
   . 모든 가능한 행들의 조합
   . 조인조건이 없거나 잘못 기술된 경우
   . 반드시 필요하지 않은 경우를 제외하고 사용되지 않음
   
ex) SELECT COUNT(*) 
      FROM CART, PROD; --행은 곱한값, 열은 더한값

    SELECT COUNT(*) 
      FROM CART, PROD,BUYPROD; 
      
  2) EQUI-JOIN
   . 조인조건에 '='연산자가 사용되는 조인
   . ANSI JOIN 중 INNER JOIN에 해당
   . 내부 조인 중 대부분이 동등조인임
   (ANSI의 INNER JOIN 사용형식)
   SELECT 컬럼list
     FROM 테이블명1 [별칭1] --프롬절에 테이블을 딱 한 개만 사용한다
    INNER JOIN 테이블명2 [별칭2] ON(조인조건 [AND 일반조건1]) --테이블들은 공통의 컬럼이 존재해야 한다. 공통되는 조인조건. 일반조건은 AND로 써줘도 되고(테이블1,테이블2에만 적용되면) 
   [INNER JOIN 테이블명3 [별칭3] ON(조인조건 [AND 일반조건2])]
                            :
   [WHERE 일반조건] --아니면 WHERE절에 적용할 수 있어(사용된 모든 테이블에 공통일 경우)
   
사용예) 사원테이블에서 급여가 5000이상인 사원정보를 조회하시오
       Alias는 사원번호,사원명,부서번호,부서명,급여
       (일반조인)
       SELECT HR.EMPLOYEES.EMPLOYEE_ID AS 사원번호,
              HR.EMPLOYEES.FIRST_NAME ||' '|| 
              HR.EMPLOYEES.LAST_NAME AS  사원명,
              HR.EMPLOYEES.DEPARTMENT_ID AS 부서번호,
              HR.DEPARTMENTS.DEPARTMENT_NAME AS 부서명,
              HR.EMPLOYEES.SALARY AS 급여
         FROM HR.EMPLOYEES, HR.DEPARTMENTS
        WHERE SALARY>=5000 --일반조건
          AND HR.EMPLOYEES.DEPARTMENT_ID=
              HR.DEPARTMENTS.DEPARTMENT_ID
        ORDER BY 3;  
          
       SELECT A.EMPLOYEE_ID AS 사원번호,
              A.FIRST_NAME ||' '||A.LAST_NAME AS  사원명,
              A.DEPARTMENT_ID AS 부서번호,
              B.DEPARTMENT_NAME AS 부서명,
              A.SALARY AS 급여
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.SALARY>=5000 --일반조건
          AND A.DEPARTMENT_ID=B.DEPARTMENT_ID --조인조건
        ORDER BY 3;       
          
        (ANSI FORMAT)
       SELECT A.EMPLOYEE_ID AS 사원번호,
              A.FIRST_NAME ||' '||A.LAST_NAME AS  사원명,
              A.DEPARTMENT_ID AS 부서번호,
              B.DEPARTMENT_NAME AS 부서명,
              A.SALARY AS 급여
         FROM HR.EMPLOYEES A
        INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=
              B.DEPARTMENT_ID)
        WHERE A.SALARY>=5000
        ORDER BY 3;
       
사용예)2005년 7월 상품별 매출현황을 조회하시오.
      Alias는 상품코드,상품명,수량,금액
      (일반조인)
      SELECT B.PROD_ID AS 상품코드,
             B.PROD_NAME AS 상품명,
             SUM(A.CART_QTY) AS 수량,
             SUM(A.CART_QTY*B.PROD_PRICE) AS 금액
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID --EQUI조인
         AND A.CART_NO LIKE '200507%'
       GROUP BY B.PROD_ID, B.PROD_NAME 
       ORDER BY 1;  
        
     (ANSI FORMAT)   
      SELECT B.PROD_ID AS 상품코드,
             B.PROD_NAME AS 상품명,
             SUM(A.CART_QTY) AS 수량,
             SUM(A.CART_QTY*B.PROD_PRICE) AS 금액
        FROM CART A
       INNER JOIN PROD B ON(A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '200507%')--이거 위에 괄호에 AND문으로 넣어주고 괄호닫으면 돼
       GROUP BY B.PROD_ID,B.PROD_NAME
       ORDER BY 1;
 
사용예)2005년 3월 거래처별 매입정보를 조회하시오 --3월에 어떤 거래처에서 얼마만큼 샀는지
      Alias는 거래처코드,거래처명,매입수량,매입금액
      
      SELECT B.BUYER_ID AS 거래처코드,
             B.BUYER_NAME AS 거래처명,
             SUM(A.BUY_QTY) AS 매입수량,
             SUM(A.BUY_QTY*C.PROD_COST) AS 매입금액
        FROM BUYPROD A, BUYER B, PROD C
       WHERE A.BUY_PROD=C.PROD_ID  -- 조인조건
         AND C.PROD_BUYER=B.BUYER_ID  -- 조인조건 테이블이 3개가 사용돼서 2개이상은 필요
         AND EXTRACT(MONTH FROM A.BUY_DATE)=03
       GROUP BY B.BUYER_ID,B.BUYER_NAME
       ORDER BY 1;
      
      (ANSI FORMAT)
      SELECT B.BUYER_ID AS 거래처코드,
             B.BUYER_NAME AS 거래처명,
             SUM(A.BUY_QTY) AS 매입수량,
             SUM(A.BUY_QTY*C.PROD_COST) AS 매입금액
        FROM BUYPROD A
       INNER JOIN PROD C ON(A.BUY_PROD=C.PROD_ID
         AND A.BUY_DATE BETWEEN '20050301' AND '20050331')
       INNER JOIN BUYER B ON(C.PROD_BUYER=B.BUYER_ID)
       GROUP BY B.BUYER_ID,B.BUYER_NAME
       ORDER BY 1;

사용예)HR계정의 테이블을 이용하여 미국 시에틀에서 근무하는 
      사원정보를 조회하시오
      사원번호,사원명,부서번호,부서명,직무명
      SELECT A.EMPLOYEE_ID AS 사원번호,
             A.FIRST_NAME||' '||A.LAST_NAME AS  사원명,
             B.DEPARTMENT_ID AS 부서번호,
             B.DEPARTMENT_NAME AS 부서명,
             C.JOB_TITLE AS 직무명
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C,
             HR.LOCATIONS D
       WHERE D.CITY='Seattle'
         AND D.LOCATION_ID=B.LOCATION_ID
         AND A.DEPARTMENT_ID=B.DEPARTMENT_ID
         AND A.JOB_ID=C.JOB_ID
       ORDER BY 3;
      
      SELECT A.EMPLOYEE_ID AS 사원번호,
             A.FIRST_NAME||' '||A.LAST_NAME AS  사원명,
             B.DEPARTMENT_ID AS 부서번호,
             B.DEPARTMENT_NAME AS 부서명,
             C.JOB_TITLE AS 직무명
        FROM HR.LOCATIONS D
       INNER JOIN HR.DEPARTMENTS B ON(D.LOCATION_ID=B.LOCATION_ID
         AND D.CITY='Seattle')
       INNER JOIN HR.EMPLOYEES A ON(B.DEPARTMENT_ID=A.DEPARTMENT_ID)
       INNER JOIN HR.JOBS C ON(A.JOB_ID=C.JOB_ID)
       ORDER BY 3;
       
사용예)2005년 5월 회원별, 상품별 구매현황을 조회하시오  --회원을 기준으로 먼저 하고 나중에 상품별로 또 구분
      조회할 내용은 회원번호,회원명,상품명,구매수량,구매금액이다 
      SELECT B.MEM_NAME AS 회원명,
             C.PROD_NAME AS 상품명,
             SUM(A.CART_QTY) AS 구매수량,
             SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액
        FROM CART A, MEMBER B, PROD C
       WHERE A.CART_MEMBER=B.MEM_ID
         AND A.CART_PROD=C.PROD_ID
         AND A.CART_NO LIKE '200505%' --일반조건
       GROUP BY ROLLUP(B.MEM_NAME,C.PROD_NAME) --만약 롤업을 하고 싶으면 둘 중 하나는 빼줘야돼
       ORDER BY 1; --회원번호 순으로 정리
      
      (ANSI FORMAT)
      SELECT B.MEM_NAME AS 회원명,
             C.PROD_NAME AS 상품명,
             SUM(A.CART_QTY) AS 구매수량,
             SUM(A.CART_QTY*C.PROD_PRICE) AS 구매금액
        FROM CART A
       INNER JOIN MEMBER B ON(A.CART_MEMBER=B.MEM_ID)
       INNER JOIN PROD C ON(A.CART_PROD=C.PROD_ID)
       WHERE A.CART_NO LIKE '200505%' --일반조건
       GROUP BY B.MEM_NAME,C.PROD_NAME
       ORDER BY 1;
      
사용예)2005년 5월 상품별 매입/매출 현황을 조회하시오
      Alias는 상품코드,상품명,매입수량,매입금액,매출수량,매출금액
      SELECT A.PROD_ID AS 상품코드,
             A.PROD_NAME AS 상품명,
             NVL(B.BAMT,0) AS 매입수량,
             NVL(B.BSUM,0) AS 매입금액,
             NVL(C.CAMT,0) AS 매출수량,
             NVL(C.CSUM,0) AS 매출금액
        FROM PROD A,
             (SELECT BUY_PROD AS BID,
                     SUM(BUY_QTY) AS BAMT,
                     SUM(BUY_QTY*BUY_COST) AS BSUM
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN '20050501' AND '20050531'
               GROUP BY BUY_PROD) B,
             (SELECT CART_PROD AS CID,
                     SUM(CART_QTY) AS CAMT,
                     SUM(CART_QTY*PROD_PRICE) AS CSUM
                FROM CART, PROD
               WHERE CART_PROD=PROD_ID
                 AND CART_NO LIKE '200505%'
               GROUP BY CART_PROD) C 
       WHERE A.PROD_ID=B.BID(+)
         AND A.PROD_ID=C.CID(+);
               
       
         
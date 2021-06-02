2021-0520-01) 연산자와 함수
1. 연산자
  - 개발언어에서 사용되는 연산자와 유사
  - 사칙연산자, 관계연산자, 논리연산자, 기타연산자로 구분
 1)사칙연산자
  .'+','-','*','/'로 구성('%'는 사용하지 않음--이런 경우는 함수를 사용하여 구할 수 있다.)
 2)관계연산자
  .값의 크기를 비교할 때 사용
  .'>,<,>=,<=,=,!= or <>' 사용
 3)논리연산자
  .NOT, AND, OR 사용
 4)기타연산자
  .IN, SOME, ANY, ALL, BETWEEN,LIKE, EXISTS 등의 연산자가 지원됨
  
  (1) IN 연산자
   . 다수의 비교 대상의 값을 제공하고 그 중에 어느 한 값과 일치하면 전체가 참이되는 조건식 구성
   . WHERE 절의 조건에 사용 --if처럼 맞으면 SELECT에서 출력돼
   . =ANY나 =SOME 또는 OR 연산자로 치환 가능
   (사용형식)
   expr IN (값1,값2,...--비교대상이 되어지는 값)-- EXPR은 표현식이다(수식, 컬럼명)
   
사용예)상품테이블(PROD)에서 피혁잡화('P301')나 화장품('P302')분류에 속한 상품정보를 출력하시오 --전체상품 출력 아니야!
    Alias는 상품코드,상품명,분류코드,판매가격이다
   
    (OR, IN, =ANY 연산자 사용)
    SELECT PROD_ID AS 상품코드,
           PROD_NAME AS 상품명,
           PROD_LGU AS 분류코드,
           PROD_PRICE AS 판매가격
      FROM PROD
      WHERE PROD_LGU='P301' OR PROD_LGU='P302' --관계식은 항상 FULL로 다 써줘야돼
      
      WHERE PROD_LGU IN ('P301','P302')
      
      WHERE PROD_LGU =ANY('P301','P302');
      
사용예)사원테이블에서 '2005'년에서 '2008'년 사이에 입사한 사원정보를 조회하시오
       Alias는 사원번호, 이름, 입사일자, 부서코드, 급여이다 --HR계정에 있는 테이블 EMPLYEES에 있다/ 출렧 시에는 SELECT사용
       
       (AND 연산자 사용 --연속된 자료만 출력가능)
       SELECT A.EMPLOYEE_ID AS 사원번호, 
              FIRST_NAME ||''|| LAST_NAME AS 이름, 
              HIRE_DATE AS 입사일자, 
              DEPARTMENT_ID AS 부서코드, 
              SALARY AS 급여
              FROM HR.EMPLOYEES A --테이블별칭을 설정하고 콜럼명 앞에 A하나만 붙여줘도 ㅇㅋ. 근데 테이블이 하나라서 굳이 별칭 안 붙여줘도 ㄱㅊ
              WHERE HIRE_DATE >= '20050101' AND HIRE_DATE <='20081231' --관계식 FULL로 다 써주는 거 잊지마!
              ORDER BY 1;--사원번호순으로는 1, 입사일자순으로는 3, 뽑아야하는데 컬럼명 중 1이라는 의미. 오름차순으로 나온게 된다.
              
        (IN 연산자 사용 --2005, 2007, 2008 이런 식으로 필요한 자료들만 추출가능)
       SELECT A.EMPLOYEE_ID AS 사원번호, 
              FIRST_NAME ||''|| LAST_NAME AS 이름, 
              HIRE_DATE AS 입사일자, 
              DEPARTMENT_ID AS 부서코드, 
              SALARY AS 급여
              FROM HR.EMPLOYEES A 
              WHERE EXTRACT(YEAR FROM HIRE_DATE) IN(2005,2006,2007,2008)
              ORDER BY 3;
              
         (OR 연산자 사용)
        SELECT A.EMPLOYEE_ID AS 사원번호, 
              FIRST_NAME ||''|| LAST_NAME AS 이름, 
              HIRE_DATE AS 입사일자, 
              DEPARTMENT_ID AS 부서코드, 
              SALARY AS 급여
              FROM HR.EMPLOYEES A 
              WHERE EXTRACT(YEAR FROM HIRE_DATE)=2005
                 OR EXTRACT(YEAR FROM HIRE_DATE)=2007
                 OR EXTRACT(YEAR FROM HIRE_DATE)=2008
              ORDER BY 3;

  (2) ANY(SOME)연산자
   .기본 기능은 IN 연산자와 동일하며, ANY와 SOME은 구별되지 않음 
   . IN 연산자를 ANY나 SOME으로 변환할 때에는 '=ANY(SOME)' 형태로 기술해야 함 --띄어쓰기하면 안돼
   (사용형식)
   expr 관계연산자ANY|SOME(값1,값2,...) --띄어쓰기하면 안돼
   
사용예)사원테이블에서 10,20,50,80번 부서에 속하지 않는 사정 정보를 출력하시오 --'않는'사람찾기야!!!!!
      Alias는 사원번호,사원명,부서번호,부서장번호이며 부서코드 순으로 출력하시오
      
      (NOT IN 연산자 사용)
      SELECT EMPLOYEE_ID AS 사원번호,
             FIRST_NAME ||''||LAST_NAME AS 사원명,
             DEPARTMENT_ID AS 부서번호,
             MANAGER_ID AS 부서장번호
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID NOT IN(10,20,50,80) -- NOT을 붙여줘야 '아닌' 사람을 찾지!
        ORDER BY 3;
             
      (NOT ANY(SOME) 연산자 사용)
      SELECT EMPLOYEE_ID AS 사원번호,
             FIRST_NAME ||''||LAST_NAME AS 사원명,
             DEPARTMENT_ID AS 부서번호,
             MANAGER_ID AS 부서장번호
        FROM HR.EMPLOYEES
       WHERE NOT DEPARTMENT_ID =ANY(10,20,50,80) -- NOT의 위치가 IN문이랑 다른 거 기억해
        ORDER BY 3;
        
      SELECT EMPLOYEE_ID AS 사원번호,
             FIRST_NAME ||''||LAST_NAME AS 사원명,
             DEPARTMENT_ID AS 부서번호,
             MANAGER_ID AS 부서장번호
        FROM HR.EMPLOYEES
       WHERE NOT DEPARTMENT_ID =SOME(10,20,50,80) -- NOT의 위치가 IN문이랑 다른 거 기억해
        ORDER BY 3;
        
      (AND 연산자 사용)
      SELECT EMPLOYEE_ID AS 사원번호,
             FIRST_NAME ||''||LAST_NAME AS 사원명,
             DEPARTMENT_ID AS 부서번호,
             MANAGER_ID AS 부서장번호
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID !=10
         AND DEPARTMENT_ID !=20
         AND DEPARTMENT_ID !=50
         AND DEPARTMENT_ID !=80
        ORDER BY 3;

  (3) BETWEEN 연산자       
   . 범위를 지정하여 연속적인 자료를 비교할 때 사용
   (사용형식)
   expr BETWEEN 값1 AND 값2
    -'expr'의 값이 '값1'에서 '값2' 사이에 존재하는 값이면 참을 반환
    -'AND' 연산자로 치환 가능
    
사용예)회원테이블에서 74-75년 사이의 회원들의 주민등록 값을 다음과 같이 변경하시오
      주민번호 앞자리 74=>00 (MEM_REGNO1)
                    75=>01
      주민번호 뒷자리 첫글자 '1'=>'3' (MEM_REGNO2)
                          '2'=>'4'로 변경
                          
      UPDATE MEMBER
         SET MEM_REGNO1='00'||TRIM(SUBSTR(MEM_REGNO1,3)),
             MEM_REGNO2='3'||TRIM(SUBSTR(MEM_REGNO2,2))
       WHERE SUBSTR(MEM_REGNO1,1,2)='74' 
         AND SUBSTR(MEM_REGNO2,1,1)='1'; --74년생 남성을 찾아서 주민등록 앞자리를 00으로 뒤자리를 3으로 
                
      UPDATE MEMBER
         SET MEM_REGNO1='00'||TRIM(SUBSTR(MEM_REGNO1,3)),
             MEM_REGNO2='4'||TRIM(SUBSTR(MEM_REGNO2,2))
       WHERE SUBSTR(MEM_REGNO1,1,2)='74' 
         AND SUBSTR(MEM_REGNO2,1,1)='2'; --74년생 여성을 찾아서 주민등록 앞자리를 00으로 뒤자리를 3으로
                 
      UPDATE MEMBER
         SET MEM_REGNO1='01'||TRIM(SUBSTR(MEM_REGNO1,3)),
             MEM_REGNO2='3'||TRIM(SUBSTR(MEM_REGNO2,2))
       WHERE SUBSTR(MEM_REGNO1,1,2)='75' 
         AND SUBSTR(MEM_REGNO2,1,1)='1'; --75년생을 01로
         
     UPDATE MEMBER
         SET MEM_REGNO1='01'||TRIM(SUBSTR(MEM_REGNO1,3)),
             MEM_REGNO2='4'||TRIM(SUBSTR(MEM_REGNO2,2))
       WHERE SUBSTR(MEM_REGNO1,1,2)='75' 
         AND SUBSTR(MEM_REGNO2,1,1)='2';
             
    COMMIT; --하드디스크에 저장 
    
사용예)회원테이블에서 20-30대 회원을 검색하여 출력하시오.
      Alias는 회원번호,회원명,주소,직업,마일리지
      
    SELECT MEM_ID AS 회원번호,
           MEM_NAME AS 회원명,
           MEM_REGNO1 AS 주민번호,
           EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000) AS 나이,
           MEM_ADD1 ||''|| MEM_ADD2 AS 주소,
           MEM_JOB AS 직업,
           MEM_MILEAGE AS 마일리지
      FROM MEMBER
     WHERE EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000)
            BETWEEN 20 AND 39
            
사용예)매입테이블(BUYPROD)에서 2005년 2월 매입정보를 조회하시오
      Alias는 날짜,상품코드,수량,매입금액이며 날짜순으로 출력하시오
      
    SELECT BUY_DATE AS 날짜,--문자열이 아니라 날짜타입인거 확인해봐
           BUY_PROD AS 상품코드,
            BUY_QTY AS 수량,
   BUY_QTY*BUY_COST AS 매입금액 --COST는 그냥 단가값이야
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY('20050201') --LAST_DAY주어진 달의 맨 끝 날짜를 알게 해주는 함수/2월은 윤달이 있어서 사용해야 한다/사실 TO_DATE를 쓰는 게 정석이다. 하지만 알아서 날짜타입으로 인식하기도 함
           --SUBSTR(BUY_DATE,1,7)='2005/02'
           --BUY_DATE >='20050201' AND BUY_DATE <='20050228'
     ORDER BY 1;
       
             
             
             
             
             
             
             
             
             
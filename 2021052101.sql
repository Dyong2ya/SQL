2021-05-21)함수 및 연산자
 4) LIKE 연산자 --일부만 같으면 전체가 같은 것으로 할 때 사용(패턴비교 ex)욕설이 포함되는 문장 삭제 / 패턴비교'문자열', 숫자,날짜에는 사용x
  -컬럼의 값을 지정된 패턴과 비교할 때 사용되는 연산자
  -패턴비교 문자열로 '%'와 '_'가 사용됨
  -WHERE절의 조건절 구성에 이용됨
  
  [와일드카드] --문자열이니까 ''로 묶어서 표시해줘야돼 
  '%' : 사용된 위치에서 여러 문자와 대응
   ex)'대전%' : 대전으로 시작하는 모든 문장과 대응
      '%함' : 끝 글자가 함으로 끝나는 모든 문장과 대응
      '%의%' : 단어 중간에 의가 있는 모든 문장과 대응
  '_' : 사용된 위치에서 하나의 문자와 대응
   ex)'대전_' : 3글자로 구성되며 대전으로 시작하는 단어와 대응
      '_함' : 2글자로 구성되며 끝 글자가 함으로 끝나는 모든 단어와 대응
      '_의_' : 단어 중간에 의가 있고 3글자로 구성된 모든 단어와 대응
 
 사용예)장바구니테이블(CART)에서 2005년 6월 판매된 자료를 일자별로 조회하시오 --BETWEEN연산자를 쓰는 것보다 훨씬 간단해짐
       Alias는 날짜,상품코드,수량
       SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS 날짜,
              CART_PROD AS 상품코드,
              CART_QTY AS 수량
         FROM CART
        WHERE CART_NO LIKE '200506%' --따옴표 안에 있어서 숫자가 아니라 문자열로 구분된다
        ORDER BY 1;
 
사용예)회원테이블(MEMBER)에서 거주지가 '충남'인 회원정보를 조회하시오 --조회는 SELECT문
      Alias는 회원번호,회원명,핸드폰번호,직업,마일리지이다.
      SELECT MEM_ID AS 회원번호, 
             MEM_NAME AS 회원명,
             MEM_HP AS 핸드폰번호,
             MEM_JOB AS 직업,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '충남%';
       
       
       
2. 함수
 -DBMS 제조사 측에서 미리 만들어 컴파일 해놓은 모듈 단위의 실행파일
 -문자열,숫자,날짜,변환,집계함수로 분류
 
1)문자열 함수
 (1) || (문자열 결합연산자)
   .JAVA의 문자열에 사용되는 '+'연산자와 동일
   .두 문자열을 결합하여 새로운 문자열을 반환
   (사용형식)
   문자열 || 문자열 

사용예)회원테이블에서 여성회원정보를 조회하시오
      Alias는 회원번호,이름,주민번호,마일리지이다. 단, 주민번호는 XXXXXX-XXXXXXX형식으로 출력하시오
      SELECT MEM_ID AS 회원번호, 
             MEM_NAME AS 이름,
             MEM_REGNO1||'-'||MEM_REGNO2 AS 주민번호,
             MEM_MILEAGE AS 마일리지
        FROM MEMBER
       WHERE SUBSTR(MEM_REGNO2,1,1)='2'
          OR SUBSTR(MEM_REGNO2,1,1)='4'; --WHERE절은 여성회원만 빼내려고
          
사용예)사원테이블(HR.EMPLOYEES)에서 급여가 10000이상이고 영업실적코드(COMMISSION_PCT)가 NULL이 아닌 사원정보를 조회하시오
      Alias는 사원번호,사원명,직무코드(JOB_ID),부서코드,영업실적코드,급여이며 이름은 성과 이름을 붙여 출력하시오
      SELECT EMPLOYEE_ID AS 사원번호,
             FIRST_NAME||' '||LAST_NAME AS 사원명,
             JOB_ID AS 직무코드,
             DEPARTMENT_ID AS 부서코드,
             COMMISSION_PCT AS 영업실적코드,
             SALARY AS 급여
        FROM HR.EMPLOYEES
       WHERE SALARY >= 10000
         AND COMMISSION_PCT IS NOT NULL; --(!=이렇게 쓰면 안된대)
         
 (2) CONCAT(c1,c2) --캐릭터문자열로 데이터를 받는 매개변수 / 잘 안 쓰여
   .두 문자열 c1과 c2를 결합하여 새로운 문자열로 반환

사용예)회원테이블에서 여성회원정보를 조회하시오
      Alias는 회원번호,이름,주민번호,마일리지이다. 단, 주민번호는 XXXXXX-XXXXXXX형식으로 출력하시오
      SELECT MEM_ID AS 회원번호, 
             MEM_NAME AS 이름,
             CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS 주민번호, --괄호 안의 CONCAT이 먼저 작동
             MEM_MILEAGE AS 마일리지
            FROM MEMBER
           WHERE SUBSTR(MEM_REGNO2,1,1)='2'
              OR SUBSTR(MEM_REGNO2,1,1)='4';
              
 (3) CHR(n), ASCII(c)
   .CHR(n) : 'n'에 해당하는 문자(한 글자)반환 --n은 정수값
   .ASCII(c) : 주어진 문자열 'c'의 첫 글자를 아스키 코드값으로 변환
      
   SELECT CHR(23),ASCII('KOREA'),ASCII('K') FROM DUAL; --해당되는 테이블이 없지만 SELECT문을 쓰려면 FROM테이블이 필요해. 그래서 가상테이블을 DUAL;을 사용        
   SELECT CHR(125),ASCII('대전시'),ASCII('A') FROM DUAL;
   
   SELECT MEM_NAME
     FROM MEMBER
 ORDER BY MEM_NAME; --WHERE절없는 건 다 출력하라는 소리야
 
    DECLARE
    V_CHAR VARCHAR2(100);
    BEGIN 
      FOR I IN 1..256 LOOP
        V_CHAR:=CHR(I);
        DBMS_OUTPUT.PUT_LINE(I||'='||V_CHAR);
      END LOOP;
     END;  
     
 (4) LOWER(c), UPPER(C), INITCAP(c)
   .LOWER(c) : 주어진 문자열 'c'에 저장된 모든 문자열을 소문자로 변환
   .UPPER(C) : 주어진 문자열 'c'에 저장된 모든 문자열을 대문자로 변환
   .INITCAP(c) : 주어진 문자열 'c'에 저장된 모든 문자열 중 단어의 첫 글자만 대문자로 변환
   
사용예)회원테이블에서 'S001'회원정보를 조회하시오
    SELECT *
      FROM MEMBER
    --WHERE MEM_ID='S001'; --이렇게 하면 MEMBER테이블에 있는 콜럼명은 뜨는데 내용이 안 떠. 그렇다고 정보가 없어서 그렇냐? 아님 대소문자땜에 정보가 안 나온거임
    WHERE UPPER(MEM_ID)='S001';
    
    SELECT *
      FROM HR.EMPLOYEES
    WHERE LAST_NAME=INITCAP('KING');
    
    SELECT INITCAP(LOWER(FIRST_NAME)||' '||LOWER(LAST_NAME))
      FROM HR.EMPLOYEES;
      
 (5) LPAD(c1,n[,c2]), RPAD(c1,n[,c2])
   . LPAD(c1,n[,c2]) : 정의된 정수값 n 만큼의 길이에 c1을 채우고 남는 공간에 왼쪽에 c2를 채움, c2는 생략되면 공백이 채워짐
   . RPAD(c1,n[,c2]) : 정의된 정수값 n 만큼의 길이에 c1을 채우고 남는 공간에 오른쪽에 c2를 채움, c2는 생략되면 공백이 채워짐
        
사용예)
        SELECT LPAD('Oracle',10,'*') from dual;
        SELECT LPAD(PROD_NAME,20) AS 상품명, --이름을 20칸에 쓰는데 왼쪽 정렬
               LPAD(PROD_PRICE,15,'*') AS 가격
          FROM PROD
        WHERE PROD_LGU=UPPER('P301');
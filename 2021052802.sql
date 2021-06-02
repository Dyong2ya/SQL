2021-0528-02) NULL 처리함수
 - 오라클의 모든 컬럼은 자료형과 관계없이 자료가 입력되지 않으면 모두 NULL 값이 입력됨(단, default value로 설정된 경우 제외) --퇴사일에 NULL값이 들어오면 퇴사한 사람이야. 아무 것도 없어야 재직중인거고 --NOT NULL은 기본키의 성질 이런 건 반드시 데이터를 넣어줘야 돼
 - NULL 값이 저장된 컬럼은 연산결과 모두 NULL값을 반환
 - NULL을 의도적으로 사용하는 경우도 있음(자료 부존재 표시)
 - NULL을 처리하는 함수는 NVL,NVL2,NVLLIF 등이 제공
 
 1) NVL(c,value)
  - c에 저장된 값이 NULL이면 'value'값을 반환하고 NULL이 아니면 자기자신 값을 반환
  - c와 value는 반드시 같은 타입의 자료형이어야 한다
  
 사용예) 사원테이블에서 영업실적에 따른 보너스를 계산하고 지급될 지급액을 조회하시오
        보너스=급여*영업실적코드
        지급액=급여+보너스
        Alias는 사원번호,사원명,급여,보너스,지급액이다
        SELECT EMPLOYEE_ID AS 사원번호,
               FIRST_NAME||' '||LAST_NAME AS 사원명,
               SALARY AS 급여,
               --NVL(TO_CHAR(COMMISSION_PCT),'영업실적없음') AS 영업실적, --오른쪽정렬해서 COMMISSION_PCT는 숫자인 걸 알 수 있어 (COMMISSION_PCT,'영업실적없음')이거는 숫자, 문자열이잖아. 그럼 수를 TO_CHAR로 두거나
               NVL(COMMISSION_PCT,0) AS 영업실적,
               NVL(SALARY*COMMISSION_PCT,0) AS 보너스, 
               SALARY+NVL(SALARY*COMMISSION_PCT,0) AS 지급액 --보너스랑 지급액은 계산해야돼 --NVL을 바깥에 설정하면 단순히 값을 0으로 바꿔주는거야 그래서 안에 붙여줘야돼`
          FROM HR.EMPLOYEES;
          
사용예) 2005년 4월 모든 상품별 매입자료를 조회하시오 --'~별'은 GROUP BY를 사용해!!!!!!!!!!!!!!!! 모든이 붙었으면 JOIN중에서도 OUTER JOIN을 써줘야 한다. 날짜.기간은 조건으로 처리해야 한다
       Alias는 상품코드,상품명,매입수량,매입금액합계
       SELECT B.PROD_ID AS 상품코드,
              B.PROD_NAME AS 상품명,
              SUM(A.BUY_QTY) AS 매입수량,
              SUM(A.BUY_QTY*B.PROD_COST) AS 매입금액합계
         FROM BUYPROD A, PROD B
        WHERE B.PROD_ID=A.BUY_PROD(+)
          AND A.BUY_DATE BETWEEN TO_DATE('20050401')
              AND TO_DATE('20050430')
        GROUP BY B.PROD_ID,B.PROD_NAME
        ORDER BY 1;
       
 (ANSI OUTER JOIN)
       SELECT B.PROD_ID AS 상품코드,
              B.PROD_NAME AS 상품명,
              NVL(SUM(A.BUY_QTY),0) AS 매입수량,
              NVL(SUM(A.BUY_QTY*B.PROD_COST),0) AS 매입금액합계
         FROM BUYPROD A
        RIGHT OUTER JOIN PROD B ON(B.PROD_ID=A.BUY_PROD)
          AND A.BUY_DATE BETWEEN TO_DATE('20050401')
              AND TO_DATE('20050430')
        GROUP BY B.PROD_ID,B.PROD_NAME
        ORDER BY 1;
        
 3) NVL2(c,val1,val2)
  - c값이 NULL이면 val2를 NULL이 아니면 val1을 반환
  - val1과 val2는 같은 데이터 타입이어야 함
  
사용예) 상품테이블에서 상품의 크기정보를 나타내는 컬럼(PROD_SIZE)을 조회하여 출력하시오. 단, 크기정보가 없으면 'SIZE 정보 없음'을 출력해야 하며 NVL2를 사용하고, 마일리지정보도 없으면 0을 NVL을 이용하여 출력하시오
       Alias는 상품코드,상품명,크기,마일리지
       SELECT PROD_ID AS 상품코드,
              PROD_NAME AS 상품명,
              NVL2(PROD_SIZE,PROD_SIZE,'SIZE 정보 없음') AS 크기,--VARCHAR2로 되어있는 걸 확인해
              NVL(PROD_MILEAGE,0) AS 마일리지
         FROM PROD
         
사용예) 상품테이블에서 상품의 전체재고(PROD_TOTALSTOCK)와 마일리지(PROD_MILEAGE)에 값을 삽입하여 테이블을 갱신하시오
       1. 전체재고=적정재고의 80%
       2. 마일리지=판매단가의 0.01%
       두 항목 모두 정수 값이며, 값이 없으면(NULL) 0을 입력할 것
       
       UPDATE PROD A
          SET (A.PROD_TOTALSTOCK,A.PROD_MILEAGE)=
          (SELECT NVL(ROUND(B.PROD_PROPERSTOCK*0.8),0), --토탈2. 이제 얘네 계산해준다
                  NVL(ROUND(B.PROD_PRICE*0.0001),0) --마일리지2.
             FROM PROD B
            WHERE B.PROD_ID=A.PROD_ID) --1.비테이블에서 에이케이블에 있는 상품과 똑같은 것을 고른다
            
    COMMIT;
    SELECT PROD_ID,PROD_TOTALSTOCK,PROD_MILEAGE
      FROM PROD;
      
 3) NULLIF(c1,c2)
  - c1과 c2를 비교하여 같은 값이면 NULL을 다른 값이면 c2를 반환
  
    SELECT NULLIF('IL POSTINO',UPPER('il postino'))
      FROM DUAL;
      
사용예) 상품테이블에서 거래처코드가 'P20202'인 상품의 매출가격을 매입가격으로 할인판매가격은 매입가격의 90%로 조정하시오
       UPDATE PROD
          SET PROD_PRICE=PROD_COST,
              PROD_SALE=ROUND(PROD_COST*0.9)  --여기가지는 모든 제품 WHERE에서 골라야지
        WHERE PROD_BUYER='P20202';
        
        SELECT PROD_NAME,
               PROD_COST,
               PROD_PRICE,
               PROD_SALE
          FROM PROD
          WHERE PROD_BUYER='P20202';
          
          COMMIT;
          
사용예) 상품테이블에서 상품의 판매가와 매입가가 같으면 '정리대상품목'을 출력하고 같지 않으면 판매이익을 출력하시오
        Alias는 상품코드,상품명,매입가,매출가,비고
        SELECT PROD_ID AS 상품코드,
               PROD_NAME AS 상품명,
               PROD_COST AS 매입가,
               PROD_PRICE AS 매출가,
               NVL2(NULLIF(PROD_COST,PROD_PRICE),TO_CHAR((PROD_PRICE-PROD_COST),'999,999'),'정리대상품목') AS 비고 --99999이거 안 쓰면 다 왼쪽으로 쏠려서 별로야
          FROM PROD;
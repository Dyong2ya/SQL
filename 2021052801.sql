2021-0528-01)
 6) ROLLUP(컬럼명1[,컬럼명2,컬럼명3,...컬럼명n]))
  - GROUP BY절 안에 사용
  - 기술된 컬럼명들을 기준으로 레벨별 집계제공
  - 레벨은 오른->왼쪽으로 적용
    ex) GROUP BY ROLLUP(C1,C2,C3)
     => (C1,C2,C3)를 기준으로 한 집계,
        (C1,C2)를 기준으로 한 집계,
        (C1)를 기준으로 한 집계,
        전체집계
  - 사용된 컬럼이 n개이면 n+1종류의 집계 제공
  
사용예) 2005년 5월 일자별,분류별,상품별 매출집계를 ROLLUP을 이용하여 조회하시오 --분류기준 3가지 분류코드별, 상품코드별, 날짜 --얘네로 분류하라고 했으니까 테이블 세 개 하고 매출집계는 그 콜럼 2개 맨날 오는거QTY나오는 거
       Alias는 날짜,분류명,상품명,매출수량합계,매출금액합계이다.
       (ROLLUP 미적용)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS 날짜,--판매되어진 날짜라서 그건 CART테이블 앞 8자리에만 있어
              B.LPROD_NM AS 분류명,--LPROD 테이블에 있음
              C.PROD_NAME AS 상품명,--PROD 테이블에 있음
              SUM(A.CART_QTY)매출수량합계,
              SUM(A.CART_QTY*C.PROD_PRICE) AS 매출금액합계
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME
        ORDER BY 1;
        
       (ROLLUP 적용)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS 날짜,--판매되어진 날짜라서 그건 CART테이블 앞 8자리에만 있어
              B.LPROD_NM AS 분류명,--LPROD 테이블에 있음
              C.PROD_NAME AS 상품명,--PROD 테이블에 있음
              SUM(A.CART_QTY)매출수량합계,
              SUM(A.CART_QTY*C.PROD_PRICE) AS 매출금액합계
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY ROLLUP(TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME);
                 
 7) CUBE(컬럼명1[,컬럼명2,컬럼명3,...컬럼명n]))
  - GROUP BY절 안에 사용
  - 기술된 컬럼명들을 기준으로 조합 가능한 모든 종류의 집계제공
  - n개의 컬럼이 사용되면 2의 n승 만큼의 집계종류 반환 --5월달만의 집계(전체집계),상품명만 집계, 분류명만 집계, 분류상품명별 집계, 상품별 집계, 날짜명집계, 날짜별 분류명 집계, 닐짜별 상품별집계
  
사용예) 2005년 5월 일자별,분류별,상품별 매출집계를 ROLLUP,CUBE 을 이용하여 조회하시오 --분류기준 3가지 분류코드별, 상품코드별, 날짜 --얘네로 분류하라고 했으니까 테이블 세 개 하고 매출집계는 그 콜럼 2개 맨날 오는거QTY나오는 거
       Alias는 날짜,분류명,상품명,매출수량합계,매출금액합계이다.
       (GROUP BY절만 적용)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS 날짜,--판매되어진 날짜라서 그건 CART테이블 앞 8자리에만 있어
              B.LPROD_NM AS 분류명,--LPROD 테이블에 있음
              C.PROD_NAME AS 상품명,--PROD 테이블에 있음
              SUM(A.CART_QTY)매출수량합계,
              SUM(A.CART_QTY*C.PROD_PRICE) AS 매출금액합계
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME
        ORDER BY 1;
             
       (ROLLUP 적용)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS 날짜,--판매되어진 날짜라서 그건 CART테이블 앞 8자리에만 있어
              B.LPROD_NM AS 분류명,--LPROD 테이블에 있음
              C.PROD_NAME AS 상품명,--PROD 테이블에 있음
              SUM(A.CART_QTY)매출수량합계,
              SUM(A.CART_QTY*C.PROD_PRICE) AS 매출금액합계
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY ROLLUP(TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME);
        
       (CUBE 적용)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS 날짜,--판매되어진 날짜라서 그건 CART테이블 앞 8자리에만 있어
              B.LPROD_NM AS 분류명,--LPROD 테이블에 있음
              C.PROD_NAME AS 상품명,--PROD 테이블에 있음
              SUM(A.CART_QTY)매출수량합계,
              SUM(A.CART_QTY*C.PROD_PRICE) AS 매출금액합계
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY CUBE(TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME);
    
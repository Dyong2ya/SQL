2021-0601-02)외부조인(OUTER JOIN)
 - 내부조인은 조인조건이 일치하는 데이터를 추출
 - 외부조인은 조인조건에 일치하지 않은 데이터도 추출
 - 조인 대상테이블 중 데이터가 없는 테이블 조인조건에 외부조인 연산자('(+)')를 붙임
 - 외부조인 조건이 여러개인 경우 모두 '(+)'를 붙임
 - 한 번에 하나의 테이블만 외부조인을 할 수 있다. 예를 들어 A,B,C테이블이 조인 연산에 참여하고
   A를 기준으로 B가 화장되고, 동시에 C를 기준으로 B가 확장될 수 없다
   (WHERE A.컬럼명=B.컬럼명(+)
      AND C.컬럼명=B.컬럼명(+)  --허용안됨)
 - '(+)'연산자가 붙은 조건에 OR연산자나 IN연산자를 같이 사용할 수 없다
 - 일반조건이 동시에 적용되는 외부조인은 ANSI나 서브쿼리로 작성해야 정확한 결과를 얻을 수 있음 
 (사용형식-일반 외부조인)
 SELECT 컬럼list
   FROM 테이블명1,테이블명2[,테이블명3,...]
  WHERE 테이블명1.컬럼명(+)=테이블명2.컬럼명
                      :
                      
(사용형식-ANSI 외부조인)
 SELECT 컬럼list
   FROM 테이블명1 
 RIGHT|LEFT|FULL OUTER JOIN 테이블명2 ON(조인조건[ AND 일반조건])
                    :
 [WHERE 일반조건]
   .'RIGHT|LEFT|FULL' : 테이블명1이 많은 자료를 가지고 있으면 LEFT, 적은 자료를 가지고 있으면 RIGHT
                        양쪽 모두 작은자료를 가기고 있으면 FULL임
   . SELECT 절의 '컬럼명'은 많은 자료를 가지고 있는 테이블의 컬럼명을 사용
   . COUNT(*|컬럼명)함수의 매개변수는 반드시 '컬럼명'을 사용 
   
사용예)상품테이블과 분류테이블을 사용하여 모든 분류별 상품의 가지수를 조회하시오 --PROD_LGU분류코드 //OUTER JOIN은 "모두,전부"이런 부사가 붙는다 /~별은 GROUP BY로// 가지수는 COUNT
      SELECT A.LPROD_GU AS 분류코드,
             A.LPROD_NM AS 분류명,
             COUNT(B.PROD_PRICE)
        FROM LPROD A, PROD B --행의 수가 많다적다가 아니라 종류의 수로 따져
       WHERE A.LPROD_GU=B.PROD_LGU(+)
       GROUP BY A.LPROD_GU,A.LPROD_NM
       ORDER BY 1; 
  (ANSI FORMAT)
      SELECT A.LPROD_GU AS 분류코드,
             A.LPROD_NM AS 분류명,
             COUNT(B.PROD_PRICE) AS "상품의 수"
        FROM LPROD A
        LEFT OUTER JOIN PROD B ON(A.LPROD_GU=B.PROD_LGU)
       GROUP BY A.LPROD_GU,A.LPROD_NM
       ORDER BY 1;         
      
       
사용예)장바구니 테이블에서 2005년도 6월 모든 회원별 판매현황를 조회하시오
      Alias는 회원번호,회원명,판매수량,판매금액
      
      SELECT B.MEM_ID AS 회원번호,
             B.MEM_NAME AS 회원명,
             SUM(A.CART_QTY) AS 판매수량,
             SUM(A.CART_QTY*C.PROD_PRICE) AS 판매금액
        FROM CART A, MEMBER B, PROD C
       WHERE A.CART_MEMBER(+)=B.MEM_ID 
         AND A.CART_PROD=C.PROD_ID
         AND A.CART_NO LIKE '200506%' --날짜,기간은 무조건 일반조건
       GROUP BY B.MEM_ID,B.MEM_NAME
       ORDER BY 1;
--전체 다 안 나와

  (ANSI FORMAT)
      SELECT B.MEM_ID AS 회원번호,
             B.MEM_NAME AS 회원명,
             NVL(SUM(A.CART_QTY),0) AS 판매수량,
             NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS 판매금액
        FROM CART A
       RIGHT OUTER JOIN MEMBER B ON(A.CART_MEMBER=B.MEM_ID AND A.CART_NO LIKE '200506%') --이제는 모든 회원조회 가능해졌어 위랑 달라
        LEFT OUTER JOIN PROD C ON(A.CART_PROD=C.PROD_ID)        
       GROUP BY B.MEM_ID,B.MEM_NAME
       ORDER BY 1;

  (SUBQUERY 사용)
      SELECT B.MEM_ID AS 회원번호,
             B.MEM_NAME AS 회원명,
             NVL(D.SCNT,0) AS 판매수량,
             NVL(D.SSUM,0) AS 판매금액
        FROM MEMBER B, (SELECT CART_MEMBER, 
                               SUM(A.CART_QTY) AS SCNT,
                               SUM(A.CART_QTY*C.PROD_PRICE) AS SSUM
                          FROM CART A, PROD C
                         WHERE A.CART_NO LIKE '200506%'
                           AND A.CART_PROD=C.PROD_ID
                         GROUP BY CART_MEMBER) D  
       WHERE B.MEM_ID=D.CART_MEMBER(+)
       ORDER BY 1;

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
사용예) 2005년 1~6월 전체 상품별 매입/매출현황을 조회하시오 --전체 아우터/ ~별 그룹바이/날짜 일반조건
    (매입현황)
     SELECT A.PROD_ID AS 상품코드,--A가 제일 많지상품명,
            A.PROD_NAME AS 상품명, --A밖에 없어
            NVL(SUM(A.PROD_COST*B.BUY_QTY),0) AS 매입금액합계
       FROM PROD A
       LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.BUY_PROD 
        AND (B.BUY_DATE BETWEEN '20050101' AND '20050531'))
      WHERE A.PROD_ID=B.BUY_PROD(+)
      GROUP BY A.PROD_ID, A.PROD_NAME 
      ORDER BY 1;

    (매출현황)
     SELECT A.PROD_ID AS 상품코드,--A가 제일 많지상품명,
            A.PROD_NAME AS 상품명, --A밖에 없어
            NVL(SUM(A.PROD_PRICE*B.CART_QTY),0) AS 매출금액합계
       FROM PROD A
       LEFT OUTER JOIN CART B ON(A.PROD_ID=B.CART_PROD
        AND B.CART_NO LIKE '200505%')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
      
    (결합)--둘이 기술방식이 달라서 WHERE로 기술하게 되면 안돼. WHERE는 전체를 통틀어서 적용되어지는 경우에만 사용할 수 있다.아니면 ON절에서 사용해야 된다
     SELECT A.PROD_ID AS 상품코드,
            A.PROD_NAME AS 상품명, 
            NVL(SUM(A.PROD_COST*B.BUY_QTY),0) AS 매입금액합계,
            NVL(SUM(A.PROD_PRICE*B.CART_QTY),0) AS 매출금액합계
       FROM PROD A
       LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.BUY_PROD 
        AND (B.BUY_DATE BETWEEN '20050101' AND '20050531'))
       LEFT OUTER JOIN CART B ON(A.PROD_ID=B.CART_PROD
        AND B.CART_NO LIKE '200505%')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
      
사용예) 사원테이블과 부서테이블에서 모든 부서별 인원수와 평균급여를 조회하시오
       Alias는 부서코드,부서명,인원수,평균급여이다
--       SELECT NVL(TO_CHAR(B.DEPARTMENT_ID),'CEO') AS 부서코드,
--              B.DEPARTMENT_ID AS 부서코드,--B가 더 많으니까
--              NVL(B.DEPARTMENT_NAME,'CEO') AS 부서명,
--              NVL(COUNT(A.SALARY)),0) AS 인원수,
--              NVL(ROUND(AVG(A.SALARY),1),0) AS 평균급여
--         FROM HR.EMPLOYEES A
--         FULL OUTER JOIN HR.DEPARTMENTS B ON(B.DEPARTMENT_ID=A.DEPARTMENT_ID)
--        GROUP BY B.DEPARTMENT_ID,B.DEPARTMENT_NAME
--        ORDER BY 1;
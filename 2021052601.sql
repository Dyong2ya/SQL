2021-0526-01)
 3) TO_DATE(d [,fmt]) --+과-의 대상. 형식지정문자열은 안 써주는 게 좋아
  - 주어진 문자열 자료 d를 'fmt'형식에 맞는 날짜형으로 변환 --숫자는 날짜형으로 바꾸는게 아니야!!!! 문자열을 날짜형으로 바꿔주는거야
  - 'fmt'는 TO_CHAR과 같으나 날짜형으로 취급될 수 있는 형식만 허용됨
  - d로 표현되는 자료는 최소 년,월,일을 나타낼 수 있는 자료이어야 한다

사용예) 장바구니테이블에서 2005년 5월 일자별 판매현황을 조회하시오 --사용되어진 테이블의 개수가 n가면 최소한의 join개수 (n-1)개
       단, 판매금액합계가 500만원 이상인 자료만 조회하시오
       Alias는 날짜,판매수량합계,판매금액합계
       
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8),'YYYY-MM-DD') AS 날짜, --문자열 8글자라 떨어지게 되는거야. 이걸 날짜형식으로 기술해주고 싶으면 TO_DATE를 붙여줘야지
              SUM(A.CART_QTY) AS 판매수량합계,
              SUM(A.CART_QTY*B.PROD_PRICE) AS 판매금액합계
         FROM CART A, PROD B
        WHERE A.CART_PROD=B.PROD_ID
          AND A.CART_NO LIKE '200505%'
        GROUP BY TO_DATE(SUBSTR(A.CART_NO,1,8),'YYYY-MM-DD')--WHERE라서 GROUP BY는 사용이 안돼
       HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=5000000
        OREDR BY 1;
        
사용예)회원테이블에서 회원들의 생년월일이 주민번호와 일치하지 않는다. 이를 주민등록번호를 기준으로 변경하시오

    SELECT MEM_REGNO1, MEM_BIR,
           CASE WHEN SUBSTR(MEM_REGNO1,1,1)='0' THEN
                     TO_DATE('20'||MEM_REGNO1)
                ELSE 
                     TO_DATE('19'||MEM_REGNO1)
                END
      FROM MEMBER;
      
      
     UPATE MEMBER A
       SET A.MEM_BIR=(SELECT CASE WHEN SUBSTR(MEM_REGNO1,1,1)='0' THEN
                                       TO_DATE('20'||MEM_REGNO1)
                                   ELSE 
                                       TO_DATE('19'||MEM_REGNO1)
                                    END
                         FROM MEMBER B
                        WHERE A.MEM_ID=B.MEM_ID);
                        
                        COMMIT;
                         
           HELP
           
 4) TO_NUMBER(c [,fmt]) 
  - 주어진 문자자료 c를 숫자형 데이터로 변환
  'fmt'는 TO_CHAR함수에 사용된 '9','0','.'를 사용할 수 있음
  
사용예) 
    SELECT TO_NUMBER('12345.67'),
           TO_NUMBER('12,345.67','999,999.99'), --원본자료가 정수가 5자리라서 9,999.99이렇게 정수부분이 4자리면 오류가 난다
  --         TO_NUMBER('12345.67','L99999.00')
           TO_NUMBER('12345.67','00000.00')
      FROM DUAL;

    SELECT 1,234+10 FROM DUAL; --1234아니야 1하고 234야. 첫번째 컬럼1, 
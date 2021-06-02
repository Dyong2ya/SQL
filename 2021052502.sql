2021-0525-02)변환함수
 - 자료형 변환 담당
 - CAST, TO_CHAR, TO_DATE, TO_NUMBER
 
 1) CAST(expr AS 타입명)
  - 명시적 형변환 함수
  - expr의 값을 '타입명'의 형식으로 해당 위치에서만 변환(일시적 변환)

사용예)장바구니테이블에서 2005년 7월 판매현황을 조회하시오
      Alias는 일자,수량,판매금액이며 날짜순으로 출력하시오
      SELECT CAST(SUBSTR(A.CART_NO,1,8) AS DATE) AS 일자,
             SUM(A.CART_QTY) AS 수량, --일자별이니까 모든 상품의 수량을 다 더해줘야 돼서
             SUM(A.CART_QTY*B.PROD_PRICE) AS 판매금액
        FROM CART A, PROD B--판매금액에서 단가를 구하기 위해 B사용
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '200507%'
       GROUP BY CAST(SUBSTR(A.CART_NO,1,8) AS DATE)
       ORDER BY 1;
   
 2) TO_CHAR(d [,fmt])
  - 주어진 자료 d(숫자, 날짜, 문자)를 'fmt'를 적용한 문자열로 형변환
  - (문자)=>문자열로 변환 : d가 CHAR, CLOB인 경우 VARCHAR2로 변환
  - 'fmt'는 날짜형식과 숫자형식문자열로 구성
  
  (날짜형식지정 문자열) -숫자로 변환X
-------------------------------------------------------------------------------------------------------------------------------
  FORMAT문자        의미
-------------------------------------------------------------------------------------------------------------------------------
 AD, BC, CC         세기(cc), 서기(BC,AD)         SELECT TO_CHAR(SYSDATE,'AD CC')
                                                   FROM DUAL;
 YYYY,YYY,YY,Y      년도
 MONTH,MON,MM,RM    월                            
 DD,DDD,J           일                            SELECT TO_CHAR(SYSDATE,'MONTH'),
                                                         TO_CHAR(SYSDATE,'MON'),
                                                         TO_CHAR(SYSDATE,'RM'), --로마자표기법
                                                         TO_CHAR(SYSDATE,'MM'),
                                                         TO_CHAR(SYSDATE,'DD'), --오늘을 뜻하는 날짜
                                                         TO_CHAR(SYSDATE,'DDD'), --연중일
                                                         TO_CHAR(SYSDATE,'J'), --기원전을 기준으로 일수
                                                         TO_CHAR(SYSDATE,'D') --일요일부터 오늘이 며칠인가
                                                    FROM DUAL;
                                                   
 DAY, DY            요일                           SELECT TO_CHAR(SYSDATE,'DAY'),
                                                          TO_CHAR(SYSDATE,'DY')
                                                     FROM DUAL;
                                                    
 Q                  분기                           SELECT TO_CHAR(SYSDATE,'Q')
                                                    FROM DUAL;
                                                    
 W,WW,IW            주차                          SELECT TO_CHAR(SYSDATE,'W'), --이번 달의 주차
                                                         TO_CHAR(SYSDATE,'WW'), --1월부터 오늘까지 경과되어진 주차
                                                         TO_CHAR(SYSDATE,'IW') --년주차
                                                    FROM DUAL;  
                                                         
 AM,A.M.,PM,P.M.    오전,오후                      SELECT TO_CHAR(SYSDATE,'AM'), 
                                                         TO_CHAR(SYSDATE,'PM') 
                                                    FROM DUAL;  
                                                    
 HH,HH12,HH24        시간                         SELECT TO_CHAR(SYSDATE,'HH'), 
                                                         TO_CHAR(SYSDATE,'HH12'),
                                                         TO_CHAR(SYSDATE,'HH24')
                                                    FROM DUAL;         
                                                    
 MI                  분                           
 SS,SSSSS            초                           SELECT TO_CHAR(SYSDATE,'HH:MI:SS'), 
                                                         TO_CHAR(SYSDATE,'HH24:MI:SSSSS') 
                                                    FROM DUAL;         
                                            
 " "안에 정의         사용자지정문자열                SELECT TO_CHAR(SYSDATE,'HH"시" MI"분" SS"초"'), 
                                                         TO_CHAR(SYSDATE,'HH24:MI:SSSSS') 
                                                    FROM DUAL;  
-------------------------------------------------------------------------------------------------------------------------------

 
 
 (숫자형식지정 '문자열') -숫자로 변환X
-------------------------------------------------------------------------------------------------------------------------------
  FORMAT문자        의미
-------------------------------------------------------------------------------------------------------------------------------
  9                 숫자자료 왼쪽의 무효의 0을 
                    공백으로 대치                             
  0                 숫자자료 왼쪽의 무효의 0을 
                    '0'으로 대치                        SELECT TO_CHAR(1234.8,'999,999.99'), --소수점 밑으로 2자린데 원본수는 1개밖에 없네. 그럼 0으로 찍어내줘
                                                              TO_CHAR(1234.8,'000,000.00')
                                                         FROM DUAL;
                                                         
  $,L               화폐기호 삽입 출력                   SELECT TO_CHAR(1234.8,'L999,999.99'),
                                                              TO_CHAR(1234.8,'$000,000.00')
                                                         FROM DUAL;   
                                                         
  MI                음수인 경우 '-'를 우측에 표시         
  PR                음수인 경우 '< >' 안에 표시           SELECT TO_CHAR(-1234.8,'999,999.99MI'),
                                                               TO_CHAR(-1234.8,'000,000.00PR')
                                                         FROM DUAL; 
  .(DOT)            소수점
  ,(COMMA)          3자리마다 자리점
-------------------------------------------------------------------------------------------------------------------------------



SELECT SUBSTR(MAX(CART_NO),1,8), --어디에서부터8자리
       TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000'))  --어디에서부터 다
  FROM CART
       
                                                      
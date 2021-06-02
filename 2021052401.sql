2021-0524-01

 (6) LTRIM(c1[,c2]), RTRIM(c1[,c2]) --공백도 하나의 문자열로 아스키코드값을 갖지만 이 함수를 쓰게 되면 알아서 짤린 것으로 인식하여 동일한 것으로 인식. 
   . LTRIM(c1[,c2]) : 주어진 문자열 c1에서 왼쪽으로부터 c2문자열을 찾아 제거함. c2가 생략되면 공백을 제거함 --숫자를 문자열로 바꿨을 때 
   . RTRIM(c1[,c2]) : 주어진 문자열 c1에서 오른쪽으로부터 c2문자열을 찾아 제거함. c2가 생략되면 공백을 제거함 --주로 CHAR고정되어 있는 공백을 제거할 때 
   . 단어 내부의 공백은 제거하지 못 함(REPLACE함수 사용)
   
사용예) 오늘이 2005년 7월20일이라고 가정하고 장바구니테이블의 장바구니 번호를 생성하시오 --CART테이블에 들어가서 CART_NO를 확인해보면 13글자인 것을 확인할 수 이씀

    SELECT TO_CHAR(SYSDATE,'YYYYMMDD') || LTRIM(TO_CHAR(1,'00000')) FROM DUAL; --1,'00000' 다섯 글자로 1을 표시하시오라는 뜻이야 / LENGTH를 쓰고 묶으면 몇자리인가 확인할 수 잇음
   
   SELECT LTRIM('IL POSTINO', 'TIN'),  --왼쪽에서 부터 똑같이(TIN) 생긴 단어를 지우는데 TIN로 시작하지 않으니까 못 지우는거야
          LTRIM('IL POSTINO', 'IL ')
     FROM DUAL;

 (7) TRIM(c1)
   . 오른쪽과 왼쪽에 (동시에)존재하는 무효의 공백을 모두 제거 --VARCHAR2는 딱 정해진 만큼만 데이터를 뽑아내서 사용되지 않지만 CHAR에서는 사용됨

 (8) SUBSTR(c1,m[,n]) --날짜에는 구별자도 포함되어 있어서 오류가 날 수 있으므로 날짜 이런 거 다 문자열''로 표시해줘
   . 주어진 문자열 c1에서 m번째 문자열에서 n개의 문자열을 추출하여 반환 
   . n이 생략되면 m번째 이후 모든 문자열을 추출
   . m은 문자열의 위치값으로 1부터 부여됨(0을 기술해도 1로 취급)
   . m이 음수이면 오른쪽 자리부터 처리함

사용예) --문자열을 떼어도 문자열이다
      SELECT SUBSTR('무궁화 꽃이 피었습니다!',2,5), --2번째글자에서 5글자까지
             SUBSTR('무궁화 꽃이 피었습니다!',2), --m에 해당하는 게 없으므로 전체 다 출력
             SUBSTR('무궁화 꽃이 피었습니다!',-2,5), --'-2'에 해당하는 '다'에서 시작인데 5글자까지 가려고 하지만 문장이 끝났자나. 글자 수 부족. 그럼 그냥 있는 데 까지만 출력해. 
             SUBSTR('무궁화 꽃이 피었습니다!',0,5) --0은 1번째 글자라는 의미
        FROM DUAL;
        
사용예) 회원테이블에서 대전에 거주하는 회원정보를 조회하시오
       Alias는 회원번호,회원명,성별,마일리지다 
       SELECT MEM_ID AS 회원번호,
              MEM_NAME AS 회원명,
              CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1'  --CASE WHEN은 IF라고 생각하면 돼 
                     OR SUBSTR(MEM_REGNO2,1,1)='3' THEN '남성' 
                  ELSE
                        '여성' END AS 성별,
              MEM_MILEAGE AS 마일리지
         FROM MEMBER
        WHERE SUBSTR(MEM_ADD1,1,2)='대전' --LIKE연산자를 써서 대전을 뽑아내도 돼
        ORDER BY 3 DESC; --컬럼명3이 성별정하는 거였잖아. 위에 있는 부분을 긁어와도 되는데 너무 기니까 그냥 숫자 3으로 표현해준다. 남성부터 뽑아내고 싶으면 어센딩시켜주면 돼

 (9) REPLACE(c1,c2[,c3]) 
   . c1에 포함된 c2문자열을 찾아 c3로 대치시킴
   . c3이 생략되면 c2를 찾아 제거시킴
   . 단어 내부의 공백 제거에 사용됨
   
사용예) 상품테이블에서 상품명 중 '겨울'을 찾아 '추동'으로 치환하여 출력하시오. 출력할 컬럼은 상품번호,원본상품명,변환상품명,판매가격이다.

    SELECT PROD_ID AS 상품번호,
           PROD_NAME AS 원본상품명,
           REPLACE(PROD_NAME,'겨울','추동') AS 변환상품명,
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE PROD_NAME LIKE '%겨울%'; --겨울이 들어간 모든 단어를 뽑아낸다
     
    SELECT PROD_ID AS 상품번호,
           PROD_NAME AS 원본상품명,
           REPLACE(PROD_NAME,' ') AS 변환상품명, --공백제거
           PROD_PRICE AS 판매가격
      FROM PROD
     WHERE PROD_NAME LIKE '%겨울%';
     
 (10) INSTR(c1,c2[,m[,n]]) --INDEX 찾고자 하는 문자열이 왼쪽에서 몇 번 나오나 
   . c1문자열에서 c2문자열이 처음 기술된 위치 값을 반환 --c1원본, c2찾고자하는 문자열
   . m은 검색할 시작위치 값, 생략되면 1이 default 값임
   . n은 반복해서 나올 순번 값
   
사용예)SELECT INSTR('PERSIMON APPLE BANANA', 'P'),
             INSTR('PERSIMON APPLE BANANA', 'P',2), --2번째 글자에서 시작해서 첫번째로 만나는 P의 위치. 세는 건 첫번째 글자부터 세서 11번재로 나오는 거야
             INSTR('PERSIMON APPLE BANANA', 'P',2,2),
             INSTR('PERSIMON APPLE BANANA', 'P',2,3), --이건 없자나 그래서 0으로 나온는 거야
             INSTR('PERSIMON APPLE BANANA', 'PLE',2)
        FROM DUAL;
     
     
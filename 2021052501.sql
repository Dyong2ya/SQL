2021-0525-01)날짜함수
 1) SYSDATE
  -시스템이 제공하는 날짜와 시각정보 제공
  -덧셈과 뺄셈 연산기능 제공
  
사용예)SELECT SYSDATE,SYSDATE+10,SYSDATE-10  -- +는 다가올 날짜, -는 지나간 날짜, 0시0분0초로 저장된다
        FROM DUAL;
      
      SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),
             TO_CHAR(SYSDATE+10,'YYYY-MM-DD HH24:MI:SS'),
             TO_CHAR(SYSDATE-10,'YYYY-MM-DD HH24:MI:SS')  
        FROM DUAL;
        
 2) ADD_MONTHS(d,n)
  - 주어진 날짜자료 d의 월 데이터에 n을 더한 월을 포함하는 날짜 반환 
  
사용예)회원의 기간이 3개월이고 기간이 종료되기 5일 전 알림을 설정하고자 할 때 알림시작일을 조회하시오
      SELECT ADD_MONTHS(SYSDATE,3)-5 FROM DUAL; --ADD_MONTH로 묶이는 건 날짜타입이다. 그 밖으로 -며칠 전을 입력하면 알림을 줄 수 있다.
      
 3) NEXT_DAY(d,c)
  - d에 해당하는 날짜에서 다가올 가장 빠른 'c'로 표현된 요일의 날짜 정보 반환 --오늘은 화요일인데 '화'를 뽑아내고 싶어. 그러면 어제말고 다음주 '화'를 추출할 수 있는거야/한글로 써야 인식돼/데이터베이스NLS에서 우리가 언어를 한글로 선택해놔서 그런거야
  - c는 요일을 나타내는 문자열 ex)'월','월요일','금','금요일',...
    SELECT NEXT_DAY(SYSDATE,'월'), 
           NEXT_DAY(SYSDATE,'월요일'),
           -- NEXT_DAY(SYSDATE,'MONDAY'), --영어라서 오류나!
           NEXT_DAY(SYSDATE,'화')
      FROM DUAL;
  
 4) LAST_DAY(d)
  - d에 해당하는 날자에서 해당 월의 마지막 날짜 자료 반환       
    SELECT LAST_DAY('20050201'),
           LAST_DAY('20201231')
          -- LAST_DAY('20200230') --문자열이 날짜형으로 반환되어 질 수 있지만 형식안에는 맞아야돼 2월에 30일은 못 와
      FROM DUAL;
사용예)매입테이블(BUYPROD)에서 20005년 2월 상품별 매입현황을 조회하시오
      Alias는 상품코드,상품명,매입수량,매입금액이며 상품코드순으로 출력하시오 
      SELECT B.PROD_ID AS 상품코드,
             B.PROD_NAME AS 상품명,
             SUM(A.BUY_QTY) AS 매입수량, --SUM을 쓰게 되면 합계를 구할 수 있다 / SUM을 써주는 이유른 상품명이 B테이블에 있기 때문에 연결시켜주려고
             SUM(A.BUY_QTY*B.PROD_COST) AS 매입금액
        FROM BUYPROD A, PROD B --상품명은 PROD에서 가져와야 돼서 테이블에 별칭을 붙여서 구분해 준거야. 이런 걸 JOIN이라고 한다
       WHERE A.BUY_PROD=B.PROD_ID   --LIKE연산자는 문자열 비교라서 여기서는 사용할 수 없어
         AND A.BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')--날짜값이 정해져 있을 때 사용한다
       GROUP BY B.PROD_ID,B.PROD_NAME 
       ORDER BY 1; 
       
사용예)오늘을 기준으로 이번달 남은 일수를 계산하시오
      SELECT LAST_DAY(SYSDATE)-SYSDATE FROM DUAL;

 5) MONTHS_BETWEEN(d1,d2)
  - 주어진 날자자료 d1과 d2사이의 개월수를 반환
  
사용예)SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,'19901205')/12) FROM DUAL; --/12로 나누니까 나이가 나오고 TRUNC를 쓰면 소수점 자리 잘라줘

 6) EXTRACT(fmt FROM d)
  - 'fmt'는 YEAR,MONTH,DAY,HOUR,MINUTE,SECOND를 사용
  - 주어진 날짜정보 d에서 fmt로 정의된 값을 추출하여 반환(숫자타입)
사용예)SELECT EXTRACT(YEAR FROM SYSDATE),
             EXTRACT(MONTH FROM SYSDATE),
             EXTRACT(DAY FROM SYSDATE)
        FROM DUAL; --오른쪽 정렬된 추출물을 볼 수 있는데 그건 숫자를 의미한다
        
        SELECT EXTRACT(YEAR FROM SYSDATE)+
             EXTRACT(MONTH FROM SYSDATE)+
             EXTRACT(DAY FROM SYSDATE)
        FROM DUAL; --숫자라서 다 더해지는 것을 확인할 수 있어
        
사용예)회원테이블에서 이번 달이 생일인 회원을 조회하시오
      Alias는 회원명,생년월일,나이,핸드폰번호이다
      SELECT MEM_NAME AS 회원명,
             MEM_BIR AS 생년월일,
             EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS 나이,
             MEM_HP AS 핸드폰번호
        FROM MEMBER
       WHERE EXTRACT(MONTH FROM MEM_BIR)=EXTRACT(MONTH FROM SYSDATE);
        
사용예)매입테이블에서 20005년 2월 상품별 매입현황을 조회하시오
      Alias는 상품코드,상품명,매입수량,매입금액이며 상품코드순으로 출력하시오 
      SELECT A.BUY_PROD AS 상품코드,
             B.PROD_NAME AS 상품명,
             SUM(A.BUY_QTY) AS 매입수량,
             SUM(A.BUY_QTY*A.BUY_COST)매입금액
        FROM BUYPROD A, PROD B
       WHERE A.BUY_PROD=B.PROD_ID --조인조건
         AND EXTRACT(MONTH FROM A.BUY_DATE)=2 --일반조건
        GROUP BY A.BUY_PROD, B.PROD_NAME
        ORDER BY 3 DESC; --매입수량이 많은 순으로 출력
2021-0524-02)숫자함수
 1) ABS(n), SIGN(n), POWER(n,y), SQRT(n)
  - 수학적 함수
  - ABS(n) : n의 절대 값 --부호를 다 없앤 값
  - SIGN(n) : n의 부호, n이 양수이면 1, 0이면 0, 음수이면 -1을 반환
  - POWER(n,y) : n의 y승 값을 반환
  - SQRT(n) : n의 평방근(루트) 값을 반환
  
사용예) SELECT ABS(100),ABS(-1.999),
              SIGN(-10000),SIGN(0),SIGN(0.0000099),
              POWER(2,10),
              SQRT(3.14)
         FROM DUAL;
         
 2) GREATEST(n1,n2[,n3,...]), LEAST(n1,n2[,n3,...]) --MAX는 주어진 컬럼 중 제일 큰 값, 알지 못 하는 값 중 제일 큰 값
  - GREATEST(n1,n2[,n3,...]) : 주어진 값 중 가장 큰 값을 반환
  - LEAST(n1,n2[,n3,...]) : 주어진 값 중 가장 작은 값을 반환
  
사용예)SELECT GREATEST('홍길동','홍길순','홍길남'),
             GREATEST(10,20,30,40),
             LEAST('강아지',999,'송아지')
        FROM DUAL;
사용예)사원테이블에서 사원들의 급여가 3000미만인 사원을 찾아 3000으로 변환하여 출력하시오
      Alias는 사원번호,사원명,변환 전 급여,변환 후 급여
    SELECT EMPLOYEE_ID AS 사원번호,
           FIRST_NAME||' '||LAST_NAME AS 사원명,
           SALARY AS "변환 전 급여", --공백이 있어서 ""로 묶어준다
           GREATEST(SALARY,3000) AS "변환 후 급여"
      FROM HR.EMPLOYEES
     ORDER BY 3 DESC;
     
 3) ROUND(n, i), TRUNC(n, i)
  - ROUND(n, i) : 주어진 수 n을 소수점 이하 i+1번째 자리에서 반올림하여 i번째 자리까지 표현 --줄 때
  - TRUNC(n, i) : 주어진 수 n을 소수점 이하 i+1번째 자리에서 절삭하여 i번째 자리까지 표현 --받을 때
  - i가 음수이면 정수부분의 i번째 자리에서 반올림(ROUND)또는 절삭(TRUNC)
  - i가 생략되면 i값은 0으로 간주됨(소수점 이하 첫 자리에서 반올림하여 소수점없는 정수를 반환: 정수화)
  
사용예)SELECT ROUND(23456.4376854, 3), --소수점 6에서 반올림
             ROUND(23456.4376854), --소수점 첫번째자리에서 4에서 반올림
             ROUND(23456.4376854, -2), --10의 자리에서 반올림
             TRUNC(23456.4376854, 3), --소수 3번째 자리까지 나타내어라
             TRUNC(23456.4376854),
             TRUNC(23456.4376854, -2) --정수 5에서 반올림
        FROM DUAL;
        
사용예)사원테이블에서 사원들의 급여(SALARY)가 포괄적 연봉이라고 간주하고 월급여를 계산하시오. 포괄적 연봉은 13개월치의 급여를 연봉이라 함
      Alias는 사원번호,사원명,원래의 급여,계산된 급여이며 계산된 급여는 소수점 1자리까지 출력할 것
      SELECT EMPLOYEE_ID AS 사원번호,
             FIRST_NAME||' '||LAST_NAME AS 사원명,
             SALARY AS "원래의 급여",
             TO_CHAR(ROUND(SALARY/13,1),'9,999.0') AS "계산된 급여" --TO_CHAR하고 9,999.0을 써 준 이유는 정수여도 .0이런 식으로 단위를 맞춰주기 위해서
        FROM HR.EMPLOYEES;
      
 4) MOD(n, d), REMAINDER(n, d)
  - 주어진 수 n을 d로 나눈 나머지를 반환 
  - MOD와 REMAINDER는 내부에서 처리하는 형식이 다름
  - MOD : n - d * FLOOR(n/d) (FLOOR(n):n과 같거나 작은 쪽에서 가장 큰 정수)
  - REMAINDER: n - d * ROUND(n/d) --나머지가 몫의 절반이상일 경우 다음 정수에서 이번 정수만큼 빼준다.......?????????
    ex)
      17/6 (=2..5)
      MOD(17,6) : 17 - 6*FLOOR(17/6) => 17-6*FLOOR(2.8XX)
                                        17-6*2 => 17-12 => 5
      REMAINDER(17,6) : 17 - 6*ROUND(17/6)
                        17 - 6*ROUND(2.8XXX) --다음몫은 3이잖아 
                        17 - 6*3
                        -1
                        
      14/6 (=2..2)
      MOD(14,6) : 14 - 6*FLOOR(14/6) 
                  14 - 6*FLOOR(2.3XXX)
                  14 - 6*2 
                  2
      REMAINDER(14,6) : 14 - 6*ROUND(14/6)
                        14 - 6*ROUND(2.33XXX) --다음몫은 3이잖아
                        14 - 6*2
                        2
                        
    SELECT MOD(14,6),REMAINDER(14,6),
           MOD(15,6),REMAINDER(15,6),
           MOD(17,6),REMAINDER(17,6)
      FROM DUAL;
      
 5) FLOOR(n), CEIL(n)
  - FLOOR(n) : n을 초과하지 않는 최대 정수(n과 같거나 작은 쪽에서 가장 큰 정수)
  - CEIL(n) : n과 같거나 큰 쪽에서 가장 작은 정수
  ex)
     FLOOR(23.89) => 23
     FLOOR(-23.89) => -24
     CEIL(23.89) => 24
     CEIL(-23.89) => -23
     
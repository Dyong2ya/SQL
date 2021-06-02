2021-0601-01)
 2)SEMI JOIN --내부쿼리에서 복수가 발생되더라도 알아서 중복배제시켜줌
  - 세미조인은 서브쿼리를 사용하여 서브쿼리의 결과에 존재하는 데이터만 메인쿼리에서 사용하는 조인 
  - 보통 EXISTS와 IN 연산자가 사용됨
  - 결과에 중복배제
  
사용예)사원의 급여가 10000을 넘는 사원이 있는 부서코드와 부서명을 조회하시오  --컬럼명이나 수식어가 나오지 않는다/ 얘뒤에는 바로 서브쿼리가 나온다. 
      SELECT A.DEPARTMENT_ID AS 부서코드,
             A.DEPARTMENT_NAME AS 부서명
        FROM HR.DEPARTMENTS A
       WHERE EXISTS (SELECT 1  --*를 써도 되는데 그냥 통상적으로 행이 있나없나를 확인하기 위해 1로 표시해본다
                       FROM HR.EMPLOYEES B
                      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
                        AND B.SALARY>=10000)
       ORDER BY 1;   
       -- WHERE EXISTS (  )  저 괄호안의 결과가 하나라도 나오게 된다면 저 행의 결과가 참이라고 여겨지게 된다. 그래서 컬럼의 값이 무의미. '행의 존재유무'가 중요
    
  그냥예시)SELECT 1
      FROM LPROD; --LPOD에 들어있는 행만큼 1이 출력돼

사용예)사원들의 평균급여보다 더 적은 급여를 받는 직원이 있는 부서코드와 부서명을 조회하시오    
      SELECT A.DEPARTMENT_ID AS 부서코드,
             A.DEPARTMENT_NAME AS 부서명
        FROM HR.DEPARTMENTS A
       WHERE EXISTS (SELECT 1 
                       FROM HR.EMPLOYEES B
                      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
                        AND B.SALARY<(SELECT AVG(SALARY)
                                        FROM HR.EMPLOYEES))  --23,24,23,26(첫번째 조건이 틀리면 밑으로도 실행 안해)
       ORDER BY 1;                 
  
  (IN 연산자 사용)
      SELECT A.DEPARTMENT_ID AS 부서코드,
             A.DEPARTMENT_NAME AS 부서명
        FROM HR.DEPARTMENTS A
       WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID 
                                   FROM HR.EMPLOYEES B
                                  WHERE B.SALARY<(SELECT AVG(SALARY)
                                                    FROM HR.EMPLOYEES))
       ORDER BY 1; 
  
  
 3) SELF JOIN
  - 하나의 테이블에 복수개의 별칭을 사용하여 서로 다른 테이블로 간주하여 조인 수행
  
 사용예)회원테이블에서 회원번호 'a001'회원보다 더 적은 마일리지를 보유한 회원을 조회하시오
       Alias는 회원번호,회원명,직업,마일리지이다
       SELECT B.MEM_ID AS 회원번호,
              B.MEM_NAME AS 회원명,
              B.MEM_JOB AS 직업,
              B.MEM_MILEAGE AS 마일리지
         FROM MEMBER A, MEMBER B --A는 A001, B는 전체회원
        WHERE A.MEM_ID='a001' 
          AND A.MEM_MILEAGE>B.MEM_MILEAGE; 
          
          
 4) ANTI JOIN
  - 서브쿼리가 사용되는 조인
  - 서브쿼리의 결과에 없는 데이터만 메인쿼리가 사용(한쪽테이블에만 있는 데이터만 추출)
  - 집합연산자 MINUS에 해당
  
사용예)부서의 위치가 미국 이외의 나라에 위치한 부서에 근무하는 사원정보를 조회
      Alias는 사원번호,사원명,부서명,도시,국가
      
SELECT EMPLOYEE_ID AS 사원번호,
       FIRST_NAME||' '||LAST_NAME AS 사원명,
       E.DNAME AS 부서명,
       E.CITY AS 도시,
       E.CNAME AS 국가
  FROM HR.EMPLOYEES D, (SELECT DEPARTMENT_ID,
                               DEPARTMENT_NAME AS DNAME,
                               CITY,
                               C.COUNTRY_NAME AS CNAME         
                          FROM HR.DEPARTMENTS A, HR.LOCATIONS B, HR.COUNTRIES C
                         WHERE B.COUNTRY_ID!='US'
                           AND A.LOCATION_ID=B.LOCATION_ID
                           AND B.COUNTRY_ID=C.COUNTRY_ID) E
 WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID;
      
사용예)부서의 위치가 미국 이외의 나라에 위치한 부서에 근무하는 사원정보를 조회
      Alias는 사원번호,사원명,부서코드
      
SELECT EMPLOYEE_ID AS 사원번호,
       FIRST_NAME||' '||LAST_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서코드
  FROM HR.EMPLOYEES A
 WHERE A.DEPARTMENT_ID NOT IN(SELECT C.DEPARTMENT_ID 
                                FROM HR.DEPARTMENTS C, HR.LOCATIONS D 
                               WHERE D.COUNTRY_ID='US'
                                 AND C.LOCATION_ID=D.LOCATION_ID)
 ORDER BY 3; 
 

SELECT EMPLOYEE_ID AS 사원번호,
       FIRST_NAME||' '||LAST_NAME AS 사원명,
       DEPARTMENT_ID AS 부서코드
  FROM HR.EMPLOYEES 

MINUS
 
SELECT EMPLOYEE_ID AS 사원번호,
       FIRST_NAME||' '||LAST_NAME AS 사원명,
       A.DEPARTMENT_ID AS 부서코드
  FROM HR.EMPLOYEES A
 WHERE A.DEPARTMENT_ID IN(SELECT C.DEPARTMENT_ID 
                            FROM HR.DEPARTMENTS C, HR.LOCATIONS D 
                           WHERE D.COUNTRY_ID='US'
                             AND C.LOCATION_ID=D.LOCATION_ID) 
 ORDER BY 3;                                  
                                 
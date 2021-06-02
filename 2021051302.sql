2021-0513-02)
사용예)사업장테이블(SITE)에 다음 자료를 저장하시오
--------------------------------------------------------------------------------------------------
사업장번호  사업장명          주소           전화번호    공사금액        투입인원  시공일자 완공일자 비고
---------------------------------------------------------------------------------------------------
WA1001     와동초등학교신축   대전시 대덕구                             1200     오늘
WG1102     천안아파트        충남 천안시                10000000000    800     2021/7/10
---------------------------------------------------------------------------------------------------

INSERT INTO SITE(SITE_NO,SITE_NAME,SITE_ADDR,INPUT_MAN_CNT,START_DATE)
 VALUES('WA1001','와동초등학교신축','대전시 대덕구',1200,SYSDATE);
 
INSERT INTO SITE(SITE_NO,SITE_NAME,SITE_ADDR,AMOUNT_CON,INPUT_MAN_CNT,START_DATE)
 VALUES('WG1102','천안아파트','충남 천안시',10000000000,'800','20210710');
 
 
 사용예)근무테이블(TBL_WORK)에 다음 자료를 저장하시오
----------------------------------
사원번호  사업장번호     투입일         
----------------------------------
E002      WG1102      오늘
E003      WA1001      2021/06/01
E001      WA1002      오늘
EOO2      WG1102
----------------------------------

INSERT INTO TBL_WORK(EMP_ID,SITE_NO) VALUES('E002','WG1102');

INSERT INTO TBL_WORK VALUES('E003','WA1001',TO_DATE('20210601'));

INSERT INTO TBL_WORK VALUES('E001','WA1001',SYSDATE);

INSERT INTO TBL_WORK(EMP_ID,SITE_NO) 
  VALUES('E002','WG1102'); 

    SELECT A.EMP_NAME
      FROM EMPLOYEE A, TBL_WORK B, SITE C
     WHERE B.SITE_NO=C.SITE_NO
       AND B.EMP_ID=A.EMP_ID
       AND C.SITE_NAME='와동초등학교신축'; 
    
                                                                                                                                                                                                                                                                                                   
 
 

 
2021-0513-02)
��뿹)��������̺�(SITE)�� ���� �ڷḦ �����Ͻÿ�
--------------------------------------------------------------------------------------------------
������ȣ  ������          �ּ�           ��ȭ��ȣ    ����ݾ�        �����ο�  �ð����� �ϰ����� ���
---------------------------------------------------------------------------------------------------
WA1001     �͵��ʵ��б�����   ������ �����                             1200     ����
WG1102     õ�Ⱦ���Ʈ        �泲 õ�Ƚ�                10000000000    800     2021/7/10
---------------------------------------------------------------------------------------------------

INSERT INTO SITE(SITE_NO,SITE_NAME,SITE_ADDR,INPUT_MAN_CNT,START_DATE)
 VALUES('WA1001','�͵��ʵ��б�����','������ �����',1200,SYSDATE);
 
INSERT INTO SITE(SITE_NO,SITE_NAME,SITE_ADDR,AMOUNT_CON,INPUT_MAN_CNT,START_DATE)
 VALUES('WG1102','õ�Ⱦ���Ʈ','�泲 õ�Ƚ�',10000000000,'800','20210710');
 
 
 ��뿹)�ٹ����̺�(TBL_WORK)�� ���� �ڷḦ �����Ͻÿ�
----------------------------------
�����ȣ  ������ȣ     ������         
----------------------------------
E002      WG1102      ����
E003      WA1001      2021/06/01
E001      WA1002      ����
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
       AND C.SITE_NAME='�͵��ʵ��б�����'; 
    
                                                                                                                                                                                                                                                                                                   
 
 

 
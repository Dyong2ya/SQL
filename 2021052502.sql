2021-0525-02)��ȯ�Լ�
 - �ڷ��� ��ȯ ���
 - CAST, TO_CHAR, TO_DATE, TO_NUMBER
 
 1) CAST(expr AS Ÿ�Ը�)
  - ����� ����ȯ �Լ�
  - expr�� ���� 'Ÿ�Ը�'�� �������� �ش� ��ġ������ ��ȯ(�Ͻ��� ��ȯ)

��뿹)��ٱ������̺��� 2005�� 7�� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ����,����,�Ǹűݾ��̸� ��¥������ ����Ͻÿ�
      SELECT CAST(SUBSTR(A.CART_NO,1,8) AS DATE) AS ����,
             SUM(A.CART_QTY) AS ����, --���ں��̴ϱ� ��� ��ǰ�� ������ �� ������� �ż�
             SUM(A.CART_QTY*B.PROD_PRICE) AS �Ǹűݾ�
        FROM CART A, PROD B--�Ǹűݾ׿��� �ܰ��� ���ϱ� ���� B���
       WHERE A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '200507%'
       GROUP BY CAST(SUBSTR(A.CART_NO,1,8) AS DATE)
       ORDER BY 1;
   
 2) TO_CHAR(d [,fmt])
  - �־��� �ڷ� d(����, ��¥, ����)�� 'fmt'�� ������ ���ڿ��� ����ȯ
  - (����)=>���ڿ��� ��ȯ : d�� CHAR, CLOB�� ��� VARCHAR2�� ��ȯ
  - 'fmt'�� ��¥���İ� �������Ĺ��ڿ��� ����
  
  (��¥�������� ���ڿ�) -���ڷ� ��ȯX
-------------------------------------------------------------------------------------------------------------------------------
  FORMAT����        �ǹ�
-------------------------------------------------------------------------------------------------------------------------------
 AD, BC, CC         ����(cc), ����(BC,AD)         SELECT TO_CHAR(SYSDATE,'AD CC')
                                                   FROM DUAL;
 YYYY,YYY,YY,Y      �⵵
 MONTH,MON,MM,RM    ��                            
 DD,DDD,J           ��                            SELECT TO_CHAR(SYSDATE,'MONTH'),
                                                         TO_CHAR(SYSDATE,'MON'),
                                                         TO_CHAR(SYSDATE,'RM'), --�θ���ǥ���
                                                         TO_CHAR(SYSDATE,'MM'),
                                                         TO_CHAR(SYSDATE,'DD'), --������ ���ϴ� ��¥
                                                         TO_CHAR(SYSDATE,'DDD'), --������
                                                         TO_CHAR(SYSDATE,'J'), --������� �������� �ϼ�
                                                         TO_CHAR(SYSDATE,'D') --�Ͽ��Ϻ��� ������ ��ĥ�ΰ�
                                                    FROM DUAL;
                                                   
 DAY, DY            ����                           SELECT TO_CHAR(SYSDATE,'DAY'),
                                                          TO_CHAR(SYSDATE,'DY')
                                                     FROM DUAL;
                                                    
 Q                  �б�                           SELECT TO_CHAR(SYSDATE,'Q')
                                                    FROM DUAL;
                                                    
 W,WW,IW            ����                          SELECT TO_CHAR(SYSDATE,'W'), --�̹� ���� ����
                                                         TO_CHAR(SYSDATE,'WW'), --1������ ���ñ��� ����Ǿ��� ����
                                                         TO_CHAR(SYSDATE,'IW') --������
                                                    FROM DUAL;  
                                                         
 AM,A.M.,PM,P.M.    ����,����                      SELECT TO_CHAR(SYSDATE,'AM'), 
                                                         TO_CHAR(SYSDATE,'PM') 
                                                    FROM DUAL;  
                                                    
 HH,HH12,HH24        �ð�                         SELECT TO_CHAR(SYSDATE,'HH'), 
                                                         TO_CHAR(SYSDATE,'HH12'),
                                                         TO_CHAR(SYSDATE,'HH24')
                                                    FROM DUAL;         
                                                    
 MI                  ��                           
 SS,SSSSS            ��                           SELECT TO_CHAR(SYSDATE,'HH:MI:SS'), 
                                                         TO_CHAR(SYSDATE,'HH24:MI:SSSSS') 
                                                    FROM DUAL;         
                                            
 " "�ȿ� ����         ������������ڿ�                SELECT TO_CHAR(SYSDATE,'HH"��" MI"��" SS"��"'), 
                                                         TO_CHAR(SYSDATE,'HH24:MI:SSSSS') 
                                                    FROM DUAL;  
-------------------------------------------------------------------------------------------------------------------------------

 
 
 (������������ '���ڿ�') -���ڷ� ��ȯX
-------------------------------------------------------------------------------------------------------------------------------
  FORMAT����        �ǹ�
-------------------------------------------------------------------------------------------------------------------------------
  9                 �����ڷ� ������ ��ȿ�� 0�� 
                    �������� ��ġ                             
  0                 �����ڷ� ������ ��ȿ�� 0�� 
                    '0'���� ��ġ                        SELECT TO_CHAR(1234.8,'999,999.99'), --�Ҽ��� ������ 2�ڸ��� �������� 1���ۿ� ����. �׷� 0���� ����
                                                              TO_CHAR(1234.8,'000,000.00')
                                                         FROM DUAL;
                                                         
  $,L               ȭ���ȣ ���� ���                   SELECT TO_CHAR(1234.8,'L999,999.99'),
                                                              TO_CHAR(1234.8,'$000,000.00')
                                                         FROM DUAL;   
                                                         
  MI                ������ ��� '-'�� ������ ǥ��         
  PR                ������ ��� '< >' �ȿ� ǥ��           SELECT TO_CHAR(-1234.8,'999,999.99MI'),
                                                               TO_CHAR(-1234.8,'000,000.00PR')
                                                         FROM DUAL; 
  .(DOT)            �Ҽ���
  ,(COMMA)          3�ڸ����� �ڸ���
-------------------------------------------------------------------------------------------------------------------------------



SELECT SUBSTR(MAX(CART_NO),1,8), --��𿡼�����8�ڸ�
       TRIM(TO_CHAR(TO_NUMBER(SUBSTR(MAX(CART_NO),9))+1,'00000'))  --��𿡼����� ��
  FROM CART
       
                                                      
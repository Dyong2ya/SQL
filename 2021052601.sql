2021-0526-01)
 3) TO_DATE(d [,fmt]) --+��-�� ���. �����������ڿ��� �� ���ִ� �� ����
  - �־��� ���ڿ� �ڷ� d�� 'fmt'���Ŀ� �´� ��¥������ ��ȯ --���ڴ� ��¥������ �ٲٴ°� �ƴϾ�!!!! ���ڿ��� ��¥������ �ٲ��ִ°ž�
  - 'fmt'�� TO_CHAR�� ������ ��¥������ ��޵� �� �ִ� ���ĸ� ����
  - d�� ǥ���Ǵ� �ڷ�� �ּ� ��,��,���� ��Ÿ�� �� �ִ� �ڷ��̾�� �Ѵ�

��뿹) ��ٱ������̺��� 2005�� 5�� ���ں� �Ǹ���Ȳ�� ��ȸ�Ͻÿ� --���Ǿ��� ���̺��� ������ n���� �ּ����� join���� (n-1)��
       ��, �Ǹűݾ��հ谡 500���� �̻��� �ڷḸ ��ȸ�Ͻÿ�
       Alias�� ��¥,�Ǹż����հ�,�Ǹűݾ��հ�
       
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8),'YYYY-MM-DD') AS ��¥, --���ڿ� 8���ڶ� �������� �Ǵ°ž�. �̰� ��¥�������� ������ְ� ������ TO_DATE�� �ٿ������
              SUM(A.CART_QTY) AS �Ǹż����հ�,
              SUM(A.CART_QTY*B.PROD_PRICE) AS �Ǹűݾ��հ�
         FROM CART A, PROD B
        WHERE A.CART_PROD=B.PROD_ID
          AND A.CART_NO LIKE '200505%'
        GROUP BY TO_DATE(SUBSTR(A.CART_NO,1,8),'YYYY-MM-DD')--WHERE�� GROUP BY�� ����� �ȵ�
       HAVING SUM(A.CART_QTY*B.PROD_PRICE)>=5000000
        OREDR BY 1;
        
��뿹)ȸ�����̺��� ȸ������ ��������� �ֹι�ȣ�� ��ġ���� �ʴ´�. �̸� �ֹε�Ϲ�ȣ�� �������� �����Ͻÿ�

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
  - �־��� �����ڷ� c�� ������ �����ͷ� ��ȯ
  'fmt'�� TO_CHAR�Լ��� ���� '9','0','.'�� ����� �� ����
  
��뿹) 
    SELECT TO_NUMBER('12345.67'),
           TO_NUMBER('12,345.67','999,999.99'), --�����ڷᰡ ������ 5�ڸ��� 9,999.99�̷��� �����κ��� 4�ڸ��� ������ ����
  --         TO_NUMBER('12345.67','L99999.00')
           TO_NUMBER('12345.67','00000.00')
      FROM DUAL;

    SELECT 1,234+10 FROM DUAL; --1234�ƴϾ� 1�ϰ� 234��. ù��° �÷�1, 
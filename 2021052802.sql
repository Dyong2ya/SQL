2021-0528-02) NULL ó���Լ�
 - ����Ŭ�� ��� �÷��� �ڷ����� ������� �ڷᰡ �Էµ��� ������ ��� NULL ���� �Էµ�(��, default value�� ������ ��� ����) --����Ͽ� NULL���� ������ ����� ����̾�. �ƹ� �͵� ����� �������ΰŰ� --NOT NULL�� �⺻Ű�� ���� �̷� �� �ݵ�� �����͸� �־���� ��
 - NULL ���� ����� �÷��� ������ ��� NULL���� ��ȯ
 - NULL�� �ǵ������� ����ϴ� ��쵵 ����(�ڷ� ������ ǥ��)
 - NULL�� ó���ϴ� �Լ��� NVL,NVL2,NVLLIF ���� ����
 
 1) NVL(c,value)
  - c�� ����� ���� NULL�̸� 'value'���� ��ȯ�ϰ� NULL�� �ƴϸ� �ڱ��ڽ� ���� ��ȯ
  - c�� value�� �ݵ�� ���� Ÿ���� �ڷ����̾�� �Ѵ�
  
 ��뿹) ������̺��� ���������� ���� ���ʽ��� ����ϰ� ���޵� ���޾��� ��ȸ�Ͻÿ�
        ���ʽ�=�޿�*���������ڵ�
        ���޾�=�޿�+���ʽ�
        Alias�� �����ȣ,�����,�޿�,���ʽ�,���޾��̴�
        SELECT EMPLOYEE_ID AS �����ȣ,
               FIRST_NAME||' '||LAST_NAME AS �����,
               SALARY AS �޿�,
               --NVL(TO_CHAR(COMMISSION_PCT),'������������') AS ��������, --�����������ؼ� COMMISSION_PCT�� ������ �� �� �� �־� (COMMISSION_PCT,'������������')�̰Ŵ� ����, ���ڿ����ݾ�. �׷� ���� TO_CHAR�� �ΰų�
               NVL(COMMISSION_PCT,0) AS ��������,
               NVL(SALARY*COMMISSION_PCT,0) AS ���ʽ�, 
               SALARY+NVL(SALARY*COMMISSION_PCT,0) AS ���޾� --���ʽ��� ���޾��� ����ؾߵ� --NVL�� �ٱ��� �����ϸ� �ܼ��� ���� 0���� �ٲ��ִ°ž� �׷��� �ȿ� �ٿ���ߵ�`
          FROM HR.EMPLOYEES;
          
��뿹) 2005�� 4�� ��� ��ǰ�� �����ڷḦ ��ȸ�Ͻÿ� --'~��'�� GROUP BY�� �����!!!!!!!!!!!!!!!! ����� �پ����� JOIN�߿����� OUTER JOIN�� ����� �Ѵ�. ��¥.�Ⱓ�� �������� ó���ؾ� �Ѵ�
       Alias�� ��ǰ�ڵ�,��ǰ��,���Լ���,���Աݾ��հ�
       SELECT B.PROD_ID AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��,
              SUM(A.BUY_QTY) AS ���Լ���,
              SUM(A.BUY_QTY*B.PROD_COST) AS ���Աݾ��հ�
         FROM BUYPROD A, PROD B
        WHERE B.PROD_ID=A.BUY_PROD(+)
          AND A.BUY_DATE BETWEEN TO_DATE('20050401')
              AND TO_DATE('20050430')
        GROUP BY B.PROD_ID,B.PROD_NAME
        ORDER BY 1;
       
 (ANSI OUTER JOIN)
       SELECT B.PROD_ID AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��,
              NVL(SUM(A.BUY_QTY),0) AS ���Լ���,
              NVL(SUM(A.BUY_QTY*B.PROD_COST),0) AS ���Աݾ��հ�
         FROM BUYPROD A
        RIGHT OUTER JOIN PROD B ON(B.PROD_ID=A.BUY_PROD)
          AND A.BUY_DATE BETWEEN TO_DATE('20050401')
              AND TO_DATE('20050430')
        GROUP BY B.PROD_ID,B.PROD_NAME
        ORDER BY 1;
        
 3) NVL2(c,val1,val2)
  - c���� NULL�̸� val2�� NULL�� �ƴϸ� val1�� ��ȯ
  - val1�� val2�� ���� ������ Ÿ���̾�� ��
  
��뿹) ��ǰ���̺��� ��ǰ�� ũ�������� ��Ÿ���� �÷�(PROD_SIZE)�� ��ȸ�Ͽ� ����Ͻÿ�. ��, ũ�������� ������ 'SIZE ���� ����'�� ����ؾ� �ϸ� NVL2�� ����ϰ�, ���ϸ��������� ������ 0�� NVL�� �̿��Ͽ� ����Ͻÿ�
       Alias�� ��ǰ�ڵ�,��ǰ��,ũ��,���ϸ���
       SELECT PROD_ID AS ��ǰ�ڵ�,
              PROD_NAME AS ��ǰ��,
              NVL2(PROD_SIZE,PROD_SIZE,'SIZE ���� ����') AS ũ��,--VARCHAR2�� �Ǿ��ִ� �� Ȯ����
              NVL(PROD_MILEAGE,0) AS ���ϸ���
         FROM PROD
         
��뿹) ��ǰ���̺��� ��ǰ�� ��ü���(PROD_TOTALSTOCK)�� ���ϸ���(PROD_MILEAGE)�� ���� �����Ͽ� ���̺��� �����Ͻÿ�
       1. ��ü���=��������� 80%
       2. ���ϸ���=�ǸŴܰ��� 0.01%
       �� �׸� ��� ���� ���̸�, ���� ������(NULL) 0�� �Է��� ��
       
       UPDATE PROD A
          SET (A.PROD_TOTALSTOCK,A.PROD_MILEAGE)=
          (SELECT NVL(ROUND(B.PROD_PROPERSTOCK*0.8),0), --��Ż2. ���� ��� ������ش�
                  NVL(ROUND(B.PROD_PRICE*0.0001),0) --���ϸ���2.
             FROM PROD B
            WHERE B.PROD_ID=A.PROD_ID) --1.�����̺��� �������̺� �ִ� ��ǰ�� �Ȱ��� ���� ����
            
    COMMIT;
    SELECT PROD_ID,PROD_TOTALSTOCK,PROD_MILEAGE
      FROM PROD;
      
 3) NULLIF(c1,c2)
  - c1�� c2�� ���Ͽ� ���� ���̸� NULL�� �ٸ� ���̸� c2�� ��ȯ
  
    SELECT NULLIF('IL POSTINO',UPPER('il postino'))
      FROM DUAL;
      
��뿹) ��ǰ���̺��� �ŷ�ó�ڵ尡 'P20202'�� ��ǰ�� ���Ⱑ���� ���԰������� �����ǸŰ����� ���԰����� 90%�� �����Ͻÿ�
       UPDATE PROD
          SET PROD_PRICE=PROD_COST,
              PROD_SALE=ROUND(PROD_COST*0.9)  --���Ⱑ���� ��� ��ǰ WHERE���� ������
        WHERE PROD_BUYER='P20202';
        
        SELECT PROD_NAME,
               PROD_COST,
               PROD_PRICE,
               PROD_SALE
          FROM PROD
          WHERE PROD_BUYER='P20202';
          
          COMMIT;
          
��뿹) ��ǰ���̺��� ��ǰ�� �ǸŰ��� ���԰��� ������ '�������ǰ��'�� ����ϰ� ���� ������ �Ǹ������� ����Ͻÿ�
        Alias�� ��ǰ�ڵ�,��ǰ��,���԰�,���Ⱑ,���
        SELECT PROD_ID AS ��ǰ�ڵ�,
               PROD_NAME AS ��ǰ��,
               PROD_COST AS ���԰�,
               PROD_PRICE AS ���Ⱑ,
               NVL2(NULLIF(PROD_COST,PROD_PRICE),TO_CHAR((PROD_PRICE-PROD_COST),'999,999'),'�������ǰ��') AS ��� --99999�̰� �� ���� �� �������� ����� ���ξ�
          FROM PROD;
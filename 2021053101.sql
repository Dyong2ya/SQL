2021-0531-01) ���̺� ����
 - ������ �����ͺ��̽��� ��ǥ ���� �� �ϳ�(Relationship)�� �̿�
 - �ʿ��� �ڷᰡ ���� ���̺� �л�Ǿ� �ִ� ��� ������ �Ӽ��� �̿��Ͽ� ������ ���� --�ĺ������ ��ĺ������ �ݵ�� ������ �Ǿ��־�� �Ѵ�
 - ũ�� �Ϲ��� ���ΰ� ANSI JOIN���� ���� --��� �ƿ��������� ����ؼ� ��Ȯ�� ����� ���� �� �־�
 - ��������(INNER JOIN : �������ǿ� �����ʴ� �ڷ�� ����) --������ ��(�������� ����)�� �������� �Ͽ� ���� ���� ���� ������ �ʿ� �ִ� �ڷḸ�� ������ ����
   �ܺ�����(OUTER JOIN : ������ ���̺� NULL���� �߰��Ͽ� JOIN����) --���� ����� �� ������ ���� ���� �������� ������ �ʿ� NULL�� �߰��ؼ� ���� ���ϰ� ������
 
 1. ��������
  - CARTESIAN PRODUCT, EQUI-JOIN, NON EQUI-JOIN,SELF JOIN ���� ���� 
 (�������)
 SELECT �÷�list
   FROM ���̺��1 [��Ī1], ���̺��2  [��Ī2][,���̺��3 [��Ī3],..] --�� ���̺��� �÷����� �Ȱ��� �̸��̸� ��Ī�� �ݵ�� �ʿ��ϴ�
  WHERE �������� --������ ���� WHERE�� �����Ұ�����!!!!
   [AND �Ϲ�����]
      :
 
  1) CARTESIAN PRODUCT
   . ��� ������ ����� ����
   . ���������� ���ų� �߸� ����� ���
   . �ݵ�� �ʿ����� ���� ��츦 �����ϰ� ������ ����
   
ex) SELECT COUNT(*) 
      FROM CART, PROD; --���� ���Ѱ�, ���� ���Ѱ�

    SELECT COUNT(*) 
      FROM CART, PROD,BUYPROD; 
      
  2) EQUI-JOIN
   . �������ǿ� '='�����ڰ� ���Ǵ� ����
   . ANSI JOIN �� INNER JOIN�� �ش�
   . ���� ���� �� ��κ��� ����������
   (ANSI�� INNER JOIN �������)
   SELECT �÷�list
     FROM ���̺��1 [��Ī1] --�������� ���̺��� �� �� ���� ����Ѵ�
    INNER JOIN ���̺��2 [��Ī2] ON(�������� [AND �Ϲ�����1]) --���̺���� ������ �÷��� �����ؾ� �Ѵ�. ����Ǵ� ��������. �Ϲ������� AND�� ���൵ �ǰ�(���̺�1,���̺�2���� ����Ǹ�) 
   [INNER JOIN ���̺��3 [��Ī3] ON(�������� [AND �Ϲ�����2])]
                            :
   [WHERE �Ϲ�����] --�ƴϸ� WHERE���� ������ �� �־�(���� ��� ���̺� ������ ���)
   
��뿹) ������̺��� �޿��� 5000�̻��� ��������� ��ȸ�Ͻÿ�
       Alias�� �����ȣ,�����,�μ���ȣ,�μ���,�޿�
       (�Ϲ�����)
       SELECT HR.EMPLOYEES.EMPLOYEE_ID AS �����ȣ,
              HR.EMPLOYEES.FIRST_NAME ||' '|| 
              HR.EMPLOYEES.LAST_NAME AS  �����,
              HR.EMPLOYEES.DEPARTMENT_ID AS �μ���ȣ,
              HR.DEPARTMENTS.DEPARTMENT_NAME AS �μ���,
              HR.EMPLOYEES.SALARY AS �޿�
         FROM HR.EMPLOYEES, HR.DEPARTMENTS
        WHERE SALARY>=5000 --�Ϲ�����
          AND HR.EMPLOYEES.DEPARTMENT_ID=
              HR.DEPARTMENTS.DEPARTMENT_ID
        ORDER BY 3;  
          
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.FIRST_NAME ||' '||A.LAST_NAME AS  �����,
              A.DEPARTMENT_ID AS �μ���ȣ,
              B.DEPARTMENT_NAME AS �μ���,
              A.SALARY AS �޿�
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.SALARY>=5000 --�Ϲ�����
          AND A.DEPARTMENT_ID=B.DEPARTMENT_ID --��������
        ORDER BY 3;       
          
        (ANSI FORMAT)
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.FIRST_NAME ||' '||A.LAST_NAME AS  �����,
              A.DEPARTMENT_ID AS �μ���ȣ,
              B.DEPARTMENT_NAME AS �μ���,
              A.SALARY AS �޿�
         FROM HR.EMPLOYEES A
        INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID=
              B.DEPARTMENT_ID)
        WHERE A.SALARY>=5000
        ORDER BY 3;
       
��뿹)2005�� 7�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
      Alias�� ��ǰ�ڵ�,��ǰ��,����,�ݾ�
      (�Ϲ�����)
      SELECT B.PROD_ID AS ��ǰ�ڵ�,
             B.PROD_NAME AS ��ǰ��,
             SUM(A.CART_QTY) AS ����,
             SUM(A.CART_QTY*B.PROD_PRICE) AS �ݾ�
        FROM CART A, PROD B
       WHERE A.CART_PROD=B.PROD_ID --EQUI����
         AND A.CART_NO LIKE '200507%'
       GROUP BY B.PROD_ID, B.PROD_NAME 
       ORDER BY 1;  
        
     (ANSI FORMAT)   
      SELECT B.PROD_ID AS ��ǰ�ڵ�,
             B.PROD_NAME AS ��ǰ��,
             SUM(A.CART_QTY) AS ����,
             SUM(A.CART_QTY*B.PROD_PRICE) AS �ݾ�
        FROM CART A
       INNER JOIN PROD B ON(A.CART_PROD=B.PROD_ID
         AND A.CART_NO LIKE '200507%')--�̰� ���� ��ȣ�� AND������ �־��ְ� ��ȣ������ ��
       GROUP BY B.PROD_ID,B.PROD_NAME
       ORDER BY 1;
 
��뿹)2005�� 3�� �ŷ�ó�� ���������� ��ȸ�Ͻÿ� --3���� � �ŷ�ó���� �󸶸�ŭ �����
      Alias�� �ŷ�ó�ڵ�,�ŷ�ó��,���Լ���,���Աݾ�
      
      SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
             B.BUYER_NAME AS �ŷ�ó��,
             SUM(A.BUY_QTY) AS ���Լ���,
             SUM(A.BUY_QTY*C.PROD_COST) AS ���Աݾ�
        FROM BUYPROD A, BUYER B, PROD C
       WHERE A.BUY_PROD=C.PROD_ID  -- ��������
         AND C.PROD_BUYER=B.BUYER_ID  -- �������� ���̺��� 3���� ���ż� 2���̻��� �ʿ�
         AND EXTRACT(MONTH FROM A.BUY_DATE)=03
       GROUP BY B.BUYER_ID,B.BUYER_NAME
       ORDER BY 1;
      
      (ANSI FORMAT)
      SELECT B.BUYER_ID AS �ŷ�ó�ڵ�,
             B.BUYER_NAME AS �ŷ�ó��,
             SUM(A.BUY_QTY) AS ���Լ���,
             SUM(A.BUY_QTY*C.PROD_COST) AS ���Աݾ�
        FROM BUYPROD A
       INNER JOIN PROD C ON(A.BUY_PROD=C.PROD_ID
         AND A.BUY_DATE BETWEEN '20050301' AND '20050331')
       INNER JOIN BUYER B ON(C.PROD_BUYER=B.BUYER_ID)
       GROUP BY B.BUYER_ID,B.BUYER_NAME
       ORDER BY 1;

��뿹)HR������ ���̺��� �̿��Ͽ� �̱� �ÿ�Ʋ���� �ٹ��ϴ� 
      ��������� ��ȸ�Ͻÿ�
      �����ȣ,�����,�μ���ȣ,�μ���,������
      SELECT A.EMPLOYEE_ID AS �����ȣ,
             A.FIRST_NAME||' '||A.LAST_NAME AS  �����,
             B.DEPARTMENT_ID AS �μ���ȣ,
             B.DEPARTMENT_NAME AS �μ���,
             C.JOB_TITLE AS ������
        FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.JOBS C,
             HR.LOCATIONS D
       WHERE D.CITY='Seattle'
         AND D.LOCATION_ID=B.LOCATION_ID
         AND A.DEPARTMENT_ID=B.DEPARTMENT_ID
         AND A.JOB_ID=C.JOB_ID
       ORDER BY 3;
      
      SELECT A.EMPLOYEE_ID AS �����ȣ,
             A.FIRST_NAME||' '||A.LAST_NAME AS  �����,
             B.DEPARTMENT_ID AS �μ���ȣ,
             B.DEPARTMENT_NAME AS �μ���,
             C.JOB_TITLE AS ������
        FROM HR.LOCATIONS D
       INNER JOIN HR.DEPARTMENTS B ON(D.LOCATION_ID=B.LOCATION_ID
         AND D.CITY='Seattle')
       INNER JOIN HR.EMPLOYEES A ON(B.DEPARTMENT_ID=A.DEPARTMENT_ID)
       INNER JOIN HR.JOBS C ON(A.JOB_ID=C.JOB_ID)
       ORDER BY 3;
       
��뿹)2005�� 5�� ȸ����, ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�  --ȸ���� �������� ���� �ϰ� ���߿� ��ǰ���� �� ����
      ��ȸ�� ������ ȸ����ȣ,ȸ����,��ǰ��,���ż���,���űݾ��̴� 
      SELECT B.MEM_NAME AS ȸ����,
             C.PROD_NAME AS ��ǰ��,
             SUM(A.CART_QTY) AS ���ż���,
             SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ�
        FROM CART A, MEMBER B, PROD C
       WHERE A.CART_MEMBER=B.MEM_ID
         AND A.CART_PROD=C.PROD_ID
         AND A.CART_NO LIKE '200505%' --�Ϲ�����
       GROUP BY ROLLUP(B.MEM_NAME,C.PROD_NAME) --���� �Ѿ��� �ϰ� ������ �� �� �ϳ��� ����ߵ�
       ORDER BY 1; --ȸ����ȣ ������ ����
      
      (ANSI FORMAT)
      SELECT B.MEM_NAME AS ȸ����,
             C.PROD_NAME AS ��ǰ��,
             SUM(A.CART_QTY) AS ���ż���,
             SUM(A.CART_QTY*C.PROD_PRICE) AS ���űݾ�
        FROM CART A
       INNER JOIN MEMBER B ON(A.CART_MEMBER=B.MEM_ID)
       INNER JOIN PROD C ON(A.CART_PROD=C.PROD_ID)
       WHERE A.CART_NO LIKE '200505%' --�Ϲ�����
       GROUP BY B.MEM_NAME,C.PROD_NAME
       ORDER BY 1;
      
��뿹)2005�� 5�� ��ǰ�� ����/���� ��Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ�ڵ�,��ǰ��,���Լ���,���Աݾ�,�������,����ݾ�
      SELECT A.PROD_ID AS ��ǰ�ڵ�,
             A.PROD_NAME AS ��ǰ��,
             NVL(B.BAMT,0) AS ���Լ���,
             NVL(B.BSUM,0) AS ���Աݾ�,
             NVL(C.CAMT,0) AS �������,
             NVL(C.CSUM,0) AS ����ݾ�
        FROM PROD A,
             (SELECT BUY_PROD AS BID,
                     SUM(BUY_QTY) AS BAMT,
                     SUM(BUY_QTY*BUY_COST) AS BSUM
                FROM BUYPROD
               WHERE BUY_DATE BETWEEN '20050501' AND '20050531'
               GROUP BY BUY_PROD) B,
             (SELECT CART_PROD AS CID,
                     SUM(CART_QTY) AS CAMT,
                     SUM(CART_QTY*PROD_PRICE) AS CSUM
                FROM CART, PROD
               WHERE CART_PROD=PROD_ID
                 AND CART_NO LIKE '200505%'
               GROUP BY CART_PROD) C 
       WHERE A.PROD_ID=B.BID(+)
         AND A.PROD_ID=C.CID(+);
               
       
         
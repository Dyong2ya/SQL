2021-0520-01) �����ڿ� �Լ�
1. ������
  - ���߾��� ���Ǵ� �����ڿ� ����
  - ��Ģ������, ���迬����, ��������, ��Ÿ�����ڷ� ����
 1)��Ģ������
  .'+','-','*','/'�� ����('%'�� ������� ����--�̷� ���� �Լ��� ����Ͽ� ���� �� �ִ�.)
 2)���迬����
  .���� ũ�⸦ ���� �� ���
  .'>,<,>=,<=,=,!= or <>' ���
 3)��������
  .NOT, AND, OR ���
 4)��Ÿ������
  .IN, SOME, ANY, ALL, BETWEEN,LIKE, EXISTS ���� �����ڰ� ������
  
  (1) IN ������
   . �ټ��� �� ����� ���� �����ϰ� �� �߿� ��� �� ���� ��ġ�ϸ� ��ü�� ���̵Ǵ� ���ǽ� ����
   . WHERE ���� ���ǿ� ��� --ifó�� ������ SELECT���� ��µ�
   . =ANY�� =SOME �Ǵ� OR �����ڷ� ġȯ ����
   (�������)
   expr IN (��1,��2,...--�񱳴���� �Ǿ����� ��)-- EXPR�� ǥ�����̴�(����, �÷���)
   
��뿹)��ǰ���̺�(PROD)���� ������ȭ('P301')�� ȭ��ǰ('P302')�з��� ���� ��ǰ������ ����Ͻÿ� --��ü��ǰ ��� �ƴϾ�!
    Alias�� ��ǰ�ڵ�,��ǰ��,�з��ڵ�,�ǸŰ����̴�
   
    (OR, IN, =ANY ������ ���)
    SELECT PROD_ID AS ��ǰ�ڵ�,
           PROD_NAME AS ��ǰ��,
           PROD_LGU AS �з��ڵ�,
           PROD_PRICE AS �ǸŰ���
      FROM PROD
      WHERE PROD_LGU='P301' OR PROD_LGU='P302' --������� �׻� FULL�� �� ����ߵ�
      
      WHERE PROD_LGU IN ('P301','P302')
      
      WHERE PROD_LGU =ANY('P301','P302');
      
��뿹)������̺��� '2005'�⿡�� '2008'�� ���̿� �Ի��� ��������� ��ȸ�Ͻÿ�
       Alias�� �����ȣ, �̸�, �Ի�����, �μ��ڵ�, �޿��̴� --HR������ �ִ� ���̺� EMPLYEES�� �ִ�/ �⎶ �ÿ��� SELECT���
       
       (AND ������ ��� --���ӵ� �ڷḸ ��°���)
       SELECT A.EMPLOYEE_ID AS �����ȣ, 
              FIRST_NAME ||''|| LAST_NAME AS �̸�, 
              HIRE_DATE AS �Ի�����, 
              DEPARTMENT_ID AS �μ��ڵ�, 
              SALARY AS �޿�
              FROM HR.EMPLOYEES A --���̺�Ī�� �����ϰ� �ݷ��� �տ� A�ϳ��� �ٿ��൵ ����. �ٵ� ���̺��� �ϳ��� ���� ��Ī �� �ٿ��൵ ����
              WHERE HIRE_DATE >= '20050101' AND HIRE_DATE <='20081231' --����� FULL�� �� ���ִ� �� ������!
              ORDER BY 1;--�����ȣ�����δ� 1, �Ի����ڼ����δ� 3, �̾ƾ��ϴµ� �÷��� �� 1�̶�� �ǹ�. ������������ ���°� �ȴ�.
              
        (IN ������ ��� --2005, 2007, 2008 �̷� ������ �ʿ��� �ڷ�鸸 ���Ⱑ��)
       SELECT A.EMPLOYEE_ID AS �����ȣ, 
              FIRST_NAME ||''|| LAST_NAME AS �̸�, 
              HIRE_DATE AS �Ի�����, 
              DEPARTMENT_ID AS �μ��ڵ�, 
              SALARY AS �޿�
              FROM HR.EMPLOYEES A 
              WHERE EXTRACT(YEAR FROM HIRE_DATE) IN(2005,2006,2007,2008)
              ORDER BY 3;
              
         (OR ������ ���)
        SELECT A.EMPLOYEE_ID AS �����ȣ, 
              FIRST_NAME ||''|| LAST_NAME AS �̸�, 
              HIRE_DATE AS �Ի�����, 
              DEPARTMENT_ID AS �μ��ڵ�, 
              SALARY AS �޿�
              FROM HR.EMPLOYEES A 
              WHERE EXTRACT(YEAR FROM HIRE_DATE)=2005
                 OR EXTRACT(YEAR FROM HIRE_DATE)=2007
                 OR EXTRACT(YEAR FROM HIRE_DATE)=2008
              ORDER BY 3;

  (2) ANY(SOME)������
   .�⺻ ����� IN �����ڿ� �����ϸ�, ANY�� SOME�� �������� ���� 
   . IN �����ڸ� ANY�� SOME���� ��ȯ�� ������ '=ANY(SOME)' ���·� ����ؾ� �� --�����ϸ� �ȵ�
   (�������)
   expr ���迬����ANY|SOME(��1,��2,...) --�����ϸ� �ȵ�
   
��뿹)������̺��� 10,20,50,80�� �μ��� ������ �ʴ� ���� ������ ����Ͻÿ� --'�ʴ�'���ã���!!!!!
      Alias�� �����ȣ,�����,�μ���ȣ,�μ����ȣ�̸� �μ��ڵ� ������ ����Ͻÿ�
      
      (NOT IN ������ ���)
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME ||''||LAST_NAME AS �����,
             DEPARTMENT_ID AS �μ���ȣ,
             MANAGER_ID AS �μ����ȣ
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID NOT IN(10,20,50,80) -- NOT�� �ٿ���� '�ƴ�' ����� ã��!
        ORDER BY 3;
             
      (NOT ANY(SOME) ������ ���)
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME ||''||LAST_NAME AS �����,
             DEPARTMENT_ID AS �μ���ȣ,
             MANAGER_ID AS �μ����ȣ
        FROM HR.EMPLOYEES
       WHERE NOT DEPARTMENT_ID =ANY(10,20,50,80) -- NOT�� ��ġ�� IN���̶� �ٸ� �� �����
        ORDER BY 3;
        
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME ||''||LAST_NAME AS �����,
             DEPARTMENT_ID AS �μ���ȣ,
             MANAGER_ID AS �μ����ȣ
        FROM HR.EMPLOYEES
       WHERE NOT DEPARTMENT_ID =SOME(10,20,50,80) -- NOT�� ��ġ�� IN���̶� �ٸ� �� �����
        ORDER BY 3;
        
      (AND ������ ���)
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME ||''||LAST_NAME AS �����,
             DEPARTMENT_ID AS �μ���ȣ,
             MANAGER_ID AS �μ����ȣ
        FROM HR.EMPLOYEES
       WHERE DEPARTMENT_ID !=10
         AND DEPARTMENT_ID !=20
         AND DEPARTMENT_ID !=50
         AND DEPARTMENT_ID !=80
        ORDER BY 3;

  (3) BETWEEN ������       
   . ������ �����Ͽ� �������� �ڷḦ ���� �� ���
   (�������)
   expr BETWEEN ��1 AND ��2
    -'expr'�� ���� '��1'���� '��2' ���̿� �����ϴ� ���̸� ���� ��ȯ
    -'AND' �����ڷ� ġȯ ����
    
��뿹)ȸ�����̺��� 74-75�� ������ ȸ������ �ֹε�� ���� ������ ���� �����Ͻÿ�
      �ֹι�ȣ ���ڸ� 74=>00 (MEM_REGNO1)
                    75=>01
      �ֹι�ȣ ���ڸ� ù���� '1'=>'3' (MEM_REGNO2)
                          '2'=>'4'�� ����
                          
      UPDATE MEMBER
         SET MEM_REGNO1='00'||TRIM(SUBSTR(MEM_REGNO1,3)),
             MEM_REGNO2='3'||TRIM(SUBSTR(MEM_REGNO2,2))
       WHERE SUBSTR(MEM_REGNO1,1,2)='74' 
         AND SUBSTR(MEM_REGNO2,1,1)='1'; --74��� ������ ã�Ƽ� �ֹε�� ���ڸ��� 00���� ���ڸ��� 3���� 
                
      UPDATE MEMBER
         SET MEM_REGNO1='00'||TRIM(SUBSTR(MEM_REGNO1,3)),
             MEM_REGNO2='4'||TRIM(SUBSTR(MEM_REGNO2,2))
       WHERE SUBSTR(MEM_REGNO1,1,2)='74' 
         AND SUBSTR(MEM_REGNO2,1,1)='2'; --74��� ������ ã�Ƽ� �ֹε�� ���ڸ��� 00���� ���ڸ��� 3����
                 
      UPDATE MEMBER
         SET MEM_REGNO1='01'||TRIM(SUBSTR(MEM_REGNO1,3)),
             MEM_REGNO2='3'||TRIM(SUBSTR(MEM_REGNO2,2))
       WHERE SUBSTR(MEM_REGNO1,1,2)='75' 
         AND SUBSTR(MEM_REGNO2,1,1)='1'; --75����� 01��
         
     UPDATE MEMBER
         SET MEM_REGNO1='01'||TRIM(SUBSTR(MEM_REGNO1,3)),
             MEM_REGNO2='4'||TRIM(SUBSTR(MEM_REGNO2,2))
       WHERE SUBSTR(MEM_REGNO1,1,2)='75' 
         AND SUBSTR(MEM_REGNO2,1,1)='2';
             
    COMMIT; --�ϵ��ũ�� ���� 
    
��뿹)ȸ�����̺��� 20-30�� ȸ���� �˻��Ͽ� ����Ͻÿ�.
      Alias�� ȸ����ȣ,ȸ����,�ּ�,����,���ϸ���
      
    SELECT MEM_ID AS ȸ����ȣ,
           MEM_NAME AS ȸ����,
           MEM_REGNO1 AS �ֹι�ȣ,
           EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000) AS ����,
           MEM_ADD1 ||''|| MEM_ADD2 AS �ּ�,
           MEM_JOB AS ����,
           MEM_MILEAGE AS ���ϸ���
      FROM MEMBER
     WHERE EXTRACT(YEAR FROM SYSDATE)-(TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000)
            BETWEEN 20 AND 39
            
��뿹)�������̺�(BUYPROD)���� 2005�� 2�� ���������� ��ȸ�Ͻÿ�
      Alias�� ��¥,��ǰ�ڵ�,����,���Աݾ��̸� ��¥������ ����Ͻÿ�
      
    SELECT BUY_DATE AS ��¥,--���ڿ��� �ƴ϶� ��¥Ÿ���ΰ� Ȯ���غ�
           BUY_PROD AS ��ǰ�ڵ�,
            BUY_QTY AS ����,
   BUY_QTY*BUY_COST AS ���Աݾ� --COST�� �׳� �ܰ����̾�
      FROM BUYPROD
     WHERE BUY_DATE BETWEEN TO_DATE('20050201') AND LAST_DAY('20050201') --LAST_DAY�־��� ���� �� �� ��¥�� �˰� ���ִ� �Լ�/2���� ������ �־ ����ؾ� �Ѵ�/��� TO_DATE�� ���� �� �����̴�. ������ �˾Ƽ� ��¥Ÿ������ �ν��ϱ⵵ ��
           --SUBSTR(BUY_DATE,1,7)='2005/02'
           --BUY_DATE >='20050201' AND BUY_DATE <='20050228'
     ORDER BY 1;
       
             
             
             
             
             
             
             
             
             
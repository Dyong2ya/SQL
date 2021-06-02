2021-0602-01)��������(Subquery)
 - ���� �ȿ� �����ϴ� �Ǵٸ� ����
 - SELECT, INSERT, UPDATE, DELETE, CREATE TABLE, VIEW���� �̿�
 - ��������� ����ϴ� ������ ��������(�Ǵ� OUTER Query)�� �ϰ� ������������ ����
   �����͸� ��ȯ�ϴ� ������ ��������(�Ǵ� Inner Query)�� ��
 - ���������� SELECT��, WHERE ��, FROM ���� �� �� �ְ� FROM ���� ����� ����������
   �ζ���(In-line) �������������
 - �ζ���(In-line) ���������� �ݵ�� ���� ������ �����ؾ� �� --FROM�� ���� ����.
 - ���������� �ݵ�� ( )�ȿ� ���(��, INSERT���� ����) �ؾ���
 - ������ ���� ��������,������ �ִ� ��������, ������/���Ͽ�,������/���߿�,������/���Ͽ�
   ������/���߿� ���������� �з�
   
 1)������ ���� ��������
  - ���������� ���� ���̺�� ���������� ���� ���̺��� �������� ������� ���� ��������

��뿹)������̺��� ��ü ��ձ޿����� �� ���� �޿��� �޴� ������� ��ȸ�Ͻÿ�
  [��������:������� ��ȸ]
      SELECT COUNT(*) AS �����
        FROM HR.EMPLOYEES
       WHERE SALARY >= (��ձ޿�);
       
  [��������:��ձ޿�]
      SELECT AVG(SALARY)
        FROM HR.EMPLOYEES;
        
  [����]      
      SELECT COUNT(*) AS �����
        FROM HR.EMPLOYEES
       WHERE SALARY >= (SELECT AVG(SALARY)
                          FROM HR.EMPLOYEES);

      SELECT COUNT(*) AS �����
        FROM HR.EMPLOYEES A,(SELECT AVG(SALARY) AS ASAL
                               FROM HR.EMPLOYEES) B
       WHERE A.SALARY >= B.ASAL;
       
��뿹)������̺��� �����ڵ�� �����������̺�(JOB_HISTORY)�� �����ڵ尡 ������ ��������� 
      ��ȸ�Ͻÿ�.Alias�� �����ȣ,�����,�����ڵ�
  [��������:������̺��� �����ȣ,�����,�����ڵ� ��ȸ]      
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME||' '||LAST_NAME AS �����,
             JOB_ID AS �����ڵ� 
        FROM HR.EMPLOYEES A
       WHERE (A.EMPLOYEE_ID, A.JOB_ID)=(�����������̺��� ��ȸ) 

  [��������:�����������̺��� �����ȣ,�����ڵ� ��ȸ]
      SELECT B.EMPLOYEE_ID, B.JOB_ID
        FROM HR.JOB_HISTORY B;

  [����]
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME||' '||LAST_NAME AS �����,
             JOB_ID AS �����ڵ� 
        FROM HR.EMPLOYEES A
       WHERE (A.EMPLOYEE_ID, A.JOB_ID)=SOME(SELECT B.EMPLOYEE_ID, B.JOB_ID
                                              FROM HR.JOB_HISTORY B);    --SOME,ANY�� �� ������ �� ��� ���� ���̶� 

 2)������ �ִ� ��������
  - ��κ��� ���������� ���ԵǸ�, ���������� ���� ���̺�� ������������ ����ϴ� ���̺���
    �������� ����Ǵ� ��� �̴�.

��뿹)�����������̺� �����ϴ� �μ��� ��ȸ�Ͻÿ�
      Alias�� �μ��ڵ�,�μ����̴� 
      
  [��������:�μ����̺��� �μ��ڵ�,�μ���,������ ������ ��ȸ]   
      SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
             A.DEPARTMENT_NAME AS �μ���,
             B.FIRST_NAME||' '||B.LAST_NAME  AS �����ڸ�
        FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE A.DEPARTMENT_ID IN (�����������̺� ���� �μ��ڵ�)
         AND A.MANAGER_ID=B.EMPLOYEE_ID
         
  [��������:�����������̺��� �μ��ڵ带 ��ȸ] 
     SELECT DEPARTMENT_ID
       FROM HR.JOB_HISTORY;
  [����]

      SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
             A.DEPARTMENT_NAME AS �μ���,
             B.FIRST_NAME||' '||B.LAST_NAME  AS �����ڸ�
        FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE (A.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                    FROM HR.JOB_HISTORY))
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;    
       
      [EXISTS ������ ���]
      SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
             A.DEPARTMENT_NAME AS �μ���,
             B.FIRST_NAME||' '||B.LAST_NAME  AS �����ڸ�
        FROM HR.DEPARTMENTS A, HR.EMPLOYEES B
       WHERE EXISTS (SELECT 1
                       FROM HR.JOB_HISTORY C
                      WHERE A.DEPARTMENT_ID=C.DEPARTMENT_ID)
         AND A.MANAGER_ID=B.EMPLOYEE_ID
       ORDER BY 1;   
       
  [�Ϲݼ�������:SELECT���� ���������� ����] 
      SELECT DISTINCT A.DEPARTMENT_ID AS �μ��ڵ�,
             (SELECT C.DEPARTMENT_NAME 
                FROM HR.DEPARTMENTS C
               WHERE C.DEPARTMENT_ID=A.DEPARTMENT_ID) AS �μ���,
             (SELECT E.FIRST_NAME||' '||E.LAST_NAME 
                FROM HR.DEPARTMENTS D, HR.EMPLOYEES E
               WHERE A.DEPARTMENT_ID=D.DEPARTMENT_ID
                 AND D.MANAGER_ID=E.EMPLOYEE_ID) AS �����ڸ�
        FROM HR.JOB_HISTORY A
       ORDER BY 1;  
  
��뿹)ȸ�����̺��� ���ϸ����� ���� 5���� 2005�� 5�� ������ ������ ��ȸ�Ͻÿ�.
      Alias�� ȸ����ȣ,ȸ����,���űݾ�
       --ROWNUM�� ORDER BY�� ���� ���� �ȵȴ�. ROWNUM�� WHERE���� ���� ������Ѽ� ORDER BY�� �� �� ����

   [���ϸ����� ���� 5�� ����]
      SELECT A.MEM_ID AS MID,
             A.MEM_NAME AS MNAME
        FROM (SELECT MEM_ID,
                     MEM_NAME
                FROM MEMBER
               ORDER BY MEM_MILEAGE DESC) A
       WHERE ROWNUM<=5 ;

    [2005�� 5�� ȸ���� ������ȸ]
      SELECT CART_MEMBER AS CID,
             SUM(CART_QTY*PROD_PRICE) AS CSUM
        FROM CART, PROD
       WHERE CART_PROD=PROD_ID
         AND CART_NO LIKE '200505%'
       GROUP BY CART_MEMBER;  

    [����]
      SELECT TBLA.MID AS ȸ����ȣ,
             TBLA.MNAME AS ȸ����,
             TBLB.CSUM AS ���űݾ�
        FROM (SELECT A.MEM_ID AS MID,
                     A.MEM_NAME AS MNAME
                FROM (SELECT MEM_ID,
                             MEM_NAME
                        FROM MEMBER
                        ORDER BY MEM_MILEAGE DESC) A
               WHERE ROWNUM<=5) TBLA,
             (SELECT CART_MEMBER AS CID,
                     SUM(CART_QTY*PROD_PRICE) AS CSUM
                FROM CART, PROD
               WHERE CART_PROD=PROD_ID
                 AND CART_NO LIKE '200505%'
               GROUP BY CART_MEMBER) TBLB 
       WHERE TBLA.MID=TBLB.CID
       ORDER BY 1;
  





           
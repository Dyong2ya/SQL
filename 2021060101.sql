2021-0601-01)
 2)SEMI JOIN --������������ ������ �߻��Ǵ��� �˾Ƽ� �ߺ�����������
  - ���������� ���������� ����Ͽ� ���������� ����� �����ϴ� �����͸� ������������ ����ϴ� ���� 
  - ���� EXISTS�� IN �����ڰ� ����
  - ����� �ߺ�����
  
��뿹)����� �޿��� 10000�� �Ѵ� ����� �ִ� �μ��ڵ�� �μ����� ��ȸ�Ͻÿ�  --�÷����̳� ���ľ ������ �ʴ´�/ ��ڿ��� �ٷ� ���������� ���´�. 
      SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
             A.DEPARTMENT_NAME AS �μ���
        FROM HR.DEPARTMENTS A
       WHERE EXISTS (SELECT 1  --*�� �ᵵ �Ǵµ� �׳� ��������� ���� �ֳ������� Ȯ���ϱ� ���� 1�� ǥ���غ���
                       FROM HR.EMPLOYEES B
                      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
                        AND B.SALARY>=10000)
       ORDER BY 1;   
       -- WHERE EXISTS (  )  �� ��ȣ���� ����� �ϳ��� ������ �ȴٸ� �� ���� ����� ���̶�� �������� �ȴ�. �׷��� �÷��� ���� ���ǹ�. '���� ��������'�� �߿�
    
  �׳ɿ���)SELECT 1
      FROM LPROD; --LPOD�� ����ִ� �ุŭ 1�� ��µ�

��뿹)������� ��ձ޿����� �� ���� �޿��� �޴� ������ �ִ� �μ��ڵ�� �μ����� ��ȸ�Ͻÿ�    
      SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
             A.DEPARTMENT_NAME AS �μ���
        FROM HR.DEPARTMENTS A
       WHERE EXISTS (SELECT 1 
                       FROM HR.EMPLOYEES B
                      WHERE A.DEPARTMENT_ID=B.DEPARTMENT_ID
                        AND B.SALARY<(SELECT AVG(SALARY)
                                        FROM HR.EMPLOYEES))  --23,24,23,26(ù��° ������ Ʋ���� �����ε� ���� ����)
       ORDER BY 1;                 
  
  (IN ������ ���)
      SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
             A.DEPARTMENT_NAME AS �μ���
        FROM HR.DEPARTMENTS A
       WHERE A.DEPARTMENT_ID IN (SELECT B.DEPARTMENT_ID 
                                   FROM HR.EMPLOYEES B
                                  WHERE B.SALARY<(SELECT AVG(SALARY)
                                                    FROM HR.EMPLOYEES))
       ORDER BY 1; 
  
  
 3) SELF JOIN
  - �ϳ��� ���̺� �������� ��Ī�� ����Ͽ� ���� �ٸ� ���̺�� �����Ͽ� ���� ����
  
 ��뿹)ȸ�����̺��� ȸ����ȣ 'a001'ȸ������ �� ���� ���ϸ����� ������ ȸ���� ��ȸ�Ͻÿ�
       Alias�� ȸ����ȣ,ȸ����,����,���ϸ����̴�
       SELECT B.MEM_ID AS ȸ����ȣ,
              B.MEM_NAME AS ȸ����,
              B.MEM_JOB AS ����,
              B.MEM_MILEAGE AS ���ϸ���
         FROM MEMBER A, MEMBER B --A�� A001, B�� ��üȸ��
        WHERE A.MEM_ID='a001' 
          AND A.MEM_MILEAGE>B.MEM_MILEAGE; 
          
          
 4) ANTI JOIN
  - ���������� ���Ǵ� ����
  - ���������� ����� ���� �����͸� ���������� ���(�������̺��� �ִ� �����͸� ����)
  - ���տ����� MINUS�� �ش�
  
��뿹)�μ��� ��ġ�� �̱� �̿��� ���� ��ġ�� �μ��� �ٹ��ϴ� ��������� ��ȸ
      Alias�� �����ȣ,�����,�μ���,����,����
      
SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME||' '||LAST_NAME AS �����,
       E.DNAME AS �μ���,
       E.CITY AS ����,
       E.CNAME AS ����
  FROM HR.EMPLOYEES D, (SELECT DEPARTMENT_ID,
                               DEPARTMENT_NAME AS DNAME,
                               CITY,
                               C.COUNTRY_NAME AS CNAME         
                          FROM HR.DEPARTMENTS A, HR.LOCATIONS B, HR.COUNTRIES C
                         WHERE B.COUNTRY_ID!='US'
                           AND A.LOCATION_ID=B.LOCATION_ID
                           AND B.COUNTRY_ID=C.COUNTRY_ID) E
 WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID;
      
��뿹)�μ��� ��ġ�� �̱� �̿��� ���� ��ġ�� �μ��� �ٹ��ϴ� ��������� ��ȸ
      Alias�� �����ȣ,�����,�μ��ڵ�
      
SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME||' '||LAST_NAME AS �����,
       A.DEPARTMENT_ID AS �μ��ڵ�
  FROM HR.EMPLOYEES A
 WHERE A.DEPARTMENT_ID NOT IN(SELECT C.DEPARTMENT_ID 
                                FROM HR.DEPARTMENTS C, HR.LOCATIONS D 
                               WHERE D.COUNTRY_ID='US'
                                 AND C.LOCATION_ID=D.LOCATION_ID)
 ORDER BY 3; 
 

SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME||' '||LAST_NAME AS �����,
       DEPARTMENT_ID AS �μ��ڵ�
  FROM HR.EMPLOYEES 

MINUS
 
SELECT EMPLOYEE_ID AS �����ȣ,
       FIRST_NAME||' '||LAST_NAME AS �����,
       A.DEPARTMENT_ID AS �μ��ڵ�
  FROM HR.EMPLOYEES A
 WHERE A.DEPARTMENT_ID IN(SELECT C.DEPARTMENT_ID 
                            FROM HR.DEPARTMENTS C, HR.LOCATIONS D 
                           WHERE D.COUNTRY_ID='US'
                             AND C.LOCATION_ID=D.LOCATION_ID) 
 ORDER BY 3;                                  
                                 
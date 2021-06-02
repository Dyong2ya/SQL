2021-0518-02)
1. SQL ����� �з�
  1)DDL(Data Definition Language : ������ ���Ǿ�)
    - �����ͱ��� ���� ���� ����
    - create, alter, drop
  2)DCL(Data Control Language : ������ �����)
    - ������� ����
    - commit, rollback, savepoint ��
  3)DML(Data Manipulation Language : ������ ���۾�)
    - ���̺� ���� ������ ���� ���
    - insert, update, delete, merge
  4)SELECT (������ �˻���)  
  
2. SELECT �� 
  - ���̺� ����� �ڷḦ �˻��ϱ� ���� ���
  (�������)
  SELECT [DISTINCT] �÷���1 [[AS] �÷���Ī][,]
                    �÷���2 [[AS] �÷���Ī][,]
                              :
                    �÷���n [[AS] �÷���Ī]
    FROM ���̺�� --FROM WHERE SELECT ������ ó����
    [WHERE ����] --WHERE���� ������ �� �ִ�. WHERE���� �����Ǹ� ���� �� �˻��Ѵ�.
    [GROUP BY �÷���[,�÷���2,...]];
 [HAVING ����] --GROUP BY�� ������ (SUM HALF AVG MIN MAX : �����Լ�)�� �����Ѵ�.
 [ORDER BY �÷���|�÷� INDEX [ASC|IDESC]; --�÷����� �������� �����Ͻʽÿ�, ũ�� ������� ��迭�Ͻʽÿ� ��� ��.
    .�÷���Ī : �÷��� �ο��� �� �ٸ� �̸�, ��¿� �������� ���, SUBQUERY���� �÷��� ���� �����ϱ� ����
    .�÷���Ī �������
     �÷��� AS �÷���Ī
     �÷���  �÷���Ī - 'AS'���� ����
     �÷��� AS "�÷���Ī" -�÷��� Ư�� ����(��������) ���Ǵ� ��� �ݵ�� ""�ȿ� ����ؾ���
     �÷��� "�÷���Ī" - 'AS'���� ����
    .'DISTINCT' : �ߺ��� �����ϰ� ��ȸ
    
��뿹)��ǰ�з����̺� �ִ� ��� �ڷḦ ��ȸ�Ͻÿ�.
     Alias�� ����, �з��ڵ�, �з����̴�
     SELECT * FROM LPROD;

     SELECT LPROD_ID AS ����,
            LPROD_GU AS �з��ڵ�,
            LPROD_NM AS �з���
       FROM LPROD;
       
��뿹)ȸ�����̺��� ��� ȸ���� ȸ����ȣ, ȸ����, �ּ�, ���ϸ����� ��ȸ�Ͻÿ�.
     SELECT MEM_ID AS ȸ����ȣ,
            MEM_NAME AS ȸ����, 
            MEM_ADD1 || ' ' || MEM_ADD2 AS �ּ�,
            MEM_MILEAGE AS ���ϸ���
       FROM MEMBER;
    
��뿹)������̺��� ��� ����� �����ȣ�� �̸�, �Ի���, �޿��� ����Ͻÿ�.
    SELECT HR.EMPLOYEES.EMPLOYEE_ID AS �����ȣ,  
           FIRST_NAME || ' ' || LAST_NAME AS �����,
           EMPLOYEES.HIRE_DATE AS �Ի���,
           SALARY AS �޿�
      FROM HR.EMPLOYEES;
      
��뿹)ȸ�����̺��� ������ �����ϴ� ȸ�������� ��ȸ�Ͻÿ�.
     Alias�� ȸ����ȣ, ȸ����, ����, ����, �����̴�.
     SELECT MEM_ID AS ȸ����ȣ, 
            MEM_NAME AS ȸ����,
            MEM_JOB AS ����, 
            MEM_REGNO1 || '-'||MEM_REGNO2 AS �ֹι�ȣ,
            CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' OR
                      SUBSTR(MEM_REGNO2,1,1)='3' THEN '����ȸ��'
                 ELSE '����ȸ��' END AS ����,
                 EXTRACT(YEAR FROM SYSDATE)-
                 TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900 AS ����
        FROM MEMBER
    WHERE MEM_ADD1 LIKE '����%';
        
        ����
    
    
    
    
    
    
    
    
    
**���̺� ����
DROP TABLE ���̺��;


DROP TABLE TEMPO1;
DROP TABLE TEMPO2;
DROP TABLE TEMPO3;
DROP TABLE TEMPO4;
DROP TABLE TEMPO5;
DROP TABLE TEMPO6;
DROP TABLE TEMPO7;
DROP TABLE TEMPO8;
DROP TABLE TEMPO9;

DROP TABLE SITE_ITEM;--�ڽĵ��� ���� �������� ��
DROP TABLE TBL_WORK;
DROP TABLE EMPLOYEE;
DROP TABLE SITE;

--LGU�� ������ �з��ڵ�
02021-0526-02)�׷��Լ�
 - �����͸� Ư�� �÷����� �������� �׷�ȭ(���� ���� ���� �����͵�� ����)�ϰ� ����ó���� ���Ǵ� �Լ�
 - SUM,AVG,COUNT, MAX, MIN ���� ����
 - SELECT���� �Ϲ� �÷��� �׷��Լ��� ���� ���Ǹ� �ݵ�� 'GROUP BY'���� ����ؾ���
 - �׷��Լ��� ������ �ο��� ��� 'HAVING'���� ó���ؾ���
 (�������)
 SELECT �÷���1[,�÷���2,...][,.]
        �׷��Լ�(��)
   FROM ���̺��
 [WHERE ����]
  GROUP BY �÷���1[,�÷���2,...]
[HAVING ����]
 [ORDER BY �÷���|�÷��ε��� [ASC|DESC][,�÷���|�÷��ε���,...][ASC|DESC]];
   . GROUP BY �÷���1,�÷���2,... : �÷���1�� �׷�ȭ ��Ų �� �� �׷쿡�� �÷���2�� ���� �׷�ȭ
     - SELECT���� �Ϲ� �÷��� �ݵ�� ����Ǿ�� ��. SELECT���� ������� ���� �÷��� ��� ���� 
     
1) SUM(col)
 - 'col'�÷��� �ִ� ���� ���� ��ȯ
 
��뿹) ������̺��� ��� ����� �޿��հ踦 ���Ͻÿ�
    SELECT SUM(SALARY)
      FROM HR.EMPLOYEES; --ȸ�翡�� ��ü������ ���޵Ǿ����� ������ �հ� / GROUP BY�� ��ü����� �������� �ʾ� �׷��� �� ��
      
��뿹) ������̺��� �μ��� �޿��հ踦 ���Ͻÿ� --'~��' �̷��� GROUP���� �����شٰ� �����ϸ� ��. SELECT�� �� ~�÷��� �־��ָ� ��
    SELECT DEPARTMENT_ID AS �μ��ڵ�, 
           SUM(SALARY) AS �޿��հ� --�׷��Լ��� �Ϲ��÷��� ���� ������ �׷���� �� ����ߵ�
      FROM HR.EMPLOYEES
     GROUP BY ROLLUP(DEPARTMENT_ID) --ROLLUP�� ���� �Ǹ� ��ü�հ赵 ������
     ORDER BY 1;
     
��뿹) ȸ�����̺��� ������ ���ϸ����հ踦 ���Ͻÿ�
    SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                     SUBSTR(MEM_REGNO2,1,1)='4' THEN
                     '����ȸ��'
                ELSE
                      '����ȸ��' END AS ����,
                      SUM(MEM_MILEAGE) AS ���ϸ����հ�
       FROM MEMBER
            GROUP BY  CASE WHEN SUBSTR(MEM_REGNO2,1,1)='2' OR
                     SUBSTR(MEM_REGNO2,1,1)='4' THEN
                     '����ȸ��'
                ELSE
                      '����ȸ��' END;
                      
��뿹) ��ٱ��� ���̺��� 2005�� 4~6�� ��ǰ�� ������ȸ 
       Alias�� ��ǰ�ڵ�,��ǰ��,�Ǹż���,�ǸƱݾ�
       SELECT A.CART_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��,
              SUM(A.CART_QTY) AS �Ǹż���,
              SUM(A.CART_QTY*B.PROD_PRICE) AS �ǸƱݾ�
         FROM CART A, PROD B
        WHERE A.CART_NO BETWEEN '20050401' AND '20050630'
          AND A.CART_PROD=B.PROD_ID
        GROUP BY A.CART_PROD,B.PROD_NAME --�� ���� ������ ��ǻ� ������ �Ȱ���. �׷����� �ϳ��� �����ϸ� �ȵ�. SUM�Լ��� �����ϸ� �÷����� 2���ݾ�....?????????
        ORDER BY 1; 
        
����] 2005�� 1~3�� ���̿� �߻��� ����(BUY_PROD)������ �̿��Ͽ� ����, ��ǰ�� ���������� ��ȸ�Ͻÿ�
     SELECT EXTRACT(MONTH FROM BUY_DATE)||'��' AS ��,
            BUY_PROD AS ��ǰ�ڵ�, --���� ��ǰ���̸� �ٸ� ���̺� �ʿ���
            SUM(BUY_QTY) AS ���Լ���, --�׾Ƴ��� �Ǵ� �ֵ� �� ������ �˾ƾ���
            SUM(BUY_QTY*BUY_COST) AS ���Աݾ� --�� �� ����� �˾ƾ���
       FROM BUYPROD
      WHERE EXTRACT(MONTH FROM BUY_DATE) IN(1,2,3)
      GROUP BY EXTRACT(MONTH FROM BUY_DATE),BUY_PROD --����Ʈ������ �����Լ��� ������ ��� �͵�
      ORDER BY 1,2;
    
����] 2005�� 5�� ���������� Ȱ���Ͽ� �з��ڵ庰 ����ݾ� �հ踦 ��ȸ�Ͻÿ�
    SELECT B.LPROD_GU AS �з��ڵ�,
           B.LPROD_NM AS �з���,
           SUM(A.CART_QTY*C.PROD_PRICE) AS "����ݾ� �հ�"
      FROM CART A,LPROD B,PROD C --PROD�� �տ� �� �� ����
     WHERE A.CART_PROD=C.PROD_ID
       AND C.PROD_LGU=B.LPROD_GU
       AND A.CART_NO LIKE '200505%'
     GROUP BY B.LPROD_GU, B.LPROD_NM
     ORDER BY 1;
     
����] ȸ�����̺��� �̿��Ͽ� �������� ȸ������ ���ϸ����հ踦 ���Ͻÿ�
    SELECT SUBSTR(MEM_ADD1,1,2) AS ������, 
           SUM(MEM_MILEAGE) AS ���ϸ���
      FROM MEMBER
     GROUP BY SUBSTR(MEM_ADD1,1,2)
     ORDER BY 2 DESC; --���ϸ��� ������������ 
     
 2) AVG(col)
  - 'col'�÷��� �ִ� ���� ��հ��� ��ȯ
  
��뿹) ������̺��� �� �μ��� ����ӱ��� ���Ͻÿ�
    SELECT DEPARTMENT_ID AS �μ�,
           ROUND(AVG(SALARY)) AS ����ӱ�
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID--AVG�� �Ϲ��÷��� ���ÿ� ���ż� �� ����߉�
     ORDER BY 1;
     
     SELECT ROUND(AVG(SALARY)) AS ����ӱ�
       FROM HR.EMPLOYEES; --��ü �������� ��� �ӱ�
       
��뿹) ��ٱ������̺��� 2005�⵵ ȸ���� ���� ��� ���űݾ��� ��ȸ�Ͻÿ�
    SELECT CASE WHEN SUBSTR(B.MEM_REGNO2,1,1)='2' OR
           SUBSTR(B.MEM_REGNO2,1,1)='4' THEN --CASE WHEN THEN�� IF���̾�
           '����ȸ��' 
      ELSE '����ȸ��' END AS ����, 
    ROUND(AVG(A.CART_QTY*C.PROD_PRICE),-1) AS ��ձ��űݾ�
       FROM CART A, MEMBER B, PROD C--CART���ſ� ���� ������ ����־�/�ܰ��� ���ϱ� ���� PROD�� ����ϴ°ž�
      WHERE SUBSTR(A.CART_NO,1,4)='2005' --���� ��¥���ǵ� �������¡
        AND A.CART_MEMBER=B.MEM_ID
        AND A.CART_PROD=C.PROD_ID
      GROUP BY CASE WHEN SUBSTR(B.MEM_REGNO2,1,1)='2' OR
           SUBSTR(B.MEM_REGNO2,1,1)='4' THEN --CASE WHEN THEN�� IF���̾�
           '����ȸ��' 
      ELSE '����ȸ��' END;
      
��뿹) ��ٱ������̺��� 2005�⵵ ȸ���� ���ɴ뺰 ��� ���űݾ��� ��ȸ�Ͻÿ�
     SELECT TRUNC((EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM B.MEM_BIR))/10)*10||'��' AS ����,
   ROUND(AVG(A.CART_QTY*C.PROD_PRICE),-1) AS ��ձ��űݾ� --��ǰ�ڵ����̺��� ����ܰ�PRICE�� ���ϴ°ž�
       FROM CART A, MEMBER B, PROD C
      WHERE SUBSTR(A.CART_NO,1,4)='2005' 
        AND A.CART_MEMBER=B.MEM_ID
        AND A.CART_PROD=C.PROD_ID
      GROUP BY TRUNC((EXTRACT(YEAR FROM SYSDATE)-
               EXTRACT(YEAR FROM B.MEM_BIR))/10)*10
      ORDER BY 1;
        
 3)COUNT(col|*) 
  - �׷쿡 ���� �ڷ��� ��(���� ��)
  - �ܺ� ���ο����� *�� ����ؼ��� �ȵ�
  --�ǸŰǼ��� COUNT�ε� �Ǹűݾ��� SUM�� ����ؾ� �Ѵ�
  
��뿹) ������̺��� �μ��� �ο����� ��ȸ�Ͻÿ� --�μ��� ������ �ο��� ���;���
    SELECT DEPARTMENT_ID AS �μ��ڵ�, 
           COUNT(*) AS �ο���1,
           COUNT(EMPLOYEE_ID) AS �ο���2
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;

��뿹) ������̺��� �μ��� �ο����� ��ȸ�ϵ� �ο����� 5�� �̻��� �μ��� ��ȸ�Ͻÿ�
    SELECT DEPARTMENT_ID AS �μ��ڵ�, 
           COUNT(*) AS �ο���
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) >= 5 --�׷��Լ��� ���Ե� �Լ��� �׷���� �ڿ� �� �׸��� HAVING���� �޾ƾߵ�
     ORDER BY 1;
     
��뿹) 2005�� 1~3��(�Ⱓ,�ð� ���� WHERE) ��ǰ�� ���԰Ǽ��� ��ȸ(��ǰ�ڵ�, �Ǽ�)�ϰ� ���Աݾ��հ�(�ش�Ǿ����� ���Լ���x�ܰ�)�� 500���� ����(<-����)�� ��ǰ�� ��ȸ�Ͻÿ�
    SELECT BUY_PROD AS ��ǰ�ڵ�,
           COUNT(*) AS ���԰Ǽ�,
           SUM(BUY_QTY*BUY_COST)
      FROM BUYPROD
     WHERE EXTRACT(MONTH FROM BUY_DATE) IN (1,2,3)--����
     GROUP BY BUY_PROD
     HAVING SUM(BUY_QTY*BUY_COST) <= 5000000
     ORDER BY 1;
     
��뿹) 2005�� 4~7�� ��ǰ�� ����Ǽ��� ��ȸ�ϰ� ����ݾ��հ谡 1000���� �̻��� ��ǰ�� ��ȸ�Ͻÿ�
   SELECT A.CART_PROD AS ��ǰ�ڵ�,
           COUNT(*) AS ����Ǽ�, --GROUP BY�� ���ؼ� ���� ���� ���ǵ� ��� �÷����� �������� �ؼ� ���� ��� �������
           SUM(A.CART_QTY*B.PROD_PRICE) AS ����ݾ��հ� --īƮ�� ���� * ��ǰ����
      FROM CART A, PROD B
      WHERE A.CART_PROD=B.PROD_ID 
        AND SUBSTR(A.CART_NO,1,6) BETWEEN '200504' AND '200507'
     GROUP BY A.CART_PROD
    HAVING SUM(A.CART_QTY*B.PROD_PRICE) >= 10000000 
     ORDER BY 1;
    
     
     
     
     (���� § ��)
     SELECT A.CART_PROD AS ��ǰ�ڵ�,
           COUNT(*) AS ����Ǽ�, 
           SUM(A.CART_QTY*B.PROD_PRICE) AS ����ݾ��հ�
      FROM CART A, PROD B
     WHERE A.CART_NO BETWEEN '20050401' AND '20050731'
       --TRUNC(MONTH FROM CART_NO,5,2)='04'
       --AND TRUNC(MONTH FROM CART_NO,5,2)='07'
       AND A.CART_PROD=B.PROD_ID 
     GROUP BY A.CART_PROD
    HAVING SUM(A.CART_QTY*B.PROD_PRICE) >= 10000000 
     ORDER BY 1;

 4) MAX(col), MIN(col)
  - MAX(col) : 'col' �÷��� �� �� ���� ū ���� ��ȯ
  - MIN(col) : 'col' �÷��� �� �� ���� ���� ���� ��ȯ
  
��뿹) ������̺��� �޿��� ���� ���� �޴� ����� ���� ���� �޴� ����� ��ȸ�Ͻÿ�
  
   (�ְ�޿��� �����޿�)
    SELECT MAX(SALARY),MIN(SALARY)
      FROM HR.EMPLOYEES;
      
   (�μ��� �ְ�޿��� �����޿�)
    SELECT DEPARTMENT_ID,
           MAX(SALARY),
           MIN(SALARY)
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;

   (�μ��� �ְ�޿��� �޴� ����� ������ �����ȣ�� ���)
    SELECT EMPLOYEE_ID AS �����ȣ,
           FIRST_NAME||' '||LAST_NAME AS �����,
           DEPARTMENT_ID AS �μ��ڵ�,
           MAX(SALARY)
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID,EMPLOYEE_ID,FIRST_NAME||' '||LAST_NAME--12���� �μ����� �׷��� ���� �����ȣ�� ���� ����鳢�� �׷����� ����.(���ϽõǴ°� �����ϱ� ������� ���� �� �׷��� ���ݾ�) �׷��� ���������ž� �ؿ��� ��
     ORDER BY 1;
      
      
      SELECT B.DID AS �μ��ڵ�,
             A.EMPLOYEE_ID AS �����ȣ,
             A.FIRST_NAME||' '||LAST_NAME AS �����,
             B.MSAL AS �ִ�޿�
        FROM HR.EMPLOYEES A,(SELECT DEPARTMENT_ID AS DID, --�÷������� ����� ���ִ� ���� ����
                                    MAX(SALARY) AS MSAL --B.DID/ B.MSAL
                               FROM HR.EMPLOYEES
                              GROUP BY DEPARTMENT_ID) B --���� �׷���̿��� �� �μ��� �ִ�޿� ()�� ��� Ȯ���غ� //(�ȿ� ����Ʈ�� �������� ����� �����)
       WHERE A.SALARY=B.MSAL
         AND A.DEPARTMENT_ID=B.DID
       ORDER BY 1;
       
    SELECT EMPLOYEE_ID, SALARY
      FROM HR.EMPLOYEES
     WHERE DEPARTMENT_ID=50
     ORDER BY 2 DESC;
     
     UPDATE HR.EMPLOYEES
        SET SALARY=8200
      WHERE EMPLOYEE_ID=120;
      
      COMMIT;
      
��뿹) ȸ�����̺��� ���ϸ����� ���� ���� 5���� ������ ����Ͻÿ�
        Alias�� ȸ����,���ϸ���
        SELECT FIRST_NAME||' '||LAST_NAME AS ȸ����
     **�ǻ��÷�(PSUEDO COLUMN)
      - ROWNUM : ���̺�(��)�� �� �࿡ �ο��� ���� �� 
SELECT A.MID AS ȸ����ȣ,
       A.MNAME AS ȸ����,
       A.MILE AS ���ϸ���
  FROM (SELECT MEM_ID AS MID,
               MEM_NAME AS MNAME,
               MEM_MILEAGE AS MILE
          FROM MEMBER 
         ORDER BY 3 DESC) A
    WHERE ROWNUM<=5;

 5) RANK, DENSE_RANK �Լ�
  - �ڷ��� ������ �����ϴ� �Լ�
  - RANK : ������ ���� �ߺ� ������ �ο�, ���� ������ �ߺ� ����������ŭ �ǳʶٰ� �ο�
  - DENSE_RANK : ������ ���� �ߺ� ������ �ο�, ���� ������ �ߺ� ������ ������� ���ʴ�� �ο�
  
 (1)RANK() OVER(ORDER BY �����÷��� DESC) AS �÷���Ī
��뿹) ȸ�����̺��� ���ϸ����� ���� ���� 5���� ������ ����Ͻÿ�
        Alias�� ȸ����,���ϸ���
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_MILEAGE AS ���ϸ���,
               RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS ���
          FROM MEMBER;
            
 (2)DENSE_RANK() OVER(ORDER BY �����÷��� DESC) AS �÷���Ī
��뿹) ȸ�����̺��� ���ϸ����� ���� ���� 5���� ������ ����Ͻÿ�
        Alias�� ȸ����,���ϸ���
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_MILEAGE AS ���ϸ���,
               DENSE_RANK() OVER(ORDER BY MEM_MILEAGE DESC) AS ���
          FROM MEMBER;

 (3)ROW_NUMBER �Լ�
  - �ߺ��� ������� �������� ������ �ο�
  - ������ ���� ���� ������ �߻��� ������ ���� ���� �ο�
  - �������
  ROW_NUMBER() OVER(ORDER BY �����÷��� DESC) AS �÷���Ī
        SELECT MEM_ID AS ȸ����ȣ,
               MEM_NAME AS ȸ����,
               MEM_MILEAGE AS ���ϸ���,
               ROW_NUMBER() OVER(ORDER BY MEM_MILEAGE DESC,
                                          MEM_BIR ASC) AS ��� --���� ���� ���ǵ��� ����� �� �ִ�
          FROM MEMBER;
     
     
        
   
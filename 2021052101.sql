2021-05-21)�Լ� �� ������
 4) LIKE ������ --�Ϻθ� ������ ��ü�� ���� ������ �� �� ���(���Ϻ� ex)�弳�� ���ԵǴ� ���� ���� / ���Ϻ�'���ڿ�', ����,��¥���� ���x
  -�÷��� ���� ������ ���ϰ� ���� �� ���Ǵ� ������
  -���Ϻ� ���ڿ��� '%'�� '_'�� ����
  -WHERE���� ������ ������ �̿��
  
  [���ϵ�ī��] --���ڿ��̴ϱ� ''�� ��� ǥ������ߵ� 
  '%' : ���� ��ġ���� ���� ���ڿ� ����
   ex)'����%' : �������� �����ϴ� ��� ����� ����
      '%��' : �� ���ڰ� ������ ������ ��� ����� ����
      '%��%' : �ܾ� �߰��� �ǰ� �ִ� ��� ����� ����
  '_' : ���� ��ġ���� �ϳ��� ���ڿ� ����
   ex)'����_' : 3���ڷ� �����Ǹ� �������� �����ϴ� �ܾ�� ����
      '_��' : 2���ڷ� �����Ǹ� �� ���ڰ� ������ ������ ��� �ܾ�� ����
      '_��_' : �ܾ� �߰��� �ǰ� �ְ� 3���ڷ� ������ ��� �ܾ�� ����
 
 ��뿹)��ٱ������̺�(CART)���� 2005�� 6�� �Ǹŵ� �ڷḦ ���ں��� ��ȸ�Ͻÿ� --BETWEEN�����ڸ� ���� �ͺ��� �ξ� ��������
       Alias�� ��¥,��ǰ�ڵ�,����
       SELECT TO_DATE(SUBSTR(CART_NO,1,8)) AS ��¥,
              CART_PROD AS ��ǰ�ڵ�,
              CART_QTY AS ����
         FROM CART
        WHERE CART_NO LIKE '200506%' --����ǥ �ȿ� �־ ���ڰ� �ƴ϶� ���ڿ��� ���еȴ�
        ORDER BY 1;
 
��뿹)ȸ�����̺�(MEMBER)���� �������� '�泲'�� ȸ�������� ��ȸ�Ͻÿ� --��ȸ�� SELECT��
      Alias�� ȸ����ȣ,ȸ����,�ڵ�����ȣ,����,���ϸ����̴�.
      SELECT MEM_ID AS ȸ����ȣ, 
             MEM_NAME AS ȸ����,
             MEM_HP AS �ڵ�����ȣ,
             MEM_JOB AS ����,
             MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
       WHERE MEM_ADD1 LIKE '�泲%';
       
       
       
2. �Լ�
 -DBMS ������ ������ �̸� ����� ������ �س��� ��� ������ ��������
 -���ڿ�,����,��¥,��ȯ,�����Լ��� �з�
 
1)���ڿ� �Լ�
 (1) || (���ڿ� ���տ�����)
   .JAVA�� ���ڿ��� ���Ǵ� '+'�����ڿ� ����
   .�� ���ڿ��� �����Ͽ� ���ο� ���ڿ��� ��ȯ
   (�������)
   ���ڿ� || ���ڿ� 

��뿹)ȸ�����̺��� ����ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ,�̸�,�ֹι�ȣ,���ϸ����̴�. ��, �ֹι�ȣ�� XXXXXX-XXXXXXX�������� ����Ͻÿ�
      SELECT MEM_ID AS ȸ����ȣ, 
             MEM_NAME AS �̸�,
             MEM_REGNO1||'-'||MEM_REGNO2 AS �ֹι�ȣ,
             MEM_MILEAGE AS ���ϸ���
        FROM MEMBER
       WHERE SUBSTR(MEM_REGNO2,1,1)='2'
          OR SUBSTR(MEM_REGNO2,1,1)='4'; --WHERE���� ����ȸ���� ��������
          
��뿹)������̺�(HR.EMPLOYEES)���� �޿��� 10000�̻��̰� ���������ڵ�(COMMISSION_PCT)�� NULL�� �ƴ� ��������� ��ȸ�Ͻÿ�
      Alias�� �����ȣ,�����,�����ڵ�(JOB_ID),�μ��ڵ�,���������ڵ�,�޿��̸� �̸��� ���� �̸��� �ٿ� ����Ͻÿ�
      SELECT EMPLOYEE_ID AS �����ȣ,
             FIRST_NAME||' '||LAST_NAME AS �����,
             JOB_ID AS �����ڵ�,
             DEPARTMENT_ID AS �μ��ڵ�,
             COMMISSION_PCT AS ���������ڵ�,
             SALARY AS �޿�
        FROM HR.EMPLOYEES
       WHERE SALARY >= 10000
         AND COMMISSION_PCT IS NOT NULL; --(!=�̷��� ���� �ȵȴ�)
         
 (2) CONCAT(c1,c2) --ĳ���͹��ڿ��� �����͸� �޴� �Ű����� / �� �� ����
   .�� ���ڿ� c1�� c2�� �����Ͽ� ���ο� ���ڿ��� ��ȯ

��뿹)ȸ�����̺��� ����ȸ�������� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ,�̸�,�ֹι�ȣ,���ϸ����̴�. ��, �ֹι�ȣ�� XXXXXX-XXXXXXX�������� ����Ͻÿ�
      SELECT MEM_ID AS ȸ����ȣ, 
             MEM_NAME AS �̸�,
             CONCAT(CONCAT(MEM_REGNO1,'-'),MEM_REGNO2) AS �ֹι�ȣ, --��ȣ ���� CONCAT�� ���� �۵�
             MEM_MILEAGE AS ���ϸ���
            FROM MEMBER
           WHERE SUBSTR(MEM_REGNO2,1,1)='2'
              OR SUBSTR(MEM_REGNO2,1,1)='4';
              
 (3) CHR(n), ASCII(c)
   .CHR(n) : 'n'�� �ش��ϴ� ����(�� ����)��ȯ --n�� ������
   .ASCII(c) : �־��� ���ڿ� 'c'�� ù ���ڸ� �ƽ�Ű �ڵ尪���� ��ȯ
      
   SELECT CHR(23),ASCII('KOREA'),ASCII('K') FROM DUAL; --�ش�Ǵ� ���̺��� ������ SELECT���� ������ FROM���̺��� �ʿ���. �׷��� �������̺��� DUAL;�� ���        
   SELECT CHR(125),ASCII('������'),ASCII('A') FROM DUAL;
   
   SELECT MEM_NAME
     FROM MEMBER
 ORDER BY MEM_NAME; --WHERE������ �� �� ����϶�� �Ҹ���
 
    DECLARE
    V_CHAR VARCHAR2(100);
    BEGIN 
      FOR I IN 1..256 LOOP
        V_CHAR:=CHR(I);
        DBMS_OUTPUT.PUT_LINE(I||'='||V_CHAR);
      END LOOP;
     END;  
     
 (4) LOWER(c), UPPER(C), INITCAP(c)
   .LOWER(c) : �־��� ���ڿ� 'c'�� ����� ��� ���ڿ��� �ҹ��ڷ� ��ȯ
   .UPPER(C) : �־��� ���ڿ� 'c'�� ����� ��� ���ڿ��� �빮�ڷ� ��ȯ
   .INITCAP(c) : �־��� ���ڿ� 'c'�� ����� ��� ���ڿ� �� �ܾ��� ù ���ڸ� �빮�ڷ� ��ȯ
   
��뿹)ȸ�����̺��� 'S001'ȸ�������� ��ȸ�Ͻÿ�
    SELECT *
      FROM MEMBER
    --WHERE MEM_ID='S001'; --�̷��� �ϸ� MEMBER���̺� �ִ� �ݷ����� �ߴµ� ������ �� ��. �׷��ٰ� ������ ��� �׷���? �ƴ� ��ҹ��ڶ��� ������ �� ���°���
    WHERE UPPER(MEM_ID)='S001';
    
    SELECT *
      FROM HR.EMPLOYEES
    WHERE LAST_NAME=INITCAP('KING');
    
    SELECT INITCAP(LOWER(FIRST_NAME)||' '||LOWER(LAST_NAME))
      FROM HR.EMPLOYEES;
      
 (5) LPAD(c1,n[,c2]), RPAD(c1,n[,c2])
   . LPAD(c1,n[,c2]) : ���ǵ� ������ n ��ŭ�� ���̿� c1�� ä��� ���� ������ ���ʿ� c2�� ä��, c2�� �����Ǹ� ������ ä����
   . RPAD(c1,n[,c2]) : ���ǵ� ������ n ��ŭ�� ���̿� c1�� ä��� ���� ������ �����ʿ� c2�� ä��, c2�� �����Ǹ� ������ ä����
        
��뿹)
        SELECT LPAD('Oracle',10,'*') from dual;
        SELECT LPAD(PROD_NAME,20) AS ��ǰ��, --�̸��� 20ĭ�� ���µ� ���� ����
               LPAD(PROD_PRICE,15,'*') AS ����
          FROM PROD
        WHERE PROD_LGU=UPPER('P301');
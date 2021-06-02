2021-0601-02)�ܺ�����(OUTER JOIN)
 - ���������� ���������� ��ġ�ϴ� �����͸� ����
 - �ܺ������� �������ǿ� ��ġ���� ���� �����͵� ����
 - ���� ������̺� �� �����Ͱ� ���� ���̺� �������ǿ� �ܺ����� ������('(+)')�� ����
 - �ܺ����� ������ �������� ��� ��� '(+)'�� ����
 - �� ���� �ϳ��� ���̺� �ܺ������� �� �� �ִ�. ���� ��� A,B,C���̺��� ���� ���꿡 �����ϰ�
   A�� �������� B�� ȭ��ǰ�, ���ÿ� C�� �������� B�� Ȯ��� �� ����
   (WHERE A.�÷���=B.�÷���(+)
      AND C.�÷���=B.�÷���(+)  --���ȵ�)
 - '(+)'�����ڰ� ���� ���ǿ� OR�����ڳ� IN�����ڸ� ���� ����� �� ����
 - �Ϲ������� ���ÿ� ����Ǵ� �ܺ������� ANSI�� ���������� �ۼ��ؾ� ��Ȯ�� ����� ���� �� ���� 
 (�������-�Ϲ� �ܺ�����)
 SELECT �÷�list
   FROM ���̺��1,���̺��2[,���̺��3,...]
  WHERE ���̺��1.�÷���(+)=���̺��2.�÷���
                      :
                      
(�������-ANSI �ܺ�����)
 SELECT �÷�list
   FROM ���̺��1 
 RIGHT|LEFT|FULL OUTER JOIN ���̺��2 ON(��������[ AND �Ϲ�����])
                    :
 [WHERE �Ϲ�����]
   .'RIGHT|LEFT|FULL' : ���̺��1�� ���� �ڷḦ ������ ������ LEFT, ���� �ڷḦ ������ ������ RIGHT
                        ���� ��� �����ڷḦ ����� ������ FULL��
   . SELECT ���� '�÷���'�� ���� �ڷḦ ������ �ִ� ���̺��� �÷����� ���
   . COUNT(*|�÷���)�Լ��� �Ű������� �ݵ�� '�÷���'�� ��� 
   
��뿹)��ǰ���̺�� �з����̺��� ����Ͽ� ��� �з��� ��ǰ�� �������� ��ȸ�Ͻÿ� --PROD_LGU�з��ڵ� //OUTER JOIN�� "���,����"�̷� �λ簡 �ٴ´� /~���� GROUP BY��// �������� COUNT
      SELECT A.LPROD_GU AS �з��ڵ�,
             A.LPROD_NM AS �з���,
             COUNT(B.PROD_PRICE)
        FROM LPROD A, PROD B --���� ���� �������ٰ� �ƴ϶� ������ ���� ����
       WHERE A.LPROD_GU=B.PROD_LGU(+)
       GROUP BY A.LPROD_GU,A.LPROD_NM
       ORDER BY 1; 
  (ANSI FORMAT)
      SELECT A.LPROD_GU AS �з��ڵ�,
             A.LPROD_NM AS �з���,
             COUNT(B.PROD_PRICE) AS "��ǰ�� ��"
        FROM LPROD A
        LEFT OUTER JOIN PROD B ON(A.LPROD_GU=B.PROD_LGU)
       GROUP BY A.LPROD_GU,A.LPROD_NM
       ORDER BY 1;         
      
       
��뿹)��ٱ��� ���̺��� 2005�⵵ 6�� ��� ȸ���� �Ǹ���Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ȸ����ȣ,ȸ����,�Ǹż���,�Ǹűݾ�
      
      SELECT B.MEM_ID AS ȸ����ȣ,
             B.MEM_NAME AS ȸ����,
             SUM(A.CART_QTY) AS �Ǹż���,
             SUM(A.CART_QTY*C.PROD_PRICE) AS �Ǹűݾ�
        FROM CART A, MEMBER B, PROD C
       WHERE A.CART_MEMBER(+)=B.MEM_ID 
         AND A.CART_PROD=C.PROD_ID
         AND A.CART_NO LIKE '200506%' --��¥,�Ⱓ�� ������ �Ϲ�����
       GROUP BY B.MEM_ID,B.MEM_NAME
       ORDER BY 1;
--��ü �� �� ����

  (ANSI FORMAT)
      SELECT B.MEM_ID AS ȸ����ȣ,
             B.MEM_NAME AS ȸ����,
             NVL(SUM(A.CART_QTY),0) AS �Ǹż���,
             NVL(SUM(A.CART_QTY*C.PROD_PRICE),0) AS �Ǹűݾ�
        FROM CART A
       RIGHT OUTER JOIN MEMBER B ON(A.CART_MEMBER=B.MEM_ID AND A.CART_NO LIKE '200506%') --������ ��� ȸ����ȸ ���������� ���� �޶�
        LEFT OUTER JOIN PROD C ON(A.CART_PROD=C.PROD_ID)        
       GROUP BY B.MEM_ID,B.MEM_NAME
       ORDER BY 1;

  (SUBQUERY ���)
      SELECT B.MEM_ID AS ȸ����ȣ,
             B.MEM_NAME AS ȸ����,
             NVL(D.SCNT,0) AS �Ǹż���,
             NVL(D.SSUM,0) AS �Ǹűݾ�
        FROM MEMBER B, (SELECT CART_MEMBER, 
                               SUM(A.CART_QTY) AS SCNT,
                               SUM(A.CART_QTY*C.PROD_PRICE) AS SSUM
                          FROM CART A, PROD C
                         WHERE A.CART_NO LIKE '200506%'
                           AND A.CART_PROD=C.PROD_ID
                         GROUP BY CART_MEMBER) D  
       WHERE B.MEM_ID=D.CART_MEMBER(+)
       ORDER BY 1;

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
��뿹) 2005�� 1~6�� ��ü ��ǰ�� ����/������Ȳ�� ��ȸ�Ͻÿ� --��ü �ƿ���/ ~�� �׷����/��¥ �Ϲ�����
    (������Ȳ)
     SELECT A.PROD_ID AS ��ǰ�ڵ�,--A�� ���� ������ǰ��,
            A.PROD_NAME AS ��ǰ��, --A�ۿ� ����
            NVL(SUM(A.PROD_COST*B.BUY_QTY),0) AS ���Աݾ��հ�
       FROM PROD A
       LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.BUY_PROD 
        AND (B.BUY_DATE BETWEEN '20050101' AND '20050531'))
      WHERE A.PROD_ID=B.BUY_PROD(+)
      GROUP BY A.PROD_ID, A.PROD_NAME 
      ORDER BY 1;

    (������Ȳ)
     SELECT A.PROD_ID AS ��ǰ�ڵ�,--A�� ���� ������ǰ��,
            A.PROD_NAME AS ��ǰ��, --A�ۿ� ����
            NVL(SUM(A.PROD_PRICE*B.CART_QTY),0) AS ����ݾ��հ�
       FROM PROD A
       LEFT OUTER JOIN CART B ON(A.PROD_ID=B.CART_PROD
        AND B.CART_NO LIKE '200505%')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
      
    (����)--���� �������� �޶� WHERE�� ����ϰ� �Ǹ� �ȵ�. WHERE�� ��ü�� ��Ʋ� ����Ǿ����� ��쿡�� ����� �� �ִ�.�ƴϸ� ON������ ����ؾ� �ȴ�
     SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��, 
            NVL(SUM(A.PROD_COST*B.BUY_QTY),0) AS ���Աݾ��հ�,
            NVL(SUM(A.PROD_PRICE*B.CART_QTY),0) AS ����ݾ��հ�
       FROM PROD A
       LEFT OUTER JOIN BUYPROD B ON(A.PROD_ID=B.BUY_PROD 
        AND (B.BUY_DATE BETWEEN '20050101' AND '20050531'))
       LEFT OUTER JOIN CART B ON(A.PROD_ID=B.CART_PROD
        AND B.CART_NO LIKE '200505%')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
      
��뿹) ������̺�� �μ����̺��� ��� �μ��� �ο����� ��ձ޿��� ��ȸ�Ͻÿ�
       Alias�� �μ��ڵ�,�μ���,�ο���,��ձ޿��̴�
--       SELECT NVL(TO_CHAR(B.DEPARTMENT_ID),'CEO') AS �μ��ڵ�,
--              B.DEPARTMENT_ID AS �μ��ڵ�,--B�� �� �����ϱ�
--              NVL(B.DEPARTMENT_NAME,'CEO') AS �μ���,
--              NVL(COUNT(A.SALARY)),0) AS �ο���,
--              NVL(ROUND(AVG(A.SALARY),1),0) AS ��ձ޿�
--         FROM HR.EMPLOYEES A
--         FULL OUTER JOIN HR.DEPARTMENTS B ON(B.DEPARTMENT_ID=A.DEPARTMENT_ID)
--        GROUP BY B.DEPARTMENT_ID,B.DEPARTMENT_NAME
--        ORDER BY 1;
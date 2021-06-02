2021-0528-01)
 6) ROLLUP(�÷���1[,�÷���2,�÷���3,...�÷���n]))
  - GROUP BY�� �ȿ� ���
  - ����� �÷������ �������� ������ ��������
  - ������ ����->�������� ����
    ex) GROUP BY ROLLUP(C1,C2,C3)
     => (C1,C2,C3)�� �������� �� ����,
        (C1,C2)�� �������� �� ����,
        (C1)�� �������� �� ����,
        ��ü����
  - ���� �÷��� n���̸� n+1������ ���� ����
  
��뿹) 2005�� 5�� ���ں�,�з���,��ǰ�� �������踦 ROLLUP�� �̿��Ͽ� ��ȸ�Ͻÿ� --�з����� 3���� �з��ڵ庰, ��ǰ�ڵ庰, ��¥ --��׷� �з��϶�� �����ϱ� ���̺� �� �� �ϰ� ��������� �� �ݷ� 2�� �ǳ� ���°�QTY������ ��
       Alias�� ��¥,�з���,��ǰ��,��������հ�,����ݾ��հ��̴�.
       (ROLLUP ������)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS ��¥,--�ǸŵǾ��� ��¥�� �װ� CART���̺� �� 8�ڸ����� �־�
              B.LPROD_NM AS �з���,--LPROD ���̺� ����
              C.PROD_NAME AS ��ǰ��,--PROD ���̺� ����
              SUM(A.CART_QTY)��������հ�,
              SUM(A.CART_QTY*C.PROD_PRICE) AS ����ݾ��հ�
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME
        ORDER BY 1;
        
       (ROLLUP ����)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS ��¥,--�ǸŵǾ��� ��¥�� �װ� CART���̺� �� 8�ڸ����� �־�
              B.LPROD_NM AS �з���,--LPROD ���̺� ����
              C.PROD_NAME AS ��ǰ��,--PROD ���̺� ����
              SUM(A.CART_QTY)��������հ�,
              SUM(A.CART_QTY*C.PROD_PRICE) AS ����ݾ��հ�
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY ROLLUP(TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME);
                 
 7) CUBE(�÷���1[,�÷���2,�÷���3,...�÷���n]))
  - GROUP BY�� �ȿ� ���
  - ����� �÷������ �������� ���� ������ ��� ������ ��������
  - n���� �÷��� ���Ǹ� 2�� n�� ��ŭ�� �������� ��ȯ --5���޸��� ����(��ü����),��ǰ�� ����, �з��� ����, �з���ǰ�� ����, ��ǰ�� ����, ��¥������, ��¥�� �з��� ����, ��¥�� ��ǰ������
  
��뿹) 2005�� 5�� ���ں�,�з���,��ǰ�� �������踦 ROLLUP,CUBE �� �̿��Ͽ� ��ȸ�Ͻÿ� --�з����� 3���� �з��ڵ庰, ��ǰ�ڵ庰, ��¥ --��׷� �з��϶�� �����ϱ� ���̺� �� �� �ϰ� ��������� �� �ݷ� 2�� �ǳ� ���°�QTY������ ��
       Alias�� ��¥,�з���,��ǰ��,��������հ�,����ݾ��հ��̴�.
       (GROUP BY���� ����)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS ��¥,--�ǸŵǾ��� ��¥�� �װ� CART���̺� �� 8�ڸ����� �־�
              B.LPROD_NM AS �з���,--LPROD ���̺� ����
              C.PROD_NAME AS ��ǰ��,--PROD ���̺� ����
              SUM(A.CART_QTY)��������հ�,
              SUM(A.CART_QTY*C.PROD_PRICE) AS ����ݾ��հ�
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME
        ORDER BY 1;
             
       (ROLLUP ����)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS ��¥,--�ǸŵǾ��� ��¥�� �װ� CART���̺� �� 8�ڸ����� �־�
              B.LPROD_NM AS �з���,--LPROD ���̺� ����
              C.PROD_NAME AS ��ǰ��,--PROD ���̺� ����
              SUM(A.CART_QTY)��������հ�,
              SUM(A.CART_QTY*C.PROD_PRICE) AS ����ݾ��հ�
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY ROLLUP(TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME);
        
       (CUBE ����)
       SELECT TO_DATE(SUBSTR(A.CART_NO,1,8)) AS ��¥,--�ǸŵǾ��� ��¥�� �װ� CART���̺� �� 8�ڸ����� �־�
              B.LPROD_NM AS �з���,--LPROD ���̺� ����
              C.PROD_NAME AS ��ǰ��,--PROD ���̺� ����
              SUM(A.CART_QTY)��������հ�,
              SUM(A.CART_QTY*C.PROD_PRICE) AS ����ݾ��հ�
         FROM CART A, LPROD B, PROD C
        WHERE A.CART_PROD=C.PROD_ID
          AND C.PROD_LGU=B.LPROD_GU
          AND A.CART_NO LIKE '200505%'
        GROUP BY CUBE(TO_DATE(SUBSTR(A.CART_NO,1,8)),B.LPROD_NM,
                 C.PROD_NAME);
    
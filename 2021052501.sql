2021-0525-01)��¥�Լ�
 1) SYSDATE
  -�ý����� �����ϴ� ��¥�� �ð����� ����
  -������ ���� ������ ����
  
��뿹)SELECT SYSDATE,SYSDATE+10,SYSDATE-10  -- +�� �ٰ��� ��¥, -�� ������ ��¥, 0��0��0�ʷ� ����ȴ�
        FROM DUAL;
      
      SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS'),
             TO_CHAR(SYSDATE+10,'YYYY-MM-DD HH24:MI:SS'),
             TO_CHAR(SYSDATE-10,'YYYY-MM-DD HH24:MI:SS')  
        FROM DUAL;
        
 2) ADD_MONTHS(d,n)
  - �־��� ��¥�ڷ� d�� �� �����Ϳ� n�� ���� ���� �����ϴ� ��¥ ��ȯ 
  
��뿹)ȸ���� �Ⱓ�� 3�����̰� �Ⱓ�� ����Ǳ� 5�� �� �˸��� �����ϰ��� �� �� �˸��������� ��ȸ�Ͻÿ�
      SELECT ADD_MONTHS(SYSDATE,3)-5 FROM DUAL; --ADD_MONTH�� ���̴� �� ��¥Ÿ���̴�. �� ������ -��ĥ ���� �Է��ϸ� �˸��� �� �� �ִ�.
      
 3) NEXT_DAY(d,c)
  - d�� �ش��ϴ� ��¥���� �ٰ��� ���� ���� 'c'�� ǥ���� ������ ��¥ ���� ��ȯ --������ ȭ�����ε� 'ȭ'�� �̾Ƴ��� �;�. �׷��� �������� ������ 'ȭ'�� ������ �� �ִ°ž�/�ѱ۷� ��� �νĵ�/�����ͺ��̽�NLS���� �츮�� �� �ѱ۷� �����س��� �׷��ž�
  - c�� ������ ��Ÿ���� ���ڿ� ex)'��','������','��','�ݿ���',...
    SELECT NEXT_DAY(SYSDATE,'��'), 
           NEXT_DAY(SYSDATE,'������'),
           -- NEXT_DAY(SYSDATE,'MONDAY'), --����� ������!
           NEXT_DAY(SYSDATE,'ȭ')
      FROM DUAL;
  
 4) LAST_DAY(d)
  - d�� �ش��ϴ� ���ڿ��� �ش� ���� ������ ��¥ �ڷ� ��ȯ       
    SELECT LAST_DAY('20050201'),
           LAST_DAY('20201231')
          -- LAST_DAY('20200230') --���ڿ��� ��¥������ ��ȯ�Ǿ� �� �� ������ ���ľȿ��� �¾ƾߵ� 2���� 30���� �� ��
      FROM DUAL;
��뿹)�������̺�(BUYPROD)���� 20005�� 2�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ�ڵ�,��ǰ��,���Լ���,���Աݾ��̸� ��ǰ�ڵ������ ����Ͻÿ� 
      SELECT B.PROD_ID AS ��ǰ�ڵ�,
             B.PROD_NAME AS ��ǰ��,
             SUM(A.BUY_QTY) AS ���Լ���, --SUM�� ���� �Ǹ� �հ踦 ���� �� �ִ� / SUM�� ���ִ� ������ ��ǰ���� B���̺� �ֱ� ������ ��������ַ���
             SUM(A.BUY_QTY*B.PROD_COST) AS ���Աݾ�
        FROM BUYPROD A, PROD B --��ǰ���� PROD���� �����;� �ż� ���̺� ��Ī�� �ٿ��� ������ �ذž�. �̷� �� JOIN�̶�� �Ѵ�
       WHERE A.BUY_PROD=B.PROD_ID   --LIKE�����ڴ� ���ڿ� �񱳶� ���⼭�� ����� �� ����
         AND A.BUY_DATE BETWEEN '20050201' AND LAST_DAY('20050201')--��¥���� ������ ���� �� ����Ѵ�
       GROUP BY B.PROD_ID,B.PROD_NAME 
       ORDER BY 1; 
       
��뿹)������ �������� �̹��� ���� �ϼ��� ����Ͻÿ�
      SELECT LAST_DAY(SYSDATE)-SYSDATE FROM DUAL;

 5) MONTHS_BETWEEN(d1,d2)
  - �־��� �����ڷ� d1�� d2������ �������� ��ȯ
  
��뿹)SELECT TRUNC(MONTHS_BETWEEN(SYSDATE,'19901205')/12) FROM DUAL; --/12�� �����ϱ� ���̰� ������ TRUNC�� ���� �Ҽ��� �ڸ� �߶���

 6) EXTRACT(fmt FROM d)
  - 'fmt'�� YEAR,MONTH,DAY,HOUR,MINUTE,SECOND�� ���
  - �־��� ��¥���� d���� fmt�� ���ǵ� ���� �����Ͽ� ��ȯ(����Ÿ��)
��뿹)SELECT EXTRACT(YEAR FROM SYSDATE),
             EXTRACT(MONTH FROM SYSDATE),
             EXTRACT(DAY FROM SYSDATE)
        FROM DUAL; --������ ���ĵ� ���⹰�� �� �� �ִµ� �װ� ���ڸ� �ǹ��Ѵ�
        
        SELECT EXTRACT(YEAR FROM SYSDATE)+
             EXTRACT(MONTH FROM SYSDATE)+
             EXTRACT(DAY FROM SYSDATE)
        FROM DUAL; --���ڶ� �� �������� ���� Ȯ���� �� �־�
        
��뿹)ȸ�����̺��� �̹� ���� ������ ȸ���� ��ȸ�Ͻÿ�
      Alias�� ȸ����,�������,����,�ڵ�����ȣ�̴�
      SELECT MEM_NAME AS ȸ����,
             MEM_BIR AS �������,
             EXTRACT(YEAR FROM SYSDATE)-EXTRACT(YEAR FROM MEM_BIR) AS ����,
             MEM_HP AS �ڵ�����ȣ
        FROM MEMBER
       WHERE EXTRACT(MONTH FROM MEM_BIR)=EXTRACT(MONTH FROM SYSDATE);
        
��뿹)�������̺��� 20005�� 2�� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�
      Alias�� ��ǰ�ڵ�,��ǰ��,���Լ���,���Աݾ��̸� ��ǰ�ڵ������ ����Ͻÿ� 
      SELECT A.BUY_PROD AS ��ǰ�ڵ�,
             B.PROD_NAME AS ��ǰ��,
             SUM(A.BUY_QTY) AS ���Լ���,
             SUM(A.BUY_QTY*A.BUY_COST)���Աݾ�
        FROM BUYPROD A, PROD B
       WHERE A.BUY_PROD=B.PROD_ID --��������
         AND EXTRACT(MONTH FROM A.BUY_DATE)=2 --�Ϲ�����
        GROUP BY A.BUY_PROD, B.PROD_NAME
        ORDER BY 3 DESC; --���Լ����� ���� ������ ���
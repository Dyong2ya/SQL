2021-0513-01)
2. ALTER TABLE (���̺� �̸�, ���� ����)
 1)�÷��߰�(ADD)
    ALTER TABLE ���̺��
     ADD �÷��� ������Ÿ��[(ũ��)][DEFAULT ��][NOT NULL];
        
��뿹)TBL_WORK���̺� ������ �÷��� �߰�
      �������� �÷����� END_DATE�̰� DATEŸ��, NULLABLE
    ALTER TABLE TBL_WORK
     ADD END_DATE DATE; --END DATE�� ��¥�� �����(NULLABLE) ���� �ٹ����̶�� ���� �� ���� �ִ�.
     
 2)�÷�����(MODIFY) --�÷��� ������Ÿ�� �� ũ�� ���� 
    ALTER TABLE ���̺��
     MODIFY (�÷��� ������Ÿ��[(ũ��)][DEFAULT ��][NOT NULL]);
        -'������Ÿ��[(ũ��)': ������ ������Ÿ�� �� ũ��
��뿹)���������(SITE_ITEM)���̺��� �����(SITE_ITEM_NAME)�� CHAR(20)���� �����Ͻÿ�
    ALTER TABLE SITE_ITEM   
     MODIFY(SITE_ITEM_NAME CHAR(20));
     
 3)�÷�����(DROP COLUMN)
     ALTER TABLE ���̺�� DROP COLUMN �÷���;
��뿹)�ٹ����̺�(TBL_WORK)���� �������÷�(END_DATE)�� �����Ͻÿ�
    ALTER TABLE TBL_WORK DROP COLUMN END_DATE;
    
  4)�÷��̸� ����(RENAME COLUMN)
     ALTER TABLE ���̺�� RENAME COLUMN �����÷��� TO ���÷���;
��뿹)������ڰ�(SITE_ITEM)���̺��� �����÷�(QTY)�� �̸��� ITEM_QTY�� �����Ͻÿ�
    ALTER TABLE SITE_ITEM RENAME COLUMN QTY TO ITEM_QTY;
    
 5)�������� �߰�(ADD)
     ALTER TABLE ���̺�� 
      ADD CONSTRAINT �⺻Ű������|�ܷ�Ű������ PRIMARY KEY|FOREIGN KEY
      (�÷���[,�÷���,...])[REFERENCES ���̺��(�÷���,...)];
      
 6)�������� ����(MODIFY)
     ALTER TABLE ���̺�� 
      MODIFY (CONSTRAINT �⺻Ű������|�ܷ�Ű������ PRIMARY KEY|FOREIGN KEY
      (�÷���[,�÷���,...])[REFERENCES ���̺��(�÷���,...)]);
    
 7)�������� ����(DROP)
     ALTER TABLE ���̺�� 
      DROP CONSTRAINT �⺻Ű������|�ܷ�Ű������;
      
 8)���̺�� ����
     ALTER TABLE �������̺�� RENAME TO �����̺��;
    
    
      
      

    
 DELETE BUYPROD;
 SELECT + FROM BUYPROD;
 
  
 ROLLBACK;
 COMMIT;

 

 

2021-0518-01)
  3)BLOB
  .�����ڷ� ����
  .����� �Ǵ� �����ڷ�� �����ͺ��̽� '����'�� ����
  .�ִ� 4GB ���� ����
  (�������)
  �÷��� BLOB;
  
  
��뿹)
CREATE TABLE TEMP09(
  COL1  BLOB);
 **�ڷ������ INSERT INTO������ ����� �� ����
   => �͸��� ���
   
   
DECLARE
  L_DIR VARCHAR2(20):='TEST_DIR';
  L_FILE VARCHAR2(30):='SAMPLE.jpg';
  L_BFILE BFILE;
  L_BLOB BLOB;
BEGIN
  INSERT INTO TEMP09(COL1) VALUES(EMPTY_BLOB())
    RETURN COL1 INTO L_BLOB;
    
  L_BFILE := BFILENAME(L_DIR, L_FILE);
  DBMS_LOB.FILEOPEN(L_BFILE, DBMS_LOB.FILE_READONLY);
  DBMS_LOB.LOADFROMFILE(L_BLOB, L_BFILE, DBMS_LOB.GETLENGTH(L_BFILE));
  DBMS_LOB.FILECLOSE(L_BFILE);
  
  COMMIT;
END;

SELECT * FROM TEMP09;



  
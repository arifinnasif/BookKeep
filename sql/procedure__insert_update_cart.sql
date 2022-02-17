CREATE OR REPLACE PROCEDURE INSERT_UPDATE_CART (
	ARG_QUANT IN NUMBER,
	CID IN VARCHAR2,
	ARG_ISBN IN VARCHAR2,
	MSG OUT VARCHAR2
) IS 
	
	BOOK_COUNT NUMBER;
	
BEGIN
	SELECT COUNT(*) INTO BOOK_COUNT 
	FROM CARTS 
	WHERE CUSTOMER_ID = CID AND ISBN = ARG_ISBN;
	
	IF BOOK_COUNT = 0 THEN
		INSERT INTO CARTS (CUSTOMER_ID, ISBN, QUANTITY)
		VALUES (CID, ARG_ISBN, ARG_QUANT);
		MSG := 'Book Added To Cart!';
	ELSE 
		UPDATE CARTS 
    SET QUANTITY = ARG_QUANT
    WHERE CUSTOMER_ID = CID AND ISBN = ARG_ISBN;
		MSG := 'Cart Edited Successfully!';
	END IF;
	
EXCEPTION
	WHEN OTHERS THEN 
		MSG:= 'Something Went Wrong!';
		
END;
/
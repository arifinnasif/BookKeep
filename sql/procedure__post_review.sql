CREATE OR REPLACE PROCEDURE POST_REVIEW (
	CID IN VARCHAR2, 
	ARG_ISBN IN VARCHAR2, 
	ARG_RATING IN NUMBER, 
	ARG_FEEDBACK IN VARCHAR2, 
	MSG OUT VARCHAR2)
IS 
	REVIEW_COUNT NUMBER;

	BEGIN
	
		SELECT COUNT(*) INTO REVIEW_COUNT
		FROM REVIEWS
		WHERE CUSTOMER_ID = CID AND ISBN = ARG_ISBN;
		
		IF REVIEW_COUNT = 0 THEN
			INSERT INTO REVIEWS (CUSTOMER_ID, ISBN, RATING, FEEDBACK) 
			VALUES (CID, ARG_ISBN, ARG_RATING, ARG_FEEDBACK);
			MSG := 'Review Successfully Added';
		
		ELSE 
			MSG := 'You have already posted a feedback!';
		
		END IF;
		
	EXCEPTION
		WHEN OTHERS THEN 
			MSG:= 'Some Technical Errors Occured. Please Try Again!';
	END;
/
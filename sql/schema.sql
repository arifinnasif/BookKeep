/*
Uncomment following line if you want to rerun the same script

[CAUTION] THIS WILL THEN DELETE ALL THE DATA
*/

DROP TABLE BOOKS					CASCADE CONSTRAINTS;
DROP TABLE BOOK_TYPE				CASCADE CONSTRAINTS;
DROP TABLE PUBLISHERS				CASCADE CONSTRAINTS;
DROP TABLE PUBLISHER_CONTACT_NUMBER	CASCADE CONSTRAINTS;
DROP TABLE AUTHORS					CASCADE CONSTRAINTS;
DROP TABLE WRITES					CASCADE CONSTRAINTS;
DROP TABLE OFFERS					CASCADE CONSTRAINTS;
DROP TABLE OFFER_BOOK				CASCADE CONSTRAINTS;
DROP TABLE BORROWABLE_ITEMS			CASCADE CONSTRAINTS;
DROP TABLE BORROWS					CASCADE CONSTRAINTS;
DROP TABLE CUSTOMERS				CASCADE CONSTRAINTS;
DROP TABLE CUSTOMER_CONTACT_NUMBER	CASCADE CONSTRAINTS;
DROP TABLE SUBSCRIBERS				CASCADE CONSTRAINTS;
DROP TABLE PLANS					CASCADE CONSTRAINTS;
DROP TABLE ORDERS					CASCADE CONSTRAINTS;
DROP TABLE ORDER_BOOK				CASCADE CONSTRAINTS;
DROP TABLE WISHLISTS				CASCADE CONSTRAINTS;
DROP TABLE REVIEWS					CASCADE CONSTRAINTS;
DROP TABLE CARTS					CASCADE CONSTRAINTS;
DROP TABLE REQUESTS					CASCADE CONSTRAINTS;


/*
Creating tables
*/

CREATE TABLE BOOKS (
	ISBN			VARCHAR2(16) NOT NULL,
	NAME			VARCHAR2(64) NOT NULL,
	EDITION			VARCHAR2(32),
	RELEASE_DATE	DATE,
	PRICE			NUMERIC(10,2) NOT NULL,
	PAGE_COUNT		INTEGER,
	QUANTITY 		INTEGER DEFAULT 0 NOT NULL,
	PUBLISHER_ID	INTEGER,

	PRIMARY KEY (ISBN)
);

CREATE TABLE BOOK_TYPE (
	ISBN			VARCHAR2(16),
	B_TYPE			VARCHAR2(64),

	PRIMARY KEY (ISBN, B_TYPE)
);

CREATE TABLE PUBLISHERS (
	PUBLISHER_ID	INTEGER GENERATED by default on null as IDENTITY,
	NAME			VARCHAR2(64) NOT NULL,
	OFFICE_LOCATION	VARCHAR2(256),

	PRIMARY KEY (PUBLISHER_ID)
);

CREATE TABLE PUBLISHER_CONTACT_NUMBER (
	PUBLISHER_ID	INTEGER,
	CONTACT_NUMBER	VARCHAR2(32),

	PRIMARY KEY (PUBLISHER_ID, CONTACT_NUMBER)
);

CREATE TABLE AUTHORS (
	AUTHOR_ID		INTEGER GENERATED by default on null as IDENTITY,
	NAME			VARCHAR2(64) NOT NULL,
	DOB				DATE,
	DOD				DATE,
	ABOUT			VARCHAR2(1024),

	PRIMARY KEY (AUTHOR_ID),
	CHECK (DOD>DOB)
);

CREATE TABLE WRITES (
	AUTHOR_ID		INTEGER,
	ISBN			VARCHAR2(16),

	PRIMARY KEY (AUTHOR_ID, ISBN)
);

CREATE TABLE OFFERS (
	OFFER_ID		INTEGER,
	NAME			VARCHAR2(64) NOT NULL,
	DISCOUNT_PCT	NUMERIC(3,2),
	START_DATE		DATE,
	PERIOD			INTEGER,

	PRIMARY KEY (OFFER_ID)
);

CREATE TABLE OFFER_BOOK (
	ISBN			VARCHAR2(16),
	OFFER_ID		INTEGER,

	PRIMARY KEY (ISBN)
);

CREATE TABLE BORROWABLE_ITEMS (
	BORROWABLE_ITEM_ID			INTEGER GENERATED by default on null as IDENTITY,
	ISBN			VARCHAR2(16),

	PRIMARY KEY (BORROWABLE_ITEM_ID)
);

CREATE TABLE BORROWS (
	BORROWABLE_ITEM_ID			INTEGER,
	CUSTOMER_ID		VARCHAR2(64),
	START_DATE			DATE,
	END_DATE			DATE,

	PRIMARY KEY (BORROWABLE_ITEM_ID, CUSTOMER_ID)
);

CREATE TABLE CUSTOMERS (
	CUSTOMER_ID			VARCHAR2(64),
	PASSWORD				VARCHAR2(64) NOT NULL,
	NAME				VARCHAR2(64) NOT NULL,
	ADDRESS				VARCHAR2(256),
	EMAIL				VARCHAR2(64) UNIQUE NOT NULL,
	ACCOUNT_CREATED_ON	DATE,

	PRIMARY KEY(CUSTOMER_ID)
);

CREATE TABLE CUSTOMER_CONTACT_NUMBER (
	CUSTOMER_ID			VARCHAR2(64),
	CONTACT_NUMBER		VARCHAR2(32),

	PRIMARY KEY(CUSTOMER_ID, CONTACT_NUMBER)
);

CREATE TABLE SUBSCRIBERS (
	CUSTOMER_ID			VARCHAR2(64),
	MEMBERSHIP_BOUGHT_ON	DATE,
	PLAN_ID				INTEGER,

	PRIMARY KEY (CUSTOMER_ID)
);

CREATE TABLE PLANS (
	PLAN_ID				INTEGER GENERATED by default on null as IDENTITY,
	NAME				VARCHAR2(64) NOT NULL,
	PERIOD 				INTEGER,
	BORROW_LIMIT		INTEGER,
	PRICE			NUMERIC(10,2),

	PRIMARY KEY (PLAN_ID)
);

CREATE TABLE ORDERS (
	ORDER_ID			INTEGER GENERATED by default on null as IDENTITY,
	CUSTOMER_ID			VARCHAR2(64),
	ORDERING_DATE		DATE,
	DELIVERY_DATE		DATE,

	PRIMARY KEY (ORDER_ID)
);

CREATE TABLE ORDER_BOOK (
	ORDER_ID			INTEGER,
	ISBN				VARCHAR2(16),
	UNIT_PRICE			NUMERIC(10,2),
	QUANTITY			INTEGER,

	PRIMARY KEY (ORDER_ID, ISBN)
);

CREATE TABLE WISHLISTS (
	CUSTOMER_ID			VARCHAR2(64),
	ISBN				VARCHAR2(16),

	PRIMARY KEY (CUSTOMER_ID, ISBN)
);

CREATE TABLE REVIEWS (
	CUSTOMER_ID			VARCHAR2(64),
	ISBN				VARCHAR2(16),
	RATING				INTEGER,
	FEEDBACK			VARCHAR2(256),	-- COMMENT CHANGED TO FEEDBACK BECAUSE THERE IS RESERVED KEYWORD

	PRIMARY KEY (CUSTOMER_ID, ISBN)
);

CREATE TABLE CARTS (
	CUSTOMER_ID			VARCHAR2(64),
	ISBN				VARCHAR2(16),
	QUANTITY			INTEGER,

	PRIMARY KEY (CUSTOMER_ID, ISBN)
);

CREATE TABLE REQUESTS (
	CUSTOMER_ID		VARCHAR2(64),
	ISBN				VARCHAR2(16),

	PRIMARY KEY (CUSTOMER_ID, ISBN)
);


CREATE TABLE MANAGERS (
	ADMIN_ID			VARCHAR2(64),
	PASSWORD				VARCHAR2(64) NOT NULL,

	PRIMARY KEY(ADMIN_ID)
);

CREATE TABLE EXPIRED (
	EXPIRED_ID INTEGER GENERATED by default on null as IDENTITY,
	CUSTOMER_ID VARCHAR2(64),
	BORROWABLE_ITEM_ID INTEGER,
	ISSUE_DATE DATE,

	PRIMARY KEY(EXPIRED_ID)
);

/*
Creating foreign key constraints
*/

ALTER TABLE BOOKS ADD (
	CONSTRAINT "BOOKS__PUBLISHER_FK" FOREIGN KEY (PUBLISHER_ID) REFERENCES PUBLISHERS(PUBLISHER_ID)
);

ALTER TABLE BOOK_TYPE ADD (
	CONSTRAINT "BOOK_TYPE__BOOKS" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

ALTER TABLE PUBLISHER_CONTACT_NUMBER ADD (
	CONSTRAINT "PUBLISHER_CONTACT_NUMBER__PUBLISHERS_FK" FOREIGN KEY (PUBLISHER_ID) REFERENCES PUBLISHERS(PUBLISHER_ID)
);

ALTER TABLE WRITES ADD (
	CONSTRAINT "WRITES__AUTHORS_FK" FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHORS(AUTHOR_ID)
);

ALTER TABLE WRITES ADD (
	CONSTRAINT "WRITES__BOOKS_FK" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

ALTER TABLE OFFER_BOOK ADD (
	CONSTRAINT "OFFER_BOOK__BOOKS_FK" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN),
	CONSTRAINT "OFFER_BOOK__OFFERS_FK" FOREIGN KEY (OFFER_ID) REFERENCES OFFERS(OFFER_ID)
);

ALTER TABLE BORROWABLE_ITEMS ADD (
	CONSTRAINT "BORROWABLE_ITEMS__BOOKS_FK" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

ALTER TABLE BORROWS ADD (
	CONSTRAINT "BORROWS__BORROWABLE_ITEMS_FK" FOREIGN KEY (BORROWABLE_ITEM_ID) REFERENCES BORROWABLE_ITEMS(BORROWABLE_ITEM_ID),
	CONSTRAINT "BORROWS__SUBSCRIBERS_FK" FOREIGN KEY (CUSTOMER_ID) REFERENCES SUBSCRIBERS(CUSTOMER_ID)
);

ALTER TABLE CUSTOMER_CONTACT_NUMBER ADD (
	CONSTRAINT "CUSTOMER_CONTACT_NUMBER__CUSTOMERS_FK" FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID)
);

ALTER TABLE SUBSCRIBERS ADD (
	CONSTRAINT "SUBSCRIBERS__CUSTOMERS_FK" FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
	CONSTRAINT "SUBSCRIBERS__PLANS_FK" FOREIGN KEY (PLAN_ID) REFERENCES PLANS(PLAN_ID)
);

ALTER TABLE ORDERS ADD (
	CONSTRAINT "ORDERS__CUSTOMERS_FK" FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID)
);

ALTER TABLE ORDER_BOOK ADD (
	CONSTRAINT "ORDER_BOOK__ORDERS_FK" FOREIGN KEY (ORDER_ID) REFERENCES ORDERS (ORDER_ID),
	CONSTRAINT "ORDER_BOOK__BOOKS_FK" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

ALTER TABLE WISHLISTS ADD (
	CONSTRAINT "WISHLISTS__CUSTOMERS_FK" FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
	CONSTRAINT "WISHLISTS__BOOKS_FK" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

ALTER TABLE REVIEWS ADD (
	CONSTRAINT "REVIEWS__CUSTOMERS_FK" FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
	CONSTRAINT "REVIEWS__BOOKS_FK" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

ALTER TABLE CARTS ADD (
	CONSTRAINT "CARTS__CUSTOMERS_FK" FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMERS(CUSTOMER_ID),
	CONSTRAINT "CARTS__BOOKS_FK" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

ALTER TABLE REQUESTS ADD (
	CONSTRAINT "REQUESTS__SUBSCRIBERS_FK" FOREIGN KEY (CUSTOMER_ID) REFERENCES SUBSCRIBERS(CUSTOMER_ID),
	CONSTRAINT "REQUESTS__BOOKS_FK" FOREIGN KEY (ISBN) REFERENCES BOOKS(ISBN)
);

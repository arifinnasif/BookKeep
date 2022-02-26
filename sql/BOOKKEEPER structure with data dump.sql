/*
 Navicat Premium Data Transfer

 Source Server         : BOOKKEEP
 Source Server Type    : Oracle
 Source Server Version : 190000
 Source Host           : localhost:1521
 Source Schema         : BOOKKEEPER

 Target Server Type    : Oracle
 Target Server Version : 190000
 File Encoding         : 65001

 Date: 26/02/2022 21:41:53
*/


-- ----------------------------
-- Table structure for AUTHORS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."AUTHORS";
CREATE TABLE "BOOKKEEPER"."AUTHORS" (
  "AUTHOR_ID" NUMBER VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73274".nextval NOT NULL,
  "NAME" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "DOB" DATE VISIBLE,
  "DOD" DATE VISIBLE,
  "ABOUT" VARCHAR2(1024 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of AUTHORS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('1', 'Jane Austen', TO_DATE('1775-12-16 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1817-07-18 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Jane Austen was an English novelist whose works of romantic fiction, set among the landed gentry, earned her a place as one of the most widely read writers in English literature, her realism and biting social commentary cementing her historical importance among scholars and critics.');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('2', 'George Orwell', TO_DATE('1903-06-25 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1950-01-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Eric Arthur Blair, better known by his pen name George Orwell, was an English author and journalist. His work is marked by keen intelligence and wit, a profound awareness of social injustice, an intense opposition to totalitarianism, a passion for clarity in language, and a belief in democratic socialism.');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('3', 'F. Scott Fitzgerald', TO_DATE('1896-09-24 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1940-12-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Francis Scott Key Fitzgerald was an American writer of novels and short stories, whose works have been seen as evocative of the Jazz Age, a term he himself allegedly coined. He is regarded as one of the greatest twentieth century writers. Fitzgerald was of the self-styled "Lost Generation," Americans born in the 1890s who came of age during World War I. He finished four novels, left a fifth unfinished, and wrote dozens of short stories that treat themes of youth, despair, and age.');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('4', 'Fyodor Dostoevsky', TO_DATE('1821-11-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1881-02-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Fyodor Mikhailovich Dostoevsky sometimes transliterated as Fedor Dostoyevsky, was a Russian novelist, short story writer, essayist, and journalist. His literary works explore human psychology in the troubled political, social, and spiritual atmospheres of 19th-century Russia, and engage with a variety of philosophical and religious themes. His most acclaimed novels include Crime and Punishment (1866), The Idiot (1869), Demons (1872), and The Brothers Karamazov (1880).');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('5', 'Mark Twain', TO_DATE('1835-11-30 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1910-04-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Samuel Langhorne Clemens, better known by his pen name Mark Twain, was an American author and humorist. He is noted for his novels Adventures of Huckleberry Finn (1885), called "the Great American Novel", and The Adventures of Tom Sawyer (1876).');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('6', 'Leo Tolstoy', TO_DATE('1828-09-09 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1910-11-20 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Lev Nikolayevich Tolstoy (most appropriately used Liev Tolstoy; commonly Leo Tolstoy in Anglophone countries) was a Russian writer who primarily wrote novels and short stories. Later in life, he also wrote plays and essays. His two most famous works, the novels War and Peace and Anna Karenina, are acknowledged as two of the greatest novels of all time and a pinnacle of realist fiction. Many consider Tolstoy to have been one of the world''s greatest novelists.');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('7', 'Ernest Hemingway', TO_DATE('1899-07-21 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1961-07-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Ernest Miller Hemingway was an American author and journalist. His economical and understated style had a strong influence on 20th-century fiction, while his life of adventure and his public image influenced later generations. Hemingway produced most of his work between the mid-1920s and the mid-1950s, and won the Nobel Prize in Literature in 1954. He published seven novels, six short story collections and two non-fiction works. Three novels, four collections of short stories and three non-fiction works were published posthumously. Many of these are considered classics of American literature.');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('8', 'Franz Kafka', TO_DATE('1883-07-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1924-06-03 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Franz Kafka was one of the major fiction writers of the 20th century. He was born to a middle-class German-speaking Jewish family in Prague, Bohemia (presently the Czech Republic), Austria–Hungary. His unique body of writing—much of which is incomplete and which was mainly published posthumously—is considered to be among the most influential in Western literature.');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('9', 'James Joyce', TO_DATE('1882-02-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('1941-01-13 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'James Joyce, Irish novelist, noted for his experimental use of language in such works as Ulysses (1922) and Finnegans Wake (1939). Joyce''s technical innovations in the art of the novel include an extensive use of interior monologue; he used a complex network of symbolic parallels drawn from the mythology, history, and literature, and created a unique language of invented words, puns, and allusions.');
INSERT INTO "BOOKKEEPER"."AUTHORS" VALUES ('10', 'Harper Lee', TO_DATE('1926-04-28 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2016-02-19 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), 'Harper Lee, known as Nelle, was born in the Alabama town of Monroeville, the youngest of four children of Amasa Coleman Lee and Frances Cunningham Finch Lee. Her father, a former newspaper editor and proprietor, was a lawyer who served on the state legislature from 1926 to 1938. As a child, Lee was a tomboy and a precocious reader, and enjoyed the friendship of her schoolmate and neighbor, the young Truman Capote.');

-- ----------------------------
-- Table structure for AUTH_GROUP
-- ----------------------------
DROP TABLE "BOOKKEEPER"."AUTH_GROUP";
CREATE TABLE "BOOKKEEPER"."AUTH_GROUP" (
  "ID" NUMBER(11,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73094".nextval NOT NULL,
  "NAME" NVARCHAR2(150) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of AUTH_GROUP
-- ----------------------------

-- ----------------------------
-- Table structure for AUTH_GROUP_PERMISSIONS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS";
CREATE TABLE "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS" (
  "ID" NUMBER(19,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73098".nextval NOT NULL,
  "GROUP_ID" NUMBER(11,0) VISIBLE NOT NULL,
  "PERMISSION_ID" NUMBER(11,0) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of AUTH_GROUP_PERMISSIONS
-- ----------------------------

-- ----------------------------
-- Table structure for AUTH_PERMISSION
-- ----------------------------
DROP TABLE "BOOKKEEPER"."AUTH_PERMISSION";
CREATE TABLE "BOOKKEEPER"."AUTH_PERMISSION" (
  "ID" NUMBER(11,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73091".nextval NOT NULL,
  "NAME" NVARCHAR2(255) VISIBLE,
  "CONTENT_TYPE_ID" NUMBER(11,0) VISIBLE NOT NULL,
  "CODENAME" NVARCHAR2(100) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of AUTH_PERMISSION
-- ----------------------------
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('1', 'Can add log entry', '1', 'add_logentry');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('2', 'Can change log entry', '1', 'change_logentry');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('3', 'Can delete log entry', '1', 'delete_logentry');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('4', 'Can view log entry', '1', 'view_logentry');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('5', 'Can add permission', '2', 'add_permission');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('6', 'Can change permission', '2', 'change_permission');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('7', 'Can delete permission', '2', 'delete_permission');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('8', 'Can view permission', '2', 'view_permission');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('9', 'Can add group', '3', 'add_group');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('10', 'Can change group', '3', 'change_group');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('11', 'Can delete group', '3', 'delete_group');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('12', 'Can view group', '3', 'view_group');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('13', 'Can add user', '4', 'add_user');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('14', 'Can change user', '4', 'change_user');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('15', 'Can delete user', '4', 'delete_user');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('16', 'Can view user', '4', 'view_user');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('17', 'Can add content type', '5', 'add_contenttype');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('18', 'Can change content type', '5', 'change_contenttype');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('19', 'Can delete content type', '5', 'delete_contenttype');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('20', 'Can view content type', '5', 'view_contenttype');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('21', 'Can add session', '6', 'add_session');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('22', 'Can change session', '6', 'change_session');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('23', 'Can delete session', '6', 'delete_session');
INSERT INTO "BOOKKEEPER"."AUTH_PERMISSION" VALUES ('24', 'Can view session', '6', 'view_session');

-- ----------------------------
-- Table structure for AUTH_USER
-- ----------------------------
DROP TABLE "BOOKKEEPER"."AUTH_USER";
CREATE TABLE "BOOKKEEPER"."AUTH_USER" (
  "ID" NUMBER(11,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73101".nextval NOT NULL,
  "PASSWORD" NVARCHAR2(128) VISIBLE,
  "LAST_LOGIN" TIMESTAMP(6) VISIBLE,
  "IS_SUPERUSER" NUMBER(1,0) VISIBLE NOT NULL,
  "USERNAME" NVARCHAR2(150) VISIBLE,
  "FIRST_NAME" NVARCHAR2(150) VISIBLE,
  "LAST_NAME" NVARCHAR2(150) VISIBLE,
  "EMAIL" NVARCHAR2(254) VISIBLE,
  "IS_STAFF" NUMBER(1,0) VISIBLE NOT NULL,
  "IS_ACTIVE" NUMBER(1,0) VISIBLE NOT NULL,
  "DATE_JOINED" TIMESTAMP(6) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of AUTH_USER
-- ----------------------------

-- ----------------------------
-- Table structure for AUTH_USER_GROUPS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."AUTH_USER_GROUPS";
CREATE TABLE "BOOKKEEPER"."AUTH_USER_GROUPS" (
  "ID" NUMBER(19,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73105".nextval NOT NULL,
  "USER_ID" NUMBER(11,0) VISIBLE NOT NULL,
  "GROUP_ID" NUMBER(11,0) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of AUTH_USER_GROUPS
-- ----------------------------

-- ----------------------------
-- Table structure for AUTH_USER_USER_PERMISSIONS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS";
CREATE TABLE "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS" (
  "ID" NUMBER(19,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73108".nextval NOT NULL,
  "USER_ID" NUMBER(11,0) VISIBLE NOT NULL,
  "PERMISSION_ID" NUMBER(11,0) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of AUTH_USER_USER_PERMISSIONS
-- ----------------------------

-- ----------------------------
-- Table structure for BOOKS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."BOOKS";
CREATE TABLE "BOOKKEEPER"."BOOKS" (
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL,
  "NAME" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "EDITION" VARCHAR2(32 BYTE) VISIBLE,
  "RELEASE_DATE" DATE VISIBLE,
  "PRICE" NUMBER(10,2) VISIBLE NOT NULL,
  "PAGE_COUNT" NUMBER VISIBLE,
  "QUANTITY" NUMBER VISIBLE DEFAULT 0 NOT NULL,
  "PUBLISHER_ID" NUMBER VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of BOOKS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780553213102', 'Pride And Prejudice', 'Paperback', TO_DATE('1813-03-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '500', '334', '5', '2');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780141036144', '1984', 'Paperback', TO_DATE('1949-04-08 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '400', '311', '8', '4');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780743273565', 'The Great Gatsby', 'Hardcover', TO_DATE('1925-04-10 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '490', '200', '7', '5');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780143058144', 'Crime And Punishment', 'Indian Edition', TO_DATE('1866-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '700', '671', '6', '4');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780142437179', 'The Adventures of Huckleberry Finn', NULL, TO_DATE('1884-12-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '250', '327', '2', '4');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780143035008', 'Anna Karenina', NULL, TO_DATE('1877-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '390', '838', '4', '4');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780099908401', 'The Old Man and the Sea', NULL, TO_DATE('1952-09-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '100', '99', '13', '1');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780670034697', 'War And Peace', 'Eastern Economy', TO_DATE('1869-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '1300', '1412', '3', '2');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780486290300', 'The Metamorphosis and Other Stories', NULL, TO_DATE('1915-01-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '120', '88', '2', '3');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9780141182803', 'Ulysses', NULL, TO_DATE('1922-02-02 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '1800', '933', '0', '4');
INSERT INTO "BOOKKEEPER"."BOOKS" VALUES ('9781439550410', 'To Kill a Mockingbird', 'Hardcover', TO_DATE('1960-07-11 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'), '870', '376', '0', '6');

-- ----------------------------
-- Table structure for BOOK_TYPE
-- ----------------------------
DROP TABLE "BOOKKEEPER"."BOOK_TYPE";
CREATE TABLE "BOOKKEEPER"."BOOK_TYPE" (
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL,
  "B_TYPE" VARCHAR2(64 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of BOOK_TYPE
-- ----------------------------
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780099908401', 'Nautical Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780099908401', 'Novel');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780141036144', 'Novel');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780141036144', 'Political Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780141036144', 'Science Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780141182803', 'Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780141182803', 'Novel');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780142437179', 'Adventure Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780142437179', 'Novel');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780142437179', 'Satire');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780143035008', 'Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780143035008', 'Novel');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780143058144', 'Crime Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780143058144', 'Novel');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780143058144', 'Psychological Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780486290300', 'Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780553213102', 'Novel');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780553213102', 'Romance');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780553213102', 'Satire');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780670034697', 'Historical Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780670034697', 'Novel');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780670034697', 'Romance');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780670034697', 'War');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9780743273565', 'Historical Fiction');
INSERT INTO "BOOKKEEPER"."BOOK_TYPE" VALUES ('9781439550410', 'Thriller');

-- ----------------------------
-- Table structure for BORROWABLE_ITEMS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."BORROWABLE_ITEMS";
CREATE TABLE "BOOKKEEPER"."BORROWABLE_ITEMS" (
  "BORROWABLE_ITEM_ID" NUMBER VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73284".nextval NOT NULL,
  "ISBN" VARCHAR2(16 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of BORROWABLE_ITEMS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('1', '9780141036144');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('2', '9780099908401');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('3', '9780486290300');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('4', '9780743273565');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('5', '9780141036144');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('6', '9781439550410');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('7', '9781439550410');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('8', '9781439550410');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('9', '9780142437179');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('10', '9780670034697');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('11', '9780142437179');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('12', '9780143035008');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('13', '9780670034697');
INSERT INTO "BOOKKEEPER"."BORROWABLE_ITEMS" VALUES ('14', '9780553213102');

-- ----------------------------
-- Table structure for BORROWS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."BORROWS";
CREATE TABLE "BOOKKEEPER"."BORROWS" (
  "BORROWABLE_ITEM_ID" NUMBER VISIBLE NOT NULL,
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "START_DATE" DATE VISIBLE,
  "END_DATE" DATE VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of BORROWS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."BORROWS" VALUES ('1', 'asif', TO_DATE('2022-01-18 15:35:29', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-02-23 00:32:04', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."BORROWS" VALUES ('3', 'asif', TO_DATE('2022-01-18 15:38:56', 'SYYYY-MM-DD HH24:MI:SS'), NULL);

-- ----------------------------
-- Table structure for CARTS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."CARTS";
CREATE TABLE "BOOKKEEPER"."CARTS" (
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL,
  "QUANTITY" NUMBER VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of CARTS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('richwell', '9780142437179', '1');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('richwell', '9780099908401', '3');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('anik', '9780142437179', '3');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('pappu', '9780143058144', '2');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('pappu', '9780141036144', '3');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('farhan', '9780670034697', '1');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('pappu', '9780670034697', '1');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('farhan', '9780143058144', '2');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('tz', '9781439550410', '1');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('sarah123', '9780743273565', '1');
INSERT INTO "BOOKKEEPER"."CARTS" VALUES ('asif', '9781439550410', '1');

-- ----------------------------
-- Table structure for CUSTOMERS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."CUSTOMERS";
CREATE TABLE "BOOKKEEPER"."CUSTOMERS" (
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "PASSWORD" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "NAME" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "ADDRESS" VARCHAR2(256 BYTE) VISIBLE,
  "EMAIL" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "ACCOUNT_CREATED_ON" DATE VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of CUSTOMERS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('richwell', 'richwellpass', 'Richard Wells', '8 Grand Way Cv, Edgewater, New Jersey(NJ), 07020', 'wells@example.com', TO_DATE('2019-01-04 15:19:44', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('sarah123', 'sarah123pass', 'Sarah Fields', '145 Cottonwood Dr, Forsyth, Missouri(MO), 65653', 'sarahfields@example.net', TO_DATE('2018-01-31 15:22:21', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('skinnynick', 'skinnynickpass', 'Nicholas Skinner', '1460 Big Cedar Way, Sebastopol, California(Ca), 95472', 'helloitsnick@yahoo.com', TO_DATE('2021-03-10 15:24:45', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('chorn', 'chornpass', 'Christopher Horn', '8651 Spring Creek Rd, Northfield, Minnesota(MN), 55057', 'chorn@example.com', TO_DATE('2020-07-25 15:27:18', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('asif', 'asifpass', 'Asif Haider Elhan', '1200 S Wood Ave, Linden, New Jersey(Nj), 07036', 'haider@example.com', TO_DATE('2022-01-03 15:30:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('anik', 'thisisanik', 'Azizur Rahman', '176, Bera Dakkhkhinpara, Bera', 'aziz@gmail.com', TO_DATE('2022-02-23 12:03:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('talharox', 'thisistalha', 'Talha Jubair', '262/1, West Nakhalpara, Farmgate', 'talha@gmail.com', TO_DATE('2022-02-23 01:51:12', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('farhan', '12345', 'Farhan Tanvir', 'mohammohpur, Dhaka', 'far@yahoo.com', TO_DATE('2022-02-24 22:51:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('monir', '12345', 'Anika Monir Tasnim', 'Mirpur, Dhaka', 'example@yahoo.com', TO_DATE('2022-02-24 23:01:56', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('naim', '123456', 'Nayeem Ahmed', 'Bogura, Bangladesh', 'example@gmail.com', TO_DATE('2022-02-24 23:57:16', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('tz', '123456', 'tanjeem ', 'Azimpur, Dhaka', 'examp@gmail.com', TO_DATE('2022-02-25 00:20:41', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('mehrab', '12345678', 'Mehrab Haque', 'Azimpur, Dhaka, Bangladesh', 'meh@gmail.com', TO_DATE('2022-02-25 02:23:33', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."CUSTOMERS" VALUES ('pappu', '12345', 'Pappu Mahmud Kowsar', 'Nakhalpara, Farmgate, Dhaka', 'pappu@yahoo.com', TO_DATE('2022-02-24 22:03:04', 'SYYYY-MM-DD HH24:MI:SS'));

-- ----------------------------
-- Table structure for CUSTOMER_CONTACT_NUMBER
-- ----------------------------
DROP TABLE "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER";
CREATE TABLE "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" (
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "CONTACT_NUMBER" VARCHAR2(32 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of CUSTOMER_CONTACT_NUMBER
-- ----------------------------
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('anik', '123-1245-236');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('asif', '123-456');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('chorn', '208-214-8200');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('farhan', '12-156-3');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('mehrab', '123-456');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('mehrab', '123-456-8');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('monir', '123-456-789');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('monir', '1234-456-789');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('naim', '12-134569-1');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('naim', '12345-5879');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('pappu', '123-456');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('pappu', '123-456-789');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('richwell', '907-200-8681');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('sarah123', '480-203-3938');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('skinnynick', '123-456-789');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('talharox', '012-236-4152');
INSERT INTO "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" VALUES ('tz', '123-456789');

-- ----------------------------
-- Table structure for DJANGO_ADMIN_LOG
-- ----------------------------
DROP TABLE "BOOKKEEPER"."DJANGO_ADMIN_LOG";
CREATE TABLE "BOOKKEEPER"."DJANGO_ADMIN_LOG" (
  "ID" NUMBER(11,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73122".nextval NOT NULL,
  "ACTION_TIME" TIMESTAMP(6) VISIBLE NOT NULL,
  "OBJECT_ID" NCLOB VISIBLE,
  "OBJECT_REPR" NVARCHAR2(200) VISIBLE,
  "ACTION_FLAG" NUMBER(11,0) VISIBLE NOT NULL,
  "CHANGE_MESSAGE" NCLOB VISIBLE,
  "CONTENT_TYPE_ID" NUMBER(11,0) VISIBLE,
  "USER_ID" NUMBER(11,0) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of DJANGO_ADMIN_LOG
-- ----------------------------

-- ----------------------------
-- Table structure for DJANGO_CONTENT_TYPE
-- ----------------------------
DROP TABLE "BOOKKEEPER"."DJANGO_CONTENT_TYPE";
CREATE TABLE "BOOKKEEPER"."DJANGO_CONTENT_TYPE" (
  "ID" NUMBER(11,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73087".nextval NOT NULL,
  "APP_LABEL" NVARCHAR2(100) VISIBLE,
  "MODEL" NVARCHAR2(100) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of DJANGO_CONTENT_TYPE
-- ----------------------------
INSERT INTO "BOOKKEEPER"."DJANGO_CONTENT_TYPE" VALUES ('1', 'admin', 'logentry');
INSERT INTO "BOOKKEEPER"."DJANGO_CONTENT_TYPE" VALUES ('2', 'auth', 'permission');
INSERT INTO "BOOKKEEPER"."DJANGO_CONTENT_TYPE" VALUES ('3', 'auth', 'group');
INSERT INTO "BOOKKEEPER"."DJANGO_CONTENT_TYPE" VALUES ('4', 'auth', 'user');
INSERT INTO "BOOKKEEPER"."DJANGO_CONTENT_TYPE" VALUES ('5', 'contenttypes', 'contenttype');
INSERT INTO "BOOKKEEPER"."DJANGO_CONTENT_TYPE" VALUES ('6', 'sessions', 'session');

-- ----------------------------
-- Table structure for DJANGO_MIGRATIONS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."DJANGO_MIGRATIONS";
CREATE TABLE "BOOKKEEPER"."DJANGO_MIGRATIONS" (
  "ID" NUMBER(19,0) VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73084".nextval NOT NULL,
  "APP" NVARCHAR2(255) VISIBLE,
  "NAME" NVARCHAR2(255) VISIBLE,
  "APPLIED" TIMESTAMP(6) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of DJANGO_MIGRATIONS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('1', 'contenttypes', '0001_initial', TO_TIMESTAMP('2022-01-24 13:14:55.287596', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('2', 'auth', '0001_initial', TO_TIMESTAMP('2022-01-24 13:14:59.342231', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('3', 'admin', '0001_initial', TO_TIMESTAMP('2022-01-24 13:14:59.524725', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('4', 'admin', '0002_logentry_remove_auto_add', TO_TIMESTAMP('2022-01-24 13:14:59.548095', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('5', 'admin', '0003_logentry_add_action_flag_choices', TO_TIMESTAMP('2022-01-24 13:14:59.572132', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('6', 'contenttypes', '0002_remove_content_type_name', TO_TIMESTAMP('2022-01-24 13:15:01.131357', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('7', 'auth', '0002_alter_permission_name_max_length', TO_TIMESTAMP('2022-01-24 13:15:01.226018', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('8', 'auth', '0003_alter_user_email_max_length', TO_TIMESTAMP('2022-01-24 13:15:01.256533', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('9', 'auth', '0004_alter_user_username_opts', TO_TIMESTAMP('2022-01-24 13:15:01.340932', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('10', 'auth', '0005_alter_user_last_login_null', TO_TIMESTAMP('2022-01-24 13:15:01.372762', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('11', 'auth', '0006_require_contenttypes_0002', TO_TIMESTAMP('2022-01-24 13:15:01.388730', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('12', 'auth', '0007_alter_validators_add_error_messages', TO_TIMESTAMP('2022-01-24 13:15:01.422890', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('13', 'auth', '0008_alter_user_username_max_length', TO_TIMESTAMP('2022-01-24 13:15:01.461823', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('14', 'auth', '0009_alter_user_last_name_max_length', TO_TIMESTAMP('2022-01-24 13:15:01.494794', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('15', 'auth', '0010_alter_group_name_max_length', TO_TIMESTAMP('2022-01-24 13:15:01.530476', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('16', 'auth', '0011_update_proxy_permissions', TO_TIMESTAMP('2022-01-24 13:15:01.555835', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('17', 'auth', '0012_alter_user_first_name_max_length', TO_TIMESTAMP('2022-01-24 13:15:01.595986', 'SYYYY-MM-DD HH24:MI:SS:FF6'));
INSERT INTO "BOOKKEEPER"."DJANGO_MIGRATIONS" VALUES ('18', 'sessions', '0001_initial', TO_TIMESTAMP('2022-01-24 13:15:01.638776', 'SYYYY-MM-DD HH24:MI:SS:FF6'));

-- ----------------------------
-- Table structure for DJANGO_SESSION
-- ----------------------------
DROP TABLE "BOOKKEEPER"."DJANGO_SESSION";
CREATE TABLE "BOOKKEEPER"."DJANGO_SESSION" (
  "SESSION_KEY" NVARCHAR2(40) VISIBLE NOT NULL,
  "SESSION_DATA" NCLOB VISIBLE,
  "EXPIRE_DATE" TIMESTAMP(6) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of DJANGO_SESSION
-- ----------------------------

-- ----------------------------
-- Table structure for EXPIRED
-- ----------------------------
DROP TABLE "BOOKKEEPER"."EXPIRED";
CREATE TABLE "BOOKKEEPER"."EXPIRED" (
  "EXPIRED_ID" NUMBER VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73564".nextval NOT NULL,
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE,
  "BORROWABLE_ITEM_ID" NUMBER VISIBLE,
  "ISSUE_DATE" DATE VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of EXPIRED
-- ----------------------------
INSERT INTO "BOOKKEEPER"."EXPIRED" VALUES ('1', 'sarah123', '6', TO_DATE('2022-02-15 15:31:26', 'SYYYY-MM-DD HH24:MI:SS'));

-- ----------------------------
-- Table structure for MANAGERS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."MANAGERS";
CREATE TABLE "BOOKKEEPER"."MANAGERS" (
  "ADMIN_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "PASSWORD" VARCHAR2(64 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of MANAGERS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."MANAGERS" VALUES ('admin', 'asif');

-- ----------------------------
-- Table structure for OFFERS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."OFFERS";
CREATE TABLE "BOOKKEEPER"."OFFERS" (
  "OFFER_ID" NUMBER VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73279".nextval NOT NULL,
  "NAME" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "DISCOUNT_PCT" NUMBER(3,2) VISIBLE,
  "START_DATE" DATE VISIBLE,
  "PERIOD" NUMBER VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of OFFERS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."OFFERS" VALUES ('1', 'Victory Day Sale', '0.16', TO_DATE('2022-12-15 01:13:32', 'SYYYY-MM-DD HH24:MI:SS'), '3');
INSERT INTO "BOOKKEEPER"."OFFERS" VALUES ('2', 'Independence Day Offer', '0.26', TO_DATE('2022-03-26 01:14:27', 'SYYYY-MM-DD HH24:MI:SS'), '1');
INSERT INTO "BOOKKEEPER"."OFFERS" VALUES ('3', 'Eid Dhamaka Offer', '0.25', TO_DATE('2022-05-04 01:15:56', 'SYYYY-MM-DD HH24:MI:SS'), '7');
INSERT INTO "BOOKKEEPER"."OFFERS" VALUES ('4', 'Puja Special Offer', '0.25', TO_DATE('2022-10-12 01:17:31', 'SYYYY-MM-DD HH24:MI:SS'), '5');
INSERT INTO "BOOKKEEPER"."OFFERS" VALUES ('5', 'New Year Sale', '0.3', TO_DATE('2023-01-01 01:19:01', 'SYYYY-MM-DD HH24:MI:SS'), '1');
INSERT INTO "BOOKKEEPER"."OFFERS" VALUES ('6', 'Valentine''s Day Special Offer', '0.15', TO_DATE('2022-02-14 01:19:51', 'SYYYY-MM-DD HH24:MI:SS'), '1');
INSERT INTO "BOOKKEEPER"."OFFERS" VALUES ('7', 'Mother Language Day Sale', '0.1', TO_DATE('2022-02-01 01:21:42', 'SYYYY-MM-DD HH24:MI:SS'), '28');

-- ----------------------------
-- Table structure for OFFER_BOOK
-- ----------------------------
DROP TABLE "BOOKKEEPER"."OFFER_BOOK";
CREATE TABLE "BOOKKEEPER"."OFFER_BOOK" (
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL,
  "OFFER_ID" NUMBER VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of OFFER_BOOK
-- ----------------------------
INSERT INTO "BOOKKEEPER"."OFFER_BOOK" VALUES ('9780553213102', '4');
INSERT INTO "BOOKKEEPER"."OFFER_BOOK" VALUES ('9780141036144', '5');
INSERT INTO "BOOKKEEPER"."OFFER_BOOK" VALUES ('9780743273565', '7');
INSERT INTO "BOOKKEEPER"."OFFER_BOOK" VALUES ('9780670034697', '7');
INSERT INTO "BOOKKEEPER"."OFFER_BOOK" VALUES ('9780141182803', '7');
INSERT INTO "BOOKKEEPER"."OFFER_BOOK" VALUES ('9781439550410', '2');

-- ----------------------------
-- Table structure for ORDERS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."ORDERS";
CREATE TABLE "BOOKKEEPER"."ORDERS" (
  "ORDER_ID" NUMBER VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73299".nextval NOT NULL,
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE,
  "ORDERING_DATE" DATE VISIBLE,
  "DELIVERY_DATE" DATE VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of ORDERS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1', 'asif', TO_DATE('2022-01-16 15:51:04', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-01-17 15:51:25', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('2', 'asif', TO_DATE('2022-01-18 15:52:17', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-02-06 10:40:47', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('3', 'chorn', TO_DATE('2022-01-01 15:52:40', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-01-02 15:52:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('4', 'chorn', TO_DATE('2022-01-10 15:53:37', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-01-11 15:53:51', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('5', 'sarah123', TO_DATE('2022-01-17 15:54:13', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1004', 'richwell', TO_DATE('2022-02-18 21:00:35', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1005', 'richwell', TO_DATE('2022-02-18 21:01:58', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1006', 'richwell', TO_DATE('2022-02-18 21:03:37', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1007', 'richwell', TO_DATE('2022-02-18 21:05:38', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1040', 'skinnynick', TO_DATE('2022-02-23 01:47:58', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1041', 'asif', TO_DATE('2022-02-23 12:21:38', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1060', 'asif', TO_DATE('2022-02-24 22:42:07', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1061', 'monir', TO_DATE('2022-02-24 23:05:15', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1062', 'naim', TO_DATE('2022-02-25 00:00:41', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1080', 'mehrab', TO_DATE('2022-02-25 02:27:12', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1001', 'asif', TO_DATE('2022-02-18 20:53:56', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1002', 'asif', TO_DATE('2022-02-18 20:54:27', 'SYYYY-MM-DD HH24:MI:SS'), NULL);
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1003', 'richwell', TO_DATE('2022-02-18 20:56:18', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-02-18 20:58:49', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1000', 'asif', TO_DATE('2022-02-18 20:37:04', 'SYYYY-MM-DD HH24:MI:SS'), TO_DATE('2022-02-18 20:52:58', 'SYYYY-MM-DD HH24:MI:SS'));
INSERT INTO "BOOKKEEPER"."ORDERS" VALUES ('1020', 'chorn', TO_DATE('2022-02-22 01:18:39', 'SYYYY-MM-DD HH24:MI:SS'), NULL);

-- ----------------------------
-- Table structure for ORDER_BOOK
-- ----------------------------
DROP TABLE "BOOKKEEPER"."ORDER_BOOK";
CREATE TABLE "BOOKKEEPER"."ORDER_BOOK" (
  "ORDER_ID" NUMBER VISIBLE NOT NULL,
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL,
  "UNIT_PRICE" NUMBER(10,2) VISIBLE,
  "QUANTITY" NUMBER VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of ORDER_BOOK
-- ----------------------------
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1', '9780553213102', '300', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1', '9780141036144', '200', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('2', '9780142437179', '120', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('3', '9780486290300', '600', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('4', '9780670034697', '1500', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('5', '9780141036144', '230', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('5', '9780143058144', '400', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('5', '9780141182803', '300', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1004', '9780553213102', '500', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1004', '9781439550410', '870', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1005', '9780143035008', '390', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1006', '9780143058144', '700', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1007', '9780142437179', '250', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1040', '9780141182803', '1620', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1040', '9780486290300', '120', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1040', '9780670034697', '1170', '3');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1041', '9780141182803', '1620', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1041', '9780142437179', '250', '3');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1041', '9780486290300', '120', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1041', '9780553213102', '500', '3');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1060', '9780143035008', '390', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1061', '9780143035008', '390', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1061', '9780670034697', '1170', '3');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1062', '9780141036144', '400', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1080', '9780141182803', '1620', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1080', '9780743273565', '441', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1001', '9780670034697', '1170', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1002', '9780141182803', '1620', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1003', '9780141036144', '400', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1003', '9780142437179', '250', '3');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1003', '9780553213102', '500', '3');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1003', '9780670034697', '1170', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1000', '9780743273565', '441', '3');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1000', '9781439550410', '870', '1');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1020', '9780141182803', '1620', '4');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1020', '9780486290300', '120', '2');
INSERT INTO "BOOKKEEPER"."ORDER_BOOK" VALUES ('1020', '9780743273565', '441', '1');

-- ----------------------------
-- Table structure for PLANS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."PLANS";
CREATE TABLE "BOOKKEEPER"."PLANS" (
  "PLAN_ID" NUMBER VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73470".nextval NOT NULL,
  "NAME" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "PERIOD" NUMBER VISIBLE,
  "BORROW_LIMIT" NUMBER VISIBLE,
  "PRICE" NUMBER(10,2) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of PLANS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."PLANS" VALUES ('1', 'Starter', '30', '0', '100');
INSERT INTO "BOOKKEEPER"."PLANS" VALUES ('2', 'Basic', '30', '1', '300');
INSERT INTO "BOOKKEEPER"."PLANS" VALUES ('3', 'Advanced', '90', '5', '500');
INSERT INTO "BOOKKEEPER"."PLANS" VALUES ('4', 'Nerd', '180', '10', '700');
INSERT INTO "BOOKKEEPER"."PLANS" VALUES ('5', 'Pro', '365', '15', '1000');

-- ----------------------------
-- Table structure for PUBLISHERS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."PUBLISHERS";
CREATE TABLE "BOOKKEEPER"."PUBLISHERS" (
  "PUBLISHER_ID" NUMBER VISIBLE DEFAULT "BOOKKEEPER"."ISEQ$$_73269".nextval NOT NULL,
  "NAME" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "OFFICE_LOCATION" VARCHAR2(256 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of PUBLISHERS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."PUBLISHERS" VALUES ('2', 'Bantam Classic', '9685 Jordan Corner, Durantown, New York City, New York, USA');
INSERT INTO "BOOKKEEPER"."PUBLISHERS" VALUES ('3', 'Signet Classic', '7447 Armstrong Street, East Keithfurt, New York City, New York, USA');
INSERT INTO "BOOKKEEPER"."PUBLISHERS" VALUES ('4', 'Penguin Books', 'PSC 6372, Box 5229, APO AE 88881');
INSERT INTO "BOOKKEEPER"."PUBLISHERS" VALUES ('5', 'Scribner', '38261 Hodges Springs, Barberfurt, RI 64304');
INSERT INTO "BOOKKEEPER"."PUBLISHERS" VALUES ('1', 'Arrow Books', '417 Reynolds Springs Suite 941, Emilyfort, VT 61812');
INSERT INTO "BOOKKEEPER"."PUBLISHERS" VALUES ('6', 'Warner Books', '425 Williams Freeway, New Jessica, OH 11631');
INSERT INTO "BOOKKEEPER"."PUBLISHERS" VALUES ('1000', 'Sheba Prokashoni', 'dummy');

-- ----------------------------
-- Table structure for PUBLISHER_CONTACT_NUMBER
-- ----------------------------
DROP TABLE "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER";
CREATE TABLE "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" (
  "PUBLISHER_ID" NUMBER VISIBLE NOT NULL,
  "CONTACT_NUMBER" VARCHAR2(32 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of PUBLISHER_CONTACT_NUMBER
-- ----------------------------
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('1', '319-395-7833');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('1', '877-363-6889');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('2', '212-572-6066');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('3', '212-485-6936');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('4', '800-733-3000');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('4', '978-750-8400');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('5', '910-695-8884');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('5', '910-695-8886');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('6', '212-522-7200');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('6', '800-759-0190');
INSERT INTO "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" VALUES ('1000', '8801451254601');

-- ----------------------------
-- Table structure for REQUESTS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."REQUESTS";
CREATE TABLE "BOOKKEEPER"."REQUESTS" (
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of REQUESTS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."REQUESTS" VALUES ('asif', '9780143058144');
INSERT INTO "BOOKKEEPER"."REQUESTS" VALUES ('asif', '9781439550410');
INSERT INTO "BOOKKEEPER"."REQUESTS" VALUES ('mehrab', '9780143035008');
INSERT INTO "BOOKKEEPER"."REQUESTS" VALUES ('monir', '9780141182803');
INSERT INTO "BOOKKEEPER"."REQUESTS" VALUES ('naim', '9780143035008');
INSERT INTO "BOOKKEEPER"."REQUESTS" VALUES ('pappu', '9780141036144');
INSERT INTO "BOOKKEEPER"."REQUESTS" VALUES ('richwell', '9780141036144');
INSERT INTO "BOOKKEEPER"."REQUESTS" VALUES ('skinnynick', '9780141182803');

-- ----------------------------
-- Table structure for REVIEWS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."REVIEWS";
CREATE TABLE "BOOKKEEPER"."REVIEWS" (
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL,
  "RATING" NUMBER VISIBLE,
  "FEEDBACK" VARCHAR2(256 BYTE) VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of REVIEWS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('richwell', '9780141036144', '5', 'One of the best dystopian fiction I have ever read');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('skinnynick', '9780143058144', '4', NULL);
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('skinnynick', '9780099908401', '4', 'loved it from start to finish 
I can''t think of another book to recommend other than this one.');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('skinnynick', '9780670034697', '4', 'I never thought I have the time to finish it. But here I am. Enjoyed reading all along');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('sarah123', '9781439550410', '4', 'nice');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('chorn', '9780743273565', '4', 'Loved the story-telling! Highly recommended.');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('chorn', '9780099908401', '5', 'Good book I must say!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('chorn', '9780142437179', '4', 'This book always takes me back to childhood! Awesome read.');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780486290300', '5', 'Such a strong interpretation of human life!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780143058144', '5', 'Really loved the story!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780670034697', '3', 'Expected better ending :(');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('richwell', '9780743273565', '3', 'মোটামুটি লেগেছে!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780141182803', '4', 'Good read indeed!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780553213102', '4', 'Good read indeed!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9781439550410', '4', 'good read indeed!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('monir', '9780143058144', '3', 'Average');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780099908401', '4', 'good book indeed!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780141036144', '4', 'good book indeed!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('mehrab', '9780743273565', '4', 'Very nice book!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('richwell', '9780142437179', '5', 'Amazing Book!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780743273565', '4', 'Good read indeed!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('asif', '9780142437179', '4', 'good book indeed!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('skinnynick', '9780143035008', '3', 'Demo');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('richwell', '9780143035008', '4', 'Loved it!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('richwell', '9781439550410', '3', 'Average. Expected better imo.');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('sarah123', '9780553213102', '4', 'Amazing book to be honest. Liked it much!');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('sarah123', '9780143035008', '4', 'Very Nice Book');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('richwell', '9780553213102', '3', 'The ending could be better');
INSERT INTO "BOOKKEEPER"."REVIEWS" VALUES ('chorn', '9780141182803', '4', 'Awesome review');

-- ----------------------------
-- Table structure for SUBSCRIBERS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."SUBSCRIBERS";
CREATE TABLE "BOOKKEEPER"."SUBSCRIBERS" (
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "MEMBERSHIP_BOUGHT_ON" DATE VISIBLE,
  "PLAN_ID" NUMBER VISIBLE
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of SUBSCRIBERS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('asif', TO_DATE('2022-01-17 15:32:49', 'SYYYY-MM-DD HH24:MI:SS'), '5');
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('chorn', TO_DATE('2022-02-23 06:12:39', 'SYYYY-MM-DD HH24:MI:SS'), '4');
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('anik', TO_DATE('2022-02-23 12:24:18', 'SYYYY-MM-DD HH24:MI:SS'), '3');
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('richwell', TO_DATE('2022-02-22 23:55:40', 'SYYYY-MM-DD HH24:MI:SS'), '3');
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('monir', TO_DATE('2022-02-24 23:03:54', 'SYYYY-MM-DD HH24:MI:SS'), '2');
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('pappu', TO_DATE('2022-02-24 22:05:49', 'SYYYY-MM-DD HH24:MI:SS'), '3');
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('naim', TO_DATE('2022-02-24 23:58:27', 'SYYYY-MM-DD HH24:MI:SS'), '3');
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('mehrab', TO_DATE('2022-02-25 02:25:51', 'SYYYY-MM-DD HH24:MI:SS'), '3');
INSERT INTO "BOOKKEEPER"."SUBSCRIBERS" VALUES ('skinnynick', TO_DATE('2022-02-23 01:40:18', 'SYYYY-MM-DD HH24:MI:SS'), '1');

-- ----------------------------
-- Table structure for WISHLISTS
-- ----------------------------
DROP TABLE "BOOKKEEPER"."WISHLISTS";
CREATE TABLE "BOOKKEEPER"."WISHLISTS" (
  "CUSTOMER_ID" VARCHAR2(64 BYTE) VISIBLE NOT NULL,
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of WISHLISTS
-- ----------------------------
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('asif', '9780141182803');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('asif', '9780486290300');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('chorn', '9780143035008');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('chorn', '9781439550410');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('pappu', '9780670034697');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('richwell', '9780141036144');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('richwell', '9780553213102');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('skinnynick', '9780141182803');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('tz', '9780141036144');
INSERT INTO "BOOKKEEPER"."WISHLISTS" VALUES ('tz', '9780553213102');

-- ----------------------------
-- Table structure for WRITES
-- ----------------------------
DROP TABLE "BOOKKEEPER"."WRITES";
CREATE TABLE "BOOKKEEPER"."WRITES" (
  "AUTHOR_ID" NUMBER VISIBLE NOT NULL,
  "ISBN" VARCHAR2(16 BYTE) VISIBLE NOT NULL
)
LOGGING
NOCOMPRESS
PCTFREE 10
INITRANS 1
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
)
PARALLEL 1
NOCACHE
DISABLE ROW MOVEMENT
;

-- ----------------------------
-- Records of WRITES
-- ----------------------------
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('1', '9780553213102');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('2', '9780141036144');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('3', '9780743273565');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('4', '9780143058144');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('5', '9780142437179');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('6', '9780143035008');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('6', '9780670034697');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('7', '9780099908401');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('8', '9780486290300');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('9', '9780141182803');
INSERT INTO "BOOKKEEPER"."WRITES" VALUES ('10', '9781439550410');

-- ----------------------------
-- Function structure for ACCEPT_BORROW_REQUEST
-- ----------------------------
CREATE OR REPLACE
FUNCTION "BOOKKEEPER"."ACCEPT_BORROW_REQUEST" AS
BEGIN
		REMOVE_EXPIRED_SUBSCRIBERS(ARG_CURRENT_DATE);
		SELECT COUNT(*) INTO CNT_SUB FROM SUBSCRIBERS WHERE CUSTOMER_ID = ARG_CUSTOMER_ID;

		IF CNT_SUB = 0 THEN
            RETURN 1;
        END IF;
		SELECT COUNT(*) INTO CNT_BOOKS_IN_BORROWS
		FROM BORROWS A
		INNER JOIN BORROWABLE_ITEMS B USING(BORROWABLE_ITEM_ID)
		WHERE A.CUSTOMER_ID = ARG_CUSTOMER_ID AND B.ISBN = ARG_ISBN;

		IF CNT_BOOKS_IN_BORROWS <> 0 THEN
			RETURN 4;
		END IF;

		SELECT COUNT(*) INTO CNT_ALREADY_BORROWED FROM BORROWS WHERE CUSTOMER_ID = ARG_CUSTOMER_ID;
		SELECT P.BORROW_LIMIT INTO CNT_LIMIT
		    FROM PLANS P
		    WHERE P.PLAN_ID = (
		        SELECT S.PLAN_ID
		        FROM SUBSCRIBERS S
		        WHERE S.CUSTOMER_ID = ARG_CUSTOMER_ID
		    );
		IF CNT_LIMIT <= CNT_ALREADY_BORROWED THEN
            RETURN 2;
        END IF;
		SELECT BORROWABLE_ITEM_ID INTO B_ID
		FROM
		(((SELECT BORROWABLE_ITEM_ID FROM BORROWABLE_ITEMS WHERE ISBN = ARG_ISBN)
	    MINUS
	    (SELECT BORROWABLE_ITEM_ID FROM BORROWS WHERE END_DATE IS NULL))
	    MINUS
	    (SELECT BORROWABLE_ITEM_ID FROM EXPIRED))
		WHERE ROWNUM = 1;

        INSERT INTO
            BORROWS(BORROWABLE_ITEM_ID, CUSTOMER_ID, START_DATE)
            VALUES (B_ID, ARG_CUSTOMER_ID, ARG_CURRENT_DATE);

		RETURN 0;

	EXCEPTION
	    WHEN NO_DATA_FOUND THEN
        RETURN 3;

	END;
/

-- ----------------------------
-- Function structure for ADD_BOOK_TO_BORROWABLE
-- ----------------------------
CREATE OR REPLACE
FUNCTION "BOOKKEEPER"."ADD_BOOK_TO_BORROWABLE" AS
BEGIN
        SELECT QUANTITY INTO V_QUANTITY FROM BOOKS WHERE ISBN = ARG_ISBN;
        IF V_QUANTITY = 0 THEN
            RETURN V_QUANTITY;
        END IF;

        INSERT INTO BORROWABLE_ITEMS(ISBN) VALUES (ARG_ISBN);

        SELECT QUANTITY INTO V_QUANTITY FROM BOOKS WHERE ISBN = ARG_ISBN;
        RETURN V_QUANTITY;

        EXCEPTION
         WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END;
/

-- ----------------------------
-- Function structure for CHECK_BOOK_STOCK
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."CHECK_BOOK_STOCK" AS
BEGIN
	FLAG := 1;

	FOR R IN (SELECT * FROM CARTS WHERE CUSTOMER_ID = ARG_CUSTOMER_ID)

	LOOP 
		REQ_QNT := R.QUANTITY;
		dbms_output.put_line(REQ_QNT);
		SELECT QUANTITY INTO AVL_QNT FROM BOOKS WHERE ISBN = R.ISBN;

		IF AVL_QNT < REQ_QNT THEN
			FLAG := 0;
		END IF;
	END LOOP;

-- EXCEPTION
-- 	WHEN OTHERS THEN
-- 		dbms_output.put_line('ERROR');
END;
/

-- ----------------------------
-- Function structure for INSERT_AUTHOR_INFO
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."INSERT_AUTHOR_INFO" AS
BEGIN
		A_ID := AUTHOR_ID_AUTOINCREMENT_SEQ.NEXTVAL;
		INSERT INTO AUTHORS (
			AUTHOR_ID,
			NAME,
			DOB,
			DOD,
			ABOUT
		) VALUES (
			A_ID,
			ARG_NAME,
			ARG_DOB,
			ARG_DOD,
			ARG_ABOUT
		);
		RET_AUTHOR_ID := A_ID;
	END;
/

-- ----------------------------
-- Function structure for INSERT_BOOK_INFO
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."INSERT_BOOK_INFO" AS
BEGIN
		INSERT INTO BOOKS(
				ISBN,
				NAME,
				EDITION,
				RELEASE_DATE,
				PRICE,
				PAGE_COUNT,
				QUANTITY,
				PUBLISHER_ID
			) VALUES (
				ARG_ISBN,
				INITCAP(ARG_BOOKNAME),
				ARG_EDITION,
				ARG_RELEASE_DATE,
				ARG_PRICE,
				ARG_PAGE_COUNT,
				ARG_QUANTITY,
				ARG_PUBLISHER_ID
			);
		SELECT COUNT(*) INTO CNT_BOOK_IN_WRITES FROM WRITES WHERE AUTHOR_ID=ARG_AUTHOR_ID AND ISBN=ARG_ISBN;
		IF CNT_BOOK_IN_WRITES = 0 THEN
			INSERT INTO WRITES(
					AUTHOR_ID,
					ISBN
				) VALUES (
					ARG_AUTHOR_ID,
					ARG_ISBN
				);
		END IF;
		COMMIT;
	END;
/

-- ----------------------------
-- Function structure for INSERT_UPDATE_CART
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."INSERT_UPDATE_CART" AS
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

-- ----------------------------
-- Function structure for MAKE_ORDER
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."MAKE_ORDER" AS
BEGIN
        SELECT COUNT(*) INTO CNT_CSTMR_IN_CARTS FROM CARTS WHERE CUSTOMER_ID = ARG_CUSTOMER_ID;
        IF CNT_CSTMR_IN_CARTS <> 0 THEN
            IS_SOME_ORDER_VALID := 0;

            FOR R IN (
                    SELECT ISBN, B.PRICE AS B_PRICE, B.QUANTITY AS B_QUANTITY, CRT.QUANTITY AS CRT_QUANTITY, TOTAL_DCT_PCT AS OFR_TOTAL_DCT_PCT
                    FROM BOOKS B
                    INNER JOIN CARTS CRT USING (ISBN)
                    LEFT OUTER JOIN
                        (
                            SELECT SUM(DISCOUNT_PCT) AS TOTAL_DCT_PCT, ISBN
                            FROM OFFER_BOOK
                            INNER JOIN OFFERS USING(OFFER_ID)
                            WHERE (START_DATE + PERIOD) >= ARG_ORDERING_DATE AND START_DATE <= ARG_ORDERING_DATE
                            GROUP BY ISBN -- UNNECESSARY. AS ISBN IS A PK IN OFFER_BOOK BUT STILL
                        ) OFR USING (ISBN) WHERE CUSTOMER_ID = ARG_CUSTOMER_ID
                )
                LOOP

                ORDR_QUANTITY := LEAST(R.CRT_QUANTITY, R.B_QUANTITY);
                IF ORDR_QUANTITY <> 0 THEN
                    IF IS_SOME_ORDER_VALID = 0 THEN
                        -- THIS BLOCK SHOULD RUN ONCE
                        IS_SOME_ORDER_VALID := 1;
                        O_ID := ORDER_ID_AUTOINCREMENT_SEQ.NEXTVAL;
                        INSERT INTO ORDERS (ORDER_ID, CUSTOMER_ID, ORDERING_DATE) VALUES (O_ID, ARG_CUSTOMER_ID, ARG_ORDERING_DATE);
                    END IF;

                    U_PRICE := R.B_PRICE * (1.0 - NVL(R.OFR_TOTAL_DCT_PCT, 0));

                    INSERT INTO ORDER_BOOK(ORDER_ID, ISBN, UNIT_PRICE, QUANTITY) VALUES (O_ID, R.ISBN, U_PRICE, ORDR_QUANTITY);
                    UPDATE BOOKS B2 SET B2.QUANTITY = B2.QUANTITY - ORDR_QUANTITY WHERE B2.ISBN = R.ISBN;

                    UPDATE CARTS CRT2 SET CRT2.QUANTITY = CRT2.QUANTITY - ORDR_QUANTITY WHERE CRT2.CUSTOMER_ID = ARG_CUSTOMER_ID AND CRT2.ISBN = R.ISBN;
                    DELETE FROM CARTS CRT2 WHERE CRT2.CUSTOMER_ID = ARG_CUSTOMER_ID AND CRT2.ISBN = R.ISBN AND CRT2.QUANTITY <= 0;


                END IF;

                END LOOP;
        END IF;
    END;
/

-- ----------------------------
-- Function structure for POST_REVIEW
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."POST_REVIEW" AS
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

-- ----------------------------
-- Function structure for REMOVE_EXPIRED_SUBSCRIBERS
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."REMOVE_EXPIRED_SUBSCRIBERS" AS
BEGIN
		DELETE FROM SUBSCRIBERS WHERE CUSTOMER_ID IN (
				SELECT S.CUSTOMER_ID
				FROM SUBSCRIBERS S
				INNER JOIN PLANS P USING(PLAN_ID)
				WHERE S.MEMBERSHIP_BOUGHT_ON+P.PERIOD < ARG_CURRENT_DATE
				);
	END;
/

-- ----------------------------
-- Function structure for REQUEST_TO_BORROW
-- ----------------------------
CREATE OR REPLACE
FUNCTION "BOOKKEEPER"."REQUEST_TO_BORROW" AS
BEGIN
        REMOVE_EXPIRED_SUBSCRIBERS(ARG_CURRENT_TIME);
        SELECT COUNT(*) INTO CNT_SUBSCRIBERS FROM SUBSCRIBERS WHERE CUSTOMER_ID = ARG_CUSTOMER_ID;
        IF CNT_SUBSCRIBERS = 0 THEN
            RETURN 1;
        END IF;

        SELECT COUNT(*) INTO CNT_BOOK_WITH_SAME_ISBN_IN_REQUESTS
        FROM REQUESTS
        WHERE CUSTOMER_ID =ARG_CUSTOMER_ID
        AND ISBN = ARG_CUSTOMER_ID;

        IF CNT_BOOK_WITH_SAME_ISBN_IN_REQUESTS <> 0 THEN
            RETURN 2;
        END IF;

        SELECT COUNT(*) INTO CNT_BOOK_WITH_SAME_ISBN_IN_BORROWS
        FROM BORROWABLE_ITEMS B_ITEM
        WHERE ISBN = ARG_ISBN
        AND BORROWABLE_ITEM_ID IN (
            SELECT BORROWABLE_ITEM_ID FROM BORROWS WHERE CUSTOMER_ID = ARG_CUSTOMER_ID
            );

        IF CNT_BOOK_WITH_SAME_ISBN_IN_BORROWS <> 0 THEN
            RETURN 3;
        END IF;

        INSERT INTO REQUESTS(CUSTOMER_ID, ISBN) VALUES (ARG_CUSTOMER_ID, ARG_ISBN);
        RETURN 0;
    END;
/

-- ----------------------------
-- Function structure for UPDATE_BOOK_INFO
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."UPDATE_BOOK_INFO" AS
BEGIN
		SELECT COUNT(*) INTO CNT_BOOK FROM BOOKS WHERE ISBN=ARG_ISBN;
		SELECT COUNT(*) INTO CNT_AUTHOR FROM AUTHORS WHERE AUTHOR_ID=ARG_AUTHOR_ID;
		SELECT COUNT(*) INTO CNT_PUBLISHER FROM PUBLISHERS WHERE PUBLISHER_ID=ARG_PUBLISHER_ID;
		SELECT COUNT(*) INTO CNT_PK_IN_WRITES FROM WRITES WHERE AUTHOR_ID = ARG_AUTHOR_ID AND ISBN = ARG_ISBN;

		IF CNT_BOOK <> 0 AND CNT_AUTHOR <> 0 AND CNT_PUBLISHER <> 0 THEN
			UPDATE BOOKS
			SET
				NAME = INITCAP(ARG_BOOKNAME),
				EDITION = INITCAP(ARG_EDITION),
				RELEASE_DATE = ARG_RELEASE_DATE,
				PRICE = ARG_PRICE,
				PAGE_COUNT = ARG_PAGE_COUNT,
				QUANTITY = ARG_QUANTITY,
				PUBLISHER_ID = ARG_PUBLISHER_ID
			WHERE ISBN=ARG_ISBN;

			IF CNT_PK_IN_WRITES = 0 THEN
				DELETE FROM WRITES WHERE ISBN = ARG_ISBN;
				INSERT INTO WRITES (AUTHOR_ID, ISBN) VALUES(ARG_AUTHOR_ID, ARG_ISBN);
			END IF;

		END IF;
	END;
/

-- ----------------------------
-- Function structure for UPDATE_OFFER_BOOK_INFO
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."UPDATE_OFFER_BOOK_INFO" AS
BEGIN
		SELECT COUNT(*) INTO CNT_OFFER_BOOK FROM OFFER_BOOK WHERE ISBN = ARG_ISBN;
		IF ARG_OFFER_ID IS NULL THEN
			DELETE FROM OFFER_BOOK WHERE ISBN = ARG_ISBN;
			RETURN;
		END IF;

		SELECT COUNT(*) INTO CNT_OFFER FROM OFFERS WHERE OFFER_ID = ARG_OFFER_ID AND START_DATE >= SYSDATE-PERIOD;
		IF CNT_OFFER <> 0 THEN
			IF CNT_OFFER_BOOK = 0 THEN
				INSERT INTO OFFER_BOOK (ISBN, OFFER_ID) VALUES(ARG_ISBN, ARG_OFFER_ID);
			ELSE
				UPDATE OFFER_BOOK SET OFFER_ID = ARG_OFFER_ID WHERE ISBN = ARG_ISBN;
			END IF;

		END IF;



	END;
/

-- ----------------------------
-- Function structure for UPDATE_PERSONAL_INFO
-- ----------------------------
CREATE OR REPLACE
PROCEDURE "BOOKKEEPER"."UPDATE_PERSONAL_INFO" AS
BEGIN
			UPDATE CUSTOMERS
			SET
				NAME = INITCAP(ARG_NAME),
				EMAIL = ARG_EMAIL,
				ADDRESS = INITCAP(ARG_ADDRESS)
			WHERE CUSTOMER_ID=ARG_CID;
	END;
/

-- ----------------------------
-- Sequence structure for AUTHOR_ID_AUTOINCREMENT_SEQ
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."AUTHOR_ID_AUTOINCREMENT_SEQ";
CREATE SEQUENCE "BOOKKEEPER"."AUTHOR_ID_AUTOINCREMENT_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_72951
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_72951";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_72951" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_72982
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_72982";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_72982" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_72987
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_72987";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_72987" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_72992
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_72992";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_72992" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_72997
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_72997";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_72997" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73009
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73009";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73009" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73012
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73012";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73012" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73084
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73084";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73084" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73087
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73087";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73087" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73091
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73091";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73091" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73094
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73094";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73094" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73098
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73098";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73098" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73101
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73101";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73101" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73105
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73105";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73105" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73108
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73108";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73108" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73122
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73122";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73122" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73230
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73230";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73230" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73233
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73233";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73233" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73269
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73269";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73269" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73274
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73274";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73274" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73279
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73279";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73279" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73284
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73284";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73284" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73296
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73296";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73296" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73299
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73299";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73299" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73467
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73467";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73467" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73470
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73470";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73470" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73561
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73561";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73561" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ISEQ$$_73564
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ISEQ$$_73564";
CREATE SEQUENCE "BOOKKEEPER"."ISEQ$$_73564" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for ORDER_ID_AUTOINCREMENT_SEQ
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."ORDER_ID_AUTOINCREMENT_SEQ";
CREATE SEQUENCE "BOOKKEEPER"."ORDER_ID_AUTOINCREMENT_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Sequence structure for PUBLISHER_ID_AUTOINCREMENT_SEQ
-- ----------------------------
DROP SEQUENCE "BOOKKEEPER"."PUBLISHER_ID_AUTOINCREMENT_SEQ";
CREATE SEQUENCE "BOOKKEEPER"."PUBLISHER_ID_AUTOINCREMENT_SEQ" MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 CACHE 20;

-- ----------------------------
-- Primary Key structure for table AUTHORS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTHORS" ADD CONSTRAINT "SYS_C007830" PRIMARY KEY ("AUTHOR_ID");

-- ----------------------------
-- Checks structure for table AUTHORS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTHORS" ADD CONSTRAINT "SYS_C007827" CHECK ("AUTHOR_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTHORS" ADD CONSTRAINT "SYS_C007828" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTHORS" ADD CONSTRAINT "SYS_C007829" CHECK (DOD>DOB) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table AUTHORS
-- ----------------------------
CREATE TRIGGER "BOOKKEEPER"."AUTHOR_ID_AUTOINCREMENT" BEFORE INSERT ON "BOOKKEEPER"."AUTHORS" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE

BEGIN
	IF :NEW.AUTHOR_ID IS NULL THEN
		:NEW.AUTHOR_ID := AUTHOR_ID_AUTOINCREMENT_SEQ.NEXTVAL;
	END IF;


END;
/
CREATE TRIGGER "BOOKKEEPER"."CLEAN_WRITES_FOR_AUTHORS" AFTER DELETE ON "BOOKKEEPER"."AUTHORS" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE

BEGIN
	DELETE FROM WRITES WHERE AUTHOR_ID = :OLD.AUTHOR_ID;
END;
/

-- ----------------------------
-- Primary Key structure for table AUTH_GROUP
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_GROUP" ADD CONSTRAINT "SYS_C007667" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table AUTH_GROUP
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_GROUP" ADD CONSTRAINT "SYS_C007668" UNIQUE ("NAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table AUTH_GROUP
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_GROUP" ADD CONSTRAINT "SYS_C007666" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table AUTH_GROUP_PERMISSIONS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS" ADD CONSTRAINT "SYS_C007672" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table AUTH_GROUP_PERMISSIONS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS" ADD CONSTRAINT "AUTH_GROU_GROUP_ID__0CD325B0_U" UNIQUE ("GROUP_ID", "PERMISSION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table AUTH_GROUP_PERMISSIONS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS" ADD CONSTRAINT "SYS_C007669" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS" ADD CONSTRAINT "SYS_C007670" CHECK ("GROUP_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS" ADD CONSTRAINT "SYS_C007671" CHECK ("PERMISSION_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table AUTH_GROUP_PERMISSIONS
-- ----------------------------
CREATE INDEX "BOOKKEEPER"."AUTH_GROUP_GROUP_ID_B120CBF9"
  ON "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS" ("GROUP_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;
CREATE INDEX "BOOKKEEPER"."AUTH_GROUP_PERMISSION_84C5C92E"
  ON "BOOKKEEPER"."AUTH_GROUP_PERMISSIONS" ("PERMISSION_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;

-- ----------------------------
-- Primary Key structure for table AUTH_PERMISSION
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_PERMISSION" ADD CONSTRAINT "SYS_C007665" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table AUTH_PERMISSION
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_PERMISSION" ADD CONSTRAINT "AUTH_PERM_CONTENT_T_01AB375A_U" UNIQUE ("CONTENT_TYPE_ID", "CODENAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table AUTH_PERMISSION
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_PERMISSION" ADD CONSTRAINT "SYS_C007663" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_PERMISSION" ADD CONSTRAINT "SYS_C007664" CHECK ("CONTENT_TYPE_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table AUTH_PERMISSION
-- ----------------------------
CREATE INDEX "BOOKKEEPER"."AUTH_PERMI_CONTENT_TY_2F476E4B"
  ON "BOOKKEEPER"."AUTH_PERMISSION" ("CONTENT_TYPE_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;

-- ----------------------------
-- Primary Key structure for table AUTH_USER
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007682" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table AUTH_USER
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007683" UNIQUE ("USERNAME") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table AUTH_USER
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007673" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007675" CHECK ("IS_SUPERUSER" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007676" CHECK ("IS_STAFF" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007677" CHECK ("IS_ACTIVE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007678" CHECK ("DATE_JOINED" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007679" CHECK ("IS_SUPERUSER" IN (0,1)) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007680" CHECK ("IS_STAFF" IN (0,1)) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER" ADD CONSTRAINT "SYS_C007681" CHECK ("IS_ACTIVE" IN (0,1)) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table AUTH_USER_GROUPS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER_GROUPS" ADD CONSTRAINT "SYS_C007687" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table AUTH_USER_GROUPS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER_GROUPS" ADD CONSTRAINT "AUTH_USER_USER_ID_G_94350C0C_U" UNIQUE ("USER_ID", "GROUP_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table AUTH_USER_GROUPS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER_GROUPS" ADD CONSTRAINT "SYS_C007684" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER_GROUPS" ADD CONSTRAINT "SYS_C007685" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER_GROUPS" ADD CONSTRAINT "SYS_C007686" CHECK ("GROUP_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table AUTH_USER_GROUPS
-- ----------------------------
CREATE INDEX "BOOKKEEPER"."AUTH_USER__GROUP_ID_97559544"
  ON "BOOKKEEPER"."AUTH_USER_GROUPS" ("GROUP_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;
CREATE INDEX "BOOKKEEPER"."AUTH_USER__USER_ID_6A12ED8B"
  ON "BOOKKEEPER"."AUTH_USER_GROUPS" ("USER_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;

-- ----------------------------
-- Primary Key structure for table AUTH_USER_USER_PERMISSIONS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS" ADD CONSTRAINT "SYS_C007691" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table AUTH_USER_USER_PERMISSIONS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS" ADD CONSTRAINT "AUTH_USER_USER_ID_P_14A6B632_U" UNIQUE ("USER_ID", "PERMISSION_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table AUTH_USER_USER_PERMISSIONS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS" ADD CONSTRAINT "SYS_C007688" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS" ADD CONSTRAINT "SYS_C007689" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS" ADD CONSTRAINT "SYS_C007690" CHECK ("PERMISSION_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table AUTH_USER_USER_PERMISSIONS
-- ----------------------------
CREATE INDEX "BOOKKEEPER"."AUTH_USER__PERMISSION_1FBB5F2C"
  ON "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS" ("PERMISSION_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;
CREATE INDEX "BOOKKEEPER"."AUTH_USER__USER_ID_A95EAD1B"
  ON "BOOKKEEPER"."AUTH_USER_USER_PERMISSIONS" ("USER_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;

-- ----------------------------
-- Primary Key structure for table BOOKS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BOOKS" ADD CONSTRAINT "SYS_C007821" PRIMARY KEY ("ISBN");

-- ----------------------------
-- Checks structure for table BOOKS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BOOKS" ADD CONSTRAINT "SYS_C007817" CHECK ("ISBN" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."BOOKS" ADD CONSTRAINT "SYS_C007818" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."BOOKS" ADD CONSTRAINT "SYS_C007819" CHECK ("PRICE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."BOOKS" ADD CONSTRAINT "SYS_C007820" CHECK ("QUANTITY" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table BOOK_TYPE
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BOOK_TYPE" ADD CONSTRAINT "SYS_C007822" PRIMARY KEY ("ISBN", "B_TYPE");

-- ----------------------------
-- Primary Key structure for table BORROWABLE_ITEMS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BORROWABLE_ITEMS" ADD CONSTRAINT "SYS_C007837" PRIMARY KEY ("BORROWABLE_ITEM_ID");

-- ----------------------------
-- Checks structure for table BORROWABLE_ITEMS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BORROWABLE_ITEMS" ADD CONSTRAINT "SYS_C007836" CHECK ("BORROWABLE_ITEM_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table BORROWABLE_ITEMS
-- ----------------------------
CREATE TRIGGER "BOOKKEEPER"."DECREASE_BOOK_QUANTITY_ON_BORROWABLE_INSERT" AFTER INSERT ON "BOOKKEEPER"."BORROWABLE_ITEMS" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
        V_QUANTITY NUMBER;
    BEGIN
        SELECT QUANTITY INTO V_QUANTITY FROM BOOKS WHERE ISBN = :NEW.ISBN;
        IF V_QUANTITY > 0 THEN
            UPDATE BOOKS SET QUANTITY = QUANTITY - 1 WHERE ISBN = :NEW.ISBN;
        END IF;

        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('BOOK NOT AVAILABLE');
    END;
/

-- ----------------------------
-- Primary Key structure for table BORROWS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BORROWS" ADD CONSTRAINT "SYS_C007838" PRIMARY KEY ("BORROWABLE_ITEM_ID", "CUSTOMER_ID");

-- ----------------------------
-- Triggers structure for table BORROWS
-- ----------------------------
CREATE TRIGGER "BOOKKEEPER"."CLEAN_REQUESTS_ON_ACCEPT_BORROW_REQUEST" AFTER INSERT ON "BOOKKEEPER"."BORROWS" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
		V_ISBN VARCHAR2(16);
	BEGIN
		SELECT ISBN INTO V_ISBN FROM BORROWABLE_ITEMS WHERE BORROWABLE_ITEM_ID = :NEW.BORROWABLE_ITEM_ID;
		DELETE FROM REQUESTS WHERE CUSTOMER_ID = :NEW.CUSTOMER_ID AND ISBN = V_ISBN;
	END;
/

-- ----------------------------
-- Primary Key structure for table CARTS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."CARTS" ADD CONSTRAINT "SYS_C007853" PRIMARY KEY ("CUSTOMER_ID", "ISBN");

-- ----------------------------
-- Primary Key structure for table CUSTOMERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."CUSTOMERS" ADD CONSTRAINT "SYS_C007841" PRIMARY KEY ("CUSTOMER_ID");

-- ----------------------------
-- Uniques structure for table CUSTOMERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."CUSTOMERS" ADD CONSTRAINT "SYS_C007842" UNIQUE ("EMAIL") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table CUSTOMERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."CUSTOMERS" ADD CONSTRAINT "SYS_C007839" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."CUSTOMERS" ADD CONSTRAINT "SYS_C007840" CHECK ("EMAIL" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."CUSTOMERS" ADD CONSTRAINT "SYS_C007879" CHECK ("PASSWORD" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table CUSTOMER_CONTACT_NUMBER
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" ADD CONSTRAINT "SYS_C007843" PRIMARY KEY ("CUSTOMER_ID", "CONTACT_NUMBER");

-- ----------------------------
-- Primary Key structure for table DJANGO_ADMIN_LOG
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_ADMIN_LOG" ADD CONSTRAINT "SYS_C007708" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table DJANGO_ADMIN_LOG
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_ADMIN_LOG" ADD CONSTRAINT "SYS_C007703" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."DJANGO_ADMIN_LOG" ADD CONSTRAINT "SYS_C007704" CHECK ("ACTION_TIME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."DJANGO_ADMIN_LOG" ADD CONSTRAINT "SYS_C007705" CHECK ("ACTION_FLAG" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."DJANGO_ADMIN_LOG" ADD CONSTRAINT "SYS_C007706" CHECK ("USER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."DJANGO_ADMIN_LOG" ADD CONSTRAINT "SYS_C007707" CHECK ("ACTION_FLAG" >= 0) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table DJANGO_ADMIN_LOG
-- ----------------------------
CREATE INDEX "BOOKKEEPER"."DJANGO_ADM_CONTENT_TY_C4BCE8EB"
  ON "BOOKKEEPER"."DJANGO_ADMIN_LOG" ("CONTENT_TYPE_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;
CREATE INDEX "BOOKKEEPER"."DJANGO_ADM_USER_ID_C564EBA6"
  ON "BOOKKEEPER"."DJANGO_ADMIN_LOG" ("USER_ID" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;

-- ----------------------------
-- Primary Key structure for table DJANGO_CONTENT_TYPE
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_CONTENT_TYPE" ADD CONSTRAINT "SYS_C007661" PRIMARY KEY ("ID");

-- ----------------------------
-- Uniques structure for table DJANGO_CONTENT_TYPE
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_CONTENT_TYPE" ADD CONSTRAINT "DJANGO_CO_APP_LABEL_76BD3D3B_U" UNIQUE ("APP_LABEL", "MODEL") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Checks structure for table DJANGO_CONTENT_TYPE
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_CONTENT_TYPE" ADD CONSTRAINT "SYS_C007660" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table DJANGO_MIGRATIONS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_MIGRATIONS" ADD CONSTRAINT "SYS_C007659" PRIMARY KEY ("ID");

-- ----------------------------
-- Checks structure for table DJANGO_MIGRATIONS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_MIGRATIONS" ADD CONSTRAINT "SYS_C007657" CHECK ("ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."DJANGO_MIGRATIONS" ADD CONSTRAINT "SYS_C007658" CHECK ("APPLIED" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table DJANGO_SESSION
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_SESSION" ADD CONSTRAINT "SYS_C007713" PRIMARY KEY ("SESSION_KEY");

-- ----------------------------
-- Checks structure for table DJANGO_SESSION
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."DJANGO_SESSION" ADD CONSTRAINT "SYS_C007711" CHECK ("SESSION_KEY" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."DJANGO_SESSION" ADD CONSTRAINT "SYS_C007712" CHECK ("EXPIRE_DATE" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Indexes structure for table DJANGO_SESSION
-- ----------------------------
CREATE INDEX "BOOKKEEPER"."DJANGO_SES_EXPIRE_DAT_A5C62663"
  ON "BOOKKEEPER"."DJANGO_SESSION" ("EXPIRE_DATE" ASC)
  LOGGING
  VISIBLE
PCTFREE 10
INITRANS 2
STORAGE (
  INITIAL 65536 
  NEXT 1048576 
  MINEXTENTS 1
  MAXEXTENTS 2147483645
  BUFFER_POOL DEFAULT
  FLASH_CACHE DEFAULT
)
   USABLE;

-- ----------------------------
-- Primary Key structure for table EXPIRED
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."EXPIRED" ADD CONSTRAINT "SYS_C008011" PRIMARY KEY ("EXPIRED_ID");

-- ----------------------------
-- Checks structure for table EXPIRED
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."EXPIRED" ADD CONSTRAINT "SYS_C008010" CHECK ("EXPIRED_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table MANAGERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."MANAGERS" ADD CONSTRAINT "SYS_C007949" PRIMARY KEY ("ADMIN_ID");

-- ----------------------------
-- Checks structure for table MANAGERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."MANAGERS" ADD CONSTRAINT "SYS_C007948" CHECK ("PASSWORD" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table OFFERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."OFFERS" ADD CONSTRAINT "SYS_C007834" PRIMARY KEY ("OFFER_ID");

-- ----------------------------
-- Checks structure for table OFFERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."OFFERS" ADD CONSTRAINT "SYS_C007832" CHECK ("OFFER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."OFFERS" ADD CONSTRAINT "SYS_C007833" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table OFFERS
-- ----------------------------
CREATE TRIGGER "BOOKKEEPER"."CLEAN_OFFER_BOOK_FOR_OFFERS" AFTER DELETE ON "BOOKKEEPER"."OFFERS" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
	BEGIN
		DELETE FROM OFFER_BOOK WHERE OFFER_ID = :OLD.OFFER_ID;
	END;
/

-- ----------------------------
-- Primary Key structure for table OFFER_BOOK
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."OFFER_BOOK" ADD CONSTRAINT "SYS_C007835" PRIMARY KEY ("ISBN");

-- ----------------------------
-- Primary Key structure for table ORDERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."ORDERS" ADD CONSTRAINT "SYS_C007849" PRIMARY KEY ("ORDER_ID");

-- ----------------------------
-- Checks structure for table ORDERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."ORDERS" ADD CONSTRAINT "SYS_C007848" CHECK ("ORDER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table ORDER_BOOK
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."ORDER_BOOK" ADD CONSTRAINT "SYS_C007850" PRIMARY KEY ("ORDER_ID", "ISBN");

-- ----------------------------
-- Triggers structure for table ORDER_BOOK
-- ----------------------------
CREATE TRIGGER "BOOKKEEPER"."UPDATE_BOOK_QUANTITY_ON_CANCEL_ORDER" AFTER DELETE ON "BOOKKEEPER"."ORDER_BOOK" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
 BEGIN
	UPDATE BOOKS B SET B.QUANTITY = B.QUANTITY + :OLD.QUANTITY WHERE B.ISBN = :OLD.ISBN;
 END;
/

-- ----------------------------
-- Primary Key structure for table PLANS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."PLANS" ADD CONSTRAINT "SYS_C007971" PRIMARY KEY ("PLAN_ID");

-- ----------------------------
-- Checks structure for table PLANS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."PLANS" ADD CONSTRAINT "SYS_C007969" CHECK ("PLAN_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."PLANS" ADD CONSTRAINT "SYS_C007970" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Primary Key structure for table PUBLISHERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."PUBLISHERS" ADD CONSTRAINT "SYS_C007825" PRIMARY KEY ("PUBLISHER_ID");

-- ----------------------------
-- Checks structure for table PUBLISHERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."PUBLISHERS" ADD CONSTRAINT "SYS_C007823" CHECK ("PUBLISHER_ID" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."PUBLISHERS" ADD CONSTRAINT "SYS_C007824" CHECK ("NAME" IS NOT NULL) NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Triggers structure for table PUBLISHERS
-- ----------------------------
CREATE TRIGGER "BOOKKEEPER"."CLEAN_PUBLISHER_CONTACT_NUMBER_FOR_PUBLISHERS" AFTER DELETE ON "BOOKKEEPER"."PUBLISHERS" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
	BEGIN
		DELETE FROM PUBLISHER_CONTACT_NUMBER WHERE PUBLISHER_ID = :OLD.PUBLISHER_ID;
	END;
/

-- ----------------------------
-- Primary Key structure for table PUBLISHER_CONTACT_NUMBER
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" ADD CONSTRAINT "SYS_C007826" PRIMARY KEY ("PUBLISHER_ID", "CONTACT_NUMBER");

-- ----------------------------
-- Primary Key structure for table REQUESTS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."REQUESTS" ADD CONSTRAINT "SYS_C007854" PRIMARY KEY ("CUSTOMER_ID", "ISBN");

-- ----------------------------
-- Primary Key structure for table REVIEWS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."REVIEWS" ADD CONSTRAINT "SYS_C007852" PRIMARY KEY ("CUSTOMER_ID", "ISBN");

-- ----------------------------
-- Primary Key structure for table SUBSCRIBERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."SUBSCRIBERS" ADD CONSTRAINT "SYS_C007844" PRIMARY KEY ("CUSTOMER_ID");

-- ----------------------------
-- Triggers structure for table SUBSCRIBERS
-- ----------------------------
CREATE TRIGGER "BOOKKEEPER"."CLEAN_BORROWS_AND_REQUESTS_FOR_SUBSCRIBERS" AFTER DELETE ON "BOOKKEEPER"."SUBSCRIBERS" REFERENCING OLD AS "OLD" NEW AS "NEW" FOR EACH ROW 
DECLARE
	ARG_ISSUE_DATE DATE;
	BEGIN
		DELETE FROM REQUESTS WHERE CUSTOMER_ID = :OLD.CUSTOMER_ID;
		SELECT (:OLD.MEMBERSHIP_BOUGHT_ON+P.PERIOD) INTO ARG_ISSUE_DATE FROM PLANS P WHERE PLAN_ID = :OLD.PLAN_ID;
		FOR R IN (
				SELECT * FROM BORROWS WHERE CUSTOMER_ID = :OLD.CUSTOMER_ID AND END_DATE IS NULL
							)
			LOOP
				INSERT INTO EXPIRED(CUSTOMER_ID, BORROWABLE_ITEM_ID, ISSUE_DATE) VALUES(R.CUSTOMER_ID, R.BORROWABLE_ITEM_ID, ARG_ISSUE_DATE);
			END LOOP;
		DELETE FROM BORROWS WHERE CUSTOMER_ID=:OLD.CUSTOMER_ID;
	END;
/

-- ----------------------------
-- Primary Key structure for table WISHLISTS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."WISHLISTS" ADD CONSTRAINT "SYS_C007851" PRIMARY KEY ("CUSTOMER_ID", "ISBN");

-- ----------------------------
-- Primary Key structure for table WRITES
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."WRITES" ADD CONSTRAINT "SYS_C007831" PRIMARY KEY ("AUTHOR_ID", "ISBN");

-- ----------------------------
-- Foreign Keys structure for table AUTH_GROUP_PERMISSIONS
-- ----------------------------

-- ----------------------------
-- Foreign Keys structure for table AUTH_PERMISSION
-- ----------------------------

-- ----------------------------
-- Foreign Keys structure for table AUTH_USER_GROUPS
-- ----------------------------

-- ----------------------------
-- Foreign Keys structure for table AUTH_USER_USER_PERMISSIONS
-- ----------------------------

-- ----------------------------
-- Foreign Keys structure for table BOOKS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BOOKS" ADD CONSTRAINT "BOOKS__PUBLISHER_FK" FOREIGN KEY ("PUBLISHER_ID") REFERENCES "BOOKKEEPER"."PUBLISHERS" ("PUBLISHER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BOOK_TYPE
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BOOK_TYPE" ADD CONSTRAINT "BOOK_TYPE__BOOKS" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BORROWABLE_ITEMS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BORROWABLE_ITEMS" ADD CONSTRAINT "BORROWABLE_ITEMS__BOOKS_FK" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table BORROWS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."BORROWS" ADD CONSTRAINT "BORROWS__BORROWABLE_ITEMS_FK" FOREIGN KEY ("BORROWABLE_ITEM_ID") REFERENCES "BOOKKEEPER"."BORROWABLE_ITEMS" ("BORROWABLE_ITEM_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."BORROWS" ADD CONSTRAINT "BORROWS__SUBSCRIBERS_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "BOOKKEEPER"."SUBSCRIBERS" ("CUSTOMER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table CARTS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."CARTS" ADD CONSTRAINT "CARTS__BOOKS_FK" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."CARTS" ADD CONSTRAINT "CARTS__CUSTOMERS_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "BOOKKEEPER"."CUSTOMERS" ("CUSTOMER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table CUSTOMER_CONTACT_NUMBER
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."CUSTOMER_CONTACT_NUMBER" ADD CONSTRAINT "CUSTOMER_CONTACT_NUMBER__CUSTOMERS_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "BOOKKEEPER"."CUSTOMERS" ("CUSTOMER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table DJANGO_ADMIN_LOG
-- ----------------------------

-- ----------------------------
-- Foreign Keys structure for table OFFER_BOOK
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."OFFER_BOOK" ADD CONSTRAINT "OFFER_BOOK__BOOKS_FK" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."OFFER_BOOK" ADD CONSTRAINT "OFFER_BOOK__OFFERS_FK" FOREIGN KEY ("OFFER_ID") REFERENCES "BOOKKEEPER"."OFFERS" ("OFFER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table ORDERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."ORDERS" ADD CONSTRAINT "ORDERS__CUSTOMERS_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "BOOKKEEPER"."CUSTOMERS" ("CUSTOMER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table ORDER_BOOK
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."ORDER_BOOK" ADD CONSTRAINT "ORDER_BOOK__BOOKS_FK" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."ORDER_BOOK" ADD CONSTRAINT "ORDER_BOOK__ORDERS_FK" FOREIGN KEY ("ORDER_ID") REFERENCES "BOOKKEEPER"."ORDERS" ("ORDER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table PUBLISHER_CONTACT_NUMBER
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."PUBLISHER_CONTACT_NUMBER" ADD CONSTRAINT "PUBLISHER_CONTACT_NUMBER__PUBLISHERS_FK" FOREIGN KEY ("PUBLISHER_ID") REFERENCES "BOOKKEEPER"."PUBLISHERS" ("PUBLISHER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table REQUESTS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."REQUESTS" ADD CONSTRAINT "REQUESTS__BOOKS_FK" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."REQUESTS" ADD CONSTRAINT "REQUESTS__SUBSCRIBERS_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "BOOKKEEPER"."SUBSCRIBERS" ("CUSTOMER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table REVIEWS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."REVIEWS" ADD CONSTRAINT "REVIEWS__BOOKS_FK" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."REVIEWS" ADD CONSTRAINT "REVIEWS__CUSTOMERS_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "BOOKKEEPER"."CUSTOMERS" ("CUSTOMER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table SUBSCRIBERS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."SUBSCRIBERS" ADD CONSTRAINT "SUBSCRIBERS__CUSTOMERS_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "BOOKKEEPER"."CUSTOMERS" ("CUSTOMER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table WISHLISTS
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."WISHLISTS" ADD CONSTRAINT "WISHLISTS__BOOKS_FK" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."WISHLISTS" ADD CONSTRAINT "WISHLISTS__CUSTOMERS_FK" FOREIGN KEY ("CUSTOMER_ID") REFERENCES "BOOKKEEPER"."CUSTOMERS" ("CUSTOMER_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

-- ----------------------------
-- Foreign Keys structure for table WRITES
-- ----------------------------
ALTER TABLE "BOOKKEEPER"."WRITES" ADD CONSTRAINT "WRITES__AUTHORS_FK" FOREIGN KEY ("AUTHOR_ID") REFERENCES "BOOKKEEPER"."AUTHORS" ("AUTHOR_ID") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;
ALTER TABLE "BOOKKEEPER"."WRITES" ADD CONSTRAINT "WRITES__BOOKS_FK" FOREIGN KEY ("ISBN") REFERENCES "BOOKKEEPER"."BOOKS" ("ISBN") NOT DEFERRABLE INITIALLY IMMEDIATE NORELY VALIDATE;

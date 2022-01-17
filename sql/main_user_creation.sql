/*
step-1 : connect to oracle database as SYS with SYSDBA role
step-2 : run this script
step-3 : create new connecttion in navicat with
			connection type -> Basic
			host -> localhost
			port -> 1521

			service name -> ORCLPDB1.localdomain
				[select "Service Name" in the radio box]

				or

			service name -> ORCLPDB1
				[select "SID" in the radio box]
			Username -> BOOKKEEPER
			Password -> 1234
			role -> default [this option can be found in the "Advanced" tab]
step-4 : double click on BOOKKEEPER database
*/



/*
Chnages Session type to Pluggable one
Uncomment one of the two options based on your machine config and oracle version.
This will later be used to connect to database.
*/

/*
OPTION 1
========
Use ORCLPDB1 as SID or ORCLPDB1.localdomain
*/
ALTER SESSION SET CONTAINER = ORCLPDB1;

/*
OPTION 2
========
Use ORCLPDB as SID or ORCLPDB.localdomain
*/
-- ALTER SESSION SET CONTAINER = ORCLPDB;

/*
Uncomment following line when you need to rerun the same script.

[CAUTION] THIS WILL THEN DELETE ALL THE DATA
*/
-- DROP USER BOOKKEEPER CASCADE;

CREATE USER BOOKKEEPER IDENTIFIED BY 1234;
ALTER USER BOOKKEEPER DEFAULT TABLESPACE users QUOTA UNLIMITED ON users;
ALTER USER BOOKKEEPER TEMPORARY TABLESPACE TEMP;
GRANT ALL PRIVILEGES TO BOOKKEEPER;

COMMIT;

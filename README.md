# BookKeep
L-2 T-2 Database Project

### Directory descriptions
* **BookKeep :** base project directory
* **catalog :** the `catalog` app directory. responsible for showing all the books as card layout. may be used as search result also
* **doc :** contains basic project info, like, project proposal, ERD etc
* **login :** this app handles user login and session managements
* **sql :** contains sql commands that are required every now and then
* **templates :** used for containing `html` template files

### Things to do after pulling the repo -
1. Setup virtual environment
2. Run
    ```
    python manage.py collectstatic
    ```
3. Install cx\_Oracle
	```
	python -m pip install cx_Oracle
	```
4. If oracle is not locally installed. Download oracle instant client and run
	```
	export LD_LIBRARY_PATH=/path/to/instantclient_directory/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
	```
5. For migration to commence
	```
	python manage.py migrate
	```

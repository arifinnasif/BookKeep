# BookKeep
L-2 T-2 Database Project

### Directory descriptions
* **BookKeep :** base project directory
* **admin :** admin panel app directory. contains admin access over all other features and users
* **catalog :** the home app directory. responsible for showing all the books short intro as card layout. may be used as search result also
* **book_details :** the details information about each book, its author, publisher and many other attributes. also contains rating, review features
* **user_profile :** client side app directory. contains user account info, cart, wishlist and order info
* **doc :** contains basic project info, like, project proposal, ERD etc
* **login :** this app handles user login and session managements
* **sql :** contains sql commands that are required every now and then
* **templates :** used for containing `html` template files
* **custome_utils :** intended to be a package that contain the elements needed in the entire django project irrespective of apps

### Things to do after cloning the repo -
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

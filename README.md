![BookKeep](https://github.com/arifinnasif/BookKeep/blob/main/static/logo.svg?raw=true)


# BookKeep

An **Online Book Store** inspired by [Rokomari](https://www.rokomari.com/book), with some extra features!

Made for Level-2 Term-2 Database Sessional Project created by [Md. Asif Haider (1805112)](https://github.com/asifhaider) and [Md Sultanul Arifin (1805097)](https://github.com/arifinnasif)

Under the kind supervision of [Rayhan Rashed](https://github.com/rayhanrashed), Lecturer, CSE, BUET



### Tools used

![Oracle](https://img.shields.io/badge/Oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white)
![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)

![Django](https://img.shields.io/badge/django-%23092E20.svg?style=for-the-badge&logo=django&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

![Bootstrap](https://img.shields.io/badge/bootstrap-%23563D7C.svg?style=for-the-badge&logo=bootstrap&logoColor=white)
![HTML5](https://img.shields.io/badge/html5-%23E34F26.svg?style=for-the-badge&logo=html5&logoColor=white)
![CSS3](https://img.shields.io/badge/css3-%231572B6.svg?style=for-the-badge&logo=css3&logoColor=white)
![JavaScript](https://img.shields.io/badge/javascript-%23323330.svg?style=for-the-badge&logo=javascript&logoColor=%23F7DF1E)
![jQuery](https://img.shields.io/badge/jquery-%230769AD.svg?style=for-the-badge&logo=jquery&logoColor=white)


[![HitCount](http://hits.dwyl.com/arifinnasif/BookKeep.svg)](http://hits.dwyl.com/arifinnasif/BookKeep)

### Directory descriptions
* **BookKeep :** base project directory
* **admin :** admin panel app directory. contains admin access over all other features and users
* **catalog :** the home app directory. responsible for showing all the books short intro as card layout. can be used as search result also
* **book_details :** the details information about each book, its author, publisher and many other attributes. also contains rating, review features
* **user_profile :** client side app directory. contains user account info, cart, wishlist, orders and borrows info
* **doc :** contains basic project info, like, project proposal, ERD etc
* **login :** this app handles user login and session managements
* **sql :** contains sql commands that are required every now and then
* **templates :** used for containing `html` template files
* **custome_utils :** intended to be a package that contain the elements needed in the entire django project irrespective of apps

### Things to do after cloning the repo -
1. Setup python virtual environment
2. Run
    ```
    python manage.py collectstatic
    ```
3. Install dependencies
	```
	python -m pip3 install -r requirements.txt
	```
4. If oracle is not locally installed. Download oracle instant client and run
	```
	export LD_LIBRARY_PATH=/path/to/instantclient_directory/${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
	```
5. For migration to commence
	```
	python manage.py migrate
	```
5. Set up the database using files in `sql`
6. Start the server with
	```
	python manage.py runserver
	```
7. The `BookKeep` app will now be avaiable on `127.0.0.1:8000`


Made with <span style="color: #e25555;">&#9829;</span> by the **BookKeep Team**

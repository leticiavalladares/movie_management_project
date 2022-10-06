from flask import Flask, render_template, send_from_directory, request
from flask_mysqldb import MySQL
import json

# Instanciating class Flask from the flask module
app = Flask("MovieApp")

# THIS IS JUST FOR LEARNING PURPOSES
# DO NOT PUBLISH SENSITIVE INFORMATION
app.config["MYSQL_HOST"]     = "ENDPOINT_PLACEHOLDER"
app.config["MYSQL_USER"]     = "root"
app.config["MYSQL_PASSWORD"] = "PASSWORD_PLACEHOLDER"
app.config["MYSQL_DB"]       = "movie_db"

mysql = MySQL(app)

# Define the route with @
# the name in python is decorator, it changes the behaviour of the 
# function that follows
@app.route("/")
def hello_world():
    return render_template('index.html')

@app.route("/static/<path>")
def static_style(path):
   return send_from_directory('static', path)

# Cursor is the property of the connection with the db
# cursor variable, based on the installed app
@app.route("/movies/")
def list_movie():
    cursor = mysql.connection.cursor()
    query_string = "SELECT * FROM movies_tbl;"
    cursor.execute(query_string)  
    data = cursor.fetchall()
    cursor.close()
    return json.dumps(data)

"""
[[1, "Titanic", 1997, 1], [10, "Wonder Woman", 2017, 4], 
[11, "Avatar", 2009, 1], [12, "Aliens", 1986, 1], 
[13, "Inception", 2010, 3], [14, "Terminator", 1984, 1], 
[15, "Cleopatra", 2023, 4], [16, "Eternals", 2021, 5], 
[17, "The Dark Knight", 2008, 3], [18, "Lost In Translation", 1997, 6], 
[19, "On the Rocks", 2020, 6], [20, "The Virgin Suicides", 1999, 6], 
[21, "Broken Flowers", 2005, 7]]
"""

@app.route("/movies-table/")
def list_movie_table():
    cursor = mysql.connection.cursor()
    query_string = "SELECT * FROM movies_tbl;"
    cursor.execute(query_string)  
    data = cursor.fetchall()
    cursor.close()
    return render_template("movies.tpl.html", movies_data=data)

@app.route("/directors-table/")
def list_director_table():
    cursor = mysql.connection.cursor()
    query_string = "SELECT * FROM directors_tbl;"
    cursor.execute(query_string)  
    data = cursor.fetchall()
    cursor.close()
    return render_template("movies.tpl.html", movies_data=data)

@app.route("/actors-table/")
def list_actor_table():
    cursor = mysql.connection.cursor()
    query_string = "SELECT * FROM main_actors_tbl;"
    cursor.execute(query_string)  
    data = cursor.fetchall()
    cursor.close()
    return render_template("movies.tpl.html", movies_data=data)

@app.route("/movies-with-dir-table/")
def list_movie_dir_table():
    cursor = mysql.connection.cursor()
    query_dir = "SELECT mov.id, mov.title, mov.release_year, dir.name FROM movies_tbl AS mov JOIN directors_tbl AS dir ON mov.director_id = dir.id ORDER BY mov.release_year ASC;"
    cursor.execute(query_dir)  
    data_dir = cursor.fetchall()
    cursor.close()
    return render_template("movies.tpl.html", movies_data=data_dir)

@app.route("/add-movie/")
def new_movie(): 
    cursor = mysql.connection.cursor()
    d_query_string = "SELECT * FROM directors_tbl;"
    a_query_string = "SELECT * FROM main_actors_tbl;"
    cursor.execute(d_query_string)
    directors_data = cursor.fetchall()
    cursor.execute(a_query_string)
    actors_data = cursor.fetchall()
    cursor.close()
    return render_template("added_movie.tpl.html",
        data_dir=directors_data,
        data_act=actors_data
    )

@app.route('/add-new-movie/', methods=['POST'])
def add_new_movie():
    cursor = mysql.connection.cursor()

    # Collect info from Form
    title = request.form['movietitle']
    release_year = request.form['releaseyear']
    director_id = request.form['directorSelect']
    actor_id = request.form['directorSelect']

    # INSERT new movie inside the table movie_tbl
    movie_query_string = "INSERT INTO movies_tbl VALUES(null, %s, %s, %s);"
    cursor.execute(movie_query_string, (title, release_year, director_id))
    new_movie_id = cursor.lastrowid

    # INSERT into the table movie_actors_tbl
    movie_actor_query_string = "INSERT INTO movie_actors_tbl VALUES(%s, %s);"
    cursor.execute(movie_actor_query_string, (new_movie_id, actor_id))
    mysql.connection.commit()
    cursor.close()
    return list_movie_table()

@app.route("/add-director/")
def new_director(): 
    cursor = mysql.connection.cursor()
    d_query_string = "SELECT * FROM directors_tbl;"
    cursor.execute(d_query_string)
    directors_data = cursor.fetchall()
    cursor.close()
    return render_template("added_director.tpl.html",
        data_dir=directors_data
    )

@app.route('/add-new-director/', methods=['POST'])
def add_new_director():
    cursor = mysql.connection.cursor()

    # Collect info from Form
    name = request.form['name']
    year_of_birth = request.form['year']

    # INSERT new director inside the table director_tbl
    dir_query_string = "INSERT INTO directors_tbl VALUES(null, %s, %s);"
    cursor.execute(dir_query_string, (name, year_of_birth))
    mysql.connection.commit()
    cursor.close()
    return list_director_table()

@app.route("/add-actor/")
def new_actor(): 
    cursor = mysql.connection.cursor()
    d_query_string = "SELECT * FROM main_actors_tbl;"
    cursor.execute(d_query_string)
    actors_data = cursor.fetchall()
    cursor.close()
    return render_template("added_director.tpl.html",
        data_dir=actors_data
    )

@app.route('/add-new-actor/', methods=['POST'])
def add_new_actor():
    cursor = mysql.connection.cursor()

    # Collect info from Form
    name = request.form['name']
    year_of_birth = request.form['year']
    sex = request.form['sex']

    # INSERT new actor inside the table director_tbl
    act_query_string = "INSERT INTO main_actors_tbl VALUES(null, %s, %s, %s);"
    cursor.execute(act_query_string, (name, year_of_birth, sex))
    mysql.connection.commit()
    cursor.close()
    return list_actor_table()

if __name__ == "__main__":
    app.run(host="127.0.0.1")
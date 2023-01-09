from flask import Flask, render_template, request, redirect, url_for, flash
from flaskext.mysql import MySQL

app = Flask(__name__)
mysql = MySQL()

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'canasta_db'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

mysql.init_app(app)
#LOGIN
@app.route('/', methods=['GET','POST'])
def index():
   error = ""
   if request.method == 'POST':
        if request.form['username'] == '' or request.form['password'] == '':
            error = "Datos incorrectos. Intente de nuevo"
        else:
            return redirect('/home')

   return render_template('login.html',error=error) 

#REGISTRO
@app.route('/registro', methods=['GET','POST'])
def registro():
   error = ""
   if request.method == 'POST':
      if request.form['username'] != '' or request.form['password'] != '' or request.form['confirmar_pass'] != '' or request.form['mail'] != '' or request.form['api_key'] != '' or request.form['token'] != '' or request.form['ubidots_app'] != '' or request.form['telefono'] != '':
         if request.form['password'] != request.form['confirmar_pass']:
            error = "Las contraseñas no coinciden"
         else:
            return redirect('/home')
      else:
         error = "Aun faltan datos por capturar"

   return render_template('registro.html',error=error) 

#HOME
@app.route('/home', methods=['GET','POST'])
def home():
   datos = []
   if request.method == 'GET':
      conn = mysql.connect()
      cursor = conn.cursor()
      cursor.execute('SELECT ventas.total,resumen_compra.fecha_y_hora, ventas.folio_resumen FROM ventas INNER JOIN resumen_compra ON ventas.c_resumen_compra = resumen_compra.clave')
      datos = cursor.fetchall()

   return render_template('dashboard.html', datos=datos)

#CARRITO
@app.route('/carrito')
def carrito():
   return render_template('carrito.html')

if __name__ == '__main__':
   app.debug = True
   app.run(host="0.0.0.0",port=5000)
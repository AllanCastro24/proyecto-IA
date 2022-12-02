from flask import Flask, render_template, request, redirect, url_for, flash

app = Flask(__name__)

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
@app.route('/home')
def home():
   return render_template('dashboard.html')

#CARRITO
@app.route('/carrito')
def carrito():
   return render_template('carrito.html')

if __name__ == '__main__':
   app.debug = True
   app.run(host="0.0.0.0",port=5000)
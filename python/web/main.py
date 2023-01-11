from flask import Flask, render_template, request, redirect, url_for, flash, Response
from flaskext.mysql import MySQL
from datetime import datetime
import cv2
import numpy as np
# from pyswip import Prolog # Conexión con prolog

# prolog = Prolog() #Crear objeto prolog
cap = cv2.VideoCapture(1)
app = Flask(__name__)
mysql = MySQL()

app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = ''
app.config['MYSQL_DATABASE_DB'] = 'canasta_db'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'

mysql.init_app(app)

def gen_frames():  
    while True:
        success, frame = cap.read()  # read the camera frame
        if not success:
            break
        else:
            ret, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()
            yield (b'--frame\r\n'b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')  # concat frame one by one and show result

def capturar():
   while(1):
      _, img = cap.read()

      # Convertir el frame (img == BGR) en HSV(hue-saturation-value)

      hsv = cv2.cvtColor(img, cv2.COLOR_BGR2HSV)

      # Identificar frutas
      apple_upper = np.array([78,2,0],np.uint8)
      apple_lower = np.array([255,27,20],np.uint8)
      
      # Color rojo

      red_lower = np.array([136,87,111],np.uint8)
      red_upper = np.array([180,255,255],np.uint8)

      # Color azul

      blue_lower = np.array([99,115,150],np.uint8)
      blue_upper = np.array([110,255,255],np.uint8)

      # Color amarillo

      yellow_lower = np.array([22,60,200],np.uint8)
      yellow_upper = np.array([60,255,255],np.uint8)

      # Color blanco

      white_lower = np.array([0,0,200],np.uint8)
      white_upper = np.array([180,20,255],np.uint8)

      # Color negro

      black_lower = np.array([0,0,0],np.uint8)
      black_upper = np.array([180,255,30],np.uint8)

      # Todos los colores
      red = cv2.inRange(hsv, red_lower, red_upper)
      blue = cv2.inRange(hsv, blue_lower, blue_upper)
      yellow = cv2.inRange(hsv, yellow_lower, yellow_upper)
      white = cv2.inRange(hsv, white_lower, white_upper)
      black = cv2.inRange(hsv, black_lower, black_upper)
      # Frutas
      apple = cv2.inRange(hsv, apple_lower, apple_upper)


      kernal = np.ones((5, 5), "uint8")

      apple = cv2.dilate(apple, kernal)
      res_apple = cv2.bitwise_and(img, img, mask = apple)
      
      red = cv2.dilate(red, kernal)
      res_red = cv2.bitwise_and(img, img, mask = red)

      blue = cv2.dilate(blue, kernal)
      res_blue = cv2.bitwise_and(img, img, mask = blue)

      yellow = cv2.dilate(yellow, kernal)
      res_yellow = cv2.bitwise_and(img, img, mask = yellow)

      white = cv2.dilate(white, kernal)
      res_white = cv2.bitwise_and(img, img, mask = white)

      black = cv2.dilate(black, kernal)
      res_black = cv2.bitwise_and(img, img, mask = black)

      # Tracking apple
      contours, hierarchy = cv2.findContours(apple, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
      for pic, contour in enumerate(contours):
         area = cv2.contourArea(contour)
         if(area > 300):
               x, y, w, h = cv2.boundingRect(contour)
               img = cv2.rectangle(img, (x, y), (x + w, y + h), (0, 0, 255), 2)
               cv2.putText(img, "MANZANA: ", (x, y), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255))    

      # Tracking red
      contours, hierarchy = cv2.findContours(red, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
      for pic, contour in enumerate(contours):
         area = cv2.contourArea(contour)
         if(area > 300):
               x, y, w, h = cv2.boundingRect(contour)
               img = cv2.rectangle(img, (x, y), (x + w, y + h), (0, 0, 255), 2)
               cv2.putText(img, "MANZANA: ", (x, y), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 255))    

      # Tracking blue
      contours, hierarchy = cv2.findContours(blue, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
      for pic, contour in enumerate(contours):
         area = cv2.contourArea(contour)
         if(area > 300):
               x, y, w, h = cv2.boundingRect(contour)
               img = cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), 2)
               cv2.putText(img, "AZUL: ", (x, y), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 0, 0))
               
      # Tracking yellow
      contours, hierarchy = cv2.findContours(yellow, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
      for pic, contour in enumerate(contours):
         area = cv2.contourArea(contour)
         if(area > 300):
               x, y, w, h = cv2.boundingRect(contour)
               img = cv2.rectangle(img, (x, y), (x + w, y + h), (0, 255, 0), 2)
               cv2.putText(img, "PLATANO: ", (x, y), cv2.FONT_HERSHEY_SIMPLEX, 1.0, (0, 255, 0))

      # Tracking white
      contours, hierarchy = cv2.findContours(white, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
      for pic, contour in enumerate(contours):
         area = cv2.contourArea(contour)
         if(area > 300):
               x, y, w, h = cv2.boundingRect(contour)
               img = cv2.rectangle(img, (x, y), (x + w, y + h), (255, 255, 255), 2)
               cv2.putText(img, "BLANCO: ", (x, y), cv2.FONT_HERSHEY_SIMPLEX, 1.0, (255, 255, 255))

      # Tracking black
      contours, hierarchy = cv2.findContours(black, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
      for pic, contour in enumerate(contours):
         area = cv2.contourArea(contour)
         if(area > 300):
               x, y, w, h = cv2.boundingRect(contour)
               img = cv2.rectangle(img, (x, y), (x + w, y + h), (0, 0, 0), 2)
               cv2.putText(img, "NEGRO: ", (x, y), cv2.FONT_HERSHEY_SIMPLEX, 0.7, (0, 0, 0))

      (flag, encodedImage) = cv2.imencode(".jpg", img)
      if not flag:
            continue
            yield(b'--frame\r\n' b'Content-Type: image/jpeg\r\n\r\n' +bytearray(encodedImage) + b'\r\n')


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
   # Definir arrays antes de utilizar para que no de error el front
   datos = []
   if request.method == 'GET':
      conn = mysql.connect()
      cursor = conn.cursor()
      cursor.execute('SELECT ventas.total,resumen_compra.fecha_y_hora, ventas.folio_resumen, productos.nombre FROM ventas INNER JOIN resumen_compra ON ventas.c_resumen_compra = resumen_compra.clave INNER JOIN productos ON resumen_compra.c_producto = productos.clave')
      datos = cursor.fetchall()

   return render_template('dashboard.html', datos=datos)

#CARRITO
@app.route('/carrito/<id>', methods=['GET','POST'])
def carrito(id):
   datos = []
   productos = []

   if id != "0":
      # print('No entré al 0')
      conn = mysql.connect()
      cursor = conn.cursor()
      cursor.execute("SELECT * FROM resumen_compra INNER JOIN productos ON resumen_compra.c_producto = productos.clave INNER JOIN unidad_medida ON productos.c_unidad_medida = unidad_medida.clave WHERE resumen_compra.folio = "+ id +";")
      datos = cursor.fetchall() 
      # print(datos)
   else:
      print("Entré al 0")

   conn = mysql.connect()
   cursor = conn.cursor()
   cursor.execute("SELECT * FROM productos INNER JOIN unidad_medida ON productos.c_unidad_medida = unidad_medida.clave;")
   productos = cursor.fetchall() 

   if request.method == 'POST':
      print("POST")
      print(request.form)
      conn = mysql.connect()
      cursor = conn.cursor()
      # INSERT INTO canasta_db.resumen_compra (c_producto, cantidad, fecha_y_hora, folio) VALUES(%s, %s, %s, %s);
      cursor.execute("INSERT INTO canasta_db.resumen_compra (c_producto, cantidad, fecha_y_hora, folio) VALUES(%s, %s, %s, %s);",(request.form['producto'],request.form['cantidad'],datetime.now(),id))
      conn.commit()

   return render_template('carrito.html', datos=datos, productos = productos)

@app.route("/video_feed")
def video_feed():
   return Response(capturar(), mimetype = "multipart/x-mixed-replace; boundary=frame")

if __name__ == '__main__':
   app.debug = True
   app.run(host="0.0.0.0",port=5000)

# class Prolog():
#    def _init_(self, consulta):
#       self.prolog = Prolog()
#       self.prolog.consult(os.path.join("/","hechos.pl"))
#       self.prolog = consulta
#       self.resultado = []

#    def esFruta(self):
#       return self.prolog.query("esFruta(" + self.consulta + ")")

#    def esColor(self):
#       return self.prolog.query("esColor(x," + self.consulta + ")")
   
#    def pesaEntre(self):
#       return self.prolog.query("pesaEntre(x," + self.min +", " + self.max+")")
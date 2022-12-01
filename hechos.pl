abrir_conexion :-
	odbc_connect('prolog', _,
		     [user(root),
		      password(' '),
		      alias(prolog),
		      open(once)
			]).

cerrar_conexion :-
	odbc_disconnect('prolog').
fila(X) :- odbc_query('prolog','select * from productos', X) %Consulta selects
esColor(X) :- (X < 0 -> true; false).

esFruta("manzana").
esFruta("naranja").
esFruta("limon").
esFruta("lima").
esFruta("toronja").
esFruta("platano").
esFruta("sandia").
esFruta("mango").
esFruta("aguacate").
esFruta("tomate").
esFruta("piña").
esFruta("uva").
esFruta("guayaba").
esFruta("mandarina").
esFruta("fresa").
esFruta("pera").
esFruta("papaya").
esFruta("durazno").
esFruta("kiwi").

esColor("manzana", "rojo").
esColor("naranja", "naranjado").
esColor("limon", "verde").
esColor("lima", "amarillo").
esColor("toronja", "naranjado").
esColor("platano", "amarillo").
esColor("sandia", "verde").
esColor("mango", "amarillo").
esColor("aguacate", "negro").
esColor("tomate", "rojo").
esColor("piña", "amarillo").
esColor("uva", "morado").
esColor("guayaba", "verde").
esColor("mandarina", "naranjado").
esColor("fresa", "rojo").
esColor("pera", "verde").
esColor("papaya", "naranjado").
esColor("durazno", "naranjado").
esColor("kiwi", "cafe").

pesaEntre("manzana", 200, 210).
pesaEntre("naranja", 200, 250).
pesaEntre("limon", 30, 70).
pesaEntre("lima", 150, 250).
pesaEntre("toronja", 250, 350).
pesaEntre("platano", 150, 200).
pesaEntre("sandia", 1000, 2000).
pesaEntre("mango", 100, 200).
pesaEntre("aguacate", 100, 200).
pesaEntre("tomate", 100, 200).
pesaEntre("piña", 700, 1200).
pesaEntre("uva", 10, 30).
pesaEntre("guayaba", 50, 100).
pesaEntre("mandarina", 70, 100).
pesaEntre("fresa", 15, 35).
pesaEntre("pera", 50, 100).
pesaEntre("papaya", 500, 1500).
pesaEntre("durazno", 150, 250).
pesaEntre("kiwi", 150, 200).

colorValido(Y) :- esColor(X, Y).
pesoValido(Y, Z) :- pesaEntre(X, Y, Z).
esManzana(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esNaranja(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esLimon(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esLima(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esPlatano(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esSandia(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esMango(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esAguacate(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esTomate(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esPiña(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esUva(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esGuayaba(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esMandarina(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esFresa(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esToronja(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esPera(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esPapaya(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esDurazno(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
esKiwi(X) :- esFruta(X), esColor(X, Y), pesaEntre(X, Y, Z).
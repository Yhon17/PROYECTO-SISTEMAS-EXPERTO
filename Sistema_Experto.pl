/* BASE DE CONOCIMIENTOS:*/

conocimiento('hidropesia',
['El pez presenta escamas levantadas','El pez presenta falta de apetito','El pez presenta el vientre hinchado', 'El pez presenta los ojos sobresalidos','El pez presenta dificultad para nadar','El pez presenta dificultad para excretar','El pez presenta aletas enrojecidas']).

conocimiento('vejiga_natatoria',
['El pez presenta el vientre hinchado','El pez presenta falta de apetito','El pez presenta aletargamiento', 'El pez presenta problemas de equilibrio']).

conocimiento('estres',
['El pez jadea en la superficie','El pez presenta falta de apetito','El pez presenta aletargamiento','El pez presenta perdida de color','El pez presenta estados de agresividad','El pez presenta las venas rojizas y dilatadas']).

conocimiento('parasito_hexamita',
['El pez presenta un hoyo en la cabeza','El pez presenta falta de apetito','El pez presenta aletargamiento','El pez presenta sangrado en la cabeza y tejido muerto','El pez presenta filamentos blanquecinos gelatinosos']).

conocimiento('punto_blanco_ich',['El pez presenta puntos blancos en el cuerpo y las aletas','El pez presenta aletargamiento','El pez presenta movimientos rápidos al nadar','El pez presenta las aletas retraídas']).


conocimiento('gusano_lernaea',
['El pez tiene hilos que Cuelgan','El pez presenta piel inflamada','El pez se frota contra las paredes','El pez presenta pérdida de peso','El pez presenta hemorragias en la piel']).


conocimiento('podredumbre_aletas',
['El pez presenta aletas con desgarros', 'El pez presenta en los bordes de las aletas un color blanquecino o rojizo','El pez se vuelve apáticos']).




id_imagen_preg('El pez presenta escamas levantadas','escamas_levantadas').
id_imagen_preg('El pez presenta los ojos sobresalidos','ojos_sobresalidos').
id_imagen_preg('El pez presenta falta de apetito','falta_apetito').
id_imagen_preg('El pez presenta el vientre hinchado','vientre_hinchado').
id_imagen_preg('El pez presenta problemas de equilibrio','equilibrio').
id_imagen_preg('El pez presenta aletargamiento','aletargamiento').
id_imagen_preg('El pez presenta las aletas retraídas','aletas_retraidas').
id_imagen_preg('El pez presenta estados de agresividad','agresivo').
id_imagen_preg('El pez presenta las venas rojizas y dilatadas','venas_rojas').
id_imagen_preg('El pez presenta un hoyo en la cabeza','hexamita').
id_imagen_preg('El pez presenta sangrado en la cabeza y tejido muerto','hexamita2').
id_imagen_preg('El pez presenta dificultad para excretar','dificultad_excretar').
id_imagen_preg('El pez presenta dificultad para nadar','dificultad_nadar').
id_imagen_preg('El pez presenta aletas enrojecidas','aletas_enrojecidas').
id_imagen_preg('El pez presenta piel inflamada','piel_inflamada').
id_imagen_preg('El pez presenta perdida de color','perdida_color').
id_imagen_preg('El pez jadea en la superficie','jadea').
id_imagen_preg('El pez presenta puntos blancos en el cuerpo y las aletas','puntos_blancos').
id_imagen_preg('El pez presenta movimientos rápidos al nadar','movimiento_rapido').
id_imagen_preg('El pez presenta filamentos blanquecinos gelatinosos','filamentos_blanquesinos').
id_imagen_preg('El pez presenta desgarros en la base de las aletas','aletas_desgarros').
id_imagen_preg('El pez presenta aletas con desgarros','aletas_desgarros').
id_imagen_preg('El pez se frota contra las paredes','frota_paredes').
id_imagen_preg('El pez tiene hilos que Cuelgan','hilos_cuelgan').
id_imagen_preg('El pez presenta pérdida de peso','perdida_peso').
id_imagen_preg('El pez presenta hemorragias en la piel','hemorragia_piel').
id_imagen_preg('El pez presenta en los bordes de las aletas un color blanquecino o rojizo','bordes_blanquesinos').
id_imagen_preg('El pez se vuelve apáticos','apatico').





%------------------------------------------------
 /* MOTOR DE INFERENCIA */
:- dynamic conocido/1.

mostrar_diagnostico(X):-haz_diagnostico(X),clean_scratchpad.
mostrar_diagnostico(lo_siento_diagnostico_desconocido):-clean_scratchpad .

haz_diagnostico(Diagnosis):-
                            obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas),
                            prueba_presencia_de(Diagnosis, ListaDeSintomas).


obten_hipotesis_y_sintomas(Diagnosis, ListaDeSintomas):-
                            conocimiento(Diagnosis, ListaDeSintomas).


prueba_presencia_de(Diagnosis, []).
prueba_presencia_de(Diagnosis, [Head | Tail]):- prueba_verdad_de(Diagnosis, Head),
                                              prueba_presencia_de(Diagnosis, Tail).


prueba_verdad_de(Diagnosis, Sintoma):- conocido(Sintoma).
prueba_verdad_de(Diagnosis, Sintoma):- not(conocido(is_false(Sintoma))),
pregunta_sobre(Diagnosis, Sintoma, Reply), Reply = 'si'.


pregunta_sobre(Diagnosis, Sintoma, Reply):- preguntar(Sintoma,Respuesta),
                          process(Diagnosis, Sintoma, Respuesta, Reply).


process(Diagnosis, Sintoma, si, si):- asserta(conocido(Sintoma)).
process(Diagnosis, Sintoma, no, no):- asserta(conocido(is_false(Sintoma))).


clean_scratchpad:- retract(conocido(X)), fail.
clean_scratchpad.


conocido(_):- fail.

not(X):- X,!,fail.
not(_).

%------------------------------------
/*
INTERFAZ GRAFICA: Esta parte del sistema experto es la que se encarga de
interactuar con la persona.*/
 :- use_module(library(pce)).
 :- pce_image_directory('./imagenes').
 :- use_module(library(pce_style_item)).
 :- dynamic color/2.

 resource(img_principal, image, image('img_principal.jpg')).
 resource(portada, image, image('portada.jpg')).
 resource(hidropesia, image, image('trat_hidropesia.jpg')).
 resource(vejiga_natatoria, image, image('trat_vejiga.jpg')).
 resource(punto_blanco_ich, image, image('trat_ich.jpg')).
 resource(estres, image, image('trat_estres.jpg')).
 resource(parasito_hexamita, image, image('trat_hexamita.jpg')).

 resource(gusano_lernaea, image, image('trat_gus.jpg')).
 resource(lo_siento_diagnostico_desconocido, image, image('desconocido.jpg')).
 resource(agresivo, image, image('agresividad.jpg')).
 resource(aletargamiento, image, image('aletargamiento.jpg')).
 resource(aletas_retraidas, image, image('aletas_retraidas.jpg')).
 resource(equilibrio, image, image('equilibrio.jpg')).
 resource(escamas_levantadas, image, image('escamas_levantadas.jpg')).
 resource(falta_apetito, image, image('falta_apetito.jpg')).
 resource(hexamita, image, image('hexamita.jpg')).
 resource(hexamita2, image, image('hexamita2.jpg')).
 resource(puntos_blancos, image, image('puntos_blancos.jpg')).
 resource(ojos_sobresalidos, image, image('ojos_sobresalidos.jpg')).
 resource(venas_rojas, image, image('venas_rojas.jpg')).
 resource(vientre_hinchado, image, image('vientre_hinchado.jpg')).
 resource(dificultad_excretar, image, image('dificultad_excretar.jpg')).
 resource(dificultad_nadar, image, image('dificultad_nadar.jpg')).
 resource(aletas_enrojecidas, image, image('aletas_enrojecidas.jpg')).
 resource(piel_inflamada, image, image('piel_inflamada.jpg')).
 resource(gusano_lernaea, image, image('trat_gus.jpg')).
 resource(podredumbre_aletas, image, image('trat_pod.jpg')).


 resource(perdida_color, image, image('perdida_color.jpg')).
 resource(jadea, image, image('jadea.jpg')).
 resource(movimiento_rapido, image, image('movimiento_rapido.jpg')).
 resource(filamentos_blanquesinos, image, image('filamentos_blanquesinos.jpg')).
 resource(aletas_desgarros,image,image('aletas_desgarros.jpg')).
 resource(frota_paredes, image, image('frota_paredes.jpg')).
 resource(hilos_cuelgan, image, image('hilos_cuelgan.jpg')).
 resource(perdida_peso, image, image('perdida_peso.jpg')).
 resource(hemorragia_piel, image, image('hemorragia_piel.jpg')).
 resource(bordes_blanquesinos, image, image('bordes_blanquesinos.jpg')).
 resource(apatico, image, image('apatico.jpg')).

%AGREGAR LINEAS DE MAS ENFERMEDADES

mostrar_imagen(Pantalla, Imagen) :- new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(100,80)).
mostrar_imagen_tratamiento(Pantalla, Imagen) :-new(Figura, figure),
                                     new(Bitmap, bitmap(resource(Imagen),@on)),
                                     send(Bitmap, name, 1),
                                     send(Figura, display, Bitmap),
                                     send(Figura, status, 1),
                                     send(Pantalla, display,Figura,point(20,100)).
nueva_imagen(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(0,0)).
imagen_pregunta(Ventana, Imagen) :-new(Figura, figure),
                                new(Bitmap, bitmap(resource(Imagen),@on)),
                                send(Bitmap, name, 1),
                                send(Figura, display, Bitmap),
                                send(Figura, status, 1),
                                send(Ventana, display,Figura,point(500,60)).
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
botones:-borrado,
                send(@boton, free),
                send(@btntratamiento,free),
                mostrar_diagnostico(Enfermedad),
                send(@texto, selection('El Diagnostico a partir de los datos es:')),
                send(@resp1, selection(Enfermedad)),
                new(@boton, button('Iniciar consulta',
                message(@prolog, botones)
                )),

                new(@btntratamiento,button('Detalles y Tratamiento',
                message(@prolog, mostrar_tratamiento,Enfermedad)
                )),
                send(@main, display,@boton,point(20,450)),
                send(@main, display,@btntratamiento,point(138,450)).



mostrar_tratamiento(X):-new(@tratam, dialog('Tratamiento')),
                          send(@tratam, append, label(nombre, 'Explicacion: ')),
                          send(@tratam, display,@lblExp1,point(70,51)),
                          send(@tratam, display,@lblExp2,point(50,80)),
                          tratamiento(X),
                          send(@tratam, transient_for, @main),
                          send(@tratam, open_centered).

tratamiento(X):- send(@lblExp1,selection('De Acuerdo Al Diagnostico El Tratamiento Es:')),
                 mostrar_imagen_tratamiento(@tratam,X).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


preguntar(Preg,Resp):-new(Di,dialog('Colsultar Datos:')),
                        new(L2,label(texto,'Responde las siguientes preguntas')),
                        id_imagen_preg(Preg,Imagen),
                        imagen_pregunta(Di,Imagen),
                        new(La,label(prob,Preg)),
                        new(B1,button(si,and(message(Di,return,si)))),
                        new(B2,button(no,and(message(Di,return,no)))),
                        send(Di, gap, size(25,25)),
                        send(Di,append(L2)),
                        send(Di,append(La)),
                        send(Di,append(B1)),
                        send(Di,append(B2)),
                        send(Di,default_button,'si'),
                        send(Di,open_centered),get(Di,confirm,Answer),
                        free(Di),
                        Resp=Answer.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

interfaz_principal:-new(@main,dialog('SISTEMA EXPERTO-UNSCH (ING-SISTEMAS ♥)',
        size(1000,500))),
        new(@texto, label(nombre,'BIENVENIDO AL SISTEMA EXPERTO',font(times, bold, 22))),
        new(@texto1, label(nombre,'El Diagnostico a partir de los datos es:',font('times','roman',18))),
        new(@resp1, label(nombre,'',font('times','roman',22))),
        new(@lblExp1, label(nombre,'',font('times','roman',14))),
        new(@lblExp2, label(nombre,'',font('times','roman',14))),
        new(@salir,button('SALIR',and(message(@main,destroy),message(@main,free)))),
        new(@boton, button('Iniciar consulta',message(@prolog, botones))),

        new(@btntratamiento,button('¿Tratamiento?')),

        nueva_imagen(@main, img_principal),
        send(@main, display,@boton,point(138,450)),
        send(@main, display,@texto,point(300,60)),
        send(@main, display,@texto1,point(20,130)),
        send(@main, display,@salir,point(300,450)),
        send(@main, display,@resp1,point(20,180)),
        send(@main,open_centered).

       borrado:- send(@resp1, selection('')).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

crea_interfaz_inicio:- new(@interfaz,dialog('SISTEMAS EXPERTOS', size(1000,1000))),
  new(@titulo, label(nombre,'SISTEMA EXPERTO PARA DIAGNOSTICAR',font(times, bold, 22))),
  new(@titulo2, label(nombre,'ENFERMEDADES EN PECES',font(times, bold, 22))),
  new(@info, label(nombre,'UNIVERSIDAD NACIONAL SAN CRISTOBAL DE HUAMANGA',font(scren, bold, 15))),
  new(@info2, label(nombre,'FACULTAD DE INGENIERIA DE MINAS GEOLOGIA Y CIVIL',font(scren, bold, 15))),
  new(@info3, label(nombre,'DOCENTE: ING. MERCEDES CCESA QUINCHO',font(scren, italic, 15))),
  new(@info4, label(nombre,'INTEGRANTES:',font(scren, italic, 15))),
  new(@info5, label(nombre,'* ALEJOS ANAYA, Jacyra Killa ',font(scren, italic, 15))),
  new(@info6, label(nombre,'* PARIONA QUISPE, Yhon Manuel',font(scren, italic, 15))),
  new(@info7, label(nombre,'* SULCA AÑANCA, Marco Antonio',font(scren, italic, 15))),
  new(@info8, label(nombre,'* TINCO PALOMINO, Josue Rainero',font(scren, italic, 15))),


  new(BotonComenzar,button('COMENZAR',and(message(@prolog,interfaz_principal) ,
  and(message(@interfaz,destroy),message(@interfaz,free)) ))),
  new(BotonSalir,button('SALIDA',and(message(@interfaz,destroy),message(@interfaz,free)))),
   mostrar_imagen(@interfaz, portada),


  send(@interfaz,append(BotonComenzar)),
  send(@interfaz,append(BotonSalir)),
  send(@interfaz, display,@titulo,point(110,20)),
  send(@interfaz, display,@titulo2,point(200,60)),
  send(@interfaz, display,@info,point(150,420)),
  send(@interfaz, display,@info2,point(150,440)),
  send(@interfaz, display,@info3,point(60,470)),
  send(@interfaz, display,@info4,point(60,490)),
  send(@interfaz, display,@info5,point(150,505)),
  send(@interfaz, display,@info6,point(150,525)),
  send(@interfaz, display,@info7,point(150,545)),
  send(@interfaz, display,@info8,point(150,565)),



  send(@interfaz,open_centered).



  :-crea_interfaz_inicio.



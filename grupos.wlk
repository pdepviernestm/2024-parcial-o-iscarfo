import persona.*
import evento.*
import emociones.*
class Grupo{
  const integrantes

  //Punto 6:
  method vivirEvento (evento) {
    integrantes.forEach{persona=>persona.vivirEvento(evento)}
  }
}
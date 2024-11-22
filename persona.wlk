import emociones.*
import evento.*
import grupos.*
class Persona{
  var edad
  const emociones
  var cantEventosVividos

  method darEmociones() = emociones

  method vivirEvento () {cantEventosVividos+=1}

  method cumplirAnios () {edad+=1}

  //Punto 1:
  method esAdolescente () = edad.between(12, 18)
  //Pongo 18 debido a que cuando cumple 19 se termina

  //Punto 2:
  method tenerNuevaEmocion (emocion) {emociones.add(emocion)}

  //Punto 3:
  method estaPorExplotar () = emociones.all{emocion=>emocion.puedeLiberarse()}

  //Punto 4:
  method vivirEvento (evento) {
    self.vivirEvento()
    evento.consecuencias(self)
  }

}
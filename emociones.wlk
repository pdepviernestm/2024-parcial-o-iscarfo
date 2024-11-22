import persona.*
import evento.*
import grupos.*
class Emocion{
  var intensidad
  var valorElevado
  var cantEventosVividos

  method cuantosEventosVivio () = cantEventosVividos

  method darIntensidad() = intensidad

  method vivirEvento () {cantEventosVividos+=1}

  //Punto 5:
  method esElevada () = intensidad > valorElevado

  method disminuirIntensidad (n) {intensidad-=n}

  method cambiarValorIntensidad (n) {intensidad=n}

  method cambiarValorElevado (nuevo) {valorElevado=nuevo}

  method accionesXEmocion (evento) 

  method liberarse (evento) {
    self.vivirEvento() //Lo vive sin importar si se libera
    if(self.puedeLiberarse()){
    self.disminuirIntensidad(evento.impacto())
    self.accionesXEmocion(evento)
    }
  }

  method puedeLiberarse() = self.esElevada()
}

class Furia inherits Emocion (intensidad=100){
  const palabrotas

  method aprenderPalabrota (palabrota) {palabrotas.add(palabrota)}

  method olvidarPalabrota (palabrota) {palabrotas.remove(palabrota)}

  override method puedeLiberarse () = super() && self.conocePalabrotaLarga()

  override method accionesXEmocion (evento) {
    self.olvidarPalabrota(self.darPrimeraPalabrota())
  }

  method darPrimeraPalabrota () = palabrotas.first()

  method conocePalabrotaLarga() = palabrotas.any{palabrota=>
  palabrota.length()>7}
}

class Alegria inherits Emocion{
  
  override method puedeLiberarse() = super() && 
  cantEventosVividos.even()

  override method disminuirIntensidad (n) {
    if (intensidad - n < 0) {
      const valor = intensidad - n
      self.cambiarValorIntensidad(valor*-1)}
    else super(n)
  }

  override method accionesXEmocion (evento) {}
}

class Tristeza inherits Emocion{
  var causa = "melancolia" //ya que dice que inicialmente es esta

  method cambiarCausa(nueva) {causa=nueva}

  override method puedeLiberarse () = super() && causa != "melancolia"

  override method accionesXEmocion (evento) {
    self.cambiarCausa (evento.darDescripcion())    
  }
}

class DesagradoYTemor inherits Emocion{
  
  override method puedeLiberarse () = super() && 
  cantEventosVividos > intensidad

  override method accionesXEmocion (evento) {}
}

class Ansiedad inherits Emocion{
  const nivelAnsiedad

  override method puedeLiberarse() = super() && nivelAnsiedad>3
  /*En este caso el polimorfismo me permite que dos clases distintas como lo
  son las emociones pueden comprender el mismo mensaje pero de manera distinta.
  En este caso, la ansiedad se libera si su nivel es mayor a 3 y si la intensiadad
  es elevada, que es distinto a la forma de comprender el mensaje del temor por decir un ejemplo,
  que relaciona la liberación con la cantidad de eventos vividos y la intensidad*/

  override method accionesXEmocion (evento) {
    self.respirar()
  }

  method respirar() {self.disminuirIntensidad(10)}
  /*En este caso pude usar la herencia como algo muy útil, primero de todo para evitar
  la repeticion de código, ya que todas las emociones al liberarse disminuyen la intensidad
  según el impacto del evento. Y usando el super() me permite realizar el método de la superclase
  y especificar más aún mis objetos, de forma que pueden realizar 
  más acciones además de las heredadas.*/
}

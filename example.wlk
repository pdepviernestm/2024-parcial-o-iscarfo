class Persona{
  var edad
  const emociones
  var property cantEventosVividos

  method vivirEvento () {cantEventosVividos+=1}

  method cumplirAnios () {edad+=1}

  method esAdolescente () = edad.between(12, 18)
  //Pongo 18 debido a que cuando cumple 19 se termina

  method tenerNuevaEmocion (emocion) {emociones.add(emocion)}

  method estaPorExplotar () = emociones.all{emocion=>emocion.puedeLiberarse()}

  method vivirEvento (evento) {
    evento.consecuencias(self)
  }
}

class Evento {
  method impacto ()
  method consecuencias (persona) {}
}

class Emocion{
  var intensidad
  var valorElevado

  method esElevada () = intensidad > valorElevado

  method disminuirIntensidad (n) {intensidad-=n}

  method cambiarValorIntensidad (n) {intensidad=n}

  method cambiarValorElevado (nuevo) {valorElevado=nuevo}

  method liberarse (evento) {
    if(self.puedeLiberarse())
    self.disminuirIntensidad(evento.impacto())
  }

  method puedeLiberarse() = self.esElevada()
}

class Furia inherits Emocion (intensidad=100){
  const palabrotas

  method aprenderPalabrota (palabrota) {palabrotas.add(palabrota)}

  method olvidarPalabrota (palabrota) {palabrotas.remove(palabrota)}

  override method puedeLiberarse () = super() && self.conocePalabrotaLarga()

  override method liberarse (evento) {
    super(evento)
    self.olvidarPalabrota(self.darPrimeraPalabrota())
  }

  method darPrimeraPalabrota () = palabrotas.first()

  method conocePalabrotaLarga() = palabrotas.any{palabrota=>
  palabrota.length()>7}
}

class Alegria inherits Emocion{
  const duenia
  
  override method puedeLiberarse() = super() && 
  duenia.cantEventosVividos().even()

  override method disminuirIntensidad (n) {
    if (intensidad - n < 0) {
      const valor = intensidad - n
      self.cambiarValorIntensidad(valor*-1)}
    else super(n)
  }
}

class Tristeza inherits Emocion{
  var causa = "melancolia" //ya que dice que inicialmente es esta

  method cambiarCausa(nueva) {causa=nueva}

  override method puedeLiberarse () = super() && causa != "melancolia"

  override method liberarse (evento) {
    super(evento)
    self.cambiarCausa (evento.darDescripcion())    
  }
}

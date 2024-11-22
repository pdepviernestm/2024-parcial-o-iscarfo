import persona.*
import emociones.*
import grupos.*
class Evento {
  const descripcion
  const impacto

  method darDescripcion () = descripcion

  method impacto () = impacto
  
  method consecuencias (persona) {
    persona.darEmociones().forEach{emocion=>emocion.liberarse(self)}
  }
}
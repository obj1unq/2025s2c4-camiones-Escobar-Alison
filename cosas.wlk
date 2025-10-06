object knightRider {
	method peso() = 500 
	method nivelPeligrosidad() = 10 
    method bulto() = 1 
	
	method aplicarAccidente(){

	}

}

object bumblebee {
	var estaTransformadoEnRobot = true //necesita un setter

	method estaTransformadoEnRobot(_estaTransformadoEnRobot){
		estaTransformadoEnRobot = _estaTransformadoEnRobot
	}


	method peso() = 800 

	method nivelPeligrosidad() = 
		if (estaTransformadoEnRobot){
			30
		} else {
			15
		}

    method bulto() = 2

	method aplicarAccidente(){
		estaTransformadoEnRobot = not estaTransformadoEnRobot
	}
}

object paqueteDeLadrillos {
	var cantidad = 0 //se me indica que la cantidad puede variar, así que necesita un setter

	method cantidad(_cantidad) {
		cantidad = _cantidad
	}

	method peso() = 2 * cantidad

	method nivelPeligrosidad() = 2

    method bulto() = 
		if (cantidad <= 100){
			1
		} else {
			self.bultoSiEsta101aMayor()
		}

	method bultoSiEsta101aMayor() =
		if (cantidad >= 101 && cantidad <= 300){
			2
		} else { 3 }

	method aplicarAccidente(){
		if (cantidad >= 12) {
			cantidad -=12
		} else { cantidad = 0 }
	}
}

object arenaAGranel {
	var property peso = 0 
	//me indican que el paso es varianble, así que lo mejor es tener un setter y también que otros sepan su peso, entonces necesito un getter

	method nivelPeligrosidad() = 1
    
	method bulto() = 1 

	method aplicarAccidente(){
		peso += 20
	}
}

object bateriaAntiaerea {
	var tieneMisilesCargados = true //necesita un setter

    method tieneMisilesCargados(_tieneMisilesCargados) {
	  tieneMisilesCargados = _tieneMisilesCargados
	}

	method peso() = 
		if (tieneMisilesCargados){
			300
		} else {
			200
		}

	method nivelPeligrosidad() = 
		if (tieneMisilesCargados){
		    100
    	} else {
			0
		}
    
	method bulto() = 
		if (tieneMisilesCargados){
			2
		} else {
			1
		}
	
	method aplicarAccidente(){
		tieneMisilesCargados = false
	}
}

object resuidosRadioactivos {
	var property peso = 0 //lo mismo que arena

	method nivelPeligrosidad() = 200 
    method bulto() = 1 

	method aplicarAccidente(){
		peso += 15
	}
}

object contenedor {
  const pesoVacio = 100
  const cosas = []
  const bultoDeContenedor = 1

  method cargar(unaCosa) {
	cosas.add(unaCosa)
  }

  method peso() =  pesoVacio + self.pesoDeContenido()

  method pesoDeContenido() = cosas.sum { cosa => cosa.peso()}

  method nivelPeligrosidad() = self.elMasPeligroso()

  method elMasPeligroso() = 
    if (cosas.isEmpty()){ 
	    0
	} else { (cosas.max { cosa => cosa.nivelPeligrosidad()}).nivelPeligrosidad() }

  method aplicarAccidente(){
		cosas.map{ elemento => elemento.aplicarAccidente() }
  }

  method bulto() = cosas.sum({ cosa => cosa.bulto() }) + bultoDeContenedor
}

object embalajeDeSeguridad {
  var cosaEnvuelta = null
  const bultoDeEmbalaje = 2

  method cosaEnvuelta(_cosaEnvuelta) {
    cosaEnvuelta = _cosaEnvuelta
  }

  method peso() = cosaEnvuelta.peso()

  method nivelPeligrosidad() = cosaEnvuelta.nivelPeligrosidad() / 2

  method aplicarAccidente(){
  }

  method bulto() = bultoDeEmbalaje
}
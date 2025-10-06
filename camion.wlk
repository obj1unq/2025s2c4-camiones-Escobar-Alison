import cosas.*

object camion {
	const property cosas = [] //por test es property
	const tara = 1000
	const pesoMaximo = 2500
	

	method cargar(unaCosa) {
		if (self.contengoA(unaCosa)) 
			self.error("Ya está " + unaCosa + " en el camión")
	    else { cosas.add(unaCosa) }
	}

	method descargar(unaCosa) {
	    if (not self.contengoA(unaCosa)) 
			self.error("No está " + unaCosa + " en el camión")
	    else { cosas.remove(unaCosa) }
	}

	method contengoA(unaCosa) = cosas.contains(unaCosa)

	method todoPesoEsPar() = cosas.all { cosa => cosa.peso()%2 == 0}

	method estaExcedidoDePeso() = self.pesoTotal() > pesoMaximo

	method pesoTotal() = tara + self.pesoDeCarga()

	method pesoDeCarga() = cosas.sum { cosa => cosa.peso() }

	method hayAlgunoQuePesa(pesoKg) = cosas.any {cosa => cosa.peso() == pesoKg}

    method cosaConNivelPeligoso(nivel) = cosas.find {cosa => cosa.nivelPeligrosidad() == nivel} //

	method cosasMasPeligrosasQueNivel(nivel) =  cosas.filter { cosa => cosa.nivelPeligrosidad() > nivel }
	
	method cosasMasPeligrosasQue(otraCosa) = self.cosasMasPeligrosasQueNivel(otraCosa.nivelPeligrosidad())

	method puedeCircularEnRuta(nivelMaximo) = not self.estaExcedidoDePeso() && not self.hayCosasQueSuperen(nivelMaximo)

    method hayCosasQueSuperen(nivelMaximo) = cosas.any { cosa => cosa.nivelPeligrosidad() > nivelMaximo }
    
	method cosaMasPesada() = cosas.max { cosa => cosa.peso() } //

	method contengoAlgunaCosaQuePesaEntre_Y_(minimo,maximo) = cosas.any { cosa => cosa.peso() > minimo && cosa.peso() < maximo }

	method pesos() = cosas.map { cosa => cosa.peso() }

	method totalBultos() = cosas.sum({cosa => cosa.bulto()})

	method accidente(){
		 cosas.map{ elemento => elemento.aplicarAccidente() }
	}

	method transportar(destino, camino){
		if (not self.puedeCircularEnRuta(camino))
			self.error("No se puede ir, el camino no es el adecuado para circular")
		else{ almacen.stock().addAll(cosas)
			      cosas.clear()
	    }
	}
}

object ruta {
  var property nivelPeligrosidadPermitido = 0
}

object almacen {
  var property stock = []
}
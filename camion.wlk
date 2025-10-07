import cosas.*

object camion {
	const property cosas = [] //por test es property
	const tara = 1000
	const pesoMaximo = 2500
	

	method cargar(unaCosa) {
		self.validarContenidoParaCargar(unaCosa)
		cosas.add(unaCosa)
	}

    method validarContenidoParaCargar(unaCosa){
			if (self.contengoA(unaCosa)) {
				self.error("Ya está " + unaCosa + " en el camión")
			}
	}

	method descargar(unaCosa) {
	    self.validarContenidoParaDescargar(unaCosa)
	    cosas.remove(unaCosa) 
	}

	method validarContenidoParaDescargar(unaCosa) {
	  if (not self.contengoA(unaCosa)) {
			self.error("No está " + unaCosa + " en el camión")
	  }
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
		 cosas.forEach { elemento => elemento.aplicarAccidente() }
	}
	
	method transportar(destino, camino){
		self.validarCirculacionEnRuta(camino)
		cosas.forEach { cosa => destino.cargar(cosa) }	    
		cosas.clear()
	}
	
	method validarCirculacionEnRuta(camino) {
	    if (not camino.puedeCircular(self)){
			self.error("No se puede ir, el camino no es el adecuado para circular")
		}
	}
}

object ruta9 {
  const nivelPeligrosidadPermitido = 20
  
  method puedeCircular(camion) = camion.puedeCircularEnRuta(nivelPeligrosidadPermitido)

}


object almacen {
  const stock = []

  method stock() = stock

  method cargar(unaCosa) {
	stock.add(unaCosa)
  }
}
class Utils {
  // Función para obtener la fecha actual en formato deseado
  static String  obtenerFechaActual() {
    final DateTime now = DateTime.now();
    final String formattedDate = "${now.day} de ${obtenerMes(now.month)} ${now.year}";
    return formattedDate;
  }

  // Función para obtener el nombre del mes
  static String obtenerMes(int month) {
    switch (month) {
      case 1:
        return "Enero";
      case 2:
        return "Febrero";
      case 3:
        return "Marzo";
      case 4:
        return "Abril";
      case 5:
        return "Mayo";
      case 6:
        return "Junio";
      case 7:
        return "Julio";
      case 8:
        return "Agosto";
      case 9:
        return "Septiembre";
      case 10:
        return "Octubre";
      case 11:
        return "Noviembre";
      case 12:
        return "Diciembre";
      default:
        return "";
    }
  }

  // Función para determinar el clima
  static String determinarClima(String estadoClima) {
    switch (estadoClima) {

      case "Soleado":
        return "assets/images/soleado.png";

      case "Parcialmente nublado":
        return "assets/images/parcialmente-nublado.png";

      case "Nublado":
        return "assets/images/nublado.png"; 

      case "Cielo cubierto":
        return "assets/images/nublado.png";

      case "Despejado":
        return "assets/images/cielo-despejado.png";

      case "Lluvia  moderada a intervalos":
        return "assets/images/lluvia moderada.png"; 

      case "Ligeras lluvias":
        return "assets/images/lluvia moderada.png";

      case "Ligeras precipitaciones":
        return "assets/images/lluvia ligera.png";

      case "Lluvia moderada":
        return "assets/images/lluvia-intensa.png";

      case "Lluvia intensa":
        return "assets/images/lluvia.png";

      case "Granizo":
        return "assets/images/granizo.png"; 

      case "Tormenta":
        return "assets/images/tormenta.png";

      case "Neblina":
        return "assets/images/neblina.png"; 

      case "Viento":
        return "assets/images/viento.png";

      case "Nevada":
        return "assets/images/nevada.png";

      case "Nieve moderada a intervalos en las aproximaciones":
        return "assets/images/nevada.png";

      case "Aguanieve moderada a intervalos en las aproximaciones":
        return "assets/images/nevada.png";

      case "Llovizna helada a intervalos en las aproximaciones":
        return "assets/images/nevada.png";

      case "Cielos tormentosos en las aproximaciones":
        return "assets/images/muy-nublado.png";

      case "Chubascos de nieve":
        return "assets/images/nevada.png";

      case "Ventisca":
        return "assets/images/vientoClima.png";

      case "Niebla moderada":
        return "assets/images/niebla.png";

      case "Niebla helada":
        return "assets/images/niebla.png";

      case "Llovizna a intervalos":
        return "assets/images/lluvia moderada.png";

      case "Llovizna":
        return "assets/images/lluvia moderada.png";

      case "Llovizna helada":
        return "assets/images/lluvia moderada.png";

      case "Fuerte llovizna helada":
        return "assets/images/lluvia.png";

      case "Lluvias ligeras a intervalos":
        return "assets/images/lluvia ligera.png";

      case "Periodos de lluvia moderada":
        return "assets/images/lluvia moderada.png";

      case "Periodos de fuertes lluvias":
        return "assets/images/lluvia.png";

      case "Fuertes lluvias":
        return "assets/images/lluvia.png";

      case "Ligeras lluvias heladas":
        return "assets/images/lluvia ligera.png";

      case "Lluvias heladas fuertes o moderadas":
        return "assets/images/lluvia.png";

      case "Ligeras precipitaciones de aguanieve":
        return "assets/images/lluvia ligera.png";

      case "Nevadas ligeras a intervalos":
        return "assets/images/nevada.png";

      case "Nevadas ligeras":
        return "assets/images/nevada.png";

      case "Nieve moderada a intervalos":
        return "assets/images/nevada.png";

      case "Nieve moderada":
        return "assets/images/nevada.png";

      case "Nevadas intensas":
        return "assets/images/nevada.png";

      case "Fuertes nevadas":
        return "assets/images/nevada.png";

      case "Lluvias fuertes o moderadas":
        return "assets/images/lluvia.png";

      case "Lluvias torrenciales":
        return "assets/images/lluvia-moderada-intensa con truenos.png";

      case "Ligeros chubascos de aguanieve":
        return "assets/images/nevada.png";

      case "Chubascos de aguanieve fuertes o moderados":
        return "assets/images/nevada.png";

      case "Ligeras precipitaciones de nieve":
        return "assets/images/nevada.png";

      case "Chubascos de nieve fuertes o moderados":
        return "assets/images/nevada.png";

      case "Ligeros chubascos acompañados de granizo":
        return "assets/images/granizada.png";

      case "Chubascos fuertes o moderados acompañados de granizo":
        return "assets/images/granizada.png";

      case "Intervalos de lluvias ligeras con tomenta en la región":
        return "assets/images/lluvia ligera.png";

      case "Lluvias con tormenta fuertes o moderadas en la región":
        return "assets/images/tormenta.png";

      case "Nieve moderada con tormenta en la región":
        return "assets/images/nevada.png";

      case "Nieve moderada o fuertes nevadas con tormenta en la región":
        return "assets/images/nevada.png";

      default:
        return "assets/images/small_logo.png";
    }
}

}
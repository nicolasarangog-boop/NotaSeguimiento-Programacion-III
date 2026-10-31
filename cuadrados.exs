
defmodule Cuadrados do
  @moduledoc """
  Modulo para generar una imagen SVG con cuadrados concéntricos
  - Autores: Briyith Sanchez Alonso y Nicolás Arango Gutiérrez
  - Fecha: Octubre del 2026
  - Licencia: GNU GPL V3
  """
  # Constantes del módulo
  @lado 300
  @x 50
  @y 50
  @cantidad 30
  @reduccion 10

  @doc """
  Genera el archivo SVG con los cuadrados concéntricos.

  ## Parámetros
  - archivo_salida: Ruta del archivo donde se guardará la imagen SVG.

  ## Ejemplo
      Cuadrados.generar("cuadrados.svg")
  """
  def generar(archivo_salida) do
    cuadrados =
      dibujar(@x, @y, @lado, @cantidad, @reduccion)

    svg = """
    <svg xmlns="http://www.w3.org/2000/svg"
         width="400" height="400" viewBox="0 0 400 400">
    #{cuadrados}
    </svg>
    """

    File.write!(archivo_salida, svg)
    IO.puts("Imagen creada: #{archivo_salida}")
  end

# Caso base para la recursión: si la cantidad es menor o igual a 0, no se dibuja nada.
  defp dibujar(_x, _y, _lado, cantidad, _reduccion)
       when cantidad <= 0 do
    ""
  end

# Caso recursivo: dibuja un cuadrado y llama a sí mismo para generar los siguientes.
  defp dibujar(x, y, lado, cantidad, reduccion)
       when lado > 0 and cantidad > 0 do
    cuadrado = dibujar_cuadrado(x, y, lado, cantidad)

    nuevo_lado = lado - reduccion
    nuevo_x = x + reduccion / 2
    nuevo_y = y + reduccion / 2

    if cantidad > 1 and nuevo_lado > 0 do
      cuadrado <>
        "\n" <>
        dibujar(nuevo_x, nuevo_y, nuevo_lado, cantidad - 1, reduccion)
    else
      cuadrado
    end
  end

# Función para dibujar un cuadrado individual con el color alternante entre blanco y negro.
  defp dibujar_cuadrado(x, y, lado, cantidad) do
    color = if rem(cantidad, 2) == 0, do: "white", else: "black"

    """
      <rect x="#{x}" y="#{y}"
            width="#{lado}" height="#{lado}"
            fill="#{color}" stroke="black" stroke-width="2"/>
    """
  end
end

Cuadrados.generar("cuadrados.svg")

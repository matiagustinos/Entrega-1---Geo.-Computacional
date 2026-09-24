# =========================================================
# geometria.jl
# Funciones generales para trabajar con puntos en el plano
# =========================================================

struct Punto
    x::Float64
    y::Float64
end


# ---------------------------------------------------------
# Producto cruzado de tres puntos
#
# > 0  -> giro antihorario
# < 0  -> giro horario
# = 0  -> puntos colineales
# ---------------------------------------------------------

function producto_cruzado(p1::Punto, p2::Punto, p3::Punto)

    return (p2.x - p1.x) * (p3.y - p1.y) -
           (p2.y - p1.y) * (p3.x - p1.x)
end


# ---------------------------------------------------------
# Orientación de tres puntos
#
#  1  -> antihorario
# -1  -> horario
#  0  -> colineales
# ---------------------------------------------------------

function orientacion(p1::Punto, p2::Punto, p3::Punto)

    valor = producto_cruzado(p1, p2, p3)

    if valor > 0
        return 1
    elseif valor < 0
        return -1
    else
        return 0
    end
end


# ---------------------------------------------------------
# Distancia al cuadrado entre dos puntos
#
# No necesitamos calcular raíz cuadrada porque para
# comparar distancias basta con la distancia al cuadrado.
# ---------------------------------------------------------

function distancia2(p1::Punto, p2::Punto)

    return (p2.x - p1.x)^2 +
           (p2.y - p1.y)^2
end


# ---------------------------------------------------------
# Mostrar un punto de forma más cómoda
# ---------------------------------------------------------

function mostrar_punto(p::Punto)

    println("(", p.x, ", ", p.y, ")")
end


# ---------------------------------------------------------
# Mostrar todos los puntos de una envolvente
# ---------------------------------------------------------

function mostrar_envolvente(envolvente)

    for p in envolvente
        mostrar_punto(p)
    end
end
# =========================================================
# quickhull.jl
# Algoritmo Quickhull
# =========================================================


# ---------------------------------------------------------
# Distancia de un punto a una recta AB
#
# No calculamos la distancia real.
# Para comparar basta con el valor absoluto
# del producto cruzado.
# ---------------------------------------------------------

function distancia_recta(a::Punto, b::Punto, p::Punto)

    return abs(producto_cruzado(a, b, p))
end


# ---------------------------------------------------------
# Función recursiva de Quickhull
# ---------------------------------------------------------

function quickhull_recursivo(
    puntos::Vector{Punto},
    a::Punto,
    b::Punto,
    envolvente::Vector{Punto}
)

    # Si no hay puntos en este lado de la recta,
    # no hay nada más que buscar.
    if isempty(puntos)
        return
    end


    # -----------------------------------------------------
    # Buscar el punto más alejado de la recta AB
    # -----------------------------------------------------

    indice_lejano = 1

    mayor_distancia =
        distancia_recta(a, b, puntos[1])


    for i in 2:length(puntos)

        distancia =
            distancia_recta(a, b, puntos[i])


        if distancia > mayor_distancia

            mayor_distancia = distancia

            indice_lejano = i
        end
    end


    punto_lejano = puntos[indice_lejano]


    # -----------------------------------------------------
    # Separar los puntos en dos nuevos subconjuntos
    # -----------------------------------------------------

    izquierda_a_p = Punto[]

    izquierda_p_b = Punto[]


    for p in puntos

        if p == punto_lejano
            continue
        end


        # Puntos a la izquierda de A -> punto_lejano
        if orientacion(a, punto_lejano, p) > 0

            push!(izquierda_a_p, p)


        # Puntos a la izquierda de punto_lejano -> B
        elseif orientacion(punto_lejano, b, p) > 0

            push!(izquierda_p_b, p)

        end
    end


    # -----------------------------------------------------
    # Resolver recursivamente la primera mitad
    # -----------------------------------------------------

    quickhull_recursivo(
        izquierda_a_p,
        a,
        punto_lejano,
        envolvente
    )


    # El punto más lejano pertenece a la envolvente
    push!(envolvente, punto_lejano)


    # -----------------------------------------------------
    # Resolver recursivamente la segunda mitad
    # -----------------------------------------------------

    quickhull_recursivo(
        izquierda_p_b,
        punto_lejano,
        b,
        envolvente
    )
end


# ---------------------------------------------------------
# Función principal Quickhull
# ---------------------------------------------------------

function quickhull(puntos::Vector{Punto})

    n = length(puntos)


    if n < 3
        return copy(puntos)
    end


    # -----------------------------------------------------
    # 1. Encontrar punto más a la izquierda
    #    y punto más a la derecha
    # -----------------------------------------------------

    indice_min = 1
    indice_max = 1


    for i in 2:n

        if puntos[i].x < puntos[indice_min].x

            indice_min = i

        elseif puntos[i].x == puntos[indice_min].x &&
               puntos[i].y < puntos[indice_min].y

            indice_min = i
        end


        if puntos[i].x > puntos[indice_max].x

            indice_max = i

        elseif puntos[i].x == puntos[indice_max].x &&
               puntos[i].y > puntos[indice_max].y

            indice_max = i
        end
    end


    a = puntos[indice_min]

    b = puntos[indice_max]


    # -----------------------------------------------------
    # 2. Dividir los puntos según qué lado de AB ocupan
    # -----------------------------------------------------

    izquierda = Punto[]

    derecha = Punto[]


    for p in puntos

        if p == a || p == b
            continue
        end


        giro = orientacion(a, b, p)


        if giro > 0

            push!(izquierda, p)

        elseif giro < 0

            push!(derecha, p)

        end
    end


    # -----------------------------------------------------
    # 3. Construir envolvente
    # -----------------------------------------------------

    envolvente = Punto[]


    push!(envolvente, a)


    # Parte superior
    quickhull_recursivo(
        izquierda,
        a,
        b,
        envolvente
    )


    push!(envolvente, b)


    # Parte inferior
    quickhull_recursivo(
        derecha,
        b,
        a,
        envolvente
    )


    return envolvente
end
# =========================================================
# graham.jl
# Graham Scan optimizado
#
# No utiliza atan().
# El orden angular se determina mediante producto cruzado.
# =========================================================


# ---------------------------------------------------------
# Buscar pivote
#
# Menor coordenada Y.
# En caso de empate, menor coordenada X.
# ---------------------------------------------------------

function encontrar_pivote(puntos::Vector{Punto})

    indice = 1

    for i in 2:length(puntos)

        if puntos[i].y < puntos[indice].y

            indice = i

        elseif puntos[i].y == puntos[indice].y &&
               puntos[i].x < puntos[indice].x

            indice = i

        end
    end

    return indice
end


# ---------------------------------------------------------
# Comparar dos puntos según su ángulo respecto al pivote
#
# En lugar de calcular atan(), usamos producto cruzado.
# ---------------------------------------------------------

function menor_angulo(
    pivote::Punto,
    a::Punto,
    b::Punto
)

    cruzado = producto_cruzado(
        pivote,
        a,
        b
    )


    # Si el producto cruzado es positivo,
    # a aparece antes que b en sentido antihorario.
    if cruzado > 0

        return true


    # Si están en la misma dirección,
    # ponemos primero el más cercano.
    elseif cruzado == 0

        return distancia2(pivote, a) <
               distancia2(pivote, b)

    end


    return false
end


# ---------------------------------------------------------
# Graham Scan
# ---------------------------------------------------------

function graham_scan(puntos::Vector{Punto})

    n = length(puntos)


    if n < 3
        return copy(puntos)
    end


    # -----------------------------------------------------
    # 1. Encontrar pivote
    # -----------------------------------------------------

    indice_pivote =
        encontrar_pivote(puntos)

    pivote =
        puntos[indice_pivote]


    # -----------------------------------------------------
    # 2. Crear arreglo de puntos excepto el pivote
    # -----------------------------------------------------

    otros = Punto[]

    sizehint!(otros, n - 1)


    for i in 1:n

        if i != indice_pivote

            push!(
                otros,
                puntos[i]
            )

        end
    end


    # -----------------------------------------------------
    # 3. Ordenar por ángulo SIN utilizar atan()
    # -----------------------------------------------------

    sort!(
        otros,
        lt = (a, b) ->
            menor_angulo(
                pivote,
                a,
                b
            )
    )


    # -----------------------------------------------------
    # 4. Crear pila
    # -----------------------------------------------------

    pila = Punto[]

    sizehint!(pila, n)

    push!(
        pila,
        pivote
    )


    # -----------------------------------------------------
    # 5. Recorrer puntos ordenados
    # -----------------------------------------------------

    for p in otros


        # Mientras tengamos al menos dos puntos
        # comprobamos el giro.
        while length(pila) >= 2

            p1 =
                pila[end - 1]

            p2 =
                pila[end]


            giro =
                producto_cruzado(
                    p1,
                    p2,
                    p
                )


            # Giro antihorario:
            # el punto pertenece por ahora
            # a la envolvente.
            if giro > 0

                break

            end


            # Giro horario o colineal:
            # eliminamos el último punto.
            pop!(pila)

        end


        push!(
            pila,
            p
        )

    end


    return pila
end
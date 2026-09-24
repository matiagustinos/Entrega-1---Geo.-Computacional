# =========================================================
# jarvis.jl
# Algoritmo Jarvis March
# =========================================================


function jarvis_march(puntos::Vector{Punto})

    n = length(puntos)

    # Si hay menos de 3 puntos no existe una envolvente
    # convexa propiamente tal.
    if n < 3
        return copy(puntos)
    end


    # -----------------------------------------------------
    # 1. Encontrar el punto más a la izquierda
    # -----------------------------------------------------

    inicio = 1

    for i in 2:n

        if puntos[i].x < puntos[inicio].x

            inicio = i

        elseif puntos[i].x == puntos[inicio].x &&
               puntos[i].y < puntos[inicio].y

            inicio = i
        end
    end


    # Aquí guardaremos los puntos de la envolvente
    envolvente = Punto[]


    # El primer punto actual es el punto más a la izquierda
    actual = inicio


    # -----------------------------------------------------
    # 2. Buscar los puntos de la envolvente
    # -----------------------------------------------------

    while true

        # Agregamos el punto actual
        push!(envolvente, puntos[actual])


        # Elegimos inicialmente cualquier punto distinto
        # del punto actual.
        if actual == 1
            siguiente = 2
        else
            siguiente = 1
        end


        # Revisamos todos los puntos
        for i in 1:n

            if i == actual
                continue
            end


            giro = orientacion(
                puntos[actual],
                puntos[siguiente],
                puntos[i]
            )


            # Si encontramos un punto más hacia la
            # izquierda, pasa a ser el nuevo candidato.
            if giro > 0

                siguiente = i


            # Si los puntos están alineados,
            # elegimos el más lejano.
            elseif giro == 0

                distancia_siguiente =
                    distancia2(
                        puntos[actual],
                        puntos[siguiente]
                    )

                distancia_i =
                    distancia2(
                        puntos[actual],
                        puntos[i]
                    )


                if distancia_i > distancia_siguiente
                    siguiente = i
                end
            end
        end


        # Avanzamos al siguiente punto de la envolvente
        actual = siguiente


        # Si volvimos al punto inicial terminamos
        if actual == inicio
            break
        end
    end


    return envolvente
end
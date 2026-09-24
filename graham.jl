# =========================================================
# graham.jl
# Graham Scan utilizando atan para ordenar por angulo
# =========================================================


# ---------------------------------------------------------
# Buscar pivote
# Menor Y, y en empate menor X
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
# Calcular angulo respecto al pivote
# ---------------------------------------------------------

function angulo(pivote::Punto, p::Punto)

    return atan(
        p.y - pivote.y,
        p.x - pivote.x
    )
end


# ---------------------------------------------------------
# Graham Scan
# ---------------------------------------------------------

function graham_scan(puntos::Vector{Punto})

    n = length(puntos)

    if n < 3
        return copy(puntos)
    end


    # 1. Buscar pivote
    indice_pivote =
        encontrar_pivote(puntos)

    pivote =
        puntos[indice_pivote]


    # 2. Copiar los demas puntos
    otros = Punto[]

    for i in 1:n

        if i != indice_pivote

            push!(
                otros,
                puntos[i]
            )
        end
    end


    # 3. Ordenar por angulo
    #
    # Si dos puntos tienen el mismo angulo,
    # se ordenan por distancia al pivote
    sort!(
        otros,
        by = p -> (
            angulo(pivote, p),
            distancia2(pivote, p)
        )
    )


    # 4. Crear pila
    pila = Punto[]

    push!(
        pila,
        pivote
    )


    # 5. Recorrer puntos ordenados
    for p in otros

        while length(pila) >= 2

            p1 =
                pila[end - 1]

            p2 =
                pila[end]


            giro =
                orientacion(
                    p1,
                    p2,
                    p
                )


            # Si gira a la izquierda,
            # el punto anterior se conserva
            if giro > 0

                break

            else

                # Si gira a la derecha o es colineal,
                # eliminamos el ultimo punto
                pop!(pila)

            end
        end


        push!(
            pila,
            p
        )
    end


    return pila
end
# =========================================================
# verificar_envolventes.jl
#
# Guarda y compara las envolventes obtenidas por:
# - Jarvis March
# - Graham Scan
# - Quickhull
# =========================================================


# ---------------------------------------------------------
# Convertir una envolvente en un conjunto de coordenadas
#
# Se redondean las coordenadas para evitar pequeños
# errores de punto flotante.
# ---------------------------------------------------------

function convertir_a_conjunto(envolvente)

    return Set(
        (
            round(p.x, digits = 12),
            round(p.y, digits = 12)
        )
        for p in envolvente
    )
end


# ---------------------------------------------------------
# Guardar una envolvente en un archivo CSV
# ---------------------------------------------------------

function guardar_envolvente(nombre_archivo, envolvente)

    archivo = open(nombre_archivo, "w")

    # Cabecera
    println(
        archivo,
        "x,y"
    )

    # Guardar cada punto
    for p in envolvente

        println(
            archivo,
            p.x,
            ",",
            p.y
        )

    end

    close(archivo)
end


# ---------------------------------------------------------
# Comparar las tres envolventes
# ---------------------------------------------------------

function verificar_envolventes(puntos)

    println()
    println("===================================================")
    println(" VERIFICACION DE ENVOLVENTES")
    println("===================================================")


    # -----------------------------------------------------
    # Ejecutar los tres algoritmos
    # -----------------------------------------------------

    hull_jarvis =
        jarvis_march(puntos)

    hull_graham =
        graham_scan(puntos)

    hull_quickhull =
        quickhull(puntos)


    # -----------------------------------------------------
    # Mostrar cantidad de puntos
    # -----------------------------------------------------

    println()
    println(
        "Jarvis:    ",
        length(hull_jarvis),
        " puntos"
    )

    println(
        "Graham:    ",
        length(hull_graham),
        " puntos"
    )

    println(
        "Quickhull: ",
        length(hull_quickhull),
        " puntos"
    )


    # -----------------------------------------------------
    # Crear carpeta para guardar resultados
    # -----------------------------------------------------

    mkpath("envolventes")


    # -----------------------------------------------------
    # Guardar envolventes
    # -----------------------------------------------------

    guardar_envolvente(
        "envolventes/jarvis.csv",
        hull_jarvis
    )

    guardar_envolvente(
        "envolventes/graham.csv",
        hull_graham
    )

    guardar_envolvente(
        "envolventes/quickhull.csv",
        hull_quickhull
    )


    # -----------------------------------------------------
    # Convertir a conjuntos
    # -----------------------------------------------------

    conjunto_jarvis =
        convertir_a_conjunto(
            hull_jarvis
        )

    conjunto_graham =
        convertir_a_conjunto(
            hull_graham
        )

    conjunto_quickhull =
        convertir_a_conjunto(
            hull_quickhull
        )


    # -----------------------------------------------------
    # Comparar
    # -----------------------------------------------------

    jarvis_graham =
        conjunto_jarvis ==
        conjunto_graham

    jarvis_quickhull =
        conjunto_jarvis ==
        conjunto_quickhull

    graham_quickhull =
        conjunto_graham ==
        conjunto_quickhull


    println()
    println("-----------------------------------------------")
    println("RESULTADO DE LA COMPARACION")
    println("-----------------------------------------------")

    println(
        "Jarvis == Graham:    ",
        jarvis_graham
    )

    println(
        "Jarvis == Quickhull: ",
        jarvis_quickhull
    )

    println(
        "Graham == Quickhull: ",
        graham_quickhull
    )


    # -----------------------------------------------------
    # Comprobar si todos son iguales
    # -----------------------------------------------------

    if jarvis_graham &&
       jarvis_quickhull &&
       graham_quickhull

        println()
        println(
            "CORRECTO: Los tres algoritmos obtuvieron los mismos puntos."
        )

    else

        println()
        println(
            "ADVERTENCIA: Las envolventes no son iguales."
        )


        # Mostrar diferencias
        println()
        println("Puntos de Jarvis que no aparecen en Graham:")

        for p in setdiff(
            conjunto_jarvis,
            conjunto_graham
        )
            println(p)
        end


        println()
        println("Puntos de Graham que no aparecen en Jarvis:")

        for p in setdiff(
            conjunto_graham,
            conjunto_jarvis
        )
            println(p)
        end


        println()
        println("Puntos de Jarvis que no aparecen en Quickhull:")

        for p in setdiff(
            conjunto_jarvis,
            conjunto_quickhull
        )
            println(p)
        end


        println()
        println("Puntos de Quickhull que no aparecen en Jarvis:")

        for p in setdiff(
            conjunto_quickhull,
            conjunto_jarvis
        )
            println(p)
        end

    end


    println()
    println("Envolventes guardadas en la carpeta:")
    println("envolventes/")

end
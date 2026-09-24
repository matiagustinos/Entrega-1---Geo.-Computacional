# =========================================================
# experimentos.jl
# Comparación experimental de los algoritmos
# =========================================================

using Random
using Statistics


# ---------------------------------------------------------
# Generar n puntos aleatorios
# ---------------------------------------------------------

function generar_puntos(n)

    puntos = Punto[]


    for i in 1:n

        x = rand() * 1000
        y = rand() * 1000


        push!(
            puntos,
            Punto(x, y)
        )
    end


    return puntos
end


# ---------------------------------------------------------
# Medir el tiempo promedio de un algoritmo
# ---------------------------------------------------------

function medir_tiempo(algoritmo, puntos, repeticiones)

    tiempos = Float64[]


    for i in 1:repeticiones

        tiempo = @elapsed algoritmo(puntos)

        push!(tiempos, tiempo)
    end


    return mean(tiempos)
end


# ---------------------------------------------------------
# Ejecutar experimentos
# ---------------------------------------------------------

function ejecutar_experimentos()

    # Cantidades de puntos a probar
    tamanos = [
        100,
        500,
        1000,
        2000,
        5000,
        10000,
        30000,
        50000,
        70000,
        100000,
        150000
    ]


    # Número de repeticiones por experimento
    repeticiones = 5


    println()
    println("==============================================")
    println(" EXPERIMENTOS ENVOLVENTE CONVEXA")
    println("==============================================")
    println()


    println(
        "n",
        "\t",
        "Jarvis",
        "\t\t",
        "Graham",
        "\t\t",
        "Quickhull"
    )


    # -----------------------------------------------------
    # Archivo donde guardaremos los resultados
    # -----------------------------------------------------

    archivo = open(
        "resultados.csv",
        "w"
    )


    println(
        archivo,
        "n,jarvis,graham,quickhull"
    )


    # -----------------------------------------------------
    # Ejecutar cada tamaño
    # -----------------------------------------------------

    for n in tamanos

        puntos = generar_puntos(n)


        # Primera ejecución para que Julia compile
        # las funciones antes de medir.
        jarvis_march(puntos)
        graham_scan(puntos)
        quickhull(puntos)


        # Medir tiempos
        tiempo_jarvis =
            medir_tiempo(
                jarvis_march,
                puntos,
                repeticiones
            )


        tiempo_graham =
            medir_tiempo(
                graham_scan,
                puntos,
                repeticiones
            )


        tiempo_quickhull =
            medir_tiempo(
                quickhull,
                puntos,
                repeticiones
            )


        # Mostrar en pantalla
        println(
            n,
            "\t",
            round(tiempo_jarvis, digits = 6),
            "\t",
            round(tiempo_graham, digits = 6),
            "\t",
            round(tiempo_quickhull, digits = 6)
        )


        # Guardar en CSV
        println(
            archivo,
            n,
            ",",
            tiempo_jarvis,
            ",",
            tiempo_graham,
            ",",
            tiempo_quickhull
        )
    end


    close(archivo)


    println()
    println("==============================================")
    println("Experimentos terminados.")
    println("Resultados guardados en resultados.csv")
    println("==============================================")
end
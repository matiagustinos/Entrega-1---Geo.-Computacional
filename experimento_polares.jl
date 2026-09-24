# =========================================================
# experimentos_polares.jl
#
# Experimento con distribución polar y distintas
# proporciones de puntos en la envolvente convexa.
#
# Se probarán:
# 10%  -> 1/10 de los puntos en R = 1
# 25%  -> 1/4  de los puntos en R = 1
# 40%  -> 2/5  de los puntos en R = 1
#
# El resto de los puntos tendrá:
# R aleatorio entre 0 y 1
# theta aleatorio entre 0 y 2pi
# =========================================================

using Random
using Statistics


# =========================================================
# GENERAR PUNTOS POLARES
# =========================================================

function generar_puntos_polares(
    n,
    proporcion_borde
)

    puntos = Punto[]

    sizehint!(puntos, n)


    # -----------------------------------------------------
    # Cantidad de puntos que estarán en la circunferencia
    # -----------------------------------------------------

    cantidad_borde =
        round(
            Int,
            n * proporcion_borde
        )


    # -----------------------------------------------------
    # Cantidad de puntos interiores
    # -----------------------------------------------------

    cantidad_interior =
        n - cantidad_borde


    # -----------------------------------------------------
    # 1. Generar puntos sobre la circunferencia
    #
    # R = 1
    # theta aleatorio entre 0 y 2pi
    # -----------------------------------------------------

    for i in 1:cantidad_borde

        r = 1.0

        theta =
            rand() * 2 * pi


        x =
            r * cos(theta)

        y =
            r * sin(theta)


        push!(
            puntos,
            Punto(x, y)
        )

    end


    # -----------------------------------------------------
    # 2. Generar puntos interiores
    #
    # R aleatorio entre 0 y 1
    # theta aleatorio entre 0 y 2pi
    # -----------------------------------------------------

    for i in 1:cantidad_interior

        r = rand()

        theta =
            rand() * 2 * pi


        x =
            r * cos(theta)

        y =
            r * sin(theta)


        push!(
            puntos,
            Punto(x, y)
        )

    end


    return puntos
end


# =========================================================
# MEDIR TIEMPO PROMEDIO
# =========================================================

function medir_tiempo_polar(
    algoritmo,
    puntos,
    repeticiones
)

    tiempos = Float64[]


    for i in 1:repeticiones

        tiempo =
            @elapsed algoritmo(puntos)


        push!(
            tiempos,
            tiempo
        )

    end


    return mean(tiempos)
end


# =========================================================
# EJECUTAR EXPERIMENTOS POLARES
# =========================================================

function ejecutar_experimentos_polares()


    # -----------------------------------------------------
    # Cantidades de puntos
    # -----------------------------------------------------

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


    # -----------------------------------------------------
    # Proporciones de puntos en la circunferencia
    # -----------------------------------------------------

    proporciones = [
        0.10,   # 1/10
        0.25,   # 1/4
        0.40    # 2/5
    ]


    # -----------------------------------------------------
    # Cantidad de repeticiones de cada medición
    # -----------------------------------------------------

    repeticiones = 5


    println()
    println("===================================================")
    println(" EXPERIMENTOS CON DISTRIBUCION POLAR")
    println("===================================================")
    println()

    println("Proporciones de puntos en R = 1:")
    println("10%  -> 1/10")
    println("25%  -> 1/4")
    println("40%  -> 2/5")

    println()


    # -----------------------------------------------------
    # Crear archivo CSV
    # -----------------------------------------------------

    archivo =
        open(
            "resultados_polares.csv",
            "w"
        )


    # Cabecera CSV
    println(
        archivo,
        "proporcion,n,jarvis,graham,quickhull,h"
    )


    # =====================================================
    # RECORRER CADA PROPORCIÓN
    # =====================================================

    for proporcion in proporciones


        println()
        println("===================================================")
        println(
            "PROPORCION DE PUNTOS EN BORDE = ",
            proporcion * 100,
            "%"
        )
        println("===================================================")


        # =================================================
        # RECORRER CADA TAMAÑO
        # =================================================

        for n in tamanos


            println()
            println("-----------------------------------------------")
            println("Probando n = ", n)
            println("-----------------------------------------------")


            # ---------------------------------------------
            # Generar conjunto de puntos
            # ---------------------------------------------

            puntos =
                generar_puntos_polares(
                    n,
                    proporcion
                )


            # ---------------------------------------------
            # Primera ejecución
            #
            # Sirve para que Julia compile las funciones
            # antes de medir los tiempos.
            # ---------------------------------------------

            hull_jarvis =
                jarvis_march(puntos)

            graham_scan(puntos)

            quickhull(puntos)


            # ---------------------------------------------
            # Cantidad real de puntos en la envolvente
            # ---------------------------------------------

            h =
                length(hull_jarvis)


            # ---------------------------------------------
            # Medir Jarvis
            # ---------------------------------------------

            tiempo_jarvis =
                medir_tiempo_polar(
                    jarvis_march,
                    puntos,
                    repeticiones
                )


            # ---------------------------------------------
            # Medir Graham
            # ---------------------------------------------

            tiempo_graham =
                medir_tiempo_polar(
                    graham_scan,
                    puntos,
                    repeticiones
                )


            # ---------------------------------------------
            # Medir Quickhull
            # ---------------------------------------------

            tiempo_quickhull =
                medir_tiempo_polar(
                    quickhull,
                    puntos,
                    repeticiones
                )


            # ---------------------------------------------
            # Mostrar resultados en consola
            # ---------------------------------------------

            println(
                "Proporcion = ",
                proporcion,
                " | n = ",
                n,
                " | h = ",
                h
            )


            println(
                "Jarvis    = ",
                round(
                    tiempo_jarvis,
                    digits = 6
                ),
                " s"
            )


            println(
                "Graham    = ",
                round(
                    tiempo_graham,
                    digits = 6
                ),
                " s"
            )


            println(
                "Quickhull = ",
                round(
                    tiempo_quickhull,
                    digits = 6
                ),
                " s"
            )


            # ---------------------------------------------
            # Guardar resultados en CSV
            # ---------------------------------------------

            println(
                archivo,
                proporcion,
                ",",
                n,
                ",",
                tiempo_jarvis,
                ",",
                tiempo_graham,
                ",",
                tiempo_quickhull,
                ",",
                h
            )

        end
    end


    # -----------------------------------------------------
    # Cerrar archivo
    # -----------------------------------------------------

    close(archivo)


    println()
    println("===================================================")
    println(" EXPERIMENTOS FINALIZADOS")
    println("===================================================")

    println()
    println("Resultados guardados en:")
    println("resultados_polares.csv")

end
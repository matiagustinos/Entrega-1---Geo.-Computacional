# =========================================================
# main.jl
# Programa principal
# =========================================================


# Cargar archivos
include("geometria.jl")
include("jarvis.jl")
include("graham.jl")
include("quickhull.jl")
include("experimentos.jl")
include("experimento_polares.jl")
include("verificar_envolventes.jl")

println()
println("==============================================")
println(" ENVOLVENTE CONVEXA")
println("==============================================")
println()


# ---------------------------------------------------------
# Conjunto pequeño de puntos para comprobar algoritmos
# ---------------------------------------------------------

puntos = [

    Punto(0.0, 0.0),
    Punto(1.0, 1.0),
    Punto(2.0, 0.0),
    Punto(3.0, 1.0),
    Punto(3.0, 3.0),
    Punto(2.0, 4.0),
    Punto(0.0, 4.0),
    Punto(-1.0, 2.0),

    # Puntos interiores
    Punto(1.0, 2.0),
    Punto(2.0, 2.0),
    Punto(1.5, 1.5),
    Punto(1.5, 3.0)
]


# ---------------------------------------------------------
# Mostrar puntos originales
# ---------------------------------------------------------

println("PUNTOS ORIGINALES:")
println()

mostrar_envolvente(puntos)


# ---------------------------------------------------------
# JARVIS MARCH
# ---------------------------------------------------------

println()
println("----------------------------------------------")
println("JARVIS MARCH")
println("----------------------------------------------")

envolvente_jarvis =
    jarvis_march(puntos)

mostrar_envolvente(
    envolvente_jarvis
)


# ---------------------------------------------------------
# GRAHAM SCAN
# ---------------------------------------------------------

println()
println("----------------------------------------------")
println("GRAHAM SCAN")
println("----------------------------------------------")

envolvente_graham =
    graham_scan(puntos)

mostrar_envolvente(
    envolvente_graham
)


# ---------------------------------------------------------
# QUICKHULL
# ---------------------------------------------------------

println()
println("----------------------------------------------")
println("QUICKHULL")
println("----------------------------------------------")

envolvente_quickhull =
    quickhull(puntos)

mostrar_envolvente(
    envolvente_quickhull
)

puntos_a_verificar = generar_puntos(1000)

verificar_envolventes(puntos_a_verificar)

# ---------------------------------------------------------
# Ejecutar experimentos
# ---------------------------------------------------------

println()
println("¿Desea ejecutar los experimentos?")

println("1 - Si")
println("2 - No")

print("Opcion: ")

opcion = readline()


if opcion == "1"

    ejecutar_experimentos()
    ejecutar_experimentos_polares()

else

    println("Programa finalizado.")

end
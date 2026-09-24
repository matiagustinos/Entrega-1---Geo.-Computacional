# =========================================================
# graficos.jl
# Graficos de los experimentos de envolvente convexa
# =========================================================

using CSV
using DataFrames
using Plots


# =========================================================
# 1. GRAFICO DEL EXPERIMENTO ORIGINAL
# =========================================================

datos = CSV.read(
    "resultados.csv",
    DataFrame
)

println("Resultados experimento original:")
println(datos)


p1 = plot(
    datos.n,
    datos.jarvis,
    label = "Jarvis March",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Comparacion de algoritmos - distribucion uniforme",
    legend = :topleft
)

plot!(
    p1,
    datos.n,
    datos.graham,
    label = "Graham Scan",
    marker = :square,
    linewidth = 2
)

plot!(
    p1,
    datos.n,
    datos.quickhull,
    label = "Quickhull",
    marker = :diamond,
    linewidth = 2
)

display(p1)

savefig(
    p1,
    "plots/comparacion_algoritmos.png"
)


# =========================================================
# 2. LEER RESULTADOS POLARES
# =========================================================

datos_polares = CSV.read(
    "resultados_polares.csv",
    DataFrame
)

println()
println("Resultados experimentos polares:")
println(datos_polares)


# =========================================================
# 3. SEPARAR DATOS SEGUN PROPORCION
# =========================================================

datos_10 = filter(
    row -> isapprox(row.proporcion, 0.10),
    datos_polares
)

datos_25 = filter(
    row -> isapprox(row.proporcion, 0.25),
    datos_polares
)

datos_40 = filter(
    row -> isapprox(row.proporcion, 0.40),
    datos_polares
)


# =========================================================
# 4. GRAFICO POLAR 10%
# =========================================================

p2 = plot(
    datos_10.n,
    datos_10.jarvis,
    label = "Jarvis March",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Distribucion polar - 10% en el borde",
    legend = :topleft
)

plot!(
    p2,
    datos_10.n,
    datos_10.graham,
    label = "Graham Scan",
    marker = :square,
    linewidth = 2
)

plot!(
    p2,
    datos_10.n,
    datos_10.quickhull,
    label = "Quickhull",
    marker = :diamond,
    linewidth = 2
)

display(p2)

savefig(
    p2,
    "plots/comparacion_polar_10.png"
)


# =========================================================
# 5. GRAFICO POLAR 25%
# =========================================================

p3 = plot(
    datos_25.n,
    datos_25.jarvis,
    label = "Jarvis March",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Distribucion polar - 25% en el borde",
    legend = :topleft
)

plot!(
    p3,
    datos_25.n,
    datos_25.graham,
    label = "Graham Scan",
    marker = :square,
    linewidth = 2
)

plot!(
    p3,
    datos_25.n,
    datos_25.quickhull,
    label = "Quickhull",
    marker = :diamond,
    linewidth = 2
)

display(p3)

savefig(
    p3,
    "plots/comparacion_polar_25.png"
)


# =========================================================
# 6. GRAFICO POLAR 40%
# =========================================================

p4 = plot(
    datos_40.n,
    datos_40.jarvis,
    label = "Jarvis March",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Distribucion polar - 40% en el borde",
    legend = :topleft
)

plot!(
    p4,
    datos_40.n,
    datos_40.graham,
    label = "Graham Scan",
    marker = :square,
    linewidth = 2
)

plot!(
    p4,
    datos_40.n,
    datos_40.quickhull,
    label = "Quickhull",
    marker = :diamond,
    linewidth = 2
)

display(p4)

savefig(
    p4,
    "plots/comparacion_polar_40.png"
)


# =========================================================
# 7. COMPARACION DE LOS TRES JARVIS
# =========================================================

p5 = plot(
    datos_10.n,
    datos_10.jarvis,
    label = "Jarvis - 10% borde",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Jarvis March segun cantidad de puntos en el borde",
    legend = :topleft
)

plot!(
    p5,
    datos_25.n,
    datos_25.jarvis,
    label = "Jarvis - 25% borde",
    marker = :square,
    linewidth = 2
)

plot!(
    p5,
    datos_40.n,
    datos_40.jarvis,
    label = "Jarvis - 40% borde",
    marker = :diamond,
    linewidth = 2
)

display(p5)

savefig(
    p5,
    "plots/comparacion_jarvis_proporciones.png"
)


# =========================================================
# 8. COMPARACION DE LOS TRES GRAHAM
# =========================================================

p6 = plot(
    datos_10.n,
    datos_10.graham,
    label = "Graham - 10% borde",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Graham Scan segun cantidad de puntos en el borde",
    legend = :topleft
)

plot!(
    p6,
    datos_25.n,
    datos_25.graham,
    label = "Graham - 25% borde",
    marker = :square,
    linewidth = 2
)

plot!(
    p6,
    datos_40.n,
    datos_40.graham,
    label = "Graham - 40% borde",
    marker = :diamond,
    linewidth = 2
)

display(p6)

savefig(
    p6,
    "plots/comparacion_graham_proporciones.png"
)


# =========================================================
# 9. COMPARACION DE LOS TRES QUICKHULL
# =========================================================

p7 = plot(
    datos_10.n,
    datos_10.quickhull,
    label = "Quickhull - 10% borde",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Quickhull segun cantidad de puntos en el borde",
    legend = :topleft
)

plot!(
    p7,
    datos_25.n,
    datos_25.quickhull,
    label = "Quickhull - 25% borde",
    marker = :square,
    linewidth = 2
)

plot!(
    p7,
    datos_40.n,
    datos_40.quickhull,
    label = "Quickhull - 40% borde",
    marker = :diamond,
    linewidth = 2
)

display(p7)

savefig(
    p7,
    "plots/comparacion_quickhull_proporciones.png"
)


# =========================================================
# 10. GRAFICO DE h PARA LAS TRES PROPORCIONES
# =========================================================

p8 = plot(
    datos_10.n,
    datos_10.h,
    label = "h observado - 10%",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad total de puntos (n)",
    ylabel = "Puntos en la envolvente (h)",
    title = "Cantidad de puntos en la envolvente convexa",
    legend = :topleft
)

plot!(
    p8,
    datos_25.n,
    datos_25.h,
    label = "h observado - 25%",
    marker = :square,
    linewidth = 2
)

plot!(
    p8,
    datos_40.n,
    datos_40.h,
    label = "h observado - 40%",
    marker = :diamond,
    linewidth = 2
)

display(p8)

savefig(
    p8,
    "plots/comparacion_h_proporciones.png"
)


# =========================================================
# 11. JARVIS CON ESCALA LOGARITMICA
# =========================================================

p9 = plot(
    datos_10.n,
    datos_10.jarvis,
    label = "Jarvis - 10%",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Jarvis March - escala logaritmica",
    yscale = :log10,
    legend = :topleft
)

plot!(
    p9,
    datos_25.n,
    datos_25.jarvis,
    label = "Jarvis - 25%",
    marker = :square,
    linewidth = 2
)

plot!(
    p9,
    datos_40.n,
    datos_40.jarvis,
    label = "Jarvis - 40%",
    marker = :diamond,
    linewidth = 2
)

display(p9)

savefig(
    p9,
    "plots/comparacion_jarvis_log.png"
)

# =========================================================
# GRAFICO POLAR 10% - ESCALA LOGARITMICA
# =========================================================

p10 = plot(
    datos_10.n,
    datos_10.jarvis,
    label = "Jarvis March",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Distribucion polar - 10% en el borde - escala log",
    yscale = :log10,
    legend = :topleft
)

plot!(
    p10,
    datos_10.n,
    datos_10.graham,
    label = "Graham Scan",
    marker = :square,
    linewidth = 2
)

plot!(
    p10,
    datos_10.n,
    datos_10.quickhull,
    label = "Quickhull",
    marker = :diamond,
    linewidth = 2
)

display(p10)

savefig(
    p10,
    "plots/comparacion_polar_10_log.png"
)


# =========================================================
# GRAFICO POLAR 25% - ESCALA LOGARITMICA
# =========================================================

p11 = plot(
    datos_25.n,
    datos_25.jarvis,
    label = "Jarvis March",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Distribucion polar - 25% en el borde - escala log",
    yscale = :log10,
    legend = :topleft
)

plot!(
    p11,
    datos_25.n,
    datos_25.graham,
    label = "Graham Scan",
    marker = :square,
    linewidth = 2
)

plot!(
    p11,
    datos_25.n,
    datos_25.quickhull,
    label = "Quickhull",
    marker = :diamond,
    linewidth = 2
)

display(p11)

savefig(
    p11,
    "plots/comparacion_polar_25_log.png"
)


# =========================================================
# GRAFICO POLAR 40% - ESCALA LOGARITMICA
# =========================================================

p12 = plot(
    datos_40.n,
    datos_40.jarvis,
    label = "Jarvis March",
    marker = :circle,
    linewidth = 2,
    xlabel = "Cantidad de puntos (n)",
    ylabel = "Tiempo promedio (segundos)",
    title = "Distribucion polar - 40% en el borde - escala log",
    yscale = :log10,
    legend = :topleft
)

plot!(
    p12,
    datos_40.n,
    datos_40.graham,
    label = "Graham Scan",
    marker = :square,
    linewidth = 2
)

plot!(
    p12,
    datos_40.n,
    datos_40.quickhull,
    label = "Quickhull",
    marker = :diamond,
    linewidth = 2
)

display(p12)

savefig(
    p12,
    "plots/comparacion_polar_40_log.png"
)

# =========================================================
# MENSAJE FINAL
# =========================================================

println()
println("===================================================")
println(" GRAFICOS GENERADOS CORRECTAMENTE")
println("===================================================")

println()
println("Archivos generados:")

println("comparacion_algoritmos.png")
println("comparacion_polar_10.png")
println("comparacion_polar_25.png")
println("comparacion_polar_40.png")
println("comparacion_jarvis_proporciones.png")
println("comparacion_graham_proporciones.png")
println("comparacion_quickhull_proporciones.png")
println("comparacion_h_proporciones.png")
println("comparacion_jarvis_log.png")
println("comparacion_polar_10_log.png")
println("comparacion_polar_25_log.png")
println("comparacion_polar_40_log.png")
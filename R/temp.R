library(ggplot2)

load(file = "output/3-2consistent.output.RData")
##### ggplot theme "science magazine
g <- ggplot(data = data, aes(x = reorder(country, yield), y = yield))

g + geom_boxplot(color = "blue", alpha = 0.2) +
        theme_bw() +
        theme(panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank(),
              panel.grid.major.y = element_line(linetype = "dashed", color = "blue"),
              plot.background = element_rect(fill = "lightblue", color = NA)
              ) +
        ggtitle("Yield by Country")

abc <- adply(matrix(rnorm(100), ncol = 5), 2, quantile, c(0, .25, .5, .75, 1))
b <- ggplot(abc, aes(x = X1, ymin = `0%`, lower = `25%`,
                     middle = `50%`, upper = `75%`, ymax = `100%`))
b

rm(list = ls())

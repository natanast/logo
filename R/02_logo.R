


rm(list = ls())
gc()


# library -------------- 

library(ggplot2)
# library(dplyr)
library(data.table)
# library(readxl)
# library(ggstream)
# library(colorspace)


# load data ----------

df <- readxl::read_xlsx("Data.xlsx") |> setDT()
# 
# df1 <- data.table(
#     x = c(2002, 2006, 2008),
#     y = c(2150, 1800, 2300),
#     size = c(23, 22, 25),  
#     Type = c("D", "D", "D")
# )


# plot------

# col = c("#00429d", "#73a2c6", '#396375', '#5a8192', '#6f6e9a', '#a2a0cf', '#e37b78',"#A65628", '#b24745')

col = c(
    "A" = "#926f0a",
    "B" = "#979d51",
    "C" = "#526E2D",
    "D" = "#677d99"
)

g = df |>
     
    ggplot(aes(x = Time, y = Number, fill = Type)) +
  
    geom_stream(color = "white", type = "ridge", lwd = 0.5, bw = .9) +
    
    # geom_point(
    #     data = df1,
    #     aes(x = x, y = y, size = size),
    #     shape = 21,
    #     stroke = .2,
    #     color = "white"
    # ) +

    scale_size_continuous(range = c(15,30)) +

    # scale_y_continuous(limits = c(0, 3000), breaks = seq(0, 3000, by = 500)) +

    # scale_color_manual(values = col) +
    scale_fill_manual(values = col) +

    
    theme_minimal() +
  
    theme(
        plot.background = element_rect(fill = "#e4e4e3"),
        legend.position = "none",
        
        
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank(),
        
        plot.margin = margin(20, 20, 20, 20)
    ) 
      
g


# install.packages('svglite')
# library(svglite)

# # Save the plot with custom size and resolution
ggsave("logo.png", plot = g, width = 15, height = 10, dpi = 600)

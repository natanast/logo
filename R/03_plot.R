


rm(list = ls())
gc()


# library -------------- 

library(ggplot2)
library(dplyr)
library(data.table)
library(readxl)
library(ggstream)
library(colorspace)


# load data ----------

df <- readxl::read_xlsx("Data.xlsx") |> setDT()


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
  
    geom_stream(aes(color = Type), type = "ridge", lwd = 0.1, bw = .9) +
    
    # scale_y_continuous(labels = scales::comma) +
    
    # scale_x_continuous(breaks = c(2001, 2023), limits = c(2003, 2023)) +
    
    # scale_x_continuous(expand = c(0, 0), breaks = seq(2003, 2023, by = 4), limits = c(2003, 2023)) +
  
    scale_color_manual(values = col) +
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

# Save the plot with custom size and resolution
ggsave("logo.png", plot = g, width = 15, height = 10, dpi = 600)

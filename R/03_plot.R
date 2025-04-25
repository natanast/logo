


rm(list = ls())
gc()


# library -------------- 

library(ggplot2)
library(dplyr)
library(data.table)
library(readxl)
library(ggstream)
library(colorspace)
library(scales)
library(cowplot)


# load data ----------

df <- readxl::read_xlsx("Data.xlsx") |> setDT()


colnames(df)

#plot------

df |>
     
    ggplot(aes(x = Time, y = Number, fill = Type, color = Type, linetype = Type)) +
  
    geom_stream(type = "ridge", color = "white", lwd = 0.1, bw = .9) +
    
    # scale_y_continuous(labels = scales::comma) +
    
    # scale_x_continuous(breaks = c(2001, 2023), limits = c(2003, 2023)) +
    
    # scale_x_continuous(expand = c(0, 0), breaks = seq(2003, 2023, by = 4), limits = c(2003, 2023)) +
  
    scale_color_manual(values = c("#80539a", "#2293ca", "#656566")) +
    scale_fill_manual(values = c("#80539a", "#2293ca", "#656566")) +

    
    theme_minimal() +
  
    theme(
        plot.background = element_rect(fill = "#e4e4e3"),
        legend.position = "none",
        panel.grid.major = element_line(linewidth = .35, color = "grey85"),
        panel.grid.minor = element_line(linewidth = .25, color = "grey85", linetype = "dashed"),
        
        axis.title.y = element_text(margin = margin(r = 10)),
        axis.title.x = element_text(margin = margin(t = 10)),
        
        plot.margin = margin(20, 20, 20, 20)
    ) 
      
# gr



# ggsave(plot = gr, filename = "04_Rplot.jpeg", width = 8, height = 8, units = "in", dpi = 600)



rm(list = ls())
gc()


# libraries ---------

library(ggplot2)
library(dplyr)
library(stringr)
library(data.table)
library(ggtext)
library(extrafont)
# library(ggstream)

# Load data -------

df <- readxl::read_xlsx("data2.xlsx") |> setDT()


# plot -------

library(paletteer)

col = paletteer_c("ggthemes::Sunset-Sunrise Diverging", 10)


g = ggplot(df, aes(x = year, y = total_emissions_MtCO2e, fill = parent_entity)) +
    
    geom_stream(type = "ridge", color = "white", lwd = 0.1) +
    
    scale_fill_manual(values = col) +
    
    scale_x_continuous(breaks = c(1930, 1950, 1975, 2000, 2022), limits = c(1930, 2027)) +
    
    theme_minimal(base_family = "Candara") +
    
    theme(
        legend.position = "none",
        
        axis.title.y = element_text(size = 10, vjust = 5),
        axis.text = element_text(size = 9),
        
        plot.title = element_blank(),
        
        panel.grid.major = element_line(linewidth = .25, color = "grey80", linetype = "dashed", lineend = "round"),
        panel.grid.minor = element_blank(),
        
        plot.background = element_rect(fill = "#e4e4e3", color = NA),
        
        plot.margin = margin(20, 20, 20, 20)
    )



g

# Save the plot with custom size and resolution
ggsave("21_day.png", plot = g, width = 10, height = 6, dpi = 600)



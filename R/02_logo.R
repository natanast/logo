


rm(list = ls())
gc()


# library -------------- 

library(ggplot2)
library(data.table)

install.packages("magick")


# load data ----------

library(magick)

# Load your PNG image
img <- image_read("odyssey_logo.png")

# Make white background transparent
# fuzz: tolerance level for what counts as "white" (increase if needed)
img_transparent <- image_transparent(img, color = "white", fuzz = 20)

# Save the output
image_write(img_transparent, path = "logo_no_background.png", format = "png")

# plot------
library(rsvg)
library(magick)

# Render SVG at high resolution
img_svg <- image_read_svg("Odyssey_logo.svg", width = 1000, height = 1000)


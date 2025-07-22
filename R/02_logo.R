


rm(list = ls())
gc()


# library -------------- 

library(ggplot2)
library(data.table)

# install.packages("magick")


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
img_svg <- image_read_svg("Odyssey_logo_1.svg", width = 3000, height = 1000)


img_clean <- image_transparent(img_svg, color = "white", fuzz = 20)

# Save the cleaned image
image_write(img_clean, "logo_clean.png")



library(magick)
library(rsvg)  # for rendering SVG

# Read the SVG and convert to high-res raster image
img <- image_read_svg("Odyssey logo.svg", width = 3000, height = 3000)  # increase for sharper output


img_clean <- image_transparent(img, color = "white", fuzz = 10)


image_write(img_clean, path = "logo_nobg.png", format = "png")


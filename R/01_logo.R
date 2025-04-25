



rm(list = ls())
gc()



# load libraries ---------

library(data.table)
library(stringr)

library(genekitr)
library(geneset)
library(ggplot2)

library(tidygraph)

library(ggplot2)
library(ggrepel)
library(ggraph)
library(ggnewscale)
library(shadowtext)

library(extrafont)


# load data --------------------


df1 = "gsea_genekitr_comparisons.xlsx" |>
    readxl::read_excel() |>
    setDT()



qm = df1$geneID |>
    str_split("\\/") |>
    unlist() |>
    unique() |>
    transId(transTo = "symbol") |>
    setDT()


df1$geneID_symbol = df1$geneID |>
    str_split("\\/") |>
    lapply(function(x) qm[which(input_id %in% x)]$symbol |>
               paste(collapse = "/")) |>
    unlist()



# plot -------------

q <- df1$geneID_symbol |> 
    str_split("\\/") |> 
    lapply(function(x) { data.table("to" = x) }) |> 
    rbindlist(idcol = "from")

q$from <- df1[q$from]$Description 

layout <- q |>
    as_tbl_graph() |> 
    mutate(Degree = centrality_degree(mode = 'all')) |>
    create_layout(layout = 'igraph', algorithm = 'kk')

layout$Level <- ifelse(layout$name %in% q$to, "Gene", "Term")



# plot ------------

layout$x[1] <- -0.2
layout$Degree[1] <- 40

layout$Degree[2] <- 15
layout$x[2] <- -0.18
layout$y[2] <- 0.7

layout$y[3] <- 0.85
layout$x[3] <- -0.2

layout$x[5] <- -0.25
layout$y[5] <- -0.3




layout$x[6] <- -0.14
layout$y[6] <- 0.15

layout$x[7] <- -0.25
layout$y[7] <- 0.1



gr = ggraph(layout) + 
    
    geom_edge_link(color = "#97A1A7", edge_width = 1) + 
    
    geom_node_point(
        aes(size = Degree, fill = Level), shape = 21,
        stroke = .2, color = "grey96"
    ) + 
    
    scale_size_continuous(
        range = c(7, 20), 
        guide = guide_legend(
            title = "No. of connections",
            override.aes = list(color = "grey10", stroke = .35)
        )
    ) +
    
    scale_fill_manual(
        values = c(
            "Term" = "#2E2A2B",
            "Gene" = "#DC9445"
        ),
        guide = "none" 
    ) +
    
    
    new_scale("size") +
    
    geom_text_repel(
        aes(x, y, label = name, size = Degree),
        family = "Calibri", fontface = "bold", 
        color = "grey10", bg.color = "grey96", bg.r = 0.075,
        segment.linetype = "dotted", segment.size = .2,
        max.overlaps = Inf
    ) +
    
    scale_size_continuous(range = c(3, 4), guide = "none") +
    
    theme_graph(base_family = "Calibri") +
    
    theme(
        legend.position = "none",
        legend.key.size = unit(0.001,"cm"),
        legend.title.position = "top",
        plot.margin = margin(20, 20, 20, 20),
        plot.background = element_rect(fill = "transparent", color = NA)
        
    )

gr


ggsave(
    plot = gr, filename = paste0("01_logo.jpeg"), 
    width = 12, height = 12, units = "in",dpi = 600
)

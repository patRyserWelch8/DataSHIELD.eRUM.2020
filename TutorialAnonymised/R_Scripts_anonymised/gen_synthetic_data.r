#'Author: Patricia Ryser-Welch (DataSHIELD Team)
#'Purpose : to do ...
#'Date of Creation : 28/5/2020
#'Date of update:    28/5/2020


library(readr)

generate.synthetic.data <- function(dataset, name.synth.data)
{
    data       <- read_csv(dataset)
    synth.GR   <- rnorm(nrow(data),mean = mean(data$GR), sd = sd(data$GR))
    synth.GR   <- synth.GR * sign(synth.GR)
    synth.WDS  <- as.integer(rnorm(nrow(data),mean = mean(data$WDS), sd = sd(data$WDS)))
    synth.WDS   <- synth.WDS * sign(synth.WDS)
    synth.YEAR <- as.integer(rnorm(nrow(data),mean = mean(data$YEAR), sd = sd(data$YEAR)))
    synth.YEAR   <- synth.YEAR * sign(synth.YEAR)
    synth.data <- data.frame(GR = synth.GR, WDS = synth.WDS, YEAR= synth.YEAR)
    write.csv (synth.data, name.synth.data, row.names = FALSE)
}

verify.synthetic.data <- function(dataset, synthetic.dataset)
{
  original.data <- read_csv(dataset)
  synthetic.data <- read_csv(synthetic.dataset)
  print("Original dataset:")
  print(summary(original.data))
  print("Synthetic dataset:")
  print(summary(synthetic.data))
  
}

generate.synthetic.better.data <- function(dataset, name.synth.data)
{
  data       <- read_csv(dataset)
  synth.data <- MASS::mvrnorm(n = nrow(data), mu = colMeans(data), Sigma = cov(data))
  write.csv (synth.data, name.synth.data, row.names = FALSE)
}


generate.synthetic.data("data/fully_anonymised_classic_1.csv","synth_classic_1.csv")
generate.synthetic.data("data/fully_anonymised_classic_2.csv","synth_classic_2.csv")
generate.synthetic.data("data/fully_anonymised_classic_3.csv","synth_classic_3.csv")

verify.synthetic.data("data/fully_anonymised_classic_1.csv","synth_classic_1.csv")
verify.synthetic.data("data/fully_anonymised_classic_2.csv","synth_classic_2.csv")
verify.synthetic.data("data/fully_anonymised_classic_3.csv","synth_classic_3.csv")


generate.synthetic.better.data("data/fully_anonymised_classic_1.csv","better_synth_classic_1.csv")
generate.synthetic.better.data("data/fully_anonymised_classic_2.csv","better_synth_classic_2.csv")
generate.synthetic.better.data("data/fully_anonymised_classic_3.csv","better_synth_classic_3.csv")


verify.synthetic.data("data/fully_anonymised_classic_1.csv","better_synth_classic_1.csv")
verify.synthetic.data("data/fully_anonymised_classic_2.csv","better_synth_classic_2.csv")
verify.synthetic.data("data/fully_anonymised_classic_3.csv","better_synth_classic_3.csv")







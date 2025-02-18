\name{TRADE}
\alias{TRADE}
\title{Function for Transcriptome-wide Analysis of Differential Expression}
\description{
TRADE estimates the distribution of differential expression effects across the transcriptome, either for a single contrast (univariate mode) or for two contrasts (bivariate mode). It provides estimates of transcriptome-wide impact, gene set enrichments, and effect size correlations, among other distribution features.
}

\usage{
TRADE(mode = NULL, 
            results1, 
            results2 = NULL,
            annot_table = NULL,
            log2FoldChange = "log2FoldChange",
            lfcSE = "lfcSE", 
            pvalue = "pvalue",
            model_significant = TRUE,
            genes_exclude = NULL, 
            estimate_sampling_covariance = FALSE,
            covariance_matrix_set = "combined", 
            component_varexplained_threshold = 0,
            weight_nocorr = 1,
            n_sample = NULL,
            verbose = FALSE)
}

\arguments{
  \item{mode}{The mode of analysis, either "univariate" or "bivariate".}
  \item{results1}{The first set of DE summary statistics.}
  \item{results2}{The second set of DE summary statistics (required only for bivariate mode).}
  \item{annot_table}{Table of gene-wise annotations for enrichment analysis.}
  \item{log2FoldChange}{The name of the column with log2FoldChanges in the DE summary statistics.}
  \item{lfcSE}{The name of the column with log2FoldChange standard errors in the DE summary statistics.}
  \item{pvalue}{The name of the column with p-values in the DE summary statistics.}
  \item{model_significant}{Should TRADE run the model separately on significant genes and calculate metrics such as fraction significant? (default is TRUE).}
  \item{genes_exclude}{Which genes should be excluded (e.g., perturbed genes).}
  \item{estimate_sampling_covariance}{In cases of shared samples in bivariate analysis, use ash utility to estimate sampling covariance matrices (default is FALSE).}
  \item{covariance_matrix_set}{The basis set of covariance matrices for bivariate analyses, either "mash_default", "adaptive_grid", or "combined" (default is "combined").}
  \item{component_varexplained_threshold}{For adaptive grid, the threshold variance explained for TRADE to retain in analysis (default is 0).}
  \item{weight_nocorr}{The prior on the bivariate component with 0 correlation. A value of 1 corresponds to no penalty (default is 1).}
  \item{n_sample}{How many samples to draw from the distribution and include in output.}
}


\value{
  A list containing:
  \item{distribution_summary}{A data frame summarizing transcriptome-wide impact, including variance and the effective number of differentially expressed genes (DEGs).}
  \item{annot_output}{A data frame providing gene set enrichment estimates, including variance, fraction of differential expression signal, and enrichment scores.}
  \item{fit}{The inferred effect size distribution, including mixture weights and component boundaries.}
  \item{qc}{Quality control metrics, such as the number of excluded genes or extreme log2FoldChange values.}
  \item{TI_correlation}{(For bivariate mode) The estimated correlation of transcriptome-wide impact between two conditions.}
}

\examples{
#This file can be downloaded from
#https://github.com/ajaynadig/TRADEtools/releases/download/0.99.0/GATA1_K562Essential_DESeq2output.Rdata
load("GATA1_K562Essential_DESeq2output.Rdata")
GATA1_K562_results <- results_pseudobulk
#This file can be downloaded from
#https://github.com/ajaynadig/TRADEtools/releases/download/0.99.0/MED12_K562Essential_DESeq2output.Rdata
load("MED12_K562Essential_DESeq2output.Rdata")
MED12_K562_results <- results_pseudobulk

gene_annot <- read.table("example/K562Essential_annot.txt")


GATA1_TRADE <- TRADE(mode = "univariate",
                     results1 = GATA1_K562_results,
                     annot_table = gene_annot)

MED12_TRADE <- TRADE(mode = "univariate",
                     results1 = MED12_K562_results,
                     annot_table = gene_annot)
                     
GATA1_MED12_TRADE = TRADE(mode = "bivariate",
                          results1 = GATA1_K562_results,
                          results2 = MED12_K562_results)
}

\seealso{
Related functions: \code{\link{mashr}}, \code{\link{ashr}}
}
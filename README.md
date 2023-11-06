# MassView-Assistant
A mass spectrometer viewer made in Shiny r-project
Authors: Guillén-Alonso Héctor & Winkler Robert


## Motivation
Because on Mac it is hard to have a simple MS visualization. I started this little project to preview MS spectra on the local machine. My teammates rapidly suggested some functions, and because of that, I decided to make the minimum viable product and share it with the community while we improved the new functions according to the interests of the community and our lab. I really hope this little program helps someone

## How to install
1. Download the full project or clone it.
2. In R, or Rstudio (suggested), install the Shiny, MALDIquant, and MALDIquantForeing packages, it can be done with the command:
```
install.packages(c('Shiny', 'MALDIquant', 'MALDIquantForeing'))
```
3. Set a working directory where the app folder is, on R Studio you can do it by selecting Session > Set Working Directory > Choose Directory ... or by console:
```
swd("/Users/UserName/Desktop")
```
4. In the console execute:
```
runApp(“MassView Assistant”)
```

pour compiler :
bison -d exo2bis.y
flex exo2bis.l
gcc exo2bis.tab.c -ly -ll

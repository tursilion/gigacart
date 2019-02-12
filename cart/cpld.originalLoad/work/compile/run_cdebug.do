#############################################################
# vsimsa environment configuration
set dsn $curdir
log $dsn/log/vsimsa.log
@echo
@echo #################### Starting C Code Debug Session ######################
cd $dsn/src
amap work $dsn/work/work.lib
set worklib work
# simulation
asim -callbacks -O5 +access +r +m+gigacart gigacart NetList
run -all
#############################################################
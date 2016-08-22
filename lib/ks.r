# USAGE:
# DESCRIPTION:
#
# USAGE:
#    R --slave "--args figureTitle case program.1 program.2 " < ks.r > ks.rout
#
# EXAMPLE:


rm(list=ls());

args = (commandArgs(TRUE))
cat(args,"\n")

figuretitle = args[1]
currentcase = args[2]

program.1 = args[3]
program.2 = args[4]

program.1.data = read.table( paste( program.1, "data", sep="" ))$V1;
program.2.data = read.table( paste( program.2, "data", sep="" ))$V1;

test = ks.test( program.1.data, program.2.data )

pdf( paste( currentcase, figuretitle, ".pdf", sep="" ));

plot( ecdf(program.1.data), xlim=range(c(program.1.data, program.2.data)), col="red",  main=paste(currentcase, figuretitle) )
plot( ecdf(program.2.data), add=TRUE, lty="dashed", col="blue" )

legend( "bottomright", c(paste( "Tests Statistics = ", test$statistic, sep=""), paste("p-value = ",format(test$p.value,digits=4),sep="")))
legend( "topleft", c(program.1, program.2), col=c("red","blue"), pch=16)
dev.off();

#cat(paste(currentcase,"|",format(ee,digits=4),format(sdv,digits=4),"|",
cat( paste(currentcase, figuretitle , "\n","|",
format(mean(program.1.data),scientific = TRUE),format(sd(program.1.data),scientific = TRUE),"||",
format(mean(program.2.data),scientific = TRUE),format(sd(program.2.data),scientific = TRUE),"|",format(test$statistic,scientific = TRUE),format(test$p.value,scientific = TRUE),
sep="\t"),file="",append=TRUE);cat("\n",file="",append=TRUE);

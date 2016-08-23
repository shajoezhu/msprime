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

pdf( paste( currentcase, figuretitle, ".pdf", sep="" ), width=14, height=7);

par(mfrow = c(1,2))

program.1.data.col = rgb(1,0,0,0.5)
program.2.data.col = rgb(0,0,1,0.5)

bins = 20
hist(program.1.data, breaks=seq(min(program.1.data), max(program.1.data), length.out = bins), main = paste(currentcase, figuretitle), , col = program.1.data.col, xlab = figuretitle )
hist(program.2.data, breaks=seq(min(program.2.data), max(program.2.data), length.out = bins), add = T, col = program.2.data.col)
legend("topright", c(program.1, program.2), fill=c(program.1.data.col, program.2.data.col))


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

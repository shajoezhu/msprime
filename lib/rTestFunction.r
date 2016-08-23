rm(list=ls())

lambdaAlpha <- function(b, k, para){
    return ( exp(lchoose(b,k) + lbeta(k - para, b-k + para) - lbeta(2.0 - para, para )))
}


lambdaAlpha(10,3,1.1)

lambdaAlpha(10, c(2:10), 1.1)
#[1] 6.51403953 1.93008579 0.90387820 0.51565511 0.32860374 0.22441231 0.16016524
#[8] 0.11694605 0.08398853

lambdaPsi <- function(b, k, para ){
#    //if ( b < k) throw std::invalid_argument("b can not be less than k");
#    //.2 is psi lambda_bk=\binom{b}{k}\psi^{k-2} (1-\psi)^{b-k}
    if ( para == 1.0 && b == k ){
        return (1.0)
    } else if ( para == 1.0 && b != k ){
        return (0.0)
    } else if ( para == 0.0 && k == 2.0 ){
        return(choose(b, k))
    } else if ( para == 0.0 && k != 2.0 ){
        return (0.0)
    } else {
        return (exp ( lchoose(b,k) + (k-2)*log(para) + (b-k)*log(1.0-para) ));
    }
}


lambdaPsi(5, 5, 1.0)
lambdaPsi(5, 3, 1.0)
lambdaPsi(5, 2, 0.0)
lambdaPsi(5, 5, 0.0)
lambdaPsi(5, 3, 0.1)

rates = lambdaPsi(10, c(2:10), .1)
totalRates = sum(rates)

nSample = 10000

u = runif(nSample, 0, totalRates)
mySample = c()

for ( i in 1:nSample ){
    tmpSum = 0
    tmpSample = 1
    repeat {
        tmpSum = tmpSum + rates[tmpSample]
        tmpSample = tmpSample + 1
        if (tmpSum > u[i]){
            break
        }
    }
    mySample = c(mySample, tmpSample)
}


rates/totalRates

table(mySample)

#[1] 19.37102445  5.73956280  1.11602610  0.14880348  0.01377810  0.00087480
#[7]  0.00003645  0.00000090  0.00000001

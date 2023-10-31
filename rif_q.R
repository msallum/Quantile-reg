rif_q <- function(X, t){
  den =approxfun(density(X))
  q =quantile(X, t)
  q+ (t-(X<=q))/den(q)
}



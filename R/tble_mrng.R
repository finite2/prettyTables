
.tbl_mrng = function(tble, strata, all_strata, data, var, var.order, type, count, nxt_row, rnd){

  if(is.numeric(data[[var]])) {
    counts = c()

    for(j in all_strata) {
      if(j == "Overall") {
        data_sub = data[, var]
      } else {
        data_sub = data[data[strata] == j, var]
      }

      counts = switch(
        count,
        n = c(counts, length(data_sub)),
        miss = c(counts, sum(is.na(data_sub))),
        NULL = c()
      )

      ################################
      # section to change for other outputs
      median = quantile(data_sub, 0.5, na.rm = TRUE)
      mn = min(data_sub, na.rm = TRUE)
      mx = max(data_sub, na.rm = TRUE)

      tble[nxt_row, j] = paste0(round(median, rnd), " (", round(mn, rnd), ",", round(mx, rnd), ")")
      #################################

    }

    if(count == "n"){
      tble[nxt_row, 2] = paste0("n=(", paste0(counts, collapse=","), ")")
    } else if(count == "miss"){
      tble[nxt_row, 2] = paste0("Missing=(", paste0(counts, collapse=","), ")")
    }

    nxt_row = nxt_row + 1

  } else {
    warning(paste(var, "is not a numeric variable, not added to table"))
  }

  return(list(tble = tble, nxt_row = nxt_row))

}


function daySince(a, b, c) {
    // Get event date from user input
    var ayear = a
    var amonth = b+1
    var aday = c


    var x = new Date()
    var dyear
    var dmonth
    var dday
    var tyear = x.getFullYear()
    var tmonth = x.getMonth()+1
    var tday = x.getDate()
    var y=1
    var mm=1 
    var d=1 
    var a2=0 
    var a1=0
    var f=28

    if ((tyear/4)-parseInt(tyear/4)==0) {
        f=29
    }

    var m = new Array(31, f, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31)

    dyear = tyear-(ayear)

    dmonth = tmonth-amonth
    if (dmonth<0) {
        dmonth = dmonth+12
        dyear--
    }

    dday = tday-aday
  
    if (dday<0) {
        var ma = amonth+tmonth
        if (ma>12) {ma = ma-12}
        if (ma=0) {ma = ma+12}
        dday = dday+m[ma]
        dmonth--
    }

    var finalDate = ""
 
    if (dyear==0) {y=0}
    if (dmonth==0) {mm=0}
    if (dday==0) {d=0}
    if ((y==1) && (mm==1)) {a1=1}
    if ((y==1) && (d==1)) {a1=1}
    if ((mm==1) && (d==1)) {a2=1}
    if (y==1){ finalDate = dyear + " Year(s)"}
    if ((a1==1) && (a2==0)) { finalDate = finalDate + " and " }
    if ((a1==1) && (a2==1)) { finalDate = finalDate + ", " }
    if (mm==1){ finalDate = finalDate + dmonth + " Month(s)" }
    if (a2==1) { finalDate = finalDate + ", and " }
    if (d==1){ finalDate = finalDate + dday + " Day(s)" }
  
    if ((y==0) && (mm==0) && (d==0)) { finalDate = "Too soon" }

    return finalDate
}












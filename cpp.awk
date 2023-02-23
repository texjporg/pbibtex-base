function  do_if(proc,sym,  direct ) {
    if( (sym in defined) && (defined[sym]!=0 ) ) {
	while( direct!="else" && direct!="endif" )  direct=proc_line(proc)
	if(direct=="else") 
	    while( direct!="endif" )  direct=proc_line(0)
    } else {
	while( direct!="else" && direct!="endif" )  direct=proc_line(0)
	if(direct=="else")
	    while( direct!="endif" )  direct=proc_line(proc)
    }
}

function  do_if_not(proc,sym,  direct ) {
    if( (!(sym in defined)) || (defined[sym]==0 ) ) {
	while( direct!="else" && direct!="endif" )  direct=proc_line(proc)
	if(direct=="else") 
	    while( direct!="endif" )  direct=proc_line(0)
    } else {
	while( direct!="else" && direct!="endif" )  direct=proc_line(0)
	if(direct=="else")
	    while( direct!="endif" )  direct=proc_line(proc)
    }
}

function  do_ifdef(proc,sym,  direct ) {
    if( sym in defined ) {
	while( direct!="else" && direct!="endif" )  direct=proc_line(proc)
	if(direct=="else") 
	    while( direct!="endif" )  direct=proc_line(0)
    } else {
	while( direct!="else" && direct!="endif" )  direct=proc_line(0)
	if(direct=="else")
	    while( direct!="endif" )  direct=proc_line(proc)
    }
}

function  do_ifndef(proc,sym,    direct) {
    if( !(sym in defined) ) {
	while( direct!="else" && direct!="endif" )  direct=proc_line(proc)
	if(direct=="else") 
	    while( direct!="endif" )  direct=proc_line(0)
    } else {
	while( direct!="else" && direct!="endif" )  direct=proc_line(0)
	if(direct=="else")
	    while( direct!="endif" )  direct=proc_line(proc)
    }
}

function proc_line(proc, direct) {
    if( (getline<"jbtxbst.doc") <1 ) {
 	exit
    }
    lno++;
    if( $0 ~ /^#/ ) {
	if( $1=="#" ) {
	    direct=$2; arg1=$3; arg2=$4
	}else {
	    direct=substr($1,2,16); arg1=$2; arg2=$3
	}
	if(direct=="define") {
	    if(proc)  defined[arg1]=arg2+0
	} else if(direct=="ifdef" ){
	    do_ifdef(proc,arg1)
	}else if(direct=="ifndef") {
	    do_ifndef(proc,arg1)
	}else if(direct=="if") {
	    if( substr(arg1,1,1)=="!" ) do_if_not(proc,substr(arg1,2,32))
	    else do_if(proc,arg1)
	}else if( (direct!="else") && (direct!="endif") ){
	    print "% Error **undefined **",direct,"** in line",lno >"/dev/tty"
	    exit
	}
	return direct;
    }else if($0 ~ /^%/ ) {
	return ""	# コメントは基本的には削除する
    }else if($0 ~ /^	%/ ) {
	sub(/	/,"")	# この形式のコメントは出力する
	print $0
	return ""
    }else {
	if(proc) print $0
	return ""
    }
}
BEGIN{
    if(ARGC<2) {
	print "usage: gawk -f cpp.awk <style-type> [<option>]"
	print "<style-type> = JPLAIN | JALPHA | JABBRV | JUNSRT | JIPSJ"
	print "               TIPSJ  | TIEICE | JNAME  | JORSJ"
	print "<option> = ASCII"
	exit
    }
    opt=ARGV[1]
    name["JPLAIN"]="jplain"; name["JALPHA"]="jalpha"; name["JABBRV"]="jabbrv"
    name["JUNSRT"]="junsrt"; name["JIPSJ" ]="jipsj" ; name["TIPSJ" ]="tipsj"
    name["TIEICE"]="tieice"; name["JNAME" ]="jname" ; name["JORSJ" ]="jorsj"
    if( opt in name )
       printf("%% JBibTeX standard bibliography style `%s'\n",name[opt])
    for(i=1;i<ARGC;i++) {
    	defined[ARGV[i]]=1
    	ARGV[i]=""
    }
    while(1) proc_line(1)
}

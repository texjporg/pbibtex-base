#!/bin/sh
#	use cpp
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc |/lib/cpp -P -DJPLAIN  >jplain.bst
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc | /lib/cpp -P -DJALPHA >jalpha.bst
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc |/lib/cpp -P -DJUNSRT  >junsrt.bst
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc |/lib/cpp -P -DJABBRV  >jabbrv.bst
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc |/lib/cpp -P -DJIPSJ   >jipsj.bst
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc |/lib/cpp -P -DTIPSJ   >tipsj.bst
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc |/lib/cpp -P -DTIEICE  >tieice.bst
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc |/lib/cpp -P -DJNAME   >jname.bst
sed -e '/^%/d' -e '/^$/d' jbtxbst.doc |/lib/cpp -P -DJORSJ   >jorsj.bst
#	use gawk 
#gawk -f cpp.awk JPLAIN >jplain.bst
#gawk -f cpp.awk JALPHA >jalpha.bst
#gawk -f cpp.awk JUNSRT >junsrt.bst
#gawk -f cpp.awk JABBRV >jabbrv.bst
#gawk -f cpp.awk JIPSJ  > jipsj.bst
#gawk -f cpp.awk TIPSJ  > tipsj.bst
#gawk -f cpp.awk TIEICE >tieice.bst
#gawk -f cpp.awk JNAME  > jname.bst
#gawk -f cpp.awk JORSJ  > jorsj.bst

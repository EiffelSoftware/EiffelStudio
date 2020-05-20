#!/bin/sh

echo -n > category.l

for i in Lu Ll Lt Lm Lo Mn Mc Me Nd Nl No Pc Pd Ps Pe Pi Pf Po Sm Sc Sk So Zs Zl Zp Cc Cf Cs Co Cn;
do
	echo -n "$i\t[" >> category.l
	$UNICODE_HELPER_GENERATOR --nologo -i UnicodeData.txt -u "13.0.0" -r -c $i | \
		tr -d '\r' | \
		while read line; do echo -n "\u{$line}"; done | \
		sed -e s/-/\\}-\\\\u\\{/g >> category.l
	echo "]" >> category.l
done

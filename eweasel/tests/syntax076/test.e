class TEST

create
	make

feature {NONE} -- Creation

	make
		do
				-- One slash kind: binary operators.
			report (Current \ Current)
			report (Current \\ Current)
			report (Current \\\ Current)
			report (Current / Current)
			report (Current // Current)
			report (Current /// Current)
				-- One slash kind: unary operators.
			report (\ Current)
			$OPERATOR_b2 report (\\ Current) -- Error: binary operator.
			report (\\\ Current)
			$OPERATOR_s1 report (/ Current) -- Error: binary operator.
			$OPERATOR_s2 report (// Current) -- Error: binary operator.
			report (/// Current)
				-- Two slash kinds: binary operators.
			report (Current \/ Current)
			report (Current \// Current)
			report (Current \/// Current)
			report (Current \\/ Current)
			report (Current \\// Current)
			report (Current \\/// Current)
			report (Current \\\/ Current)
			report (Current \\\// Current)
			report (Current \\\/// Current)
			report (Current /\ Current)
			report (Current /\\ Current)
			report (Current /\\\ Current)
			report (Current //\ Current)
			report (Current //\\ Current)
			report (Current //\\\ Current)
			report (Current ///\ Current)
			report (Current ///\\ Current)
			report (Current ///\\\ Current)
				-- Two slash kinds: unary operators.
			report (\/ Current)
			report (\// Current)
			report (\/// Current)
			report (\\/ Current)
			report (\\// Current)
			report (\\/// Current)
			report (\\\/ Current)
			report (\\\// Current)
			report (\\\/// Current)
			report (/\ Current)
			report (/\\ Current)
			report (/\\\ Current)
			report (//\ Current)
			report (//\\ Current)
			report (//\\\ Current)
			report (///\ Current)
			report (///\\ Current)
			report (///\\\ Current)
		end

feature -- Basic operations

	bb1 alias "\" (other: TEST): STRING do Result := "binary \" end
	bb2 alias "\\" (other: TEST): STRING do Result := "binary \\" end
	bb3 alias "\\\" (other: TEST): STRING do Result := "binary \\\" end

	bs1 alias "/" (other: TEST): STRING do Result := "binary /" end
	bs2 alias "//" (other: TEST): STRING do Result := "binary //" end
	bs3 alias "///" (other: TEST): STRING do Result := "binary ///" end

	ub1 alias "\": STRING do Result := "unary \" end
	$ALIAS_b2 ub2 alias "\\": STRING do Result := "unary \\" end -- Error: binary operator.
	ub3 alias "\\\": STRING do Result := "unary \\\" end

	$ALIAS_s1 us1 alias "/": STRING do Result := "unary /" end -- Error: binary operator.
	$ALIAS_s2 us2 alias "//": STRING do Result := "unary //" end -- Error: binary operator.
	us3 alias "///": STRING do Result := "unary ///" end

	bb1s1 alias "\/" (other: TEST): STRING do Result := "binary \/" end
	bb1s2 alias "\//" (other: TEST): STRING do Result := "binary \//" end
	bb1s3 alias "\///" (other: TEST): STRING do Result := "binary \///" end
	bb2s1 alias "\\/" (other: TEST): STRING do Result := "binary \\/" end
	bb2s2 alias "\\//" (other: TEST): STRING do Result := "binary \\//" end
	bb2s3 alias "\\///" (other: TEST): STRING do Result := "binary \\///" end
	bb3s1 alias "\\\/" (other: TEST): STRING do Result := "binary \\\/" end
	bb3s2 alias "\\\//" (other: TEST): STRING do Result := "binary \\\//" end
	bb3s3 alias "\\\///" (other: TEST): STRING do Result := "binary \\\///" end

	bs1b1 alias "/\" (other: TEST): STRING do Result := "binary /\" end
	bs1b2 alias "/\\" (other: TEST): STRING do Result := "binary /\\" end
	bs1b3 alias "/\\\" (other: TEST): STRING do Result := "binary /\\\" end
	bs2b1 alias "//\" (other: TEST): STRING do Result := "binary //\" end
	bs2b2 alias "//\\" (other: TEST): STRING do Result := "binary //\\" end
	bs2b3 alias "//\\\" (other: TEST): STRING do Result := "binary //\\\" end
	bs3b1 alias "///\" (other: TEST): STRING do Result := "binary ///\" end
	bs3b2 alias "///\\" (other: TEST): STRING do Result := "binary ///\\" end
	bs3b3 alias "///\\\" (other: TEST): STRING do Result := "binary ///\\\" end

	ub1s1 alias "\/": STRING do Result := "unary \/" end
	ub1s2 alias "\//": STRING do Result := "unary \//" end
	ub1s3 alias "\///": STRING do Result := "unary \///" end
	ub2s1 alias "\\/": STRING do Result := "unary \\/" end
	ub2s2 alias "\\//": STRING do Result := "unary \\//" end
	ub2s3 alias "\\///": STRING do Result := "unary \\///" end
	ub3s1 alias "\\\/": STRING do Result := "unary \\\/" end
	ub3s2 alias "\\\//": STRING do Result := "unary \\\//" end
	ub3s3 alias "\\\///": STRING do Result := "unary \\\///" end

	us1b1 alias "/\": STRING do Result := "unary /\" end
	us1b2 alias "/\\": STRING do Result := "unary /\\" end
	us1b3 alias "/\\\": STRING do Result := "unary /\\\" end
	us2b1 alias "//\": STRING do Result := "unary //\" end
	us2b2 alias "//\\": STRING do Result := "unary //\\" end
	us2b3 alias "//\\\": STRING do Result := "unary //\\\" end
	us3b1 alias "///\": STRING do Result := "unary ///\" end
	us3b2 alias "///\\": STRING do Result := "unary ///\\" end
	us3b3 alias "///\\\": STRING do Result := "unary ///\\\" end

feature {NONE} -- Output

	report (s: STRING)
			-- Print message `s` with a new line.
		do
			io.put_string (s)
			io.put_new_line
		end

end

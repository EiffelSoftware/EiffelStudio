class TEST

inherit
	A
		redefine
			make
		end

create
	make,
	proc

feature {NONE} -- Creation

	make
		local
			value: TEST
		do
			attr := Current
			proc
			Current.proc
			extn
			Current.extn
			attr.do_nothing
			Current.attr.do_nothing
			;(+ Current).do_nothing
			;(- Current).do_nothing
			;(Current + Current).do_nothing
			;(Current - Current).do_nothing
			;(Current [Current]).do_nothing
			;(item (Current)).do_nothing
			;(agent proc).do_nothing
			;(agent do proc end).do_nothing
			;($attr).do_nothing
			{TEST}.extn
			create value.proc
			;(create {TEST}.proc).do_nothing
			Precursor
		end

feature {TEST} -- Access

	proc
			-- An obsolete procedure.
		obsolete "Internal."
		do
		end

	extn
			-- An obsolete procedure.
		obsolete "External."
		external "C inline"
			alias "return;"
		end

	attr: TEST
			-- An obsolete attribute.
		obsolete "Attribute."
		attribute
			Result := Current
		end

	prefix "+": TEST
			-- An obsolete prefix feature.
		obsolete "Prefix."
		do
			Result := Current
		end

	infix "+" (other: TEST): TEST
			-- An obsolete infix feature.
		obsolete "Infix."
		do
			Result := Current
		end

	negation alias "-": TEST
			-- An obsolete unary feature.
		obsolete "Unary."
		do
			Result := Current
		end

	difference alias "-" (other: TEST): TEST
			-- An obsolete binary feature.
		obsolete "Binary."
		do
			Result := Current
		end

	access alias "[]" (other: TEST): TEST
			-- An obsolete bracket feature.
		obsolete "Bracket."
		do
			Result := Current
		end

	call alias "()" (other: TEST): TEST
			-- An obsolete parenthesis feature.
		obsolete "Parenthesis."
		do
			Result := Current
		end

	item: like Current
			-- Current object.
		do
			Result := Current
		end

end

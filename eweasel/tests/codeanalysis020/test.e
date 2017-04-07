class TEST

inherit
	A
		redefine
			make
		end

create
	make,
	make_from_a,
	proc

convert
	make_from_a ({A}),
	to_boolean: {BOOLEAN}

feature {NONE} -- Creation

	make
		local
			value: TEST
			b: BOOLEAN
		do
			attr := Current -- No warning here: it's OK to assign to obsolete attributes.
			create attr.make -- No warning here: it's OK to use obsolete attributes as targets of creation.
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
			;($proc).do_nothing
			{TEST}.extn
			create value.proc
			;(create {TEST}.proc).do_nothing
			Precursor
			value := a
			b := Current
		end

feature {NONE} -- Access

	a: A
		do
			Result := Current
		end

feature {TEST} -- Test

	make_from_a (other: A)
			-- An obsolete procedure.
		obsolete "Conversion procedure. [$(YESTERDAY)]"
		do
		end

	proc
			-- An obsolete procedure.
		obsolete "Internal. [$(YESTERDAY)]"
		do
		end

	extn
			-- An obsolete procedure.
		obsolete "External. [$(YESTERDAY)]"
		external "C inline"
			alias "return;"
		end

	attr: TEST
			-- An obsolete attribute.
		obsolete "Attribute. [$(YESTERDAY)]"
		attribute
			Result := Current
		end

	prefix "+": TEST
			-- An obsolete prefix feature.
		obsolete "Prefix. [$(YESTERDAY)]"
		do
			Result := Current
		end

	infix "+" (other: TEST): TEST
			-- An obsolete infix feature.
		obsolete "Infix. [$(YESTERDAY)]"
		do
			Result := Current
		end

	negation alias "-": TEST
			-- An obsolete unary feature.
		obsolete "Unary. [$(YESTERDAY)]"
		do
			Result := Current
		end

	difference alias "-" (other: TEST): TEST
			-- An obsolete binary feature.
		obsolete "Binary. [$(YESTERDAY)]"
		do
			Result := Current
		end

	access alias "[]" (other: TEST): TEST
			-- An obsolete bracket feature.
		obsolete "Bracket. [$(YESTERDAY)]"
		do
			Result := Current
		end

	call alias "()" (other: TEST): TEST
			-- An obsolete parenthesis feature.
		obsolete "Parenthesis. [$(YESTERDAY)]"
		do
			Result := Current
		end

	to_boolean: BOOLEAN
			-- An obsolete conversion function.
		obsolete "Conversion function. [$(YESTERDAY)]"
		do
		end

	item: like Current
			-- Current object.
		do
			Result := Current
		end

end

class TEST

create
	make

feature {NONE} -- Creation

	make
		do
			Current.func := Current
			Current.extn := True
			Current.attr := Current
			-- Not supported: ;+ Current := Current
			-- Not supported: ;- Current := Current
			-- Not supported: Current + Current := Current
			-- Not supported: Current - Current := Current
			Current [Current] := Current
			-- Not supported: item (Current) := Current
			{TEST}.extn := True
		end

feature {TEST} -- Access

	func: TEST assign put
			-- An obsolete function.
		obsolete "Internal. [$(YESTERDAY)]"
		do
			Result := Current
		end

	extn: BOOLEAN assign put_boolean
			-- An obsolete function.
		obsolete "External. [$(YESTERDAY)]"
		external "C inline"
			alias "return 1;"
		ensure
			is_class: class
		end

	attr: TEST assign put
			-- An obsolete attribute.
		obsolete "Attribute. [$(YESTERDAY)]"
		attribute
			Result := Current
		end

	identity alias "+": TEST assign put
			-- An obsolete prefix feature.
		obsolete "Prefix. [$(YESTERDAY)]"
		do
			Result := Current
		end

	plus alias "+" (other: TEST): TEST assign put_to
			-- An obsolete infix feature.
		obsolete "Infix. [$(YESTERDAY)]"
		do
			Result := Current
		end

	negation alias "-": TEST assign put
			-- An obsolete unary feature.
		obsolete "Unary. [$(YESTERDAY)]"
		do
			Result := Current
		end

	difference alias "-" (other: TEST): TEST assign put_to
			-- An obsolete binary feature.
		obsolete "Binary. [$(YESTERDAY)]"
		do
			Result := Current
		end

	access alias "[]" (other: TEST): TEST assign put_to
			-- An obsolete bracket feature.
		obsolete "Bracket. [$(YESTERDAY)]"
		do
			Result := Current
		end

	call alias "()" (other: TEST): TEST assign put_to
			-- An obsolete parenthesis feature.
		obsolete "Parenthesis. [$(YESTERDAY)]"
		do
			Result := Current
		end

	item: TEST assign put
			-- Current object.
		do
			Result := Current
		end

feature {TEST} -- Modification

	put_boolean (b: BOOLEAN)
		do
		ensure
			is_class: class
		end

	put (t: TEST)
		do
		end

	put_to (t1, t2: TEST)
		do
		end

end

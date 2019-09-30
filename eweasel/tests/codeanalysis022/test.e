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
			-- A function.
		do
			Result := Current
		end

	extn: BOOLEAN assign put_boolean
			-- A function.
		external "C inline"
			alias "return 1;"
		end

	attr: TEST assign put
			-- An attribute.
		attribute
			Result := Current
		end

	positive alias "+": TEST assign put
			-- A alias feature.
		do
			Result := Current
		end

	plus alias "+" (other: TEST): TEST assign put_to
			-- An alias feature.
		do
			Result := Current
		end

	negation alias "-": TEST assign put
			-- An unary feature.
		do
			Result := Current
		end

	difference alias "-" (other: TEST): TEST assign put_to
			-- A binary feature.
		do
			Result := Current
		end

	access alias "[]" (other: TEST): TEST assign put_to
			-- A bracket feature.
		do
			Result := Current
		end

	call alias "()" (other: TEST): TEST assign put_to
			-- A parenthesis feature.
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
			-- An obsolete assigner.
		obsolete "Boolean. [$(YESTERDAY)]"
		do
		ensure
			is_class: class
		end

	put (t: TEST)
			-- An obsolete assigner.
		obsolete "Object. [$(YESTERDAY)]"
		do
		end

	put_to (t1, t2: TEST)
			-- An obsolete assigner.
		obsolete "Indexed. [$(YESTERDAY)]"
		do
		end

end

class
	TEST

create
	default_create,
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			a: ANY
		do
				-- VUAR(2): detachable actual argument.
			use_attached
				(if Current = twin then
					Current
				else
					Void
				end)
				-- VUAR(2): detachable actual argument.
			use_attached
				(if Current = twin then
					Void
				else
					Current
				end)
			a :=
				if Current = twin then
					a
				else
					Current
				end
				-- VUTA(2): target is not attached.
			a.do_nothing
				-- VUAR(2) in SCOOP: non-separate formal argument.
			use_attached 
				(if Current = twin then
					create {separate TEST}
				else
					Current
				end)
				-- VUAR(2) in SCOOP: non-separate formal argument.
			use_attached
				(if Current = twin then
					Current
				else
					create {separate TEST}
				end)
				-- VUAR(2): detachable actual argument.
			use_separate
				(if Current = twin then
					Current
				elseif Current ~ twin then
					a
				else
					Void
				end)
		end

feature {NONE} -- Basic operations

	use_attached (x: TEST)
		do
		end
	
	use_separate (y: separate TEST)
		do
		end

end

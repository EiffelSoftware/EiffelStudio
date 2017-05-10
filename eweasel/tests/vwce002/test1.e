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
			s: separate ANY
			x: TEST
			y: separate TEST
		do
			a := Current
			x :=
				if Current = twin then
					Current
				else
					Void
				end
			x :=
				if Current = twin then
					Void
				else
					Current
				end
			a :=
				if Current = twin then
					a
				else
					Current
				end
			a.do_nothing
			y :=
				if Current = twin then
					create {separate TEST}
				else
					Current
				end
			y :=
				if Current = twin then
					Current
				else
					create {separate TEST}
				end
			s := 
				if Current = twin then
					Current
				elseif Current ~ twin then
					a
				else
					Void
				end
		end

end

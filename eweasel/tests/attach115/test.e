class TEST

inherit

	ITERABLE [TEST]
	ITERATION_CURSOR [TEST]

create
	make,
	make_with_other

feature {NONE} -- Creation

	make
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other (Current)
		end

	make_with_other (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			across t as tc loop end
		end

feature -- Access

	a: A
			-- This attribute should not be accessed before it is initialized.

feature -- Iteration

	new_cursor: ITERATION_CURSOR [TEST]
			-- <Precursor>
		do
			Result := Current
		end

	after: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	item: TEST
			-- <Precursor>
		do
			Result := Current
		end

	forth
			-- <Precursor>
		do
			a.do_nothing
		end

end
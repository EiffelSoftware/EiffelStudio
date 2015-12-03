class A

inherit

	ITERABLE [A]
	ITERATION_CURSOR [A]

create
	make,
	make_with_other

feature {NONE} -- Creation

	make
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other (Current)
		end

	make_with_other (t: TEST)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			across t as tc loop end
		end

feature -- Access

	a: TEST
			-- This attribute should not be accessed before it is initialized.

feature -- Iteration

	new_cursor: ITERATION_CURSOR [A]
			-- <Precursor>
		do
			Result := Current
		end

	after: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

	item: A
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
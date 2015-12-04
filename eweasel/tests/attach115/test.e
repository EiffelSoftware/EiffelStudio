class TEST

inherit

	ITERABLE [TEST]
	ITERATION_CURSOR [TEST]

create
	make_loop,
	make_all,
	make_some,
	make_with_other_loop,
	make_with_other_all,
	make_with_other_some

feature {NONE} -- Creation

	make_loop
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_loop (Current)
		end

	make_all
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_all (Current)
		end

	make_some
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_some (Current)
		end

	make_with_other_loop (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			across t as tc loop end
		end

	make_with_other_all (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			b := across t as tc all a = t end
		end

	make_with_other_some (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			b := across t as tc some a = t end
		end

feature -- Access

	a: A
			-- This attribute should not be accessed before it is initialized.

	b: BOOLEAN
			-- A variable initialized in some creation procedures.

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
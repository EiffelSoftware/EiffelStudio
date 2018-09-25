class TEST

inherit

	ITERABLE [TEST]
	ITERATION_CURSOR [TEST]

create
	make_loop_as,
	make_all_as,
	make_some_as,
	make_loop_is,
	make_all_is,
	make_some_is,
	make_with_other_loop_as,
	make_with_other_all_as,
	make_with_other_some_as,
	make_with_other_loop_is,
	make_with_other_all_is,
	make_with_other_some_is

feature {NONE} -- Creation

	make_loop_as
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_loop_as (Current)
		end

	make_all_as
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_all_as (Current)
		end

	make_some_as
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_some_as (Current)
		end

	make_loop_is
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_loop_is (Current)
		end

	make_all_is
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_all_is (Current)
		end

	make_some_is
			-- Call a creation procedure that makes an implicit qualified call using an iterative form of a loop.
		do
			create a.make_with_other_some_is (Current)
		end

	make_with_other_loop_as (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			across t as tc loop end
		end

	make_with_other_all_as (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			b := across t as tc all a = t end
		end

	make_with_other_some_as (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			b := across t as tc some a = t end
		end

	make_with_other_loop_is (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			across t is tc loop end
		end

	make_with_other_all_is (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			b := across t is tc all a = t end
		end

	make_with_other_some_is (t: A)
			-- Iterate over `t' with an iterative form of a loop.
		do
			a := t
			b := across t is tc some a = t end
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
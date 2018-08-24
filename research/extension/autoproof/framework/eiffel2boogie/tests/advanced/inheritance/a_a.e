class
	A_A

create
	make

feature
	make
		note
			status: creator
		do
			x := 1
			next := Current
			prev := Current
		end

feature
	x: INTEGER

	next: A_A

	prev: A_A

	set_x (a_x: INTEGER)
		require
			a_x >= 0
		do
			x := a_x
		end

	set_to_next_public
		require
			next_wrapped: next.is_wrapped
		do
			check next.inv end
			x := next.x
		end

	set_to_prev_public
		require
			prev_wrapped: prev.is_wrapped
		do
			check prev.inv end
			x := prev.x
		end

	get_x: INTEGER
		note
			status: functional
		do
			Result := x
		end

feature {A_A}

	set_to_next
		require
			open: is_open
			partially_holds: inv_without ("x_non_negative")
			next_wrapped: next.is_wrapped
		do
			check next.inv end
			x := next.x
		ensure
			invariant_holds: inv
		end

	break
		require
			wrapped: is_wrapped
		do
			unwrap
			prev := Void
		ensure
			open: is_open
			almost_holds: inv_without ("prev_exists")
		end

	something
		require
			next /= Void
		do
		end

	set_prev
		require
			open: is_open
			observers = []
			modify_field ("prev", Current)
		do
			prev := Current
		ensure
			prev /= Void
		end

invariant
	next_exists: next /= Void
	prev_exists: prev /= Void
	x_non_negative: x >= 0
end

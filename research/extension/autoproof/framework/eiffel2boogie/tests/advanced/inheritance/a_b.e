class
	A_B

inherit
	A_C
		rename
			right as next
		redefine
			something
		end

	A_A
		redefine
			prev,
			break,
			get_x,
			something
		end

feature
	prev: A_B
		-- Redefined.

	-- set_x: fails

	-- set_to_next: fails since inv_without is bound statically, so new invariant is not available

	-- set_to_next_public succeeds, as the new invariant holds at the start

	-- set_to_prev_public succeeds, since the type of prev has been redefined

	use_break (other: A_A)
		note
			explicit: wrapping
		require
			other_wrapped: other.is_wrapped
			modify (Current, other)
		do
			break
			check x > 0 end
			prev := Current
			wrap

			other.break
			check almost_holds: other.inv_without ("prev_exists") end
			check new_property: other.x > 0 end -- Fail
			other.set_prev
			other.wrap -- Fail: dynamic type unknown
		end

	get_x: INTEGER
		do
			Result := 0
		end

feature {A_A}

	break
		do
			check inv end
			check new_property: prev.x > 0 end -- Fail
			unwrap
			prev := Void
		ensure then
			still_almost_holds: inv_without ("prev_exists")
		end

	something
		do
			check next.get_x = next.x end
		end

invariant
	next_is_b: attached {A_B} next
	x_positive: x > 0
end

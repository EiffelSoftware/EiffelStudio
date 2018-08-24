note
	model: x, y
class
	A_MODELS

feature

	x: INTEGER

	y: INTEGER

	z: INTEGER

	foo
		require
			modify_model (["x", "y"], Current)
		do
			x := 1
			z := 1 -- OK: z is non-model
		end

	bar
		note
			explicit: wrapping
		require
			modify_model (["x"], Current)
		do
			if x > 0 then
				foo		-- Bad
			else
				unwrap
				y := 1 	-- Bad: y is model
				wrap
			end
		end

	bar_ok
		note
			explicit: wrapping
		require
			modify_model (["x", "y"], Current)
		do
			if x > 0 then
				foo
			else
				unwrap
				y := 1
				wrap
			end
		end

end

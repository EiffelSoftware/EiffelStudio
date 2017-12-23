class TEST

inherit
	MEMORY

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			y: detachable ANY
		do
			across
				0 |..| 9 as i
			loop
					-- Attach an expanded value to a reference variable.
				y := True
					-- Make sure `Current` and `y` reach an old generation.
				create_and_collect_garbage
					-- Attach an old expanded object to a variable of an old object.
					-- The new clone of `y` has to be reachable by GC.
				x := y
					-- Perform generational GC, so that `Current` (and the copy in `x`) is not processed
					-- unless it has been registered by the assignment `x := y`.
				create_and_collect_garbage
					-- Report the value stored in `x` (presumably `True`).
				check attached x as z then
					io.put_integer (i.item)
					io.put_string (": ")
					print (z)
					io.put_new_line
				end
			end
		end

feature {NONE} -- Testing

	x: detachable ANY
			-- An attribute to be assigned an expanded value that should be tracked by GC.

	create_and_collect_garbage
			-- Create some new objects and then trigged a generational GC.
		local
			s: STRING
		do
			across
				1 |..| 10 as j
			loop
				create s.make_empty
				across
					1 |..| 44 as i
				loop
					s.append ("sljkf shdjf hsdjf hjksd ds sd sdf dsf sdjgsd")
				end
				collect
			end
		end

end

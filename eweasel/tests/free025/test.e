class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			c: CELL [BOOLEAN]
		do
			io.put_boolean (f) -- VUCR (feature call)
			create c.put (f) -- VUCR (creation procedure call in a creation instruction)
			;(create {CELL [BOOLEAN]}.put (f)).do_nothing -- VUCR (creation procedure call in a creation expression)
			c.do_nothing
		ensure
			instance_free: class
		end

feature {NONE} -- Tests

	f: BOOLEAN
		do
		end

end
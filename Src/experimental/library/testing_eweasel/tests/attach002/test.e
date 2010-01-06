class TEST

create
	make

feature {NONE} -- Creation

	make is
			-- Run tests.
		do
			print ("Test 1: ")
			if {a: STRING} Current then
				a.do_nothing
				print ("Failed 1%N")
			elseif {b: TEST} Current then
				b.do_nothing
				print ("OK%N")
			else
				print ("Failed 2%N")
			end
			print ("Test 2: ")
			if not {c: TEST} Current then
				print ("Failed 1%N")
			elseif not {d: STRING} Current then
				c.do_nothing
				print ("OK%N")
			else
				c.do_nothing
				d.do_nothing
				print ("Failed 2%N")
			end
		end

end
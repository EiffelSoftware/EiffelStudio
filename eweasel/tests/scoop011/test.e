class TEST

create
	default_create, make, make_from_other

feature {NONE} -- Creation

	make_from_other (other: separate TEST)
		do
			a := other
		end

        make
        	local
        		x: separate TEST
			p1: separate TEST
			p2: separate TEST
		do
			create x.make_from_other (create {separate TEST})
			create p1.make_from_other (x)
			create p2.make_from_other (x)
			start (p1, 0)
			start (p2, 1)
			wait (p1)
			wait (p2)
			io.put_string ("OK")
			io.put_new_line
		end

feature -- Access

	start (x: separate TEST; r: INTEGER)
		do
			x.run (r)
		end

	wait (x: separate TEST)
		require
			x.done
		do
		end

	run (r: INTEGER)
		local
			i: INTEGER
		do
			from
			until
				i > 2
			loop
				i := i + 1
				if attached a as x then
					g (x, r)
				end
			end
			done := True
		rescue
			retry
		end

	g (x: separate TEST; r: INTEGER)
		require
			x.value \\ 2 = r
		do
			x.increment
			value := x.value // (r - r)
		end

	a: detachable separate TEST

	done: BOOLEAN

	value: INTEGER

	increment
		do
			value := value + 1
		end

end

class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			t: TEST
		do
			t := Current
			t (1)
			t (2, 3)
			t ("a", 4, "b")
		end

feature

	f alias "()" (t: TUPLE)
		local
			i, n: INTEGER
		do
			from
				n := t.count
			until
				i >= n
			loop
				if i > 0 then
					io.put_string (", ")
				end
				i := i + 1
				if attached {ANY} t [i] as x then
					print (x)
				end
			end
			io.put_new_line
		end

end

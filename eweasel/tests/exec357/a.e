deferred class A

feature -- Output

	print_tuple (t: TUPLE)
		local
			i, n: INTEGER
		do
			io.put_character ('[')
			from
				n := t.count
			until
				i >= n
			loop
				if i > 0 then
					io.put_string (", ")
				end
				i := i + 1
				check attached {ANY} t [i] as x then
					print (x)
				end
			end
			io.put_character (']')
		end

end
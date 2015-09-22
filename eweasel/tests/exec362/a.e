class A [G -> TUPLE]

feature -- Test

	f alias "()" (t: G)
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
			io.put_new_line
		end

end
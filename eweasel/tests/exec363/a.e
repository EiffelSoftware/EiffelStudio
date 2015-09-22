deferred class A

feature {NONE} -- Creation

	make (n: like name)
			-- Initialize with a name `n'.
		do
			name := n
		ensure
			name_set: name = n
		end

feature {NONE} -- Access

	name: STRING
			-- Object name.

feature {NONE} -- Output

	print_name (t: STRING)
			-- Print type description `t'.`
		do
			print (t)
			print (" (")
			print (name)
			print ("): ")
		end

	print_tuple (t: TUPLE)
			-- Print `t'.
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
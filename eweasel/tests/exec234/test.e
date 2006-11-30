indexing
	description: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create 
	make

feature
	make is
		local
			ai: ARRAYI [STRING]
			a: ARRAY [STRING]
			i, v: INTEGER
			r: RANDOM
			eq: BOOLEAN
		do
			
			create r.make
			create ai.make (1, 10)
			create a.make (1, 10)

			from i := ai.lower until i > ai.upper loop
				ai.put ((i*2).out, i)
				a.put ((i*2).out, i)
				i := i + 1
			end

			from i := 1 until i > 100 loop
				v := r.i_th (i)
				ai.force (v.out, i // 1000)
				a.force (v.out, i // 1000)
				i := i + 1
			end

			from 
				i := ai.lower 
				eq := True
			until 
				i > ai.upper or not eq
			loop
				eq := equal (ai.item (i), a.item (i))
				i := i + 1
			end
			
			print (eq.out)
		end

end

indexing
description	: "This test mainly tests infix features together with multi constraints including renaming."
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

create
	make

feature -- Initialization
	a: DOUBLE

	make is
			-- Creation procedure.
		local
			l: MULTI [ARRAYED_LIST[like a], like a]
			arrayed_list: ARRAYED_LIST[like a]

			i: INTEGER
		do
			create arrayed_list.make (4);
			from i := 1 until i > 4
			loop
				arrayed_list.extend(42+i)
				i := i + 1
			end

			create l.make (arrayed_list)

			a := arrayed_list @ 1
			print (a.out + "%N")	-- prints 43
			a := l.g.i_th(2)
			print (a.out + "%N")	-- prints 44
			a := l.g @ 3
			print (a.out + "%N")	-- prints 45
			print ("test:%N")
			print (l.test.out)		-- prints 45
			print ("%N")
		end

end -- class ROOT_CLASS

class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			a: ARRAY [STRING]
			l: ARRAYED_LIST [STRING]
			i: INTEGER
		do
			create a.make (Start, Start + Items - 1)
			from
				i := Start
			until
				i > Start + Items - 1
			loop
				a.put (i.out, i)
				i := i + 1
			end
			Io.put_string ("ARRAY... OK%N")
			create l.make (Items)
			from
				i := 1
			until
				i > Items
			loop
				l.extend (i.out)
				i := i + 1
			end
			Io.put_string ("ARRAYED_LIST... OK%N")
		end
		
feature {NONE} -- Constants

	Start: INTEGER is 200
	Items: INTEGER is 100

end -- class TEST

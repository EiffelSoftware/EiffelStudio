class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			a: ARRAY [STRING]
			a2: ARRAY2 [STRING]
			l: ARRAYED_LIST [STRING]
			set: ARRAYED_SET [STRING]
			stack: ARRAYED_STACK [STRING]
			fl: FIXED_LIST [STRING]
			hq: HEAP_PRIORITY_QUEUE [STRING]
			aq: ARRAYED_QUEUE [STRING]
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
			create a2.make (Items, 1)
			from
				i := 1
			until
				i > Items
			loop
				a2.put (i.out, i, 1)
				i := i + 1
			end
			Io.put_string ("ARRAY2... OK%N")
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
			create set.make (Items)
			from
				i := 1
			until
				i > Items
			loop
				set.extend (i.out)
				i := i + 1
			end
			Io.put_string ("ARRAYED_SET... OK%N")
			create stack.make (Items)
			from
				i := 1
			until
				i > Items
			loop
				stack.extend (i.out)
				i := i + 1
			end
			Io.put_string ("ARRAYED_STACK... OK%N")
			create fl.make (Items)
			from
				i := 1
			until
				i > Items
			loop
				fl.extend (i.out)
				i := i + 1
			end
			Io.put_string ("FIXED_LIST... OK%N")
			create hq.make (Items)
			from
				i := 1
			until
				i > Items
			loop
				hq.put (i.out)
				i := i + 1
			end
			Io.put_string ("HEAP_PRIORITY_QUEUE... OK%N")
			create aq.make (Items)
			from
				i := 1
			until
				i > Items
			loop
				aq.put (i.out)
				i := i + 1
			end
			Io.put_string ("ARRAYED_QUEUE... OK%N")
		end
		
feature {NONE} -- Constants

	Start: INTEGER is 200
	Items: INTEGER is 100

end -- class TEST

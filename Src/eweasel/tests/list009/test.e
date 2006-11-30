class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > Tests
			loop
				fill_list (i)
				output_list (i)
				i := i + 1
			end
		end

feature {NONE} -- Constants

	Items: INTEGER is 20
	
	Tests: INTEGER is 9

feature {NONE} -- Implementation

	l: ARRAYED_LIST [INTEGER]

	fill_list (n: INTEGER) is
			-- Fill list with test data `n'
		require
			in_range: 1 <= n and n <= Tests
		local
			i: INTEGER
		do
			create l.make (Items)
			inspect
				n
			when 1 then
				from
					i := 1
				until
					i > Items
				loop
					l.extend (i)
					i := i + 1
				end
			when 2 then
				from
					i := 1
				until
					i > Items
				loop
					l.put_right (i)
					i := i + 1
				end
			when 3 then
				from
					i := 1
					l.forth
				until
					i > Items
				loop
					l.extend (i)
					i := i + 1
				end
			when 4 then
				from
					i := 1
					l.forth
				until
					i > Items
				loop
					l.put_front (i)
					i := i + 1
				end
			when 5 then
				from
					i := 1
					l.forth
				until
					i > Items
				loop
					l.put_left (i)
					i := i + 1
				end
			when 6 then
				from
					i := 1
				until
					i > Items // 2
				loop
					l.extend (i)
					i := i + 1
				end
				from
					i := (Items // 2) + 1
					l.go_i_th (i // 2)
				until
					i > Items
				loop
					l.extend (i)
					i := i + 1
				end
			when 7 then
				from
					i := 1
				until
					i > Items // 2
				loop
					l.extend (i)
					i := i + 1
				end
				from
					i := (Items // 2) + 1
					l.go_i_th (i // 2)
				until
					i > Items
				loop
					l.put_front (i)
					i := i + 1
				end
			when 8 then
				from
					i := 1
				until
					i > Items // 2
				loop
					l.extend (i)
					i := i + 1
				end
				from
					i := (Items // 2) + 1
					l.go_i_th (i // 2)
				until
					i > Items
				loop
					l.put_left (i)
					i := i + 1
				end
			when 9 then
				from
					i := 1
				until
					i > Items // 2
				loop
					l.extend (i)
					i := i + 1
				end
				from
					i := (Items // 2) + 1
					l.go_i_th (i // 2)
				until
					i > Items
				loop
					l.put_right (i)
					i := i + 1
				end
			end
		end

	output_list (n: INTEGER) is
			-- Output list of test `n'.
		require
			in_range: 1 <= n and n <= Tests
		do
			Io.put_string ("Test " + n.out + ": ")
			from
				l.start
			until
				l.after
			loop
				Io.put_integer (l.item)
				if not l.islast then Io.put_string (",") end
				l.forth
			end
			Io.put_new_line
		end
		
end -- class TEST

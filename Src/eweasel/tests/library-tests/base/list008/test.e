class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			Io.put_string ("Fill...%N")
			fill_list
			Io.put_string ("Prune...%N")
			prune
			Io.put_string ("Check...%N")
			check_result
		end

feature {NONE} -- Constants

	Items: INTEGER is 1000
		
	One_frequency: INTEGER is 5

feature {NONE} -- Implementation

	l: ARRAYED_LIST [INTEGER]
	
	ones: INTEGER

	fill_list is
			-- Fill up list.
		local
			i: INTEGER
			val: INTEGER
		do
			create l.make (Items)
			from i := 1 until i > Items loop
				if (i - 1) \\ One_frequency = 0 then
					val := 1
				else
					val := i
				end
				l.extend (val)
				if val = 1 then ones := ones + 1 end
				i := i + 1
			end
		ensure
			ones_correct: ones = Items // One_frequency
		end

	prune is
			-- Prune all ones.
		do
			l.prune_all (1)
		ensure
			count_correct: l.count = old l.count - ones
		end

	check_result is
			-- Check result of pruning.
		do
			if l.has (1) then
				Io.put_string ("Pruning... FAILED%N")
			else
				Io.put_string ("Pruning... OK%N")
			end
		end

end -- class TEST

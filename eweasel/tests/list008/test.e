class 
	TEST

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		do
			fill_list (1)
			prune
			check_result
			fill_list (Items)
			prune
			check_result
		end

feature {NONE} -- Constants

	Items: INTEGER is 1000
		
	One_frequency: INTEGER is 5

feature {NONE} -- Implementation

	l: ARRAYED_LIST [INTEGER]
	
	ones: INTEGER

	fill_list (n: INTEGER) is
			-- Fill up list.
		require
			positive: n > 0
		local
			i: INTEGER
			val: INTEGER
		do
			if n > 1 then
				Io.put_string ("Fill with " + n.out + " items...%N")
			else
				Io.put_string ("Fill with 1 item...%N")
			end
			create l.make (n)
			ones := 0
			from i := 1 until i > n loop
				if (i - 1) \\ One_frequency = 0 then
					val := 1
				else
					val := i
				end
				l.extend (val)
				if val = 1 then ones := ones + 1 end
				i := i + 1
			end
		end

	prune is
			-- Prune all ones.
		do
			Io.put_string ("Prune...%N")
			l.prune_all (1)
		ensure
			count_correct: l.count = old l.count - ones
		end

	check_result is
			-- Check result of pruning.
		do
			Io.put_string ("Check...%N")
			if l.has (1) then
				Io.put_string ("Pruning... FAILED%N%N")
			else
				Io.put_string ("Pruning... OK%N%N")
			end
		end

end -- class TEST

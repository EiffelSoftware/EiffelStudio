class TEST inherit

	EXCEPTIONS
		export
			{NONE} all
		end

create

	make

feature {NONE} -- Initialization

	make is
			-- Execute test.
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > Cases
			loop
				fill_lists
				merge (i)
				i := i + 1
			end
		end

feature {NONE} -- Constants

	Cases: INTEGER is 10
			-- Number of test cases

	Exception_cases: ARRAY [INTEGER] is 
			-- Cases that violate the preconditions of the merge features
		once
			Result := <<1, 10>>
		end

feature {NONE} -- Implementation

	l1, l2: ARRAYED_LIST [INTEGER]
	
	fill_lists is
			-- Fill both lists with test data.
		do
			create l1.make (4)
			create l2.make (4)
			l1.extend (1)
			l1.extend (2)
			l1.extend (3)
			l1.extend (4)
			l2.extend (11)
			l2.extend (12)
			l2.extend (13)
			l2.extend (14)
			l2.extend (15)
			l2.extend (16)
		end

	merge (case: INTEGER) is
			-- Merge lists. Use test case `case'.
		require
			defined_case: 1 <= case and case <= Cases
		local
			retried: BOOLEAN
		do
			if not retried then
				Io.put_string ("Case " + case.out + ": ")
				inspect
					case
				when 1 then
					l1.start
					l1.back
					l1.merge_left (l2)
				when 2 then
					l1.start
					l1.back
					l1.merge_right (l2)
				when 3 then
					l1.start
					l1.merge_left (l2)
				when 4 then
					l1.start
					l1.merge_right (l2)
				when 5 then
					l1.go_i_th (2)
					l1.merge_left (l2)
				when 6 then
					l1.go_i_th (2)
					l1.merge_right (l2)
				when 7 then
					l1.finish
					l1.merge_left (l2)
				when 8 then
					l1.finish
					l1.merge_right (l2)
				when 9 then
					l1.finish
					l1.forth
					l1.merge_left (l2)
				when 10 then
					l1.finish
					l1.forth
					l1.merge_right (l2)
				end
				if Exception_cases.has (case) then
					raise ("Case " + case.out + " should throw an exception")
				end
				output_list
			end
		rescue
			if exception = Precondition and then Exception_cases.has (case) then
				Io.put_string ("Precondition violated... OK, Tag: " +
						tag_name + "%N")
				retried := True
				retry
			end
		end

	output_list is
			-- Output merged list.
		do
			from
				l1.start
			until
				l1.after
			loop
				Io.put_integer (l1.item)
				if not l1.islast then Io.put_string (", ") end
				l1.forth
			end
			Io.put_new_line
		end

end -- class TEST

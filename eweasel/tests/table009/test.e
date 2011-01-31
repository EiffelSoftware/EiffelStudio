class
	TEST

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			list: LIST [STRING]
		do
			create table.make (17)
			list := table.linear_representation
			add_first_ones
			list := table.linear_representation
			delete_first_ones
			list := table.linear_representation
			add_others
			list := table.linear_representation
			add_first_ones
			list := table.linear_representation
		end

	table: HASH_TABLE [STRING, STRING]

	first_ones: ARRAY [STRING]
		once
			Result := << "TEST_BREF", "TEST_SUB", "TEST_MSG", "TEST_OBJ1", "TEST_OBJ2" >>
		end

	others: ARRAY [STRING]
		once
			Result := << "sub10" >>
		end

	add_first_ones
		local
			i, lim: INTEGER
			ts: STRING
		do
			lim := first_ones.count
			from i := 1
			until i > lim
			loop
				ts := first_ones.item (i)
				table.extend (ts, ts)
				i := i + 1
			end
		end

	delete_first_ones
		local
			i, lim: INTEGER
			ts: STRING
		do
			lim := first_ones.count
			from i := 1
			until i > lim
			loop
				ts := first_ones.item (i)
				table.remove (ts)
				i := i + 1
			end
		end

	add_others
		local
			i, lim: INTEGER
			ts: STRING
		do
			lim := others.count
			from i := 1
			until i > lim
			loop
				ts := others.item (i)
				table.extend (ts, ts)
				i := i + 1
			end
		end

end

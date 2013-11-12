class DS_SPARSE_TABLE_KEYS [G, K]

inherit

	DS_LINEAR [K]

create {DS_SPARSE_TABLE}

	make, make_with_table_cursor

feature {NONE}

	make (a_table: like table)
		do
			table := a_table
			equality_tester := table.key_equality_tester
			set_internal_cursor (new_cursor)
		end

	make_with_table_cursor (a_table: like table; a_table_cursor: like table.new_cursor)
		do
			table := a_table
			set_internal_cursor (new_cursor_with_table_cursor (a_table_cursor))
		end

feature -- Access

	new_cursor: DS_SPARSE_TABLE_KEYS_CURSOR [G, K]
		do
			create Result.make (Current)
		end

feature {NONE}

	set_internal_cursor (c: like internal_cursor)
		do
			internal_cursor := c
		end

	internal_cursor: like new_cursor

	new_cursor_with_table_cursor (a_table_cursor: like table.new_cursor): DS_SPARSE_TABLE_KEYS_CURSOR [G, K]
		do
			create Result.make_with_table_cursor (Current, a_table_cursor)
		end

feature {DS_SPARSE_TABLE, DS_SPARSE_TABLE_KEYS, DS_SPARSE_TABLE_KEYS_CURSOR}

	table: DS_SPARSE_TABLE [G, K]

feature {DS_SPARSE_TABLE}

	internal_set_equality_tester (a_tester: like equality_tester)
		do
			equality_tester := a_tester
		end

end

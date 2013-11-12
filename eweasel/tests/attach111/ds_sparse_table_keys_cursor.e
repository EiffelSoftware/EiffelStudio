class DS_SPARSE_TABLE_KEYS_CURSOR [G, K]

inherit

	DS_LINEAR_CURSOR [K]

create {DS_SPARSE_TABLE_KEYS}

	make, 
	make_with_table_cursor

feature {NONE}

	make (a_container: like container)
		do
			container := a_container
			table_cursor := container.table.new_cursor
		end

	make_with_table_cursor (a_container: like container; a_table_cursor: like table_cursor)
		do
			container := a_container
			table_cursor := a_table_cursor
		end

feature

	container: DS_SPARSE_TABLE_KEYS [G, K]

feature {DS_SPARSE_TABLE_KEYS}

	table_cursor: like container.table.new_cursor

end

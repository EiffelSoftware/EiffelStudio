class TEST
create
	make
feature

	make
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			create table.make (2)
			table.put (0, 0)
			table.put (1, 1)
			table.put (2, 2)
			iterate (table)
			table.remove (0)
			iterate (table)

			create table.make (2)
			table.put (1, 1)
			table.put (2, 2)
			table.put (0, 0)
			iterate (table)
			table.remove (0)
			iterate (table)

			create table.make (2)
			table.put (1, 1)
			table.put (0, 0)
			table.put (2, 2)
			iterate (table)
			table.remove (0)
			iterate (table)
		end

feature {NONE}

	iterate (a_hash_table: HASH_TABLE [INTEGER, INTEGER])
		do
			from
				a_hash_table.start
			until
				a_hash_table.after
			loop
				check a_hash_table.has (a_hash_table.key_for_iteration) end
				a_hash_table.forth
			end
		end

end

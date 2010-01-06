class TEST

create
	make

feature
	 make
		local
			table: HASH_TABLE [STRING_8, HASHABLE]
		do
			create table.make (1)
			table.put ("abc", 0)
			from
				table.start
			until
				table.off
			loop
				print (table.item_for_iteration)
				table.forth
			end
			print ("%N")
		end
end

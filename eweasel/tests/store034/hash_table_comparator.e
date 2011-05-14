class
	HASH_TABLE_COMPARATOR [G, H -> HASHABLE]

feature

	same_table (old_table, new_table: HASH_TABLE [G, H]): BOOLEAN
		do
			if old_table.count = new_table.count then
				Result := True

				from
					old_table.start
				until
					old_table.after or not Result
				loop
					Result := new_table.item (old_table.key_for_iteration) ~ old_table.item_for_iteration
					old_table.forth
				end

				from
					new_table.start
				until
					new_table.after or not Result
				loop
					Result := old_table.item (new_table.key_for_iteration) ~ new_table.item_for_iteration
					new_table.forth
				end

			end
		end

end

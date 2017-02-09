class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			table: HASH_TABLE [INTEGER, INTEGER]
			keys: ARRAYED_LIST [INTEGER]
		do
			create keys.make (3)
			create table.make (3)
			table [1] := 7
			table [2] := 6
			table [3] := 5
			across
				table as c
			loop
				keys.extend (c.key)
			end
			across
				table.new_cursor.reversed as c
			from
				keys.finish
			loop
				keys.back
				if c.key = keys.item_for_iteration then
					keys.remove
				end
			end
			io.put_string (if keys.is_empty then "OK" else "Failed" end)
			io.put_new_line
		end

end
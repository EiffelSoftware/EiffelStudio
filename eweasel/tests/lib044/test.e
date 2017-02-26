class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			across
				1 |..| 3 as i
			loop
				create table.make (3)
				table [1] := 7
				table [2] := 6
				table [3] := 5
				if i.item /= 1 then table.remove (1) end
				if i.item /= 2 then table.remove (2) end
				if i.item /= 3 then table.remove (3) end
					-- Forward iteration.
				across
					table as c
				loop
					io.put_integer (c.item)
				end
					-- Backward iteration.
				across
					table.new_cursor.reversed as c
				loop
					io.put_integer (c.item)
				end
				io.put_new_line
			end
		end

end

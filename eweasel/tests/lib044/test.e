class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run test.
		local
			table: HASH_TABLE [INTEGER, INTEGER]
		do
			io.put_string ("Test #1:")
			io.put_new_line
			create table.make (1)
			table [1] := 7
			table.remove (1)
				-- Forward iteration.
			across
				table as c
			loop
				io.put_character ('%T')
				io.put_integer (c.item)
			end
			across
				table is c
			loop
				io.put_character ('(')
				io.put_integer (c)
				io.put_character (')')
			end
			from
				table.start
			until
				table.after
			loop
				io.put_integer (table.item_for_iteration)
				table.forth
			end
				-- Backward iteration.
			across
				table.new_cursor.reversed as c
			loop
				io.put_character ('-')
				io.put_integer (c.item)
			end
			across
				table.new_cursor.reversed is c
			loop
				io.put_character ('(')
				io.put_integer (c)
				io.put_character (')')
			end
			io.put_new_line

			io.put_string ("Test #2:")
			io.put_new_line
			across
				1 |..| 2 as i
			loop
				create table.make (2)
				table [1] := 7
				table [2] := 6
				if i.item /= 1 then table.remove (1) end
				if i.item /= 2 then table.remove (2) end
					-- Forward iteration.
				across
					table as c
				loop
					io.put_character ('%T')
					io.put_integer (c.item)
				end
				across
					table is c
				loop
					io.put_character ('(')
					io.put_integer (c)
					io.put_character (')')
				end
				from
					table.start
				until
					table.after
				loop
					io.put_integer (table.item_for_iteration)
					table.forth
				end
					-- Backward iteration.
				across
					table.new_cursor.reversed as c
				loop
					io.put_character ('-')
					io.put_integer (c.item)
				end
				across
					table.new_cursor.reversed is c
				loop
					io.put_character ('(')
					io.put_integer (c)
					io.put_character (')')
				end
				io.put_new_line
			end

			io.put_string ("Test #3:")
			io.put_new_line
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
					io.put_character ('%T')
					io.put_integer (c.item)
				end
				across
					table is c
				loop
					io.put_character ('(')
					io.put_integer (c)
					io.put_character (')')
				end
				from
					table.start
				until
					table.after
				loop
					io.put_integer (table.item_for_iteration)
					table.forth
				end
					-- Backward iteration.
				across
					table.new_cursor.reversed as c
				loop
					io.put_character ('-')
					io.put_integer (c.item)
				end
				across
					table.new_cursor.reversed is c
				loop
					io.put_character ('(')
					io.put_integer (c)
					io.put_character (')')
				end
				io.put_new_line
			end
		end

end

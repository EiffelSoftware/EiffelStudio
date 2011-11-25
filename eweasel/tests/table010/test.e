class
	TEST

create
	make

feature

	make
		do
			create table.make (0)
			print (table.valid_cursor (table.cursor)); io.new_line
		end

	table: HASH_TABLE [STRING, INTEGER]

end

class 
	TEST

create

	make

feature {NONE} -- Initialization

	make
		local
			l_string_table: STRING_TABLE [INTEGER_32]
			l_item: INTEGER_32
		do
			create l_string_table.make_caseless (5)
			l_string_table.put (123, {STRING_32} "CLASS_NAME")
			l_string_table.put (456, {STRING_32} "NOTE_KEYWORD")
			l_string_table.put (789, {STRING_32} "YEAR")
			l_string_table.put (012, {STRING_32} "CLASS_MODIFIERS")
			l_string_table.put (345, {STRING_32} "INHERIT_CLAUSE")
			l_string_table.put (678, {STRING_32} "CREATION_CLAUSE")
			l_string_table.put (901, {STRING_32} "INIT_CLAUSE")
			l_string_table.put (123, {STRING_32} "CLASS_NAME")
			l_string_table.put (456, {STRING_32} "NOTE_KEYWORD")
			l_string_table.put (789, {STRING_32} "YEAR")
			l_string_table.put (012, {STRING_32} "CLASS_MODIFIERS")
			l_string_table.put (345, {STRING_32} "INHERIT_CLAUSE")
			l_string_table.put (678, {STRING_32} "CREATION_CLAUSE")
			l_string_table.put (901, {STRING_32} "INIT_CLAUSE")
			l_item := l_string_table.item ({STRING_32} "CLASS_NAME")
			print (l_item.out + "%N")
		end

end

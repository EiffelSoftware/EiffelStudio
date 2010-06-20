
class TEST

create
	make
feature
	
	make
		do
			create table.make (5)
			print (table.generating_type); io.new_line
		end

	table: HASH_TABLE [like value, like value]

	value: $(ATTRIBUTE_TYPE)

end


class TEST
create
	make
feature

	make
		local
			table: HASH_TABLE [STRING, STRING]
			l_keys: ARRAY [STRING]
			i: INTEGER
		do
			create table.make (2)
			table.put ("abc", "ABC")
			table.put ("def", "DEF")
			table.put ("ghi", "GHI")

			l_keys := table.current_keys
			from
				i := l_keys.lower
			until
				i > l_keys.upper
			loop
				print (i.out + ": " + l_keys[i] + "%N")
				i := i + 1
			end
		end

end

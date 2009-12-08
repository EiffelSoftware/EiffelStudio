indexing
	description: "Garbage collection will cause runtime exception"
	author: "Gyrd Thane Lange"
	date: "$Date$"
	revision: "$Revision$"

class
	TEST

inherit
	MEMORY

create
	make

feature

	make is
		local
			i, j: INTEGER
			field_name, field_value: STRING
			tuple: HASH_TABLE [ANY_VALUE, STRING]
			any_list: ARRAYED_LIST [ANY]
			v: ANY_VALUE
			special: SPECIAL [CHARACTER]
		do
			allocate_tiny
			Create any_list.make (5000)
			from
				i := 0
			until
				i >= 10000
			loop
				io.put_integer (i)
				Create tuple.make (100)
				from
					j := 0
				until
					j >= 60
				loop
					field_name := "any_field_" + j.out
					field_value := "any_value_" + j.out + "_" + i.out
					Create v.make (field_value)
					tuple.put (v, field_name.twin)
					j := j + 1
				end
--				io.put_string (" ")
				special := field_name.area
--				io.put_string (($special).out)
				any_list.extend (tuple)
				i := i + 1
				io.new_line
			end
		end

end

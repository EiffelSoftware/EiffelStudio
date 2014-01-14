class TEST

create
	make

feature {NONE} -- Creation
	
	make
			-- Run test.
		local
			l_hash_table: STRING_TABLE [detachable ANY]
			l_any: detachable ANY
		do
			create l_hash_table.make (2)
			l_hash_table.put ("s", "s")
			l_any := l_hash_table.item ("s")

			if obj_is_string (l_any) then
				io.put_string ("OK%N")
			else
				io.put_string ("Not OK%N")
			end
		end

feature

	obj_is_string (obj: ANY): BOOLEAN
		require
			argument_not_null: obj /= Void
		do
			Result := attached {READABLE_STRING_8} obj
		end

end

class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			d: DIRECTORY
			f: FILE_UTILITIES
		do
			create d.make ({STRING_32} "Тестовая директория")
			f.create_directory_path (d.path.extended ({STRING_32} "Вложенная директория"))
			d.delete_content_with_action (agent process_entries, Void, 1)
		end

feature {NONE} -- Basic operations

	process_entries (entries: LIST [READABLE_STRING_GENERAL])
		local
			u: UTF_CONVERTER
		do
			across
				entries as c
			loop
				if attached {READABLE_STRING_8} c.item as s then
					io.put_string (s)
				elseif attached {READABLE_STRING_32} c.item as s then
					io.put_string (u.string_32_to_utf_8_string_8 (s))
				else
					io.put_string ("Unexpected entry type")
				end
				io.put_new_line
			end
		end

end

class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		local
			d: DIRECTORY
			f: RAW_FILE
			u: FILE_UTILITIES
		do
			create d.make ({STRING_32} "Тестовая директория")

			io.put_string ("Test 1:")
			io.put_new_line
				-- Create directory structure.
			u.create_directory_path (d.path.extended ({STRING_32} "Вложенная директория"))
			create f.make_with_path (d.path.extended ({STRING_32} "Вложенный файл.текст"))
			f.create_read_write
			f.close
				-- Delete contents of a directory.
			d.delete_content_with_action (agent process_entries, Void, 1)

			io.put_string ("Test 2:")
			io.put_new_line
				-- Create directory structure.
			u.create_directory_path (d.path.extended ({STRING_32} "Другая директория"))
			create f.make_with_path (d.path.extended ({STRING_32} "Другой файл.текст"))
			f.create_read_write
			f.close
				-- Delete a directory completely.
			d.recursive_delete_with_action (agent process_entries, Void, 1)
		end

feature {NONE} -- Basic operations

	process_entries (entries: LIST [READABLE_STRING_GENERAL])
			-- Print names of `entries' (without full path) to standard output.
		do
			across
				entries as c
			loop
				io.put_character ('%T')
				io.put_string ((create {PATH}.make_from_string (c.item)).components.last.utf_8_name)
				io.put_new_line
			end
		end

end

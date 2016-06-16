class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		do
			create directory.make ({STRING_32} "Тестовая директория")
				-- Delete contents of a directory with output.
			create_entries ({STRING_32} "Вложенная директория", {STRING_32} "Вложенный файл.текст", 1)
			directory.delete_content_with_action (agent process_entries, Void, 1)
				-- Delete a directory completely with output.
			create_entries ({STRING_32} "Другая директория", {STRING_32} "Другой файл.текст", 2)
			directory.recursive_delete_with_action (agent process_entries, Void, 1)
				-- Delete contents of a directory without output.
			create_entries ({STRING_32} "Вложенная директория", {STRING_32} "Вложенный файл.текст", 3)
			directory.delete_content_with_action (agent process_entries, Void, 0)
				-- Delete a directory completely without output.
			create_entries ({STRING_32} "Другая директория", {STRING_32} "Другой файл.текст", 4)
			directory.recursive_delete_with_action (agent process_entries, Void, 0)
		end

feature {NONE} -- Access

	directory: DIRECTORY
			-- A directory to perform tests.

feature {NONE} -- Basic operations

	create_entries (directory_name, file_name: READABLE_STRING_GENERAL; test_number: NATURAL)
			-- Create entriers `directory_name' and `file_name' in `directory' for test `test_number'.
		local
			f: RAW_FILE
			u: FILE_UTILITIES
		do
			io.put_string ("Test ")
			io.put_natural (test_number)
			io.put_character (':')
			io.put_new_line
				-- Create directory structure.
			u.create_directory_path (directory.path.extended (directory_name))
			create f.make_with_path (directory.path.extended (file_name))
			f.create_read_write
			f.close
		end

	process_entries (entries: LIST [READABLE_STRING_GENERAL])
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

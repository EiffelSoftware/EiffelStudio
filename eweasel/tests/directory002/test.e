class TEST

create
	make

feature {NONE} -- Creation

	make
			-- Run the test.
		do
			create directory.make ({STRING_32} "Тестовая директория")
				-- Delete contents of a directory with output.
			create_entries (
				{STRING_32} "Вложенная директория",
				{STRING_32} "Вложенный файл.текст",
				1)
			directory.delete_content_with_action (agent actual_entries.append ({LIST [READABLE_STRING_GENERAL]} ?), Void, 1)
			report (<<
				<<directory.path.extended ({STRING_32} "Вложенная директория")>>,
				<<
					directory.path.extended ({STRING_32} "Вложенный файл.текст"),
					directory.path.extended ({STRING_32} "Вложенный файл.текст")
				>>
			>>)
				-- Delete a directory completely with output.
			create_entries (
				{STRING_32} "Другая директория",
				{STRING_32} "Другой файл.текст",
				2)
			directory.recursive_delete_with_action (agent actual_entries.append ({LIST [READABLE_STRING_GENERAL]} ?), Void, 1)
			report (<<
				<<directory.path.extended ({STRING_32} "Другая директория")>>,
				<<
					directory.path.extended ({STRING_32} "Другой файл.текст"),
					directory.path.extended ({STRING_32} "Другой файл.текст")
				>>,
				<<directory.path>>
			>>)
				-- Delete contents of a directory without output.
			create_entries (
				{STRING_32} "Вложенная директория",
				{STRING_32} "Вложенный файл.текст",
				3)
			directory.delete_content_with_action (agent actual_entries.append ({LIST [READABLE_STRING_GENERAL]} ?), Void, 0)
			report (<<>>)
				-- Delete a directory completely without output.
			create_entries (
				{STRING_32} "Другая директория",
				{STRING_32} "Другой файл.текст",
				4)
			directory.recursive_delete_with_action (agent actual_entries.append ({LIST [READABLE_STRING_GENERAL]} ?), Void, 0)
			report (<<>>)
				-- Delete contents of a directory without output.
			create_entries (
				{STRING_32} "Вложенная директория",
				{STRING_32} "Вложенный файл.текст",
				5)
			directory.delete_content
			report (<<>>)
				-- Delete a directory completely without output.
			create_entries (
				{STRING_32} "Другая директория",
				{STRING_32} "Другой файл.текст",
				6)
			directory.recursive_delete
			report (<<>>)
		end

feature {NONE} -- Access

	directory: DIRECTORY
			-- A directory to perform tests.

	actual_entries: ARRAYED_LIST [READABLE_STRING_GENERAL]
			-- Directory entries obtained by running a directory operation.

feature {NONE} -- Basic operations

	create_entries (directory_name, file_name: READABLE_STRING_GENERAL; test_number: NATURAL)
			-- Create entriers `directory_name' and `file_name' in `directory' for test `test_number'.
		local
			f: RAW_FILE
			u: FILE_UTILITIES
		do
			io.put_string ("Test ")
			io.put_natural (test_number)
			io.put_string (": ")
				-- Create directory structure.
			u.create_directory_path (directory.path.extended (directory_name))
			create f.make_with_path (directory.path.extended (file_name))
			f.create_read_write
			f.close
				-- Initialize storage to record enties.
			create actual_entries.make (0)
		end

feature {NONE} -- Output

	report (expected_entries: ARRAY [ARRAY [PATH]])
			-- Report if `actual_entries' match `expected_entries'.
			-- Every item in `expected_entries' correspond to one element of `actual_entries'.
			-- However because of possible Unicode normalization, `actual_enties' may contain
			-- one of several forms provided in one element of `actual_entries'.
		local
			u: UTF_CONVERTER
			has_error: BOOLEAN
		do
			if expected_entries.count = actual_entries.count then
				across
					expected_entries as expected_forms
				until
					has_error
				loop
					has_error :=
						across expected_forms.item as expected_form all
							across actual_entries as actual_entry all
								expected_form.item /~ create {PATH}.make_from_string (actual_entry.item)
							end
						end
				end
			else
				io.put_string ("Different number of entries")
				has_error := True
			end
			if has_error then
				io.put_string ("Failed")
				io.put_new_line
				io.put_string ("%TExpected:")
				io.put_new_line
				across
					expected_entries as expeted_forms
				loop
					io.put_string ("%T%T")
					across
						expeted_forms.item as expeted_form
					loop
						if not expeted_form.is_first then
							io.put_character (' ')
						end
						io.put_character ('"')
						io.put_string (expeted_form.item.utf_8_name)
						io.put_character ('"')
					end
					io.put_new_line
				end
				io.put_string ("%TActual:")
				io.put_new_line
				across
					actual_entries as c
				loop
					io.put_string ("%T%T")
					io.put_character ('"')
					io.put_string ((create {PATH}.make_from_string (c.item)).utf_8_name)
					io.put_character ('"')
					io.put_new_line
				end
			else
				io.put_string ("OK")
				io.put_new_line
			end
		end

end

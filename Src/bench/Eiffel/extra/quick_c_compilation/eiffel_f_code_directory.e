indexing
	description: "Objects that ..."
	author: "Mark Howard, AxaRosenberg"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_F_CODE_DIRECTORY

inherit
	DIRECTORY
		rename
			make as directory_make
		end

	OPERATING_ENVIRONMENT

creation
	make

feature

	make (a_path: STRING; extension_type: STRING) is
		local
			l_files: LINEAR[STRING]
			l_file_name, tag: STRING
			l_file: X_FILE
			l_directory: EIFFEL_F_CODE_DIRECTORY
			l_start: INTEGER
			finished_file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
		do
				-- Create `big_file_name' with a number as a suffix, in order not to
				-- confuse the C debugger.
			l_start := a_path.last_index_of (Directory_separator, a_path.count)
			tag := a_path.substring (l_start + 1, a_path.count)
			big_file_name := big_file_prefix + tag

			directory_make (a_path)
			object_extension := clone (extension_type)

				-- Check if we modified something in the directory
				-- True if the file `finished' does not exist.
			create finished_file_name.make_from_string (a_path)
			finished_file_name.set_file_name ("finished")
			create finished_file.make (finished_file_name)
			has_finished_file := finished_file.exists

				-- Clean up previous conversion
			if has_entry ("Makefile.SHold") then
				create makefile_sh.make (path ("Makefile.SH"))
				makefile_sh.delete
				makefile_sh.make (path("Makefile.SHold"))
				makefile_sh.change_name(path("Makefile.SH"))
				l_file_name := path (big_file_name) + ".x"
				create l_file.make (l_file_name)
				if l_file.exists then
					l_file.delete
				end
				l_file_name := path (big_file_name) + ".c"
				create l_file.make (l_file_name)
				if l_file.exists then
					l_file.delete
				end
			end

			create x_files.make
			create c_files.make
			create directories.make
			l_files := linear_representation
			from
				l_files.start
			until
				l_files.off
			loop
				if
					not l_files.item.is_equal (".") and
					not l_files.item.is_equal ("..")
				then
					l_file_name := path (l_files.item)
			   		create l_file.make (l_file_name)
			   		if l_file.is_directory then
						create l_directory.make (l_file_name, extension_type)
						directories.extend (l_directory)
						directories.forth
			   		elseif not has_finished_file and then (l_files.item.substring_index (".c",1)) > 0 then
				  		c_files.extend (l_file)
						c_files.forth
			   		elseif not has_finished_file and then (l_files.item.substring_index (".x",1)) > 0 then
				  		x_files.extend (l_file)
						x_files.forth
					elseif (l_files.item.is_equal ("Makefile.SH")) then
						create makefile_sh.make (l_file_name)
					end
				end
				l_files.forth
			end
		end

	convert is
			-- Concatene all the x/c files and modify the Makefile.
		local
			l_files: LINKED_LIST [C_FILE]
			l_file: C_FILE
			l_directories: LINEAR[EIFFEL_F_CODE_DIRECTORY]
			l_big_file_name, l_makefile_sh_name, l_old_name: STRING
			l_makefile_sh: PLAIN_TEXT_FILE
			is_x_file: BOOLEAN
		do
			l_files := c_files
			if l_files /= Void then
				l_files.append (x_files)
			else
				l_files := x_files
			end
			l_directories := directories.linear_representation

debug ("OUTPUT")
			print ("x/c files%N")
end
			if not l_files.empty then 
				l_big_file_name := clone (name)
				l_big_file_name.append_character (Directory_separator)
				l_big_file_name.append (big_file_name)
				create big_file.make_open_write (l_big_file_name)
				is_x_file := False
				from
					l_files.start
				until
					l_files.off
				loop
					l_file := l_files.item
debug ("OUTPUT")
					print (makefile_sh.last_string)
					io.new_line
					print (l_file.name)
					io.new_line
end
					if not is_x_file and then l_file.name.substring_index (".x",1) > 0 then
						is_x_file := True
					end
					l_file.open_read
					l_file.read_all
						-- Generate the `line' statement for the C debugger.
					big_file.put_string ("#line 1 %"" + generate_name (l_file.name) + "%"%N")
					big_file.put_string (l_file.last_string)
					l_file.close
					l_files.forth
				end
				big_file.close

				l_big_file_name := clone (l_big_file_name)
				if is_x_file then
					l_big_file_name.append (".x")
				else
					l_big_file_name.append (".c")
				end
				big_file.change_name (l_big_file_name)
			end

			l_makefile_sh_name := clone (makefile_sh.name)
			l_old_name := clone  (makefile_sh.name)
			l_old_name.append ("old")
			makefile_sh.change_name (l_old_name)
			create l_makefile_sh.make_open_write (l_makefile_sh_name)
			from
				makefile_sh.open_read
			until
				makefile_sh.off
			loop
				makefile_sh.read_line
				if
					makefile_sh.last_string.count > 0 and then
					makefile_sh.last_string.substring_index ("OBJECTS =",1) = 1
				then
					l_makefile_sh.put_string ("OBJECTS = " + big_file_name + ".")
					l_makefile_sh.put_string (object_extension + "%N%N")
					l_makefile_sh.put_string ("OLD")
				end
				l_makefile_sh.put_string (makefile_sh.last_string)
debug ("OUTPUT")
				print (makefile_sh.last_string)
				io.new_line
end
				l_makefile_sh.put_string ("%N")
			end
			l_makefile_sh.close
			makefile_sh.close

debug ("OUTPUT")
		print ("Directories%N")
end
			-- Do the work an all subdirectories
			from
				l_directories.start
			until
				l_directories.off
			loop
debug ("OUTPUT")
				print (l_directories.item.name)
				io.new_line
end
				l_directories.item.convert
				l_directories.forth
			end
debug ("OUTPUT")
			print ("Makefile SH%N")
			print (makefile_sh.name)
			io.new_line
end
		end

	path (a_name: STRING): STRING is
		do
			Result := clone (name)
			Result.append_character (Directory_separator)
			Result.append (a_name)
		end

feature -- Access

	object_extension: STRING
			-- Extension name of the object files, depends on the platform.

	x_files: LINKED_LIST[X_FILE]

	c_files: LINKED_LIST[C_FILE]

	makefile_sh: PLAIN_TEXT_FILE

	directories: LINKED_LIST[EIFFEL_F_CODE_DIRECTORY]

	has_finished_file: BOOLEAN
			-- Does the directory contain `finished'?

	big_file: PLAIN_TEXT_FILE

	big_file_name: STRING
			-- Real name of the `big_file'.

feature -- Constants

	big_file_prefix: STRING is "big_file_"
			-- Prefix of the big_file name.

feature {NONE} -- Implementation

	generate_name (file_name: STRING): STRING is
			-- On Windows, convert all `\' sequence by `\\'.
			-- On Unix platforms, returns `file_name'
		local
			l_count, i, j: INTEGER
		do
			if Directory_separator = '\' then
				create Result.make (file_name.count + file_name.occurrences ('\'))
				Result.fill_blank
				from
					i := 1
					j := 1
					l_count := file_name.count
				until
					i > l_count
				loop
					Result.put (file_name.item (i), j)
					if file_name.item (i) = '\' then
						j := j + 1
						Result.put ('\', j)
					end
					i := i + 1
					j := j + 1
				end
			else
				Result := file_name
			end
		end

end -- class EIFFEL_F_CODE_DIRECTORY

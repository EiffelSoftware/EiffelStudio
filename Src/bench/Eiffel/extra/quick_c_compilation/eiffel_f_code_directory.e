indexing
	description: "Objects that describe a directory containing C code to merge into a single file"
	author: "Mark Howard, AxaRosenberg - revision 1.12 by Arnaud PICHERY, ISE"
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

	make (a_path: STRING; extension_type: STRING; is_root: BOOLEAN) is
		local
			l_files: LINEAR[STRING]
			l_file_name, tag: STRING
			l_file: X_FILE
			l_directory: EIFFEL_F_CODE_DIRECTORY
			l_start, string_count: INTEGER
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

				-- Clean up previous conversion if really needed.
			if not is_root and then not has_finished_file then
				l_file_name := path (big_file_name) + ".x"
				create l_file.make (l_file_name)
				if l_file.exists then
					l_file.delete
				end
				l_file_name := path (big_file_name) + ".xpp"
				create l_file.make (l_file_name)
				if l_file.exists then
					l_file.delete
				end
				l_file_name := path (big_file_name) + ".c"
				create l_file.make (l_file_name)
				if l_file.exists then
					l_file.delete
				end
				l_file_name := path (big_file_name) + ".cpp"
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
						create l_directory.make (l_file_name, extension_type, False)
						directories.extend (l_directory)
						directories.forth
					elseif (l_files.item.is_equal ("Makefile.SH")) then
						create makefile_sh.make (l_file_name)
					else
						if not has_finished_file then
							l_file_name := l_files.item
							string_count := l_file_name.count
								-- If the name is not greater than 3 and does not contain ".", it means that
							   	-- we are not handling with Eiffel generated files which have always the
								-- following format: "eaxxxx.c".
							if
								not l_file_name.is_equal ("edynlib.c") and then
								not l_file_name.is_equal ("egc_dynlib.c") and then
								not l_file_name.is_equal ("emain.c") and then
								string_count > 3 and then l_file_name.substring_index (".", 1) /= 0
							then
								if
									l_file_name.substring_index (".c",1) = string_count - 1 or else
									l_file_name.substring_index (".cpp",1) = string_count - 3
								then
									c_files.extend (l_file)
									c_files.forth
								else
									if
										l_file_name.substring_index (".x",1) = string_count - 1 or else
										l_file_name.substring_index (".xpp",1) = string_count - 3
									then
										x_files.extend (l_file)
										x_files.forth
									end
								end
							end
						end
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
			l_big_file_name: STRING
			is_x_file: BOOLEAN
			is_cpp_file: BOOLEAN
			input_string: STRING
		do
			if makefile_sh /= Void then
				input_string := buffered_input_string
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
				if not l_files.is_empty then 
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
						if not is_x_file then
							is_x_file := l_file.name.substring_index (".x",1) > 0
						end

						if not is_cpp_file then
							is_cpp_file := l_file.name.substring_index ("pp", 1) = l_file.name.count - 1
						end
						l_file.open_read
						l_file.read_all (input_string)
							-- Generate the `line' statement for the C debugger.
						big_file.put_string (input_string)
						l_file.close
						l_files.forth
					end -- loop
					big_file.close

					l_big_file_name := clone (l_big_file_name)
					if is_x_file then
						if is_cpp_file then
							l_big_file_name.append (".xpp")
						else
							l_big_file_name.append (".x")
						end
					else
						if is_cpp_file then
							l_big_file_name.append (".cpp")
						else
							l_big_file_name.append (".c")
						end
					end
					big_file.change_name (l_big_file_name)
				end -- not l_files.is_empty

				makefile_sh.open_read
				makefile_sh.read_stream (makefile_sh.count)
				makefile_sh.close

				if makefile_sh.last_string.substring_index ("OLDOBJECTS", 1) = 0 then
					makefile_sh.last_string.replace_substring_all ("OBJECTS =",
						"OBJECTS = " + big_file_name + "." + object_extension + "%N%N" + "OLDOBJECTS = ")
					makefile_sh.open_write
					makefile_sh.put_string (makefile_sh.last_string)
					makefile_sh.put_string ("%N")
					makefile_sh.close
				end

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
			else -- makefile_sh /= void
				io.put_string("WARNING: Directory '")
				io.put_string(name)
				io.put_string("'%Nhas not been generated by the ISE Eiffel compiler.%N")
			end -- makefile_sh /= void
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

	buffered_input_string: STRING is
			-- Buffer string filled by reading into a file.
		once
			create Result.make (2_000_000)
		end

end -- class EIFFEL_F_CODE_DIRECTORY


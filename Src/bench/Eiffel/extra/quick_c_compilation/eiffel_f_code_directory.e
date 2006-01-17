indexing
	description: "Objects that describe a directory containing C code to merge into a single file"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
	make

feature

	make (a_path: STRING; extension_type: STRING; a_is_root: BOOLEAN) is
			-- Create new EIFFEL_F_CODE_DIRECTORY.
		require
			a_path_not_void: a_path /= Void
			extension_type_not_void: extension_type /= Void
		local
			l_files: ARRAYED_LIST [STRING]
			l_fname, tag: STRING
			l_file: X_FILE
			l_directory: EIFFEL_F_CODE_DIRECTORY
			l_start, l_count: INTEGER
			finished_file: PLAIN_TEXT_FILE
			finished_file_name: FILE_NAME
		do
			is_root := a_is_root

				-- Create `l_big_file_name' with a number as a suffix, in order not to
				-- confuse the C debugger.
			l_start := a_path.last_index_of (Directory_separator, a_path.count)
			tag := a_path.substring (l_start + 1, a_path.count)
			big_file_name_prefix := big_file_prefix + tag

			directory_make (a_path)
			object_extension := extension_type.twin

				-- Check if we modified something in the directory
				-- True if the file `finished' does not exist.
			create finished_file_name.make_from_string (a_path)
			finished_file_name.set_file_name ("finished")
			create finished_file.make (finished_file_name)
			has_finished_file := finished_file.exists

				-- Clean up previous conversion if really needed.
			if not is_root and then not has_finished_file then
				l_fname := path (big_file_name (False, False, False))
				create l_file.make (l_fname)
				if l_file.exists then
					l_file.delete
				end
				l_fname := path (big_file_name (False, False, True))
				create l_file.make (l_fname)
				if l_file.exists then
					l_file.delete
				end
				l_fname := path (big_file_name (False, True, False))
				create l_file.make (l_fname)
				if l_file.exists then
					l_file.delete
				end
				l_fname := path (big_file_name (False, True, True))
				create l_file.make (l_fname)
				if l_file.exists then
					l_file.delete
				end
			end

			create x_files.make (100)
			create xpp_files.make (100)
			create c_files.make (100)
			create cpp_files.make (100)
			create directories.make (100)
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
					l_fname := path (l_files.item)
			   		create l_file.make (l_fname)
			   		if	 
			   			l_file.is_directory and then 
			   			(l_fname.count < 2 or else not l_fname.substring (l_fname.count -1, l_fname.count).is_equal (once "E1")) 
			   		then
						create l_directory.make (l_fname, extension_type, False)
						directories.extend (l_directory)
						directories.forth
					elseif (l_files.item.is_equal ("Makefile.SH")) then
						create makefile_sh.make (l_fname)
					else
						l_fname := l_files.item
						l_count := l_fname.count
							-- If the name is not greater than 3 and does not contain ".",
							-- it means that we are not handling with Eiffel generated files
							-- which have always the following format: "eaxxxx.c".
						if
							not l_fname.is_equal ("edynlib.c") and then
							not l_fname.is_equal ("egc_dynlib.c") and then
							not l_fname.is_equal ("emain.c") and then
							l_count > 3 and then l_fname.substring_index (".", 1) /= 0
						then
							if l_fname.substring_index (".c",1) = l_count - 1 then
								c_files.extend (l_file)
								c_files.forth
							elseif l_fname.substring_index (".cpp",1) = l_count - 3 then
								cpp_files.extend (l_file)
								cpp_files.forth
							elseif l_fname.substring_index (".x",1) = l_count - 1 then
								x_files.extend (l_file)
								x_files.forth
							elseif l_fname.substring_index (".xpp",1) = l_count - 3 then
								xpp_files.extend (l_file)
								xpp_files.forth
							end
						end
					end
				end
				l_files.forth
			end
		ensure
			is_root_set: is_root = a_is_root
		end

	concat is
			-- Concatene all the x/c files and modify the Makefile.
		local
			l_directories: LINEAR [EIFFEL_F_CODE_DIRECTORY]
			l_has_c_file, l_has_cpp_file, l_has_x_file, l_has_xpp_file: BOOLEAN
			l_new_objects: STRING
		do
			if is_root then
					-- Do the work an all subdirectories
				from
					l_directories := directories.linear_representation
					l_directories.start
				until
					l_directories.off
				loop
					l_directories.item.concat
					l_directories.forth
				end
			elseif makefile_sh /= Void then
				if not c_files.is_empty then
					l_has_c_file := True
					if not has_finished_file then
						concat_files (c_files, big_file_name (False, True, False))
					end
				end
				if not cpp_files.is_empty then
					l_has_cpp_file := True
					if not has_finished_file then
						concat_files (cpp_files, big_file_name (False, True, True))
					end
				end
				if not x_files.is_empty then
					l_has_x_file := True
					if not has_finished_file then
						concat_files (x_files, big_file_name (False, False, False))
					end
				end
				if not xpp_files.is_empty then
					l_has_xpp_file := True
					if not has_finished_file then
						concat_files (xpp_files, big_file_name (False, False, True))
					end
				end
				
				makefile_sh.open_read
				makefile_sh.read_stream (makefile_sh.count)
				makefile_sh.close

				if makefile_sh.last_string.substring_index ("OLDOBJECTS", 1) = 0 then
					l_new_objects := "OBJECTS = "
					if l_has_c_file then
						l_new_objects.append (big_file_name (True, True, False))
						l_new_objects.append (" ")
					end 
					if l_has_cpp_file then
						l_new_objects.append (big_file_name (True, True, True))
						l_new_objects.append (" ")
					end 
					if l_has_x_file then
						l_new_objects.append (big_file_name (True, False, False))
						l_new_objects.append (" ")
					end 
					if l_has_xpp_file then
						l_new_objects.append (big_file_name (True, False, True))
					end 
					l_new_objects.append ("%N%N" + "OLDOBJECTS = ")
					makefile_sh.last_string.replace_substring_all ("OBJECTS =", l_new_objects)
					makefile_sh.open_write
					makefile_sh.put_string (makefile_sh.last_string)
					makefile_sh.put_string ("%N")
					makefile_sh.close
				end
			else
					-- makefile_sh = void
				io.put_string("WARNING: Directory '")
				io.put_string(name)
				io.put_string("'%Nhas not been generated by the ISE Eiffel compiler.%N")
			end
		end

	path (a_name: STRING): STRING is
		do
			Result := name.twin
			Result.append_character (Directory_separator)
			Result.append (a_name)
		end

feature -- Access

	is_root: BOOLEAN
			-- Is current directory the root of W_code of F_code?

	object_extension: STRING
			-- Extension name of the object files, depends on the platform.

	x_files: ARRAYED_LIST [X_FILE]
			-- List of .x files in F_code.

	c_files: ARRAYED_LIST [C_FILE]
			-- List of .c files in W_code.

	xpp_files: ARRAYED_LIST [X_FILE]
			-- List of .xpp files in F_code.

	cpp_files: ARRAYED_LIST [C_FILE]
			-- List of .cpp files in W_code.

	makefile_sh: PLAIN_TEXT_FILE

	directories: ARRAYED_LIST [EIFFEL_F_CODE_DIRECTORY]

	has_finished_file: BOOLEAN
			-- Does the directory contain `finished'?

feature {NONE} -- Access

	big_file_name_prefix: STRING
			-- Prefix to `big_file_name'.

feature {NONE} -- Constants

	big_file_prefix: STRING is "big_file_"
			-- Prefix of the big_file name.

	buffered_input_string: STRING is
			-- Buffer string filled by reading into a file.
		once
			create Result.make (10_000_000)
		end

feature {NONE} -- Implementation

	big_file_name (is_obj_file, is_c_file, is_cpp_file: BOOLEAN): STRING is
			-- Build big file name associated to current directory with `is_obj_file', 
			-- `is_c_file' and `is_cpp_file' specification.
		do
			create Result.make (big_file_name_prefix.count + 8)
			Result.append (big_file_name_prefix)
			if is_c_file then
				if is_cpp_file then
					if is_obj_file then
						Result.append ("_cpp." + object_extension)
					else
						Result.append ("_cpp.cpp")
					end
				else
					if is_obj_file then
						Result.append ("_c." + object_extension)
					else
						Result.append ("_c.c")
					end
				end
			else
				if is_cpp_file then
					if is_obj_file then
						Result.append ("_xpp." + object_extension)
					else
						Result.append ("_xpp.xpp")
					end
				else
					if is_obj_file then
						Result.append ("_x." + object_extension)
					else
						Result.append ("_x.x")
					end
				end
			end
		ensure
			big_file_name_not_void: Result /= Void
			big_file_name_not_empty: not Result.is_empty
		end

	concat_files (l_files: ARRAYED_LIST [C_FILE]; l_output_name: STRING) is
			-- Concat all files into one file whose name is specified by `is_c_file' and 
			-- `is_cpp_file'.	
		require
			l_files_not_void: l_files /= Void
			l_output_name_not_void: l_output_name /= Void
		local
			l_big_file_name: STRING
			l_file: C_FILE
			input_string: STRING
			l_big_file: RAW_FILE
		do
			if not l_files.is_empty then 
				input_string := buffered_input_string
				l_big_file_name := name.twin
				l_big_file_name.append_character (Directory_separator)
				l_big_file_name.append (l_output_name)
				create l_big_file.make_open_write (l_big_file_name)
				from
					l_files.start
				until
					l_files.off
				loop
					l_file := l_files.item
					l_file.open_read
					l_file.read_all (input_string)
						-- Generate the `line' statement for the C debugger.
					l_big_file.put_string (input_string)
					l_file.close
					l_files.forth
				end
				l_big_file.close
			end
		end

invariant
	big_file_name_prefix_not_void: big_file_name_prefix /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EIFFEL_F_CODE_DIRECTORY


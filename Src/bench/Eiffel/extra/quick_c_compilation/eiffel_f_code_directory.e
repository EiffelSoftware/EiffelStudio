indexing
	description: "Objects that ..."
	author: "Mark Howard, Axa-Rosenberg"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_F_CODE_DIRECTORY

inherit
	DIRECTORY
		redefine
			make
		end

creation
	make

feature

	make (a_path : STRING) is
		local
			l_files : LINEAR[STRING]
			l_file_name : STRING
			l_file : X_FILE
			l_directory : EIFFEL_F_CODE_DIRECTORY
		do
			{DIRECTORY} Precursor (a_path)

				-- Clean up previous conversion
			if has_entry("Makefile.SHold") then
				create makefile_sh.make(path("Makefile.SH"))
				makefile_sh.delete
				makefile_sh.make(path("Makefile.SHold"))
				makefile_sh.change_name(path("Makefile.SH"))
				create l_file.make(path("big_file.x"))
				l_file.delete
			end

			create x_files.make
			create directories.make
			l_files := linear_representation
			from l_files.start until l_files.off
			loop
				if not l_files.item.is_equal(".") and
					not l_files.item.is_equal("..") then
					l_file_name := path(l_files.item)
			   		create l_file.make(l_file_name)
			   		if l_file.is_directory then
						create l_directory.make(l_file_name)
						directories.extend(l_directory)
						directories.forth
			   		elseif (l_files.item.substring_index(".x",1)) > 0 then
				  		x_files.extend(l_file)
						x_files.forth
					elseif (l_files.item.is_equal("Makefile.SH")) then
						create makefile_sh.make(l_file_name)
					end
				end
				l_files.forth
			end
		end

	convert is
		local
			l_x_files : LINEAR[X_FILE]
			l_x_file : X_FILE
			l_directories : LINEAR[EIFFEL_F_CODE_DIRECTORY]
			l_big_file_name,l_makefile_sh_name,l_old_name : STRING
			l_makefile_sh : PLAIN_TEXT_FILE
		do
			l_x_files := x_files.linear_representation
			l_directories := directories.linear_representation
debug ("OUTPUT")
			print("x files%N")
end
			if not l_x_files.empty then 
				l_big_file_name := clone(name)
				l_big_file_name.append("\big_file")
				create big_file.make_open_write(l_big_file_name)
				from l_x_files.start until l_x_files.off
				loop
					l_x_file := l_x_files.item
debug ("OUTPUT")
					print (makefile_sh.last_string)
					io.new_line
					print(l_x_file.name)
					io.new_line
end
					l_x_file.open_read
					l_x_file.read_all
					big_file.put_string(l_x_file.last_string)
					l_x_file.close
					l_x_files.forth
				end
				big_file.close
				l_big_file_name := clone(l_big_file_name)
				l_big_file_name.append(".x")
				big_file.change_name(l_big_file_name)
				l_makefile_sh_name := clone(makefile_sh.name)
				l_old_name := clone(makefile_sh.name)
				l_old_name.append("old")
				makefile_sh.change_name(l_old_name)
				create l_makefile_sh.make_open_write(l_makefile_sh_name)
				from makefile_sh.open_read until makefile_sh.off
				loop
					makefile_sh.read_line
					if makefile_sh.last_string.count > 0 and then
						makefile_sh.last_string.substring_index("OBJECTS =",1) = 1 then
						l_makefile_sh.put_string("OBJECTS = big_file.obj%N%N")
						l_makefile_sh.put_string("OLD")
					end
					l_makefile_sh.put_string(makefile_sh.last_string)
debug ("OUTPUT")
					print (makefile_sh.last_string)
					io.new_line
end
					l_makefile_sh.put_string("%N")
				end
				l_makefile_sh.close
				makefile_sh.close
			end
debug ("OUTPUT")
			print("Directories%N")
end
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
			print("Makefile SH%N")
			print (makefile_sh.name)
			io.new_line
end
		end

	x_files : LINKED_LIST[X_FILE]

	makefile_sh : PLAIN_TEXT_FILE

	directories : LINKED_LIST[EIFFEL_F_CODE_DIRECTORY]

	path (a_name : STRING) : STRING is
		do
			Result := clone(name)
			Result.append("\")
			Result.append(a_name)
		end

	big_file : PLAIN_TEXT_FILE

end -- class EIFFEL_F_CODE_DIRECTORY

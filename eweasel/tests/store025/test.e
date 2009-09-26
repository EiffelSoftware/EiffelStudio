class
	TEST

inherit
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		local
			l_file_name: FILE_NAME
			l_wdir: STRING
			l_file: RAW_FILE
			i: INTEGER
		do
			l_wdir := command_line.argument (1)
			if command_line.argument_count > 1 then
				i := command_line.argument (2).to_integer
				create l_file_name.make_from_string (l_wdir)
				l_file_name.extend (file_name (i))
				create l_file.make_open_write (l_file_name)
				l_file.independent_store (["STRING"])
				l_file.close
			else
				from
					i := 0
				until
					i = 4
				loop
					print (file_name (i))
					print (": ")
					create l_file_name.make_from_string (l_wdir)
					l_file_name.extend (file_name (i))
					create l_file.make_open_read (l_file_name)
					if attached {TUPLE [string: STRING]} l_file.retrieved as l_retrieved then
						print (l_retrieved.string)
					end
					print ('%N')
					l_file.close
					i := i + 1
				end
			end
		end

	file_name (a_int: INTEGER): STRING
		do
			create Result.make (50)
			Result.append ("tuple")
			if 0 < (a_int & 1) then
				Result.append (".void_safe")
			end
			if 0 < (a_int & 2) then
				Result.append (".finalized")
			end
			if 0 < (a_int & 4) then
				Result.append (".experimental")
			end
		end

end

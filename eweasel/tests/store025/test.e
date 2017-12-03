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
			l_path: PATH
			l_wdir: READABLE_STRING_32
			l_file: RAW_FILE
			i: INTEGER
		do
			l_wdir := arguments.argument (1)
			if arguments.argument_count > 1 then
				i := arguments.argument (2).to_integer
				create l_path.make_from_string (l_wdir)
				create l_file.make_with_path (l_path.extended (file_name (i)))
				l_file.open_write
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
					create l_path.make_from_string (l_wdir)
					create l_file.make_with_path (l_path.extended (file_name (i)))
					l_file.open_read
					if attached {TUPLE [string: detachable STRING]} l_file.retrieved as l_retrieved then
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
			if (a_int & 1) = 1 then
				Result.append (".void_safe")
			end
			if (a_int & 2) = 2 then
				Result.append (".finalized")
			end
		end

end

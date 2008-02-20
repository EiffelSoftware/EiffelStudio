class
	TEST

inherit
	ARGUMENTS

	EXCEPTION_MANAGER_FACTORY

create
	make

feature -- Initialization

	make is
			-- Run application.
		do
			if argument_count = 2 then
				file_name := argument (1)
				if argument (2).is_case_insensitive_equal ("s") then
					save
				elseif argument (2).is_case_insensitive_equal ("r") then
					retrieve
				end
			else
				print ("Usage: FILE_NAME s|r%NExample: bug_uncaught_exception e:\saved_object s%N")
			end
			print ("Exiting ... %N")
		end

	file_name: STRING

	save
		local
			a: A
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				print ("Saving object at: " + file_name + "%N")
				create a.make

				create l_file.make_create_read_write (file_name)
				l_file.independent_store (a)
				l_file.close
				print ("Object saved at: " + file_name + "%N")
			end
		rescue
			print ("Exception caught.%N")
			retried := True
			retry
		end

	retrieve
		local
			a: A
			l_file: RAW_FILE
			retried: BOOLEAN
		do
			if not retried then
				print ("Retrieving object at: " + file_name + "%N")
				create l_file.make_open_read (file_name)
				a ?=  l_file.retrieved
				l_file.close
				if a /= Void then
					print ("Object retrived at: " + file_name + "%N")
				else
					print ("Object retrieving failed.%N")
				end
			end
		rescue
			print ("Exception caught.%N")
			retried := True
			retry
		end

end -- class APPLICATION

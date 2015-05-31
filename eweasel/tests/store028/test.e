class
	TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
			-- Run application.
		do
			if argument_count >= 1 and then argument (1) ~ "store" then
				save_to_file
			else
				retrieve_from_file
			end
		end

feature {NONE} -- Implementation

	storage_file_name: STRING = "stored_file"

	retrieve_from_file
			-- Retrieve storage from file	
		local
			l_file: detachable RAW_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create l_file.make (storage_file_name)
				l_file.open_read
				if attached {A [TUPLE [STRING, INTEGER]]} l_file.retrieved as l_a then
					print (l_a.generating_type)
					print ("%N")
				end
				if not l_file.is_closed then
					l_file.close
				end
			end
		rescue
			l_retried := True
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		end

	save_to_file
			-- Save storage to file when needed.
		local
			l_file: detachable RAW_FILE
			l_retried: BOOLEAN
			l_a: A [STRING]
		do
			if not l_retried then
				create l_a
				l_a.many_types (1000).do_nothing
				create l_file.make_create_read_write (storage_file_name)
				l_file.independent_store (create {A [TUPLE [STRING, INTEGER]]}) 
				l_file.close
			end
		rescue
			l_retried := True
			if l_file /= Void and then not l_file.is_closed then
				l_file.close
			end
		end

end

note
	description: "A stub class to perform several test features."
	author: "Florian Besser, Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	WORKER

feature -- Access

	counter: INTEGER

	my_exception: DEVELOPER_EXCEPTION
		attribute create Result end

	my_environment: EXECUTION_ENVIRONMENT
		attribute create Result end

feature -- Call API helpers

	do_invalid_call
		local
			s: STRING
			i: INTEGER
		do
			s := "A string trying to be an integer."
				-- Note: s violates the precondition of to_integer_32.
			i := s.to_integer_32

			print("ERROR: We didn't get an exception.%N")
		end

feature -- Chain Purge helpers

	work
		local
			retried: BOOLEAN
		do
			if not retried then

					-- Sleep 0.01 sec.
				my_environment.sleep ({INTEGER_64} 1_000_000)

				my_exception.raise
				print("ERROR: After raising exception.%N")
			end
		rescue
			counter := counter + 1
			retried := True
			retry
		end

feature -- Read File helpers

	read_file
			-- Read a non-existent file.
	    local
	      input : PLAIN_TEXT_FILE
	    do
	    	create input.make_open_read("a_file_that_does_not_exist")
	    	input.close
	    	print ("ERROR: No exception thrown in read_file.%N")
	    rescue
	    	print ("OK: Propagating exception in {WORKER}read_file.%N")
	    end

feature -- Worker Aggregator helpers

	fail_work
			-- Directly throw an exception.
		do
			my_exception.raise
		end
end

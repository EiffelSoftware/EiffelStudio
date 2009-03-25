class
	TEST

inherit
	EXCEPTIONS
	
	CONSOLE
	
create
	make_test

feature -- Initialization

	make_test is
			-- Run application.
		do
			make_open_stdout ("stdout")
			io_ex
		end

	io_ex is
		local
			retried: BOOLEAN
		do
			if not retried then
					-- Raise a runtime_io_exception.
				read_character
			end
		rescue
			if exception /= {EXCEP_CONST}.Runtime_io_exception then
				print ("Not Runtime_io_exception exception code.%N")
			else
				print ("OK%N")
			end
			retried := True
			retry
		end

end

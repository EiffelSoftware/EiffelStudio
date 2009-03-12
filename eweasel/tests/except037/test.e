
class TEST
inherit
	EXCEPTIONS

create
	make

feature

	make
		local
			tried: BOOLEAN
		do
			if not tried then
				test_none_once
				test_once
			end
		rescue
			tried := True
			retry
		end

feature -- Non once

	test_none_once
		local
			tried: BOOLEAN
		do
			if not tried then
				try2
			end
		rescue
			print_exception (exception_manager.last_exception)
			print_exception (exception_manager.last_exception.original)
			print_exception (exception_manager.last_exception.cause)
			print_exception (exception_manager.last_exception.cause.original)
			tried := True
			retry
		end
	
	try2
		do
			try3
		rescue
			print_exception (exception_manager.last_exception)
			print_exception (exception_manager.last_exception.original)
			print_exception (exception_manager.last_exception.cause)
			print_exception (exception_manager.last_exception.cause.original)
			try4
		end

	try3
		do
			raise ("My Exception 1")
		rescue
			-- Make a ROUTINE_FAILURE
		end
		
	try4
		do
			raise ("My Exception 2")
		rescue
			-- Make a ROUTINE_FAILURE
		end

feature -- Non once

	test_once
		local
			tried: INTEGER
		do
			if tried = 0 then
				o_try2
			elseif tried = 1 then
				o_try2_another_path_to_get_once
			end
		rescue
			print_exception (exception_manager.last_exception)
			print_exception (exception_manager.last_exception.original)
			print_exception (exception_manager.last_exception.cause)
			print_exception (exception_manager.last_exception.cause.original)
			tried := tried + 1
			retry
		end
	
	o_try2
		do
			o_try3
		rescue
			print_exception (exception_manager.last_exception)
			print_exception (exception_manager.last_exception.original)
			print_exception (exception_manager.last_exception.cause)
			print_exception (exception_manager.last_exception.cause.original)
			o_try4
		end
		
	o_try2_another_path_to_get_once
		do
			o_try5
		rescue
			print_exception (exception_manager.last_exception)
			print_exception (exception_manager.last_exception.original)
			print_exception (exception_manager.last_exception.cause)
			print_exception (exception_manager.last_exception.cause.original)
			o_try4
		end
		
	o_try3
		do
			raise ("My Exception 1 for once")
		rescue
			-- Make a ROUTINE_FAILURE
		end
		
	o_try4
		once
			raise ("My Exception 2 for once")
		rescue
			-- Make a ROUTINE_FAILURE
		end
		
	o_try5
		do
			raise ("My Exception 3 for once")
		rescue
			-- Make a ROUTINE_FAILURE
		end

feature

	print_exception (a_ex: EXCEPTION)
		do
			print (a_ex.generating_type + ": ")
			print (a_ex.message + "%N")
		end

end


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
				test_process_once
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
		
feature -- Test process once

	test_process_once
		local
			tried: INTEGER
		do
			if tried = 0 then
				o_try2_process
			elseif tried = 1 then
				o_try2_another_path_to_get_process_once
			end
		rescue
			print_exception (exception_manager.last_exception)
			print_exception (exception_manager.last_exception.original)
			print_exception (exception_manager.last_exception.cause)
			print_exception (exception_manager.last_exception.cause.original)
			tried := tried + 1
			retry
		end

	o_try2_process
		do
			o_try6
		rescue
			print_exception (exception_manager.last_exception)
			print_exception (exception_manager.last_exception.original)
			print_exception (exception_manager.last_exception.cause)
			print_exception (exception_manager.last_exception.cause.original)
			o_try4_process
		end
		
	o_try2_another_path_to_get_process_once
		do
			o_try7
		rescue
			print_exception (exception_manager.last_exception)
			print_exception (exception_manager.last_exception.original)
			print_exception (exception_manager.last_exception.cause)
			print_exception (exception_manager.last_exception.cause.original)
			o_try4_process
		end
		
	o_try4_process
		note
			once_status: global
		once
			raise ("My Exception 4 for global once")
		rescue
			-- Make a ROUTINE_FAILURE
		end
		
	o_try6
		do
			raise ("My Exception 5 for global once")
		rescue
			-- Make a ROUTINE_FAILURE
		end
		
	o_try7
		do
			raise ("My Exception 6 for global once")
		rescue
			-- Make a ROUTINE_FAILURE
		end

feature

	print_exception (a_ex: EXCEPTION)
		do
			print (a_ex.generating_type + ": ")
			if a_ex.message /= Void then
				print (a_ex.message)
			end
			print ("%N")
		end

end

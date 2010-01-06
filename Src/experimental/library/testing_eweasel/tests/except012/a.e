class
	A

feature

	f is
		local
			retried: BOOLEAN
			l_exception: EXCEPTION
		do
			if not retried then
				my_exception.raise
			end
		rescue
			l_exception := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
			if l_exception = my_exception then
				print ("True%N")
				print_exception (l_exception, False)
			else
				print ("False%N")
			end
		end

	my_exception: MY_EXCEPTION is
		once
			create Result
			Result.set_message ("mymessage")
		end

	print_exception (a_ex: EXCEPTION; rf: BOOLEAN) is
			--
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
			if not rf then
				print (a_ex.message + "%N")
			end
		end

end

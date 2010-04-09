class A

inherit
	FOO
		redefine
			f
		end

create
	make

feature
	
	make is
		local
			retried: INTEGER
			l_exception: EXCEPTION
			s: STRING
		do
			if retried = 0 then
				s := f
			elseif retried = 1 then
				g
			end
		rescue
			retried := retried + 1
			print ("Retried " + retried.out + "%N")
			if retried = 1 then
				saved_exception := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception.original
				print ("Saving exception%N")
				print_exception (saved_exception)
			else
				l_exception := (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception.original
				if l_exception = saved_exception then
					print ("True%N")
					print_exception (saved_exception)
				else
					print ("False%N")
				end
			end
			rescued_call
			retry
		end

	f: STRING is
		local
			l_exception: CHECK_VIOLATION
		once ("OBJECT")
			print ("Execute `f'%N")
			check
				my_check: False
			end
			Result := "a_string"
		rescue
			l_exception ?= (create {EXCEPTION_MANAGER_FACTORY}).exception_manager.last_exception
			print ("In once rescue%N")
			if l_exception /= Void then
				print ("True%N")
			else
				print ("False%N")
			end
		end
		
	g is
		local
			s: STRING
		do
			s := f
		rescue
			print ("In g rescue%N")
		end
		
	rescued_call is
		local
			s: STRING
			retried: BOOLEAN
		do
			if not retried then
				s.do_nothing
			end
		rescue
			retried := True
			retry
		end
		
	print_exception (a_ex: EXCEPTION) is
			--
		do
			print (a_ex.recipient_name + "%N")
			print (a_ex.type_name + "%N")
			print (a_ex.message + "%N")
		end
		
	saved_exception: EXCEPTION

end

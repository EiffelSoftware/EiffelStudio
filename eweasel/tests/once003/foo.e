class
	FOO


feature -- Access

	f: STRING
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

end

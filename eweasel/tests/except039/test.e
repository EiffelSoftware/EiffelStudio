class TEST

create
	make

feature -- Initialization

	make
		local
			l_retried: BOOLEAN
			l_ex: DEVELOPER_EXCEPTION
		do
			if not l_retried then
				create l_ex
				l_ex.set_description ({STRING_32} "字符串")
			end
		rescue
			l_retried := True
			if 
				not (create {EXCEPTION_MANAGER_FACTORY}).Exception_manager.last_exception.description.has_substring ({STRING_32} "字符串") or else
				not (create {EXCEPTION_MANAGER_FACTORY}).Exception_manager.last_exception.trace.has_substring ({STRING_32} "字符串")
			then
				print ("Expected Unicode string was not found.%N")
			end
			retry
		end
		
end

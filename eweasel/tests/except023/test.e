class
	TEST

inherit
	EXCEPTION_MANAGER_FACTORY

create
	make

feature -- Initialization

	make is
		local
			is_retried: BOOLEAN
		do
			if not is_retried then
				read
			end
		rescue
			is_retried := True
			if not {ex: OPERATING_SYSTEM_SIGNAL_FAILURE}exception_manager.last_exception or else ex.signal_code = 0 then
				print (exception_manager.last_exception)
			end
			retry
		end

	read is
		external
			"C inline"
		alias
			"[
				char **a = 100;
				char *b = *a;
			]"
		end


end -- class ROOT_CLASS

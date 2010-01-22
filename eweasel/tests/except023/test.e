class
	TEST

inherit
	EXCEPTION_MANAGER_FACTORY

create
	make

feature -- Initialization

	make
		local
			is_retried: BOOLEAN
		do
			if not is_retried then
				read
			end
		rescue
			is_retried := True
			if not attached {OPERATING_SYSTEM_SIGNAL_FAILURE} exception_manager.last_exception as ex or else ex.signal_code <= 0 then
				print (exception_manager.last_exception)
			end
			retry
		end

	read
		external
			"C inline"
		alias
			"[
				char **a = 100;
				char *b = *a;
			]"
		end


end -- class ROOT_CLASS

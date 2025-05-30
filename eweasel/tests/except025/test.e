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
				io.error.close
				io.error.put_string ("TEST%N")
			end
		rescue
			is_retried := True
			if not attached {IO_FAILURE} exception_manager.last_exception as ex or else ex.error_code <= 0 then
				print (exception_manager.last_exception)
			end
			retry
		end

end -- class ROOT_CLASS

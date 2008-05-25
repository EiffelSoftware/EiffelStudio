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
			if not {ex: OPERATING_SYSTEM_FAILURE}exception_manager.last_exception or else ex.error_code = 0 then
				print (exception_manager.last_exception)
			end
			retry
		end

	read is
		local
			l_file: RAW_FILE
		do
			create l_file.make ("bad name")
			l_file.open_read
		end


end -- class ROOT_CLASS

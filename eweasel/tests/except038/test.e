class TEST

create
	make

feature -- Initialization

	make
		local
			f: RAW_FILE
			l_retried: BOOLEAN
		do
			if not l_retried then
				create f.make_open_read ("$CORRUPTED_FILE")
				if attached f.retrieved then end
				f.close
			end
		rescue
			l_retried := True
			if (create {EXCEPTION_MANAGER_FACTORY}).Exception_manager.last_exception.code = {EXCEP_CONST}.Io_exception then
				retry
			end
		end
		
end

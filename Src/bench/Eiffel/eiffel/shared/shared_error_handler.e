class SHARED_ERROR_HANDLER
	
feature {NONE} -- Shared handler

	Error_handler: ERROR_HANDLER is
			-- Shared Error handler
		once
			!! Result.make
		end;

end

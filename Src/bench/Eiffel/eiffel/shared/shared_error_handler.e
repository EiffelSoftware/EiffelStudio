class SHARED_ERROR_HANDLER

inherit

	SHARED_STATUS

feature {NONE}

	Error_handler: ERROR_HANDLER is
			-- GUI Error handler
		once
			!!Result.make
		end;

end

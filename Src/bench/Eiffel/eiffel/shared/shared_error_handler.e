class SHARED_ERROR_HANDLER

feature {NONE}

	Error_handler: ERROR_HANDLER is
			-- GUI Error handler
		once
			!!Result.make
		end;

end

class SHARED_ERROR_HANDLER

inherit

	SHARED_STATUS

feature {NONE}

	Error_handler: ERROR_HANDLER is
			-- GUI Error handler
		once
			if batch_mode then
				!!Result.make
			else
				!ERROR_W!Result.make
			end;
		end;

end

class SHARED_ERROR_HANDLER
	
feature {NONE}

	Error_handler: ERROR_W is
			-- GUI Error handler
		once
			!!Result.make
		end;

end

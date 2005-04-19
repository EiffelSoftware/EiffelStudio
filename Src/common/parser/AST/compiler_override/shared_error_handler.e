indexing
	description	: "Means to share the error handler"
	date		: "$Date$"
	revision	: "$Revision$"

class
	SHARED_ERROR_HANDLER
	
feature {NONE} -- Shared handler

	Error_handler: ERROR_HANDLER is
			-- Shared Error handler
		once
			create Result.make
		end

end -- class SHARED_ERROR_HANDLER

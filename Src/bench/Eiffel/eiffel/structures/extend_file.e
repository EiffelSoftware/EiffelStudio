class EXTEND_FILE

inherit

	PLAIN_TEXT_FILE;
	SHARED_RESCUE_STATUS

creation

	make

feature

	open_read_error: BOOLEAN is
			-- Open current file in reading mode and returns False if
			-- no error happened
		local
			error_happened: BOOLEAN;
		do
			if not error_happened then
				open_read
			end
		rescue
			if Rescue_status.is_unexpected_exception then
				error_happened := True;
				retry;
			end
		end

end

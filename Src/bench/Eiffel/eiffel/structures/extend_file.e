class EXTEND_FILE

inherit

	UNIX_FILE

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
			-- FIXME
			error_happened := True;
			retry;
		end

end

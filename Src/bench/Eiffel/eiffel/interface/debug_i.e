deferred class DEBUG_I 

inherit

	DB_CONST
	
feature 

	is_yes: BOOLEAN is
			-- Is the debug option value `yes' ?
		do
			-- Do nothing
		end;

	is_no: BOOLEAN is
			-- Is the  debug option value `no' ?
		do
			-- Do nothing
		end;

	is_partial: BOOLEAN is
			-- Is the debug option a list of tag ?
		do
			-- Do nothing
		end;

	is_debug (tag: STRING): BOOLEAN is
			-- Is the debug compatible with tag `tag' ?
		deferred
		end;

	trace is
			-- Debug purpose
		deferred
		end;

	generate (file: INDENT_FILE; id: CLASS_ID) is
			-- Generate assertion value in `file'.
		require
			good_argument: file /= Void;
			is_open: file.is_open_write;
		deferred
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for current debug level
		deferred
		end;

end

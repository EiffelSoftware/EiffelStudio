deferred class DEBUG_I 

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

	generate (buffer: GENERATION_BUFFER; id: INTEGER) is
			-- Generate assertion value in `buffer'.
		require
			good_argument: buffer /= Void;
		deferred
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for current debug level
		deferred
		end;

end

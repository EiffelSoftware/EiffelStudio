class DEBUG_YES_I 

inherit

	DEBUG_I
		redefine
			is_yes
		end
	
feature 

	is_yes: BOOLEAN is
			-- Is the debug option value `yes' ?
		do
			Result := True;
		end;

	is_debug (tag: STRING): BOOLEAN is
			-- Is `tag' compatible with current option ?
		do
			Result := True;
		end;

	trace is
		do
			io.error.put_string ("all debug");
		end;

	generate (buffer: GENERATION_BUFFER; id: INTEGER) is
			-- Generate assertion value in `buffer'.
		do
			buffer.put_string ("{OPT_ALL, (int16) 0, (char **) 0}");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for current debug level
		do
			ba.append (feature {DB_CONST}.Db_yes);
		end;

end

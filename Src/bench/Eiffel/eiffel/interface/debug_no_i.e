class DEBUG_NO_I 

inherit

	DEBUG_I
		redefine
			is_no
		end
	
feature 

	is_no: BOOLEAN is
			-- is the debug option value `no' ?
		do
			Result := True;
		end;

	is_debug (tag: STRING): BOOLEAN is
			-- Is the `tag' compatible with current debug value ?
		do
			-- Do nothing
		end;

	trace is
		do
			io.error.putstring ("no debug");
		end;

	generate (file: INDENT_FILE; id: CLASS_ID) is
			-- Generate assertion value in `file'.
		do
			file.putstring ("{OPT_NO, (int16) 0, (char **) 0}");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for current debug level
		do
			ba.append (Db_no);
		end;

end

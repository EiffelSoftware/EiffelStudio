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
			io.error.putstring ("all debug");
		end;

	generate (file: INDENT_FILE; id: INTEGER) is
			-- Generate assertion value in `file'.
		do
			file.putstring ("{DB_ALL, (int16) 0, (char **) 0}");
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for current debug level
		do
			ba.append (Db_yes);
		end;

feature -- DLE

	generate_dle (file: INDENT_FILE; id: INTEGER) is
			-- Generate assertion value in `file'.
		do
			file.putstring ("dle_dbg->debug_level = DB_ALL;");
			file.new_line;
			file.putstring ("dle_dbg->nb_keys = (int16) 0;");
			file.new_line;
			file.putstring ("dle_dbg->keys = (char **) 0;");
			file.new_line
		end;

end

-- Set execution format so that all breakable points set except those 
-- of the current routine will be taken into account.

class
	
	EXEC_LAST

inherit

	EXEC_FORMAT
		redefine
			dark_symbol
		end

creation

	make

feature

	symbol: PIXMAP is
		once
			Result := bm_Exec_last
		end;

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_exec_last
		end;

feature {NONE}

	execution_mode: INTEGER is
		once
			Result := Out_of_routine
		end;

	command_name: STRING is
		do
			Result := l_Exec_last
		end;

end -- class EXEC_LAST

-- Set execution format so that user-defined stop points will be taken 
-- into account.

class
	
	EXEC_STOP

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
			Result := bm_Exec_stop
		end;

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_exec_stop
		end;

feature {NONE}

	execution_mode: INTEGER is
		once
			Result := User_stop_points
		end;
	
	command_name: STRING is
		do
			Result := l_Exec_stop
		end;

end -- class EXEC_STOP

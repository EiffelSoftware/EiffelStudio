-- Set execution format so that each breakable points of the current
-- routine will be taken into account.

class
	
	EXEC_STEP

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
			Result := bm_Exec_step
		end;

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_exec_step
		end;

feature {NONE}

	execution_mode: INTEGER is
		once
			Result := Routine_breakables
		end;

	command_name: STRING is
		do
			Result := l_Exec_step
		end;

end -- class EXEC_STEP

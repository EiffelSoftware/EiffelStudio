-- Set execution format so that no stop points will be taken into account.

class
	
	EXEC_NOSTOP

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
			Result := bm_Exec_nostop
		end;

	dark_symbol: PIXMAP is
		once
			Result := bm_Dark_Exec_nostop
		end;

feature {NONE}

	execution_mode: INTEGER is
		once
			Result := No_stop_points
		end;

	command_name: STRING is
		do
			Result := l_Exec_nostop
		end;

end -- class EXEC_NOSTOP

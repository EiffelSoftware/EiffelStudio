indexing

	description:	
		"Set execution format so that each breakable points %
			%of the current routine will be taken into account.";
	date: "$Date$";
	revision: "$Revision$"

class
	
	EXEC_STEP

inherit

	EXEC_FORMAT
		redefine
			dark_symbol
		end

creation

	make

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := bm_Exec_step
		end;

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'.
		once
			Result := bm_Dark_exec_step
		end;

feature {NONE} -- Attributes

	execution_mode: INTEGER is
			-- Mode of execution.
		once
			Result := All_breakable_points
		end;

	command_name: STRING is
			-- Name of the command.
		do
			Result := l_Exec_step
		end;

end -- class EXEC_STEP

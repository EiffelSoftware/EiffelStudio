indexing

	description:	
		"Set execution format so that user-defined stop %
			%points will be taken into account.";
	date: "$Date$";
	revision: "$Revision$"

class EXEC_STOP

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
			Result := Pixmaps.bm_Exec_stop
		end;

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'.
		once
			Result := Pixmaps.bm_Dark_exec_stop
		end;

feature {NONE} -- Attributes

	execution_mode: INTEGER is
			-- Mode of execution.
		once
			Result := User_stop_points
		end;
	
	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Exec_stop
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Exec_stop
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Exec_stop
		end;

end -- class EXEC_STOP

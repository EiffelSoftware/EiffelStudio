indexing

	description:	
		"Set execution format so that all breakable points %
			%set except those of the current routine will be %
			%taken into account.";
	date: "$Date$";
	revision: "$Revision$"

class
	
	EXEC_LAST

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
			Result := Pixmaps.bm_Exec_last
		end;

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'.
		once
			Result := Pixmaps.bm_Dark_exec_last
		end;

feature {NONE} -- Attributes

	execution_mode: INTEGER is
			-- Mode for the execution.
		once
			Result := Out_of_routine
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Exec_last
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Exec_last
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
			Result := Interface_names.a_Exec_last
		end;

end -- class EXEC_LAST

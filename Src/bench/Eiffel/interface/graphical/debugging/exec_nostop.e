indexing

	description:	
		"Set execution format so that no stop points will be %
			%taken into account.";
	date: "$Date$";
	revision: "$Revision$"

class
	
	EXEC_NOSTOP

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
			Result := Pixmaps.bm_Exec_nostop
		end;

	dark_symbol: PIXMAP is
			-- Dark version of `symbol'.
		once
			Result := Pixmaps.bm_Dark_Exec_nostop
		end;

feature {NONE} -- Attributes

	execution_mode: INTEGER is
			-- Mode of execution.
		once
			Result := No_stop_points
		end;

	name: STRING is
			-- Name of the command.
		do
			Result := Interface_names.f_Exec_nostop
		end;

	menu_name: STRING is
			-- Name used in menu entry
		do
			Result := Interface_names.m_Exec_nostop
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

end -- class EXEC_NOSTOP

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
		rename
			No_stop_points as execution_mode
		end

create
	make

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Exec_nostop
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		once
			Result := Interface_names.f_Exec_nostop
		end;

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Exec_nostop
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

end -- class EXEC_NOSTOP

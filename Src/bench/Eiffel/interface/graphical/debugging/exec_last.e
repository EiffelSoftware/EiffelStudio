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
		rename
			Out_of_routine as execution_mode
		end

create
	make

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Exec_last
		end;

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		once
			Result := Interface_names.f_Exec_last
		end;

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Exec_last
		end;

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end;

end -- class EXEC_LAST

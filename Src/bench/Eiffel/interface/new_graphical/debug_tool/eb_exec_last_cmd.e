indexing

	description:	
		"Set execution format so that all breakable points %
			%set except those of the current routine will be %
			%taken into account."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_LAST_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			Out_of_routine as execution_mode
		end

creation
	make

feature -- Properties

--	symbol: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Exec_last
--		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		once
			Result := Interface_names.f_Exec_last
		end

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Exec_last
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

end -- class EB_EXEC_LAST_CMD

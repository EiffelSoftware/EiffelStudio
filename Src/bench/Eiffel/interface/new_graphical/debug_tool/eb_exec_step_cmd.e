indexing

	description:	
		"Set execution format so that each breakable points %
			%of the current routine will be taken into account."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_STEP_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			All_breakable_points as execution_mode
		end

creation
	make

feature -- Properties

--	symbol: EV_PIXMAP is
--			-- Pixmap for the button.
--		once
--			Result := Pixmaps.bm_Exec_step
--		end

feature {NONE} -- Attributes

	name: STRING is
			-- Name of the command.
		once
			Result := Interface_names.f_Exec_step
		end

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Exec_step
		end

	accelerator: STRING is
			-- Accelerator action for menu entry
		do
		end

end -- class EB_EXEC_STEP_CMD

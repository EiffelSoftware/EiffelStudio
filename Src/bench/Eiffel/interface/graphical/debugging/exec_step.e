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
		rename
			step_by_step as execution_mode
		redefine
			work
		end

creation
	make

feature -- Properties

	symbol: PIXMAP is
			-- Pixmap for the button.
		once
			Result := Pixmaps.bm_Exec_step
		end

feature -- Formatting

	work (argument: ANY) is
			-- Set the execution format to `stone'.
		do
			precursor(argument)
		end

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

end -- class EXEC_STEP

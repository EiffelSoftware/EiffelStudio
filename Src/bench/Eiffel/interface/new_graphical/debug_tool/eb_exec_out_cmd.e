indexing

	description:	
		"Set execution format so that each breakable points %
			%of the current routine will be taken into account."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_OUT_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			Out_of_routine as execution_mode
		redefine
			make
		end

creation
	make

feature -- Initialization

	make (a_manager: like debugger_manager) is
			-- Initialize `Current'.
		do
			Precursor (a_manager)
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f11),
				False, False, True)
			accelerator.actions.extend (~execute)
		end

feature {NONE} -- Attributes

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap for the button.
		once
			Result := Pixmaps.Icon_step_out
		end

	name: STRING is "Exec_out"
			-- Name of the command.

	internal_tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_out
		end

	menu_name: STRING is
			-- Name used in menu entry
		once
			Result := Interface_names.m_Exec_last
		end

end -- class EB_EXEC_OUT_CMD



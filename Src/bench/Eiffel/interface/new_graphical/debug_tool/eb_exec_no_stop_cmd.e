indexing

	description:	
		"Set execution format so that no breakable point %
			%will be taken into account."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_EXEC_NO_STOP_CMD

inherit
	EB_EXEC_FORMAT_CMD
		rename
			No_stop_points as execution_mode
		redefine
			make,
			tooltext
		end

create
	make

feature -- Initialization

	make (a_manager: like debugger_manager) is
			-- Initialize `Current'.
		do
			Precursor (a_manager)
			create accelerator.make_with_key_combination (
				create {EV_KEY}.make_with_code (Key_constants.Key_f5),
				True, False, False)
			accelerator.actions.extend (agent execute)
		end

feature {NONE} -- Attributes

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap for the button.
		once
			Result := Pixmaps.Icon_no_stop
		end

	name: STRING is "Exec_no_stop"
			-- Name of the command.

	internal_tooltip: STRING is
			-- Tooltip displayed on `Current's buttons.
		do
			Result := Interface_names.e_Exec_no_stop
		end

	tooltext: STRING is
			-- Text displayed on `Current's buttons.
		do
			Result := Interface_names.b_Exec_no_stop
		end

	menu_name: STRING is
			-- Name used in menu entry.
		once
			Result := Interface_names.m_Exec_nostop
		end

end -- class EB_EXEC_NO_STOP_CMD



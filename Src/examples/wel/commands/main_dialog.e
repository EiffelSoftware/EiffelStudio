indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_DIALOG

inherit
	WEL_MAIN_DIALOG
		redefine
			setup_dialog,
			on_control_id_command,
			on_cancel,
			on_ok
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Create the main dialog and the commands.
		local
			c1: SHOW_MOVE_INFORMATION
			c2: SHOW_MOUSE_BUTTON_INFORMATION
			c3: SHOW_COMMAND_INFORMATION
		do
			make_by_id (Main_dialog)
			create list_box.make_by_id (Current, Idc_listbox)
			create check_box.make_by_id (Current, Idc_checkbox)
			create c1
			create c2
			create c3
			put_command (c1, Wm_move, list_box)
			put_command (c2, Wm_lbuttondown, list_box)
			put_command (c3, Wm_command, list_box)
		end

feature -- Basic operations

	on_control_id_command (control_id: INTEGER) is
			-- Process the check mark and the button.
		do
			if control_id = Idc_checkbox then
				if check_box.checked then
					enable_commands
				else
					disable_commands
				end
			elseif control_id = Idc_clear_button then
				list_box.reset_content
			end
		end

	setup_dialog is
			-- Enable the commands.
		do
			check_box.set_checked
			enable_commands
		end

feature -- Access

	list_box: WEL_SINGLE_SELECTION_LIST_BOX
			-- List box which contains the information

	check_box: WEL_CHECK_BOX
			-- Check box to control the command execution
			
feature {NONE} -- Implementation

	on_ok is
			-- Button OK has been pressed (marked "Cancel").
		do
			remove_commands
			Precursor {WEL_MAIN_DIALOG}			
		end
		
	
	on_cancel is
			-- Current has been cancelled.
		do
			remove_commands
			Precursor {WEL_MAIN_DIALOG}
		end
		
	remove_commands is
			-- Unconnect all commands from `Current'.
		do
			remove_command (Wm_move)
			remove_command (Wm_lbuttondown)
			remove_command (Wm_command)
		end
		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class MAIN_DIALOG


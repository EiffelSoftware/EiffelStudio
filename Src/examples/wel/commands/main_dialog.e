note
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

	make
			-- Create the main dialog and the commands.
		local
			c1: SHOW_MOVE_INFORMATION
			c2: SHOW_MOUSE_BUTTON_INFORMATION
			c3: SHOW_COMMAND_INFORMATION
			l_list_box: like list_box
		do
			make_by_id (Main_dialog)
			create l_list_box.make_by_id (Current, Idc_listbox)
			list_box := l_list_box
			create check_box.make_by_id (Current, Idc_checkbox)
			create c1
			create c2
			create c3
			put_command (c1, Wm_move, l_list_box)
			put_command (c2, Wm_lbuttondown, l_list_box)
			put_command (c3, Wm_command, l_list_box)
		end

feature -- Basic operations

	on_control_id_command (control_id: INTEGER)
			-- Process the check mark and the button.
		local
			l_check_box: like check_box
			l_list_box: like list_box
		do
			if control_id = Idc_checkbox then
				l_check_box := check_box
					-- Per invariant
				check l_check_box_attached: l_check_box /= Void end
				if l_check_box.checked then
					enable_commands
				else
					disable_commands
				end
			elseif control_id = Idc_clear_button then
				l_list_box := list_box
					-- Per invariant
				check l_list_box_attached: l_list_box /= Void end
				l_list_box.reset_content
			end
		end

	setup_dialog
			-- Enable the commands.
		local
			l_check_box: like check_box
		do
			l_check_box := check_box
				-- Per invariant
			check l_check_box_attached: l_check_box /= Void end
			l_check_box.set_checked
			enable_commands
		end

feature -- Access

	list_box: detachable WEL_SINGLE_SELECTION_LIST_BOX
			-- List box which contains the information

	check_box: detachable WEL_CHECK_BOX
			-- Check box to control the command execution

feature {NONE} -- Implementation

	on_ok
			-- Button OK has been pressed (marked "Cancel").
		do
			remove_commands
			Precursor {WEL_MAIN_DIALOG}
		end

	on_cancel
			-- Current has been cancelled.
		do
			remove_commands
			Precursor {WEL_MAIN_DIALOG}
		end

	remove_commands
			-- Unconnect all commands from `Current'.
		do
			remove_command (Wm_move)
			remove_command (Wm_lbuttondown)
			remove_command (Wm_command)
		end

invariant
	list_box_attached: list_box /= Void
	check_box_attached: check_box /= Void

note
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


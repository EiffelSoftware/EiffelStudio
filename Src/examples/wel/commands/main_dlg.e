class
	MAIN_DIALOG

inherit
	WEL_MAIN_DIALOG
		redefine
			setup_dialog,
			on_control_id_command
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

xxxxxx: WEL_COMMAND_LIST

	make is
			-- Create the main dialog and the commands.
		local
			c1: SHOW_MOVE_INFORMATION
			c2: SHOW_MOUSE_BUTTON_INFORMATION
			c3: SHOW_COMMAND_INFORMATION
		do
			make_by_id (Main_dialog)
			!! list_box.make_by_id (Current, Idc_listbox)
			!! check_box.make_by_id (Current, Idc_checkbox)
			!! c1
			!! c2
			!! c3
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

end -- class MAIN_DIALOG

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

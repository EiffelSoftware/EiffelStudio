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

end -- class MAIN_DIALOG

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


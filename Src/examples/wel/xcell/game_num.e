class
	SELECT_GAME_NUMBER_DIALOG

inherit
	WEL_MODAL_DIALOG
		redefine
			setup_dialog,
			on_ok
		end

	APP_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Creates the dialog
		require
			a_parent_not_void: a_parent /= Void
		do
			make_by_id (a_parent, Select_game_number_dlg_id)
			create number_edit.make_by_id (Current, Idc_edit)
		end

feature -- Access

	set_game_number (a_game_number: INTEGER) is
			-- Set the 'game_number' to `a_game_number'
		do
			game_number := a_game_number
		ensure
			game_number_is_set: game_number = a_game_number
		end

	game_number: INTEGER
			-- Number of cards choosen

	number_edit: WEL_SINGLE_LINE_EDIT
			-- Edit control to input the game number

feature {NONE} -- Implementation

	setup_dialog is
			-- Setup the dialog before
			-- it is activated
		do
			number_edit.set_text (game_number.out)
		end

	on_ok is
			-- Ok button is pressed
		local
			msg_box: WEL_MSG_BOX
		do
			if number_edit.text.is_integer then
				if number_edit.text.to_integer < 1 or number_edit.text.to_integer > 65000 then
					create msg_box.make
					msg_box.information_message_box (Current, "You can only select %
						%a game number from 1 to 65000.", "Information")
					number_edit.set_text (game_number.out)
				else
					game_number := number_edit.text.to_integer
					terminate (Idok)
				end
			else
				create msg_box.make
				msg_box.information_message_box (Current, "This field requires %
					%a number.", "Information")
				number_edit.set_text (game_number.out)
			end
		end

end -- class SELECT_GAME_NUMBER_DIALOG

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


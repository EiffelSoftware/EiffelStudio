indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

create
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


end -- class SELECT_GAME_NUMBER_DIALOG


indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	SELECT_NUMBER_OF_CARDS_DIALOG

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
			-- Create the dialog
		do
			make_by_id (a_parent, Select_cards_dlg_id)
			create number_edit.make_by_id (Current, Idc_edit)
			no_cards := 52
		end

feature -- Access

	no_cards: INTEGER
			-- Number of cards choosen

feature {NONE} -- Implementation

	number_edit: WEL_SINGLE_LINE_EDIT
			-- Edit control to input the number of cards

	setup_dialog is
			-- Setup the dialog before
			-- it is activated
		do
			number_edit.set_text (no_cards.out)
		end

	on_ok is
			-- Ok button is pressed
		local
			msg_box: WEL_MSG_BOX
		do
			if number_edit.text.is_integer then
				if number_edit.text.to_integer < 1 or number_edit.text.to_integer > 52 then
					create msg_box.make
					msg_box.information_message_box (Current, "You can only select %
						%a number of cards%Nwithin the range of 1-52.", "Information")
					number_edit.set_text (no_cards.out)
				else
					no_cards := number_edit.text.to_integer
					terminate (Idok)
				end
			else
				create msg_box.make
				msg_box.information_message_box (Current, "This field requires %
						%a number.", "Information")
				number_edit.set_text (no_cards.out)
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


end -- class SELECT_NUMBER_OF_CARDS_DIALOG


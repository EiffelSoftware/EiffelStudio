indexing
	description	: "Error state when the user has not choosen to precompile at least one library"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_CHOOSE_ONE_ERROR_STATE

inherit
	WIZARD_FINAL_STATE_WINDOW
		redefine
			proceed_with_current_info
		end

create
	make

feature -- Basic Operations

	proceed_with_current_info is
		do
			first_window.disable_next_button
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Precompilation Wizard Error")
			message.set_text (
				"You must choose at least one library.%N%
				%%N%
				%If you want to precompile one or more libraries, click Back%N%
				%and add the libraries you want to precompile into the right list%N%
				%%N%
				%If you don't want to precompile any library, click Cancel"
				)
		end

	final_message: STRING is
		do
			Result := "Fuck !"
		end

feature -- Access

	pixmap_icon_location: STRING is "eiffel_wizard_icon.bmp"
			-- Icon for the Eiffel Wizard

end -- class WIZARD_CHOOSE_ONE_ERROR_STATE

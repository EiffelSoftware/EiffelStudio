indexing
	description	: "Page in which the user choose..."
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_SECOND_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
		do 
		end

	change_preview is
			-- Change the pixmap used to preview the application.
		do
		end

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state (create {WIZARD_FINAL_STATE}.make(wizard_information))
		end

	update_state_information is
			-- Check User Entries
		do
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text (".NET Application type")
			subtitle.set_text ("You can choose to create a .exe or a .dll file.")
			message.set_text (
				"You can create an executable file (.exe) or%N%
				%a dynamic-link library (.dll)")
		end

	preview_pixmap: EV_PIXMAP
			-- Pixmap used to preview the application.

end -- class WIZARD_SECOND_STATE
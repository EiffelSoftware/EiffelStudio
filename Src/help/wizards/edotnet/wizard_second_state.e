indexing
	description	: "Page in which the user choose to create an EXE or a DLL"
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
			create rb_project_type_exe.make_with_text ("Executable")
			create rb_project_type_dll.make_with_text ("Dynamic-Link Library")

			choice_box.set_padding (dialog_unit_to_pixels(1))
			choice_box.extend (rb_project_type_exe)
			choice_box.disable_item_expand (rb_project_type_exe)
			choice_box.extend (rb_project_type_dll)
			choice_box.disable_item_expand (rb_project_type_dll)
			choice_box.extend (create {EV_CELL}) -- expandable item

			if wizard_information.generate_dll then
				rb_project_type_dll.enable_select
			else
				rb_project_type_exe.enable_select
			end
			
			set_updatable_entries(<<
				rb_project_type_exe.select_actions,
				rb_project_type_dll.select_actions
				>>)
		end

	change_preview is
			-- Change the pixmap used to preview the application.
		do
		end

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state (create {WIZARD_THIRD_STATE}.make (wizard_information))
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
			
	rb_project_type_exe: EV_RADIO_BUTTON
	rb_project_type_dll: EV_RADIO_BUTTON

end -- class WIZARD_SECOND_STATE
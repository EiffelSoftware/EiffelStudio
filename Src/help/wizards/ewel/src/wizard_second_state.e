indexing
	description	: "Page in which the user choose where he wants to generate the sources."
	author		: "David Solal"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_THIRD_STATE

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
			create icon_location.make (Current)
			icon_location.set_textfield_string (wizard_information.icon_location)
			icon_location.set_label_string_and_size ("Project icon", 10)
			icon_location.enable_file_browse_button ("*.ico")
			icon_location.generate

			choice_box.set_padding (Default_padding_size)
			choice_box.extend (icon_location.widget)
			choice_box.disable_item_expand(icon_location.widget)
			choice_box.extend (create {EV_CELL}) -- Expandable item

			set_updatable_entries(<<icon_location.change_actions>>)
		end

	proceed_with_current_info is 
		do
			Precursor
			proceed_with_new_state(Create {WIZARD_FINAL_STATE}.make(wizard_information))
		end

	update_state_information is
			-- Check User Entries
		local
			icon_path: FILE_NAME
		do
			if not icon_location.text.is_equal ("") then
				wizard_information.set_icon_location (icon_location.text)
			else
				create icon_path.make_from_string (wizard_resources_path)
				icon_path.set_file_name ("eiffel")
				icon_path.add_extension ("ico")
				wizard_information.set_icon_location (icon_path)
			end
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Project icon")
			subtitle.set_text ("Choose an icon for you project.")
			message.set_text (
				"You have chosen to build a Frame-Based Application.%N%
				%You can provide an icon or use the default icon")
		end

	icon_location: WIZARD_SMART_TEXT_FIELD
			-- Label and Textfield for the icon location.

end -- class WIZARD_SECOND_STATE

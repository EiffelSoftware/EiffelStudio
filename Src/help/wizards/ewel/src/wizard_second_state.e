indexing
	description	: "Page in which the user choose where he wants to generate the sources."
	author		: "David Solal"
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
			create project_name.make (Current)
			project_name.set_textfield_string_and_capacity (wizard_information.project_name, 50)
			project_name.set_label_string_and_size ("Project name (without space)", 10)
			project_name.generate

			create icon_location.make (Current)
			icon_location.set_textfield_string_and_capacity (wizard_information.icon_location, 50)
			icon_location.set_label_string_and_size ("Project icon", 10)
			icon_location.enable_file_browse_button ("*.ico")
			icon_location.generate

			choice_box.set_padding (Default_padding_size)
			choice_box.extend (project_name.widget)
			choice_box.disable_item_expand (project_name.widget)
			choice_box.extend (icon_location.widget)
			choice_box.disable_item_expand(icon_location.widget)

			set_updatable_entries(<<project_name.change_actions, icon_location.change_actions>>)
		end

	proceed_with_current_info is 
		do
			string_cleaner.set_input (project_name.text)
			if not string_cleaner.is_eiffel_lace_compatible then
				Precursor
				proceed_with_new_state (create {WIZARD_ERROR_PROJECT_NAME}.make (wizard_information))
			else
				Precursor
				proceed_with_new_state(Create {WIZARD_THIRD_STATE}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		local
			p_name: STRING
		do
			p_name:= project_name.text 
			if p_name.has(' ') then
				p_name.replace_substring_all (" ", "_")
			end 
			wizard_information.set_project_name (p_name)
			if not icon_location.text.is_equal ("") then
				wizard_information.set_icon_location (icon_location.text)
			else
				wizard_information.set_icon_location (wizard_resources_path + "\eiffel.ico")
			end
			Precursor
		end


feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("Project Parameters")
			subtitle.set_text ("In order to create the Eiffel project you must supply some parameters")
			if not wizard_information.dialog_application then
				message.set_text ("You have chosen to build a Frame-Based Application.%
								%%NYou must provide:%
								%%N%T A project name.%
								%%N%T An icon [Optional]")
			else
				message.set_text ("You have chosen to build a Frame-Based Application.%
								%%NYou must provide the name of your project")
			end
		end

	icon_location: WIZARD_SMART_TEXT_FIELD
			-- Label, Textfield and browse button for the icon location.

	project_name: WIZARD_SMART_TEXT_FIELD
			-- Label, Textfield for the project name.

end -- class WIZARD_SECOND_STATE

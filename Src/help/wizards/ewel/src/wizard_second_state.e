indexing
	description: "Page in which the user choose where he wants to generate the sources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SECOND_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
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
		local
			browse_b: EV_BUTTON
			h1: EV_HORIZONTAL_BOX
			v1: EV_VERTICAL_BOX
			cell: EV_CELL
		do 
			create h1
			create project_name.make("Project Name",
							 wizard_information.project_name, 10, 50, Current, False)
			h1.extend (project_name)
			create cell	
			cell.set_minimum_width (10)
			h1.extend (cell)
			choice_box.extend (h1)
			choice_box.disable_item_expand (h1)
			choice_box.extend (create {EV_HORIZONTAL_BOX})

			create h1
			h1.set_padding (5)
			create icon_location.make("Project icon (Enter file name)",
							 wizard_information.icon_location, 10, 50, Current, False)		
			create browse_b.make_with_text("Browse...")
			browse_b.select_actions.extend(~Browse)
			h1.extend (icon_location)
		
			create v1
--			v1.set_minimum_width (50)
			create cell
			cell.set_minimum_height (10)
			v1.extend (cell)
			v1.extend (browse_b)
			v1.disable_item_expand (browse_b)	
			h1.extend (v1)
			h1.disable_item_expand (v1)

			if not wizard_information.dialog_application then
					-- Test because the second state is used by 2 examples.
					-- And for the dialog, we don't ask for an icon.

				choice_box.extend (h1)
				choice_box.disable_item_expand(h1)
			end

			choice_box.extend (create {EV_HORIZONTAL_BOX})
			choice_box.extend (create {EV_HORIZONTAL_BOX})

			set_updatable_entries(<<project_name.change_actions, icon_location.change_actions>>)
		end

	proceed_with_current_info is 
		local
			dir: DIRECTORY
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
--			wizard_information.set_dialog_application (dialog_application.is_selected)
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
			title.set_text ("CHOOSE PROJECT OPTIONS")
			if not wizard_information.dialog_application then
				message.set_text ("%NYou have chosen to build a Frame-Based Application.%
								%%NYou must provide:%
								%%N%T+ A project name.%
								%%N%T+ (Optional) An icon (Default: ISE Eiffel icon.)")
			else
				message.set_text ("%NYou chosen to build a Frame-Based Application.%
								%%NYou must provide:%
								%%N%T+ The name of your project")
			end
		end

	icon_location, project_name: WIZARD_SMART_TEXT_FIELD

--	dialog_application: EV_CHECK_BUTTON

feature -- Process

	browse is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_FILE_OPEN_DIALOG  
		do
			create dir_selector
			dir_selector.set_filter ("*.ico")
			dir_selector.ok_actions.extend(~directory_selected(dir_selector))
			dir_selector.show_modal
		end

	directory_selected (dir_selector: EV_FILE_OPEN_DIALOG) is
			-- The user selected a directory from the browser. 
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			icon_location.set_text(dir_selector.file_name)
		end

end -- class WIZARD_SECOND_STATE

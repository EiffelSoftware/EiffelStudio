indexing
	description	: "Second state of the wizard wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	WIZARD_PROJECT_NAME_AND_LOCATION_STATE

inherit
	BENCH_WIZARD_INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end
		
	ISE_DIRECTORY_UTILITIES
		export
			{NONE} all
		end
		
create
	make
			
feature -- Basic Operation

	build is 
			-- Build entries.
		do 
			create project_name.make (Current)
			project_name.set_label_string_and_size ("Project name", 10)
			project_name.set_textfield_string (wizard_information.project_name)
			project_name.generate
			project_name.change_actions.extend (agent on_change_name)

			create project_location.make (Current)
			project_location.set_label_string_and_size ("Project location", 10)
			project_location.set_textfield_string (wizard_information.project_location)
			project_location.enable_directory_browse_button
			project_location.generate

			create to_compile_b.make_with_text ("Compile the generated project")
			if wizard_information.compile_project then
				to_compile_b.enable_select
			else
				to_compile_b.disable_select
			end
			
			choice_box.set_padding (dialog_unit_to_pixels(10))
			choice_box.extend (project_name.widget)
			choice_box.disable_item_expand (project_name.widget)
			choice_box.extend (project_location.widget)
			choice_box.disable_item_expand (project_location.widget)
			choice_box.extend (to_compile_b)
			choice_box.disable_item_expand (to_compile_b)
			choice_box.extend (create {EV_CELL}) -- expandable item

			set_updatable_entries(<<
				project_name.change_actions,
				project_location.change_actions,
				to_compile_b.select_actions>>)
		end
		
	proceed_with_current_info is 
		local
			next_window: WIZARD_STATE_WINDOW
			rescued: BOOLEAN
			a_project_location: DIRECTORY_NAME
		do
			if not rescued then
				if not is_project_name_valid (project_name.text) then
						-- Ask for a valid project name
					create {WIZARD_ERROR_PROJECT_NAME} next_window.make (wizard_information)
				else
					a_project_location := validate_directory_string (project_location.text)
					if a_project_location.is_empty then
						create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
					else
							-- create the directory
						recursive_create_directory (a_project_location)
		
						Precursor
						create {WIZARD_SECOND_STATE} next_window.make (wizard_information)
					end
				end
			else
				-- Something went wrong when checking that the selected directory exists
				-- or when trying to create the directory, go to error.
				create {WIZARD_ERROR_LOCATION} next_window.make (wizard_information)
			end

			Precursor
			proceed_with_new_state (next_window)
		rescue
			rescued := True
			retry
		end

	update_state_information is
			-- Check User Entries
		local
			a_project_location: DIRECTORY_NAME
		do
			a_project_location := validate_directory_string (project_location.text)
			wizard_information.set_project_location (a_project_location)
			wizard_information.set_project_name (project_name.text)
			wizard_information.set_compile_project (to_compile_b.is_selected)
			Precursor
		end

feature {NONE} -- Implementation

	on_change_name is
			-- The user has changed the project name, update the project location
		local
			curr_project_location: STRING
			curr_project_name: STRING
			sep_index: INTEGER
		do
			curr_project_location := project_location.text
			curr_project_name := project_name.text
			if curr_project_location /= Void then
				sep_index := curr_project_location.last_index_of (Operating_environment.Directory_separator, curr_project_location.count)
				curr_project_location.head (sep_index)
				if curr_project_name /= Void then
					curr_project_location.append (curr_project_name)
				end
	
				project_location.set_text (curr_project_location)
			end
		end
		
	validate_directory_string (a_directory: STRING): DIRECTORY_NAME is
			-- Validate the directory `a_directory' and return the
			-- validated version of `a_directory'.
		local
			a_directory_name: DIRECTORY_NAME
		do
			if a_directory /= Void then
				create a_directory_name.make_from_string (a_directory)
				a_directory_name := validate_directory_name (a_directory_name)
				if a_directory_name /= Void then
					Result := a_directory_name
				end
			end
			if Result = Void then
				create Result.make_from_string("")
			end
		ensure
			valid_Result: Result /= Void
		end
		
	is_project_name_valid (a_project_name: STRING): BOOLEAN is
			-- Is `a_project_name' valid as project name?
		local
			curr_index: INTEGER
			curr_character: CHARACTER
		do
			if a_project_name = Void or else a_project_name.is_empty then
				Result := False
			else
				Result := True
				from
					curr_index := 1
				until
					(Result = false) or (curr_index > a_project_name.count)
				loop
					curr_character := a_project_name @ curr_index
					if curr_index = 1 then
						if not curr_character.is_alpha then
							Result := False
						end
					else
						if not (curr_character.is_alpha or curr_character.is_digit or curr_character.is_equal ('_')) then
							Result := False
						end
					end
					curr_index := curr_index + 1
				end
			end
		end
		
	display_state_text is
		do
			title.set_text ("Project Name and Project location")
			subtitle.set_text (
				"You can choose the name of the project and%N%
				%the directory where the project will be generated.")

			message.set_text (
				"Please fill in:%N%
				%%T The name of the project.%N%
				%%T The directory where you want the eiffel classes to be generated into.")
		end

	project_location: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the location of the project

	project_name: WIZARD_SMART_TEXT_FIELD
			-- Text field to enter the name of the wizard

	to_compile_b: EV_CHECK_BUTTON
			-- Should compilation be launched?.

end -- class WIZARD_PROJECT_NAME_AND_LOCATION_STATE


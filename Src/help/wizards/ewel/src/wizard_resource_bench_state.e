indexing
	description: "Page in which the user choose where he wants to generate the sources."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RESOURCE_BENCH_STATE

inherit
	INTERMEDIARY_STATE_WINDOW
		redefine
			update_state_information,
			proceed_with_current_info,
			build
		end

	TABLE_OF_SYMBOLS

	ERROR_HANDLING

	INTERFACE_MANAGER

	EXECUTION_ENVIRONMENT
		rename
			command_line as ex_command_line
		end

	TDS_DEFINE_TABLE

	RB_DATA
		rename
			title as rb_title
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

create
	make

feature -- Basic Operation

	build is 
			-- Build entries.
				local
			browse_b: EV_BUTTON
			h1: EV_HORIZONTAL_BOX
			cell: EV_CELL
		do 
			create h1
			create project_name.make("Project name. (No space)",
							 wizard_information.project_name, 20, 50, Current, False)
			h1.extend (project_name)
			create cell	
			cell.set_minimum_width (10)
			h1.extend (cell)
			choice_box.extend (h1)
			choice_box.disable_item_expand (h1)

			create h1
			create rc_location.make("Resource file (Enter file name)",
							 wizard_information.full_path_rc, 10, 200, Current, False)		
			create browse_b.make_with_text("Browse...")
			browse_b.select_actions.extend(~Browse)
			h1.extend (rc_location)
			h1.extend (browse_b)
			h1.disable_item_expand (browse_b)
			choice_box.extend (h1)
			choice_box.disable_item_expand (h1)
			create cell
			choice_box.extend (cell)

			set_updatable_entries(<<rc_location.change_actions>>)

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
				proceed_with_new_state(Create {WIZARD_RESOURCE_BENCH_STATE_INFO}.make(wizard_information))
			end
		end

	update_state_information is
			-- Check User Entries
		local
			p_name: STRING
		do
			create_analyzer
			do_analyze
			wizard_information.set_full_path_rc (rc_location.text)
			wizard_information.set_rc_location (filename)
			p_name:= project_name.text
			if p_name.has(' ') then
				p_name.replace_substring_all (" ", "_")
			end 
			wizard_information.set_project_name (p_name)
			Precursor
		end

feature {NONE} -- Implementation

	display_state_text is
		do
			title.set_text ("PROVIDE RESOURCE FILE")
			message.set_text ("You have chosen to build a Dialog-Based Application with your own resource file.%
							  %%NYou must now provide:%
							  %%N%T+ A project name.%
							  %%N%T+ The name of the resource file.%
							  %%N%N%NThe provided resource file will be parsed as soon as you will push the Next button.%
							  %%N(This operation may take a few minutes for a first-time parsing.)")
		end


feature -- Process

	analyzer: PROCESS

	rc_location, project_name: WIZARD_SMART_TEXT_FIELD

	rc_file: EV_FILE_OPEN_DIALOG

	filename: STRING

	create_analyzer is
			-- Create the resource analyzer.
		require
			analyzer_void: analyzer = Void
		local
			file: RAW_FILE
		do
			set_application_directory (current_working_directory)

			set_working_directory (current_working_directory)
			change_working_directory (application_directory)

			create file.make (Grammar_name)

			if (file.exists) then
				create file.make_open_read (Grammar_name)
				create analyzer.retrieve_grammar (file)
			else
				create analyzer.make
				create file.make_open_write (Grammar_name)
				analyzer.store_grammar (file)
			end

			file.close

--			interface.hide_all
			change_working_directory (working_directory)
		ensure
			analyzer_not_void: analyzer /= Void
		end


	do_analyze is --(a_parent: WEL_COMPOSITE_WINDOW; a_open_file: WEL_OPEN_FILE_DIALOG) is
			-- Analyze a resource script `a_filename'.
		local
			temp_file: PLAIN_TEXT_FILE
			temp_filename: STRING
			folder: DIRECTORY 
			preprocessor: PREPROCESSOR
			directory_name: STRING
		do
			create folder.make (Tmp_directory)
			If (not folder.exists) then
				folder.create_dir
			end

			filename := clone (rc_file.file_title)

				-- Prepare saving of current working directory
				-- and change to directory where file is opened from
			directory_name := clone (rc_file.file_path)

			set_working_directory (directory_name)

			temp_filename := clone (Tmp_directory)
			temp_filename.append ("\Temp_file.rc")
			create temp_file.make_open_write (temp_filename)

			create preprocessor.make (temp_file)
			preprocessor.convert (filename)
			temp_file.close

			set_define_table (preprocessor.define_table)
			set_has_error (false)

			analyzer.regenerate
			analyzer.parsing (temp_filename)
		end

	browse is
			-- Launch a computer directory Browser.
		local
			dir_selector: EV_FILE_OPEN_DIALOG  
		do
			create dir_selector
			dir_selector.set_filter ("*.rc")
			dir_selector.ok_actions.extend(~directory_selected(dir_selector))
			dir_selector.show_modal
		end

	directory_selected (dir_selector: EV_FILE_OPEN_DIALOG) is
			-- The user selected a directory from the browser. 
			-- It updates the text fields accordingly.
		require
			selector_exists: dir_selector /= Void
		do
			rc_location.set_text(dir_selector.file_name)
			rc_file:= dir_selector
		end

end -- class WIZARD_RESOURCE_BENCH_STATE


indexing
	description	: "Command to create a new project"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_CREATE_PROJECT_DIALOG

inherit
	EV_DIALOG
		export
			{NONE} all
		end

	EXCEPTIONS
		rename
			raise as raise_exception
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_GRAPHICAL_ERROR_MANAGER
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			default_create, copy
		end

	COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		export
			{NONE} all
		undefine
			default_create, copy
		end

	SYSTEM_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EIFFEL_ENV
		export
			{NONE} all
		undefine
			default_create, copy
		end

	ISE_DIRECTORY_UTILITIES
		rename
			raise as raise_exception,
			make_for_test as make_for_dir_test
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_blank,
	make_with_ace,
	make_with_ace_and_directory_and_flags

feature {NONE} -- Initialization

	make_blank (a_parent_window: EV_WINDOW) is
			-- Create a new blank project
			--
			-- Note: 
			--  + The ace file will be automatically generated
			--  + The user has to choose the project directory.
		require
			valid_parent_window: a_parent_window /= Void
		do
			parent_window := a_parent_window
			compile_project := True
			suggested_directory_name := create_default_directory_name (Default_project_name)

			ask_for_system_name := True
			blank_project_creation := True
			build_interface
			set_title (Interface_names.t_Choose_project_and_directory)
		end

	make_with_ace (a_parent_window: EV_WINDOW; ace_name: STRING; a_suggested_directory_name: STRING) is
			-- Create a new project using the ace file named `ace_name'.
			-- and the suggested project directory `dir_name'.
			--
			-- Note: 
			--  The user has to choose the project directory.
			--  suggested_directory_name can be set to Void to indicate
			--  no suggested directory.
		require
			valid_parent_window: a_parent_window /= Void
		do
			parent_window := a_parent_window
			ace_file_name := ace_name
			if not a_suggested_directory_name.is_empty then
				suggested_directory_name := a_suggested_directory_name
			else
				suggested_directory_name := create_default_directory_name (Default_project_name)
			end
			compile_project := True

			ask_for_system_name := False
			build_interface
			set_title (Interface_names.t_Choose_directory)
		end

	make_with_ace_and_directory_and_flags (a_parent_window: EV_WINDOW; ace_name: STRING; a_directory_name: STRING; compilation_flag: BOOLEAN; overwrite_existing_project_flag: BOOLEAN) is
			-- Create a new project using the ace file named `ace_name'.
			-- and the suggested project directory `dir_name'.
			--
			-- Compile the project upon creation if `compilation_flag' is set
			-- Ask confirmation before deleting the EIFGEN if `confirmation_flag' is set.
		require
			valid_parent_window: a_parent_window /= Void
		do
			parent_window := a_parent_window
			ace_file_name := ace_name
			suggested_directory_name := a_directory_name
			compile_project := compilation_flag
			overwrite_project_confirmation_flag := overwrite_existing_project_flag
			
			ask_for_system_name := False
			build_interface
			set_title (Interface_names.t_Choose_ace_and_directory)
		end

feature -- Access

	compile_project: BOOLEAN
			-- Should the generated project be compiled?

	success: BOOLEAN
			-- Was last operation sucessful?

feature -- Execution

	show_modal_to_parent is
			-- Show `Current' modal to `parent_window' provided in creation procedure.
		do
			show_modal_to_window (parent_window)
		end
		
	create_blank_project is
			-- Create a blank project in directory `directory_name'.
		local
			blank_project_builder: BLANK_PROJECT_BUILDER
			rescued: BOOLEAN
			cla, clu, f: STRING
			sc: EIFFEL_SYNTAX_CHECKER
		do
			success := False
			if not rescued then
				create sc
					-- Retrieve System parameters
				if directory_field.text = Void or else directory_field.text.is_empty then
					add_error_message (Warning_messages.w_Fill_in_location_field)
					raise_exception (Invalid_directory_exception)
				end
				create directory_name.make_from_string (directory_field.text)
				check_and_create_directory (directory_name)

				system_name := system_name_field.text
				if not sc.is_valid_system_name (system_name) then
					add_error_message (Warning_messages.w_Fill_in_project_name_field)
					raise_exception (Invalid_project_name_exception)
				end
				cla := root_class_field.text
				cla.to_upper
				if not sc.is_valid_class_name (cla) then
					add_error_message (Warning_messages.w_invalid_class_name (cla))
					raise_exception (Invalid_project_name_exception)
				end
				clu := root_cluster_field.text
				clu.to_lower
				if not sc.is_valid_cluster_name (clu) then
					add_error_message (Warning_messages.w_invalid_cluster_name (clu))
					raise_exception (Invalid_project_name_exception)
				end
				f := root_feature_field.text
				f.to_lower
				if not sc.is_valid_identifier (f) then
					add_error_message (Warning_messages.w_invalid_feature_name (f))
					raise_exception (Invalid_project_name_exception)
				end

				create blank_project_builder.make (system_name, cla, clu, f, directory_name)
				ace_file_name := blank_project_builder.ace_filename
				compile_project := compile_project_check_button.is_selected

					-- Generate the files (ace file + root class)
				blank_project_builder.create_blank_project

					-- Create a new project using the previously generated files.
				create_project

					-- Update `success' state.
				success := Eiffel_project.initialized and then (not Eiffel_ace.file_name.is_empty)
			else
				if is_displayed then
					display_error_message (Current)
				else
					display_error_message (parent_window)
				end
			end
		rescue
			rescued := True
			retry
		end

	create_project is
			-- Create a project in directory `directory_name', with ace file
			-- `ace_file_name'.
			--
			-- Ask confirmation before overwriting an existing project is
			-- `ask_confirmation' is set.
			--
			-- Use `parent_window' as parent window when displaying dialogs
		local
			cmd: EB_NEW_PROJECT_COMMAND
			ebench_name: STRING
			rescued: BOOLEAN
		do
			success := False

			if not rescued then
					-- If the ace file or the directory is not yet specified,
					-- retrieve it from the text field.
				if directory_field.text = Void or else directory_field.text.is_empty then
					add_error_message (Warning_messages.w_Fill_in_location_field)
					raise_exception (Invalid_directory_exception)
				end
				if ace_filename_field /= Void then
					if ace_filename_field.text = Void or else ace_filename_field.text.is_empty then
						add_error_message (Warning_messages.w_Fill_in_ace_field)
						raise_exception (Invalid_ace_exception)
					else
						ace_file_name := ace_filename_field.text
					end
				end
				create directory_name.make_from_string (directory_field.text)
				check_and_create_directory (directory_name)

				compile_project := compile_project_check_button.is_selected

				if not Eiffel_project.initialized then
					check_ace_file (ace_file_name)
					if is_displayed then
						create cmd.make_with_parent (Current)
					else
						create cmd.make_with_parent (parent_window)
					end
					cmd.create_project (directory_name, not overwrite_project_confirmation_flag)
					if Eiffel_project.initialized then
						Eiffel_ace.set_file_name (ace_file_name)
						success := Eiffel_project.initialized and then 
							Eiffel_ace.file_name /= Void and then 
							(not Eiffel_ace.file_name.is_empty)
						destroy
					end
				else
					ebench_name := clone ((create {EIFFEL_ENV}).Estudio_command_name)
					ebench_name.append (" -create ")
					ebench_name.append (directory_name)
					ebench_name.append (" -ace ")
					ebench_name.append (ace_file_name)
					if compile_project then
						ebench_name.append (" -compile")
						compile_project := False
					end
					launch_ebench (ebench_name)
					success := True

					destroy
				end
			else
				if is_displayed then
					display_error_message (Current)
				else
					display_error_message (parent_window)
					show_modal_to_window (parent_window)
				end
			end
		rescue
			rescued := True
			retry
		end

feature {NONE} -- Implementation

	build_interface is
			-- Build the interface
		local
			vb, main_vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			label: EV_LABEL
			b: EV_BUTTON
			ok_b, cancel_b: EV_BUTTON
			buttons_box: EV_HORIZONTAL_BOX
			project_directory_frame: EV_FRAME
			system_name_frame: EV_FRAME
			clal, clul, snl, fnl: EV_LABEL
			sz: INTEGER
		do
				-- Let the user choose the directory
			default_create
			set_icon_pixmap (Pixmaps.Default_window_icon)

				-- Ask for the system name if it's not already known.
			if ask_for_system_name then
				create system_name_frame.make_with_text (Interface_names.l_System_properties)
				create main_vb
				main_vb.set_padding (Layout_constants.Tiny_padding_size)
				main_vb.set_border_width (Layout_constants.Small_border_size)
				create clal.make_with_text (Interface_names.L_root_class_name)
				create clul.make_with_text (Interface_names.L_root_cluster_name)
				create snl.make_with_text (Interface_names.L_system_name)
				create fnl.make_with_text (Interface_names.L_root_feature_name)
				sz := clal.minimum_width.max (clul.minimum_width).max (snl.minimum_width).max (fnl.minimum_width)
				clal.set_minimum_width (sz)
				clal.align_text_left
				clul.set_minimum_width (sz)
				clul.align_text_left
				snl.set_minimum_width (sz)
				snl.align_text_left
				fnl.set_minimum_width (sz)
				fnl.align_text_left
					-- System name
				create system_name_field.make_with_text (Default_project_name)
				system_name_field.change_actions.extend (agent on_change_project_name)
				create hb
				hb.extend (snl)
				hb.disable_item_expand (snl)
				hb.extend (system_name_field)
				main_vb.extend (hb)
					-- Root cluster name
				create root_cluster_field.make_with_text (Default_root_cluster_name)
				create hb
				hb.extend (clul)
				hb.disable_item_expand (clul)
				hb.extend (root_cluster_field)
				main_vb.extend (hb)
					-- Root class name
				create root_class_field.make_with_text (Default_root_class_name)
				create hb
				hb.extend (clal)
				hb.disable_item_expand (clal)
				hb.extend (root_class_field)
				main_vb.extend (hb)
					-- Root feature name
				create root_feature_field.make_with_text (Default_root_feature_name)
				create hb
				hb.extend (fnl)
				hb.disable_item_expand (fnl)
				hb.extend (root_feature_field)
				main_vb.extend (hb)
				
				system_name_frame.extend (main_vb)
			else
					-- Ace file Name
				create ace_filename_field.make_with_text (ace_file_name)
				create b.make_with_text_and_action (Interface_names.b_Browse, agent browse_ace_file)
				create hb
				hb.set_border_width (Layout_constants.Small_border_size)
				hb.extend (ace_filename_field)
				hb.extend (b)
				hb.disable_item_expand (b)
				create system_name_frame.make_with_text (Interface_names.l_Ace_file_for_frame)
				system_name_frame.extend (hb)
			end

				-- Project directory
			create project_directory_frame.make_with_text (Interface_names.l_Location)
			create vb
			vb.set_border_width (Layout_constants.Small_border_size)
			vb.set_padding (Layout_constants.Small_padding_size)
			
			create directory_field
			if suggested_directory_name /= Void then
				directory_field.set_text (suggested_directory_name)
			end
			create b.make_with_text_and_action (Interface_names.b_Browse, agent browse_directory)
			create hb
			hb.extend (directory_field)
			hb.extend (b)
			hb.disable_item_expand (b)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create label.make_with_text (Interface_names.l_Project_location)
			label.align_text_left
			vb.extend (label)
			project_directory_frame.extend (vb)

				-- "Compile project" Check box
			create compile_project_check_button.make_with_text (Interface_names.l_Compile_generated_project)
			if compile_project then
				compile_project_check_button.enable_select
			else
				compile_project_check_button.disable_select
			end

				--| Action buttons box
			create ok_b.make_with_text_and_action (Interface_names.b_OK, agent on_ok)
			Layout_constants.set_default_size_for_button (ok_b)
			create cancel_b.make_with_text_and_action (Interface_names.b_Cancel, agent on_cancel)
			Layout_constants.set_default_size_for_button (cancel_b)
			create buttons_box
			buttons_box.enable_homogeneous
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.extend (ok_b)
			buttons_box.extend (cancel_b)
			create hb
			hb.extend (create {EV_CELL})
			hb.extend (buttons_box)
			hb.disable_item_expand (buttons_box)

				-- General layout
			create vb
			vb.set_padding (Layout_constants.Small_border_size)
			vb.set_border_width (Layout_constants.Default_border_size)
			vb.extend (system_name_frame)
			vb.disable_item_expand (system_name_frame)
			vb.extend (project_directory_frame)
			vb.disable_item_expand (project_directory_frame)
			vb.extend (compile_project_check_button)
			vb.disable_item_expand (compile_project_check_button)
			vb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.disable_item_expand (hb)
			extend (vb)
			set_width (Layout_constants.Dialog_unit_to_pixels (350))
			
				--| Setting default buttons
			set_default_push_button (ok_b)
			set_default_cancel_button (cancel_b)
		
			show_actions.extend (agent on_window_shown)	
		end
		
	on_window_shown is
			-- The window has just been shown.
			-- Set the focus to the first widget and show the beginning of each text field.
		do
			if ask_for_system_name then
				system_name_field.set_caret_position (1)
			else
				ace_filename_field.set_caret_position (1)
			end
			if not directory_field.text.is_empty then
				directory_field.set_caret_position (1)
			end
			directory_field.set_focus
		end

	check_ace_file (ace_name: STRING) is
			-- Check the existence of the ace file `ace_name', raise exception
			-- if the ace file does not exists or is not readable.
		local
			f: PLAIN_TEXT_FILE
			rescued: BOOLEAN
		do
			if not rescued then
					-- Check the validity of the ace file.
				if ace_name.is_empty then
					add_error_message (Warning_messages.w_Not_a_file (ace_name))
					raise_exception (Invalid_ace_exception)
				end
				create f.make (ace_name)
				if not f.exists or else not f.is_readable then
					add_error_message (Warning_messages.w_Cannot_read_file (ace_name))
					raise_exception (Invalid_ace_exception)
				end
				if not f.is_plain then
					add_error_message (Warning_messages.w_Not_a_file (ace_name))
					raise_exception (Invalid_ace_exception)
				end
			end
		rescue
			if error_messages.is_empty then
					-- Add default error message
				add_error_message (Warning_messages.w_Unable_to_load_ace_file (ace_name))
			end
		end

	browse_directory is
			-- Popup a "select directory" dialog.
		local
			dd: EV_DIRECTORY_DIALOG
			start_directory: STRING
		do
			create dd
			dd.set_title (Interface_names.t_Select_a_directory)
			if directory_field /= Void then
				start_directory := directory_field.text
				if start_directory /= Void and then not start_directory.is_empty then
					start_directory := validate_directory_name (start_directory)
					if start_directory /= Void and then (create {DIRECTORY}.make (start_directory)).exists then
						dd.set_start_directory (start_directory)
					end
				end
			end
			dd.ok_actions.extend (agent retrieve_directory (dd))
			dd.show_modal_to_window (Current)
		end

	browse_ace_file is
			-- Popup a "select file" dialog.
		local
			fod: EV_FILE_OPEN_DIALOG
			existing_path: STRING
		do
			existing_path := directory_field.text
			create fod
			if not existing_path.is_empty then
				fod.set_start_directory (existing_path)
			end
			fod.set_title (Interface_names.t_Select_a_file)
			fod.set_filter ("*.ace")
			fod.open_actions.extend (agent retrieve_ace_file (fod))
			fod.show_modal_to_window (Current)
		end

	check_and_create_directory (a_directory_name: DIRECTORY_NAME) is
			-- Check that the directory `a_directory_name' is valid and exists and MODIFY IT if needed.
			-- If `a_directory_name' is not valid or does not exits, a developper exception is raised.
		local
			new_directory_name: DIRECTORY_NAME
		do
			new_directory_name := validate_directory_name (a_directory_name)
			if new_directory_name = Void then
				raise_exception (Invalid_directory_exception)
			else
					-- Try to create the directory
				recursive_create_directory (new_directory_name)
			end
		rescue
			add_error_message (Warning_messages.w_Invalid_directory_or_cannot_be_created (a_directory_name))
		end

	create_default_directory_name (project_name: STRING): STRING is
			-- Return the proposed directory for project `project_name'
		local
			project_location: STRING
		do
			if
				Eiffel_projects_directory /= Void and then
				not Eiffel_projects_directory.is_empty
			then
				project_location := clone (Eiffel_projects_directory)
			else
				if Platform_constants.is_windows then
					project_location := Default_project_location_for_windows
				else
					project_location := Home
				end
			end
			if project_location @ project_location.count /= Operating_environment.Directory_separator then
				project_location.append_character (Operating_environment.Directory_separator)
			end
			project_location.append (project_name)
			Result := project_location
		end
		

feature {NONE} -- Callbacks

	on_cancel is
			-- User has clicked "Cancel"
		do
			success := False
			destroy
		end
		
	on_ok is
			-- User has clicked "Ok"
		do
			if blank_project_creation then
				create_blank_project
			else
				create_project
			end
		end

	on_change_project_name is
			-- The user has changed the project name, update the project location
		local
			curr_project_location: STRING
			curr_project_name: STRING
			sep_index: INTEGER
		do
			curr_project_location := directory_field.text
			curr_project_name := system_name_field.text
			if not curr_project_location.is_empty then
				sep_index := curr_project_location.last_index_of (Operating_environment.Directory_separator, curr_project_location.count)
				curr_project_location.keep_head (sep_index)
				if curr_project_name /= Void then
					curr_project_location.append (curr_project_name)
				end
	
				directory_field.set_text (curr_project_location)
			end
		end
		
	retrieve_directory (dialog: EV_DIRECTORY_DIALOG) is
			-- Get callback information from `dialog', then send it to the directory field.
		local
			wd: EV_WARNING_DIALOG
			dir_name: STRING
		do
			dir_name := dialog.directory
			if dir_name.is_empty then
				create wd.make_with_text (Warning_messages.w_directory_not_exist (dir_name))
				wd.show_modal_to_window (Current)
			else
				directory_field.set_text (dir_name)
			end
		end

	retrieve_ace_file (dialog: EV_FILE_OPEN_DIALOG) is
			-- Get callback information from `dialog', then send it to the ace file name field.
		local
			cd: EV_CONFIRMATION_DIALOG
			file_name: STRING
		do
			file_name := dialog.file_name
			if file_name.is_empty then
				create cd.make_with_text (Warning_messages.w_Not_a_file_retry (file_name))
				cd.show_modal_to_window (Current)
				if cd.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					browse_ace_file
				end
			else
				ace_filename_field.set_text (file_name)
			end
		end

feature {NONE} -- Private attributes

	blank_project_creation: BOOLEAN
			-- Should we create a blank project when user click "OK"?

	parent_window: EV_WINDOW
			-- Parent window

	ace_file_name: STRING
			-- Name of the ace file to create the project with.

	directory_name: DIRECTORY_NAME
			-- Directory to create the project in.

	system_name: STRING
			-- Name of the system of the project to create.

	suggested_directory_name: STRING
			-- Initial directory (suggestion, can be Void)

	ask_for_system_name: BOOLEAN
			-- Should `build_interface' be built so that it asks for
			-- the system name? (if False, ask for the ace file)
			
	overwrite_project_confirmation_flag: BOOLEAN
			-- Should we display a confirmation dialog before deleting
			-- the EIFGEN?
			
feature {NONE} -- Vision2 architechture

	directory_field: EV_TEXT_FIELD

	system_name_field: EV_TEXT_FIELD
	
	root_class_field: EV_TEXT_FIELD
	
	root_cluster_field: EV_TEXT_FIELD
	
	root_feature_field: EV_TEXT_FIELD
	
	ace_filename_field: EV_TEXT_FIELD
	
	compile_project_check_button: EV_CHECK_BUTTON
	
feature {NONE} -- Constants

	Default_project_name: STRING is "sample"
	
	Default_root_class_name: STRING is "ROOT_CLASS"
	
	Default_root_feature_name: STRING is "make"
	
	Default_root_cluster_name: STRING is "root_cluster"
	
	Default_project_location_for_windows: STRING is "C:\projects"
	
	Invalid_ace_exception: STRING is "Invalid_ace"
	
	Invalid_directory_exception: STRING is "Invalid_directory"
	
	Invalid_project_name_exception: STRING is "Invalid_project_name"

end -- class EB_CREATE_PROJECT_DIALOG

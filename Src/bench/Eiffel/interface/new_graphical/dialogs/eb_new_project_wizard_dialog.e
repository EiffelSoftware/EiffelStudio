indexing
	description	: "Dialog to create a new project using a Wizard"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_NEW_PROJECT_WIZARD_DIALOG

inherit
	EV_DIALOG

	EIFFEL_ENV
		export
			{NONE} all
		undefine
			default_create
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		undefine
			default_create
		end

	COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		export
			{NONE} all
		undefine
			default_create
		end

	EB_ERROR_MANAGER
		export
			{NONE} all
		undefine
			default_create
		end

	EB_GRAPHICAL_ERROR_MANAGER
		export
			{NONE} all
		undefine
			default_create
		end

create
	make

feature {NONE} -- Initialization

	make is	
			-- Initialize the dialog
		do
			load_available_wizards
			build_interface
		end

	build_interface is
			-- Build the interface
		local
			vbox: EV_VERTICAL_BOX
			hbox: EV_HORIZONTAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			message_label: EV_LABEL
			description_frame: EV_FRAME
			description_box: EV_VERTICAL_BOX
		do
			default_create
			set_title ("Choose a wizard")
			set_icon_pixmap (Pixmaps.Default_window_icon)

			create message_label.make_with_text (
				"Choose the type of application you want to create and %N%
				%click OK to start the corresponding wizard.%N%N")
			message_label.align_text_left
			
			create wizards_list
			wizards_list.select_actions.extend (~update_description)
			wizards_list.deselect_actions.extend (~update_description)
			wizards_list.select_actions.extend (~update_ok_button)
			wizards_list.deselect_actions.extend (~update_ok_button)
			wizards_list.set_minimum_height (Layout_constants.dialog_unit_to_pixels (80))
			fill_list_with_available_wizards

			create description_label.make_with_text (No_item_selected_description)
			description_label.align_text_left
			description_label.set_minimum_height (Layout_constants.dialog_unit_to_pixels (50))
			create description_box
			description_box.set_border_width (Layout_constants.Small_border_size)
			description_box.extend (description_label)
			create description_frame.make_with_text ("Description ")
			description_frame.extend (description_box)
		
				--| Action buttons box
			create ok_button.make_with_text_and_action (Interface_names.b_Next, ~on_ok)
			Layout_constants.set_default_size_for_button (ok_button)
			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, ~destroy)
			Layout_constants.set_default_size_for_button (cancel_button)
			create buttons_box
			buttons_box.enable_homogeneous
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.extend (ok_button)
			buttons_box.extend (cancel_button)
			create hbox
			hbox.extend (create {EV_CELL})
			hbox.extend (buttons_box)
			hbox.disable_item_expand (buttons_box)

				-- Build the interface
			create vbox
			vbox.set_border_width (Layout_constants.Default_border_size)
			vbox.set_padding (Layout_constants.Default_padding_size)
			vbox.extend (message_label)
			vbox.disable_item_expand (message_label)
			vbox.extend (wizards_list) -- Expandable item
			vbox.extend (description_frame)
			vbox.disable_item_expand (description_frame)
			vbox.extend (hbox)
			vbox.disable_item_expand (hbox)
			extend (vbox)

				-- Set default buttons
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)

				-- Select the first item in the list.
			wizards_list.start
			if not wizards_list.after then
				wizards_list.item.enable_select
			end

				-- Set the size
			set_size (Layout_constants.dialog_unit_to_pixels (380), Layout_constants.dialog_unit_to_pixels (330))
		end

feature -- Access

	compile_project: BOOLEAN
			-- Should the project be compiled?

	ok_selected: BOOLEAN
			-- Has the user choosen "Ok"?

	cancel_selected: BOOLEAN is
			-- Has the user choosen "Cancel"?
		do
			Result := not ok_selected
		end

feature {NONE} -- Execution

	on_ok is
			-- User has clicked "Ok"
		local
			currently_selected_wizard: EB_NEW_PROJECT_WIZARD
		do
			ok_selected := True
			currently_selected_wizard := selected_wizard
			if currently_selected_wizard /= Void then
				start_wizard (currently_selected_wizard)
			end
		end

	on_cancel is
			-- User has clicked "Cancel"
		do
			ok_selected := False

			destroy
		end

	start_wizard (a_wizard: EB_NEW_PROJECT_WIZARD) is
			-- Start the selected wizard, wait for the wizard to
			-- terminate and load the generated wizard.
		local
			result_parameters: LIST [ARRAY [STRING]]
			ace_filename: STRING
			directory_name: STRING
		do
			compile_project := False
			ok_button.disable_sensitive
			cancel_button.disable_sensitive
			remove_default_cancel_button
			wizards_list.disable_sensitive
			a_wizard.execute
			if a_wizard.successful then
				hide
				destroy
				result_parameters := a_wizard.result_parameters
				from
					result_parameters.start
				until
					result_parameters.after
				loop
					if (result_parameters.item @ 1).is_equal ("ace") then
						ace_filename := clone (result_parameters.item @ 2)
					elseif (result_parameters.item @ 1).is_equal ("directory") then
						directory_name := clone (result_parameters.item @ 2)
					elseif (result_parameters.item @ 1).is_equal ("compilation") then
						(result_parameters.item @ 2).to_lower
						compile_project := (result_parameters.item @ 2).is_equal ("yes")
					elseif (result_parameters.item @ 1).is_equal ("success") then
						-- Do nothing
					else
						check false end -- Invalid parameter!!
					end
					result_parameters.forth
				end

				check
					ace_filename_initialized: ace_filename /= Void
					directory_name_initialized: directory_name /= Void
				end
				create_project (directory_name, ace_filename)
			else
				ok_button.enable_sensitive
				cancel_button.enable_sensitive
				set_default_cancel_button (cancel_button)
				wizards_list.enable_sensitive
			end
		end

	fill_list_with_available_wizards is
			-- Fill in `wizard_list' with the available wizards
		local
			list_item: EV_LIST_ITEM
		do
			if not available_wizards.is_empty then
					-- Add a line per wizard.
				from
					available_wizards.start
				until
					available_wizards.after
				loop
					create list_item.make_with_text (available_wizards.item.name)
					wizards_list.extend (list_item)
					available_wizards.forth
				end
			else
					-- Add a line telling that no wizard is currently installed.
				create list_item.make_with_text (No_wizard_installed)
				wizards_list.extend (list_item)
			end
		end

	load_available_wizards is
			-- Enumerate the available wizards.
		local
			new_project_directory: DIRECTORY
			entries: ARRAYED_LIST [STRING]
			extension: STRING
			wizard: EB_NEW_PROJECT_WIZARD
			filename: FILE_NAME
			retried: BOOLEAN
		do
			if not retried then
				create available_wizards.make
	
				create new_project_directory.make (New_project_wizards_path)
				entries := new_project_directory.linear_representation
				from
					entries.start
				until
					entries.after
				loop
					extension := clone(entries.item)
					extension.tail(4)
	
					if extension.is_equal (".dsc") then
						create filename.make_from_string (New_project_wizards_path)
						filename.extend (entries.item)
						create wizard.make_with_file (filename)
						if wizard.target_platform_supported then
							available_wizards.extend (wizard)
						end						
					end
					entries.forth
				end
			end
		rescue
			add_error_message ("Unable to retrieve the list of installed wizard.")
			display_error_message (Current)
			if catch_exception then
				retried := True
				retry
			end
		end

	create_project (directory_name: STRING; ace_file_name: STRING) is
			-- Create a project in directory `directory_name', with ace file
			-- `ace_file_name'.
		local
			cmd: EB_NEW_PROJECT_COMMAND
			ebench_name: STRING
			last_char: CHARACTER
			ace_name, dir_name: STRING
		do
			ace_name := clone (ace_file_name)
			dir_name := clone (directory_name)

			if dir_name.count > 1 then
				last_char := dir_name.item (dir_name.count)
				if last_char = Operating_environment.Directory_separator then
					dir_name.remove (dir_name.count)
				end
			end
			if not Eiffel_project.initialized then
				create cmd
				cmd.create_project (dir_name, True)
				eiffel_ace.set_file_name (ace_name)
			else
				ebench_name := clone (Ebench_command_name)
				ebench_name.append (" -create ")
				ebench_name.append (dir_name)
				ebench_name.append (" -ace ")
				ebench_name.append (ace_name)
				if compile_project then
					ebench_name.append (" -compile")
					compile_project := False			
				end
				launch_ebench (ebench_name)
			end
		rescue
			set_error_message ("Unable to initialize the project generated by the wizard")
		end

feature {NONE} -- Implementation

	update_ok_button is
			-- Update the sensitiveness of the Ok button
		local
			has_selected_item: BOOLEAN
			ok_button_is_sensitive: BOOLEAN
		do
			has_selected_item := selected_wizard /= Void
			ok_button_is_sensitive := ok_button.is_sensitive

			if has_selected_item and not ok_button_is_sensitive then
				ok_button.enable_sensitive
			elseif not has_selected_item and ok_button_is_sensitive then
				ok_button.disable_sensitive
			end
		end

	update_description is
			-- Update the description for the currently selected wizard
			-- and the state of the "ok" button.
		local
			loc_selected_wizard: EB_NEW_PROJECT_WIZARD
			new_description: STRING
		do
			new_description := No_item_selected_description

			loc_selected_wizard := selected_wizard
			if loc_selected_wizard /= Void then 
					-- Change the description text.
				if loc_selected_wizard.description /= Void then
					new_description := loc_selected_wizard.description
				else
					new_description := No_description
				end
			end
			description_label.set_text (new_description)
		end

	selected_wizard: EB_NEW_PROJECT_WIZARD is
			-- Currently selected wizard.
		local
			selected_item: EV_LIST_ITEM
		do
			selected_item := wizards_list.selected_item
			if selected_item /= Void then
				from
					available_wizards.start
				until
					available_wizards.after or else Result /= Void
				loop
					if (available_wizards.item.name.is_equal (selected_item.text)) then
						Result := available_wizards.item
					end
					available_wizards.forth
				end
			end
		end

feature {NONE} -- Vision2 architechture

	wizards_list: EV_LIST
			-- Widget representing the list of all available wizard.

	available_wizards: LINKED_LIST [EB_NEW_PROJECT_WIZARD]
			-- All available wizards.

	description_label: EV_LABEL
			-- Description for the currently selected wizard.

	ok_button: EV_BUTTON
			-- Ok button of the dialog.

	cancel_button: EV_BUTTON
			-- Cancel button of the dialog.

feature {NONE} -- Constants

	No_wizard_installed: STRING is "No wizard is currently installed for this platform."
			-- List item text when no wizard is installed for the platform.

	No_item_selected_description: STRING is "Select an item to view its description."
			-- Description when no wizard is currently selected.

	No_description: STRING is "No description is available for this wizard"
			-- Description when no description is available.

end -- class EB_CREATE_PROJECT_DIALOG

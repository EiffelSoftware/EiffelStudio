indexing
	description	: "Dialog displayed at startup of $EiffelGraphicalCompiler$"
	author		: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_STARTING_DIALOG

inherit
	EV_DIALOG
		export
			{NONE} all
		redefine
			show_modal_to_window,
			destroy
		end
		
	EV_DIALOG_CONSTANTS
		export
			{NONE} All
		undefine
			copy,
			default_create
		end

	EB_SHARED_MANAGERS
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

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_GENERAL_DATA
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EB_VISION2_FACILITIES
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

	COMMAND_EXECUTOR
		rename
			execute as launch_ebench
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_default,
	make_without_open_project_frame

feature {NONE} -- Initialization

	make_default is
			-- Initialize the dialog with a regular layout (Create/Open project)
		do
			show_open_project_frame := True
			build_interface
		end
	
	make_without_open_project_frame is
			-- Initialize the dialog with the "Create Project" frame only.
		do
			show_open_project_frame := False
			build_interface
		end
		
	build_interface is
			-- Initialize
		local
			new_project_vb, open_project_vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			new_project_frame, open_project_frame: EV_FRAME
			main_container: EV_VERTICAL_BOX
		do
			default_create
			set_title (Interface_names.t_Starting_dialog)
			set_icon_pixmap (Pixmaps.Icon_dialog_window)
			
				-- New projects item
			create new_project_frame
			create new_project_vb
			new_project_vb.set_border_width (Layout_constants.Small_border_size)
			new_project_vb.set_padding (Layout_constants.Default_border_size)
			create wizard_rb.make_with_text (Interface_names.l_Use_wizard)
			add_option_box (clone (Pixmaps.Icon_wizard_project), wizard_rb, new_project_vb)
			create_and_fill_wizards_list
			new_project_vb.extend (wizards_list)
			new_project_frame.extend (new_project_vb)

				-- Open projects item
			create open_project_frame.make_with_text (Interface_names.l_Open_project)
			create open_project_vb
			open_project_vb.set_border_width (Layout_constants.Small_border_size)
			open_project_vb.set_padding (Layout_constants.Default_border_size)
			create open_ace_file_rb.make_with_text (Interface_names.l_Use_existing_ace)
			add_option_box (clone (Pixmaps.Icon_wizard_ace_project), open_ace_file_rb, open_project_vb)

			if show_open_project_frame then
				create open_epr_project_rb.make_with_text (Interface_names.l_Open_an_existing_project)
				create browse_button.make_with_text_and_action (Interface_names.b_Browse, agent open_existing_project_not_listed)
				add_option_box_and_button (clone (Pixmaps.Icon_open_project), open_epr_project_rb, browse_button, open_project_vb)
				create_and_fill_compiled_projects_list
				open_project_vb.extend (compiled_projects_list)
			end

			open_project_frame.extend (open_project_vb)

				--| Option buttons
			if show_open_project_frame then
				create do_not_display_dialog_button.make_with_text (Interface_names.l_Discard_starting_dialog)
				create vb
				vb.extend (do_not_display_dialog_button)
				vb.disable_item_expand (do_not_display_dialog_button)
				vb.extend (create {EV_CELL})
			end	
			
				--| Action buttons box
			create ok_button
			if show_open_project_frame then
				ok_button.set_text (Interface_names.b_Ok)
			else
				ok_button.set_text (Interface_names.b_Next)
			end				
			ok_button.select_actions.extend (agent on_ok)
			Layout_constants.set_default_size_for_button (ok_button)
			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, agent on_cancel)
			Layout_constants.set_default_size_for_button (cancel_button)
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.enable_homogeneous
			buttons_box.extend (ok_button)
			buttons_box.extend (cancel_button)
			create hb
			hb.extend (create {EV_CELL})
			hb.extend (buttons_box)
			hb.disable_item_expand (buttons_box)

				-- General layout
			create main_container
			main_container.set_border_width (Layout_constants.Small_border_size)
			main_container.set_padding (Layout_constants.Small_border_size)
			main_container.extend (new_project_frame)
			main_container.extend (open_project_frame)
			if show_open_project_frame then
				main_container.extend (vb)
				main_container.disable_item_expand (vb)
			else
				main_container.disable_item_expand (open_project_frame)
			end
			main_container.extend (hb)
			main_container.disable_item_expand (hb)
			extend (main_container)

			open_project_vb.merge_radio_button_groups (new_project_vb)
			wizard_rb.select_actions.extend (agent lookup_selection)
			open_ace_file_rb.select_actions.extend (agent lookup_selection)

				--| Connect buttons together
			if show_open_project_frame then
				open_epr_project_rb.select_actions.extend (agent lookup_selection)

				compiled_projects_list.pointer_double_press_actions.extend (agent dbl_clk_action)
				
				if show_starting_dialog then
					do_not_display_dialog_button.disable_select
				else
					do_not_display_dialog_button.enable_select
				end
			end
			
				--| Setting default buttons
			set_default_push_button (ok_button)
			set_default_cancel_button (cancel_button)
			ok_selected := False
			
				--| Set the initial size of the dialog.
			if show_open_project_frame then
				set_size (Layout_constants.dialog_unit_to_pixels(340), Layout_constants.dialog_unit_to_pixels(440))
			else
				set_size (Layout_constants.dialog_unit_to_pixels(340), Layout_constants.dialog_unit_to_pixels(270))
			end
			
				--| Select the default item
			if show_open_project_frame then 
				if compiled_projects_list.is_empty then
					wizard_rb.enable_select
				else
					open_epr_project_rb.enable_select
				end
			else
				wizard_rb.enable_select
			end
		end

	add_option_box (a_pixmap: EV_PIXMAP; a_radio_button: EV_RADIO_BUTTON; a_container: EV_BOX) is
			-- Add a box representing an option to `a_container'.
			--
			--   --------    -
			--  | PIXMAP |  |x| Label
			--   --------    -
		local
			hb: EV_HORIZONTAL_BOX
		do
				-- Connect the radio button with `ok_ok' via the wrapper `on_double_click_radio_button'
			a_radio_button.pointer_double_press_actions.extend (agent on_double_click_radio_button)
	
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			a_pixmap.set_minimum_size (32, 32)
			hb.extend (a_pixmap)
			hb.disable_item_expand (a_pixmap)
			hb.extend (a_radio_button)
			
			a_container.extend (hb)
			a_container.disable_item_expand (hb)
			a_container.merge_radio_button_groups (hb)
		end

	add_option_box_and_button (a_pixmap: EV_PIXMAP; a_radio_button: EV_RADIO_BUTTON; a_button: EV_BUTTON; a_container: EV_BOX) is
			-- Add a box representing an option to `a_container'.
			--
			--   --------    -         --------
			--  | PIXMAP |  |x| Label | Button |
			--   --------    -         --------
		local
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
			Layout_constants.set_default_size_for_button (a_button)
			create vb
			vb.extend (create {EV_CELL})
			vb.extend (a_button)
			vb.disable_item_expand (a_button)
			vb.extend (create {EV_CELL})
			
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			a_pixmap.set_minimum_size (32, 32)
			hb.extend (a_pixmap)
			hb.disable_item_expand (a_pixmap)
			hb.extend (a_radio_button)
			hb.disable_item_expand (a_radio_button)
			hb.extend (vb)
			hb.disable_item_expand (vb)
			hb.extend (create {EV_CELL})
			
			a_container.extend (hb)
			a_container.disable_item_expand (hb)
			a_container.merge_radio_button_groups (hb)
		end

feature -- Status report

	ok_selected: BOOLEAN
			-- Has the button "OK" been selected?

	cancel_selected: BOOLEAN is
			-- Has the button "Cancel" been selected?
		do
			Result := not ok_selected
		end

feature -- Basic operations
	
	show_modal_to_window (a_window: EV_WINDOW) is
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		do
			parent_window := a_window
			Precursor (a_window)
			parent_window := Void
		end

feature {NONE} -- Execution

	destroy is
			-- 
		do
			if not controls_disabled then
				Precursor
			end
		end
		
	on_cancel is
			-- Cancel button has been pressed
		do
			ok_selected := False
			destroy
			update_preferences
		end

	on_ok is
			-- Ok button has been pressed
		do
			ok_selected := True

				-- Create a new project using an ISE Wizard
			if wizard_rb.is_selected then
				create_new_project_using_wizard

				-- Create a new project using an existing ace file
			elseif open_ace_file_rb.is_selected then
				create_new_project_using_ace_file

				-- Open an existing project
			elseif open_epr_project_rb.is_selected then
				open_existing_project_current_selection

			else
				check no_item_selected: False end
			end

			if compile_project then
				window_manager.last_focused_development_window.Melt_project_cmd.execute
			end

			update_preferences
		end
		
	on_double_click_radio_button (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER; a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE; a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- A radio button has been double clicked
		do
				-- Execute the selected radio button
			on_ok
		end

	create_new_project_using_ace_file is
			-- Create a new project using an existing ace file.
		local
			file_dialog: EV_FILE_OPEN_DIALOG
			success: BOOLEAN
			create_project_dialog: EB_CREATE_PROJECT_DIALOG
			default_project_directory: STRING
		do
			create file_dialog
			file_dialog.set_title (Interface_names.t_Choose_ace_file)
			file_dialog.set_filter ("*.ace")
			default_project_directory := clone (Eiffel_projects_directory)
			if default_project_directory /= Void then
				file_dialog.set_start_directory (default_project_directory)
			end
			file_dialog.show_modal_to_window (Current)

			success := file_dialog.selected_button.is_equal(ev_open)
			if success then
				create create_project_dialog.make_with_ace (Current, file_dialog.file_name, file_dialog.file_path)
				create_project_dialog.show_modal_to_parent
				success := create_project_dialog.success
			end

				-- Destroy the current dialog if `create_project_dialog'
				-- was successful, go on displaying this dialog otherwise.
			if success then
				destroy
				compile_project := create_project_dialog.compile_project
			end
		end

	create_blank_project is
			-- Create a new blank project.
		local
			create_project_dialog: EB_CREATE_PROJECT_DIALOG
		do
			create create_project_dialog.make_blank (parent_window)
			hide
			create_project_dialog.show_modal_to_parent

				-- Destroy the current dialog if `create_project_dialog'
				-- was successful, go on displaying this dialog otherwise.
			if create_project_dialog.success then
				destroy
				compile_project := create_project_dialog.compile_project
			else
				show_modal_to_window (parent_window)
			end
		end

	create_new_project_using_wizard is
			-- Create a new project using the ISE Wizard.
		local
			li: EV_LIST_ITEM
			wd: EV_WARNING_DIALOG
			currently_selected_wizard: EB_NEW_PROJECT_WIZARD
			selected_item_text: STRING
		do
			li := wizards_list.selected_item
			if li /= Void then
				selected_item_text := li.text
				if selected_item_text.is_equal (Interface_names.l_Basic_application) then
						-- Create a blank project
					create_blank_project
				else
					currently_selected_wizard := selected_wizard
					if currently_selected_wizard /= Void then
						start_wizard (currently_selected_wizard)
					end
				end
			else
				create wd.make_with_text (Warning_messages.w_Select_project_to_create)
				wd.show_modal_to_window (Current)
			end
		end

	open_existing_project_current_selection is
			-- Load the currently selected project (.epr).
		local
			li: EV_LIST_ITEM
			open_project_cmd: EB_OPEN_PROJECT_COMMAND
			wd: EV_WARNING_DIALOG
		do
			li := compiled_projects_list.selected_item
			if li /= Void then
				create open_project_cmd.make_with_parent (parent_window)
				hide
				set_pointer_style (Pixmaps.Wait_cursor)
				open_project_cmd.execute_with_file (li.text)
				set_pointer_style (Pixmaps.standard_cursor)

				if Eiffel_project.initialized then
					destroy
				else
					show_modal_to_window (parent_window)
				end
			else
				create wd.make_with_text (Warning_messages.w_Select_project_to_load)
				wd.show_modal_to_window (Current)
			end

			compile_project := False
		end
		
	open_existing_project_not_listed is
			-- Open a non listed existing project
		local
			open_project_cmd: EB_OPEN_PROJECT_COMMAND
		do
			create open_project_cmd.make_with_parent (Current)
			open_project_cmd.execute

			if Eiffel_project.initialized then
				destroy
			end

			compile_project := False
		end

	lookup_selection is
			-- Look at the selection and enable/disable some items.
		do
			if show_open_project_frame then
				if open_epr_project_rb.is_selected then
					compiled_projects_list.enable_sensitive
					browse_button.enable_sensitive
					ok_button.set_text (Interface_names.b_Ok)
				else
					compiled_projects_list.disable_sensitive
					browse_button.disable_sensitive
					ok_button.set_text (Interface_names.b_Next)
				end
			end
			if wizard_rb.is_selected then
				wizards_list.enable_sensitive
			else
				wizards_list.disable_sensitive
			end
		end

feature {NONE} -- Implementation

	compile_project: BOOLEAN
			-- Should a compilation be launched upon completion of this dialog?
			
	update_preferences is
			-- Update user preferences
		do
			if show_open_project_frame then
				save_show_starting_dialog (not do_not_display_dialog_button.is_selected)
			end
		end

	dbl_clk_action (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER;
					a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE;
					a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Action performed when the list is double-clicked.
		do
			if a_button = 1 then
				on_ok
			end
		end

	create_and_fill_wizards_list is
			-- Create and fill `wizards_list'
		local
			retried: BOOLEAN
		do
			create wizards_list
			wizards_list.set_minimum_height (layout_constants.dialog_unit_to_pixels (80))
			
			if not retried then
				load_available_wizards
				fill_list_with_available_wizards
			end
		ensure
			wizards_list_created: wizards_list /= Void
		rescue
			retried := True
			retry
		end
			
	create_and_fill_compiled_projects_list is
			-- Create and fill `compiled_projects_list'
		local
			lop: ARRAYED_LIST [STRING]
			li: EV_LIST_ITEM
			retried: BOOLEAN
			project_exist: BOOLEAN
		do
			create compiled_projects_list
			compiled_projects_list.set_minimum_height (Layout_constants.Dialog_unit_to_pixels(80))
	
			if not retried then
				lop := recent_projects_manager.recent_projects
				if not lop.is_empty then
					from
						lop.start
					until
						lop.after
					loop
						if exists_project (lop.item) then
							project_exist := True
							create li.make_with_text (lop.item)
							compiled_projects_list.extend (li)
						end
						lop.forth
					end
					if project_exist then
						compiled_projects_list.i_th (1).enable_select
					end
				end
			end
		ensure
			compiled_projects_list_created: compiled_projects_list /= Void
		rescue
			retried := True
			retry
		end
		
	exists_project (a_project_path: STRING): BOOLEAN is
			-- Does the project `a_project_path' exists?
		local
			a_project_filename: FILE_NAME
			a_project_file: RAW_FILE
		do
			create a_project_filename.make_from_string (a_project_path)
			create a_project_file.make (a_project_filename)
			Result := a_project_file.exists and then a_project_file.is_readable
		end

	fill_list_with_available_wizards is
			-- Fill in `wizard_list' with the available wizards
		local
			list_item: EV_LIST_ITEM
			basic_application_item: EV_LIST_ITEM
		do
				-- Add the "blank project" item
			create basic_application_item.make_with_text (Interface_names.l_Basic_application)
			wizards_list.extend (basic_application_item)

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
			
			basic_application_item.enable_select
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
	
				create new_project_directory.make ((create {EIFFEL_ENV}).New_project_wizards_path)
				entries := new_project_directory.linear_representation
				from
					entries.start
				until
					entries.after
				loop
					extension := clone(entries.item)
					extension.keep_tail(4)
	
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
				create cmd.make_with_parent (Current)
				cmd.create_project (dir_name, True)
				eiffel_ace.set_file_name (ace_name)
			else
				ebench_name := clone (Estudio_command_name)
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

	start_wizard (a_wizard: EB_NEW_PROJECT_WIZARD) is
			-- Start the selected wizard, wait for the wizard to
			-- terminate and load the generated wizard.
		local
			result_parameters: LIST [ARRAY [STRING]]
			ace_filename: STRING
			directory_name: STRING
			retried: BOOLEAN
		do
			if not retried then
				compile_project := False

					-- Disable all controls
				disable_all_controls

					-- Execute the wizard
				a_wizard.execute
				
					-- Enable controls
				enable_all_controls

				if a_wizard.successful then
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
					destroy
				end
			else
				enable_all_controls
				compile_project := False
				if not error_messages.is_empty then
					display_error_message (Current)
				end
			end
		rescue
			retried := True
			retry
		end
		
	disable_all_controls is
			-- Disable all controls in the window
		do
			ok_button.disable_sensitive
			cancel_button.disable_sensitive
			open_ace_file_rb.disable_sensitive
			wizard_rb.disable_sensitive
			wizards_list.disable_sensitive
			if show_open_project_frame then
				open_epr_project_rb.disable_sensitive
				compiled_projects_list.disable_sensitive
				do_not_display_dialog_button.disable_sensitive
			end
			controls_disabled := True
		end
		
	enable_all_controls is
			-- Enable all controls in the window
		do
			ok_button.enable_sensitive
			cancel_button.enable_sensitive
			open_ace_file_rb.enable_sensitive
			wizard_rb.enable_sensitive
			wizards_list.enable_sensitive
			if show_open_project_frame then
				open_epr_project_rb.enable_sensitive
				compiled_projects_list.enable_sensitive
				do_not_display_dialog_button.enable_sensitive
			end
			controls_disabled := False
		end
		
feature {NONE} -- Private attributes

	controls_disabled: BOOLEAN
			-- Are all control disabled?

	available_wizards: LINKED_LIST [EB_NEW_PROJECT_WIZARD]
			-- All available wizards.

	show_open_project_frame: BOOLEAN
			-- Show the "Open project" frame.

	wizard_rb: EV_RADIO_BUTTON
			-- Radio button for "ISE Wizard"
	
	browse_button: EV_BUTTON
			-- Browse button to browse for existing projects
			
	open_ace_file_rb: EV_RADIO_BUTTON
			-- Radio button for "Ace file"

	open_epr_project_rb: EV_RADIO_BUTTON
			-- Radio button for "Open an existing project"

	do_not_display_dialog_button: EV_CHECK_BUTTON
			-- Check button labeled "Don't show this dialog at start-up"
			
	ok_button: EV_BUTTON
			-- OK/Next button
		
	cancel_button: EV_BUTTON
			-- Cancel button
	
	compiled_projects_list: EV_LIST
			-- List containing the last opened projects.
			
	wizards_list: EV_LIST
			-- Widget representing the list of all available wizard.
	
	parent_window: EV_WINDOW
			-- Parent window, Void if none.

end -- class EB_STARTING_DIALOG

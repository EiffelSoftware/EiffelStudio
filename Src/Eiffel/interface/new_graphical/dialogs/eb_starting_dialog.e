note
	description: "Dialog displayed at startup of $EiffelGraphicalCompiler$"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_STARTING_DIALOG

inherit
	EB_DIALOG
		redefine
			show_modal_to_window
		end

	EV_DIALOG_CONSTANTS
		export
			{NONE} all
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

	EB_SHARED_PREFERENCES
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

	FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		undefine
			default_create, copy
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		undefine
			default_create, copy
		end

create
	make_default,
	make_without_open_project_frame

feature {NONE} -- Initialization

	make_default
			-- Initialize the dialog with a regular layout (Create/Open project)
		do
			show_open_project_frame := True
			incoming_command_manager.notify_created_starting_dialog (Current)
			build_interface
		end

	make_without_open_project_frame
			-- Initialize the dialog with the "Create Project" frame only.
		do
			show_open_project_frame := False
			incoming_command_manager.notify_created_starting_dialog (Current)
			build_interface
		end

	build_interface
			-- Initialize
		local
			new_project_vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			l_frame: EV_FRAME
			main_container: EV_VERTICAL_BOX
		do
			default_create
			set_title (Interface_names.t_Starting_dialog)

			create main_container
			create ok_button

			main_container.set_border_width (Layout_constants.Small_border_size)
			main_container.set_padding (Layout_constants.Small_border_size)

				-- New projects item
			create new_project_vb
			new_project_vb.set_border_width (Layout_constants.Small_border_size)
			new_project_vb.set_padding (Layout_constants.Default_border_size)
			create_and_fill_wizards_list
			create vb
			vb.set_border_width (1)
			vb.set_background_color ((create {EV_STOCK_COLORS}).black)
			vb.extend (wizards_list)
			new_project_vb.extend (vb)
			create l_frame.make_with_text (interface_names.l_use_wizard)
			l_frame.extend (new_project_vb)
			main_container.extend (l_frame)
			if show_open_project_frame then
				main_container.disable_item_expand (l_frame)
			end

				-- General layout
			if show_open_project_frame then
				create vb
				create open_project.make (Current)
				wizards_list.row_select_actions.extend (agent on_wizards_selected)
				wizards_list.row_deselect_actions.extend (agent on_item_deselected)
				open_project.select_actions.extend (agent on_project_selected)
				open_project.deselect_actions.extend (agent on_item_deselected)

				vb.extend (open_project.widget)

				create l_frame.make_with_text (Interface_names.l_open_project)
				l_frame.extend (vb)
				main_container.extend (l_frame)

					--| Option buttons
				create hb
				create do_not_display_dialog_button.make_with_text (Interface_names.l_Discard_starting_dialog)
				hb.extend (do_not_display_dialog_button)
				hb.disable_item_expand (do_not_display_dialog_button)
				hb.extend (create {EV_CELL})
				main_container.extend (hb)
				main_container.disable_item_expand (hb)

				set_icon_pixmap (pixmaps.icon_pixmaps.general_dialog_icon)
			end

				--| Action buttons box
			ok_button.select_actions.extend (agent on_ok)
			ok_button.set_pixmap (pixmaps.icon_pixmaps.general_open_icon)

			create cancel_button.make_with_text_and_action (Interface_names.b_Cancel, agent on_cancel)
			Layout_constants.set_default_width_for_button (cancel_button)
			create buttons_box
			buttons_box.set_padding (Layout_constants.Small_padding_size)
			buttons_box.enable_homogeneous
			buttons_box.extend (ok_button)
			buttons_box.extend (cancel_button)
			create hb
			hb.extend (create {EV_CELL})
			hb.extend (buttons_box)
			hb.disable_item_expand (buttons_box)
			main_container.extend (hb)
			main_container.disable_item_expand (hb)
			extend (main_container)

				--| Connect buttons together
			if show_open_project_frame then
				if preferences.dialog_data.show_starting_dialog then
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
				set_size (preferences.dialog_data.starting_dialog_width,
					preferences.dialog_data.starting_dialog_height)
			else
				set_width (Layout_constants.dialog_unit_to_pixels(440))
			end

				--| Select the default item
			if show_open_project_frame then
				if open_project.is_empty then
					open_project.remove_selection
					show_actions.extend (agent wizards_list.set_focus)
					ok_button.set_text (Interface_names.b_create)
				else
					wizards_list.remove_selection
					show_actions.extend (agent open_project.set_focus)
					ok_button.set_text (Interface_names.b_open)
				end
			else
				ok_button.set_text (Interface_names.b_create)
			end
			Layout_constants.set_default_width_for_button (ok_button)
		end

feature -- Status report

	ok_selected: BOOLEAN
			-- Has the button "OK" been selected?

	cancel_selected: BOOLEAN
			-- Has the button "Cancel" been selected?
		do
			Result := not ok_selected
		end

feature -- Basic operations

	show_modal_to_window (a_window: EV_WINDOW)
			-- Show and wait until `Current' is closed.
			-- `Current' is shown modal with respect to `a_window'.
		do
			parent_window := a_window
			Precursor (a_window)
			parent_window := Void
		end

feature {NONE} -- Execution

	on_cancel
			-- Cancel button has been pressed
		do
			ok_selected := False
			update_preferences
			destroy
			incoming_command_manager.notify_closing_starting_dialog
		end

	on_item_deselected (a_row: EV_GRID_ROW)
			-- Handle case when an item has been deselected and whether or not
			-- the `OK' button should be activated.
		do
			if not wizards_list.has_selected_row and then not open_project.has_selected_item then
				ok_button.disable_sensitive
			else
				ok_button.enable_sensitive
			end
		end

	on_ok
			-- Ok button has been pressed
		do
			update_preferences
			ok_selected := True
				-- Create a new project using an ISE Wizard
			if wizards_list.has_selected_row then
				check parent_window_not_void: parent_window /= Void end
				create_new_project_using_wizard

				-- Open an existing project
			elseif open_project.has_selected_item and not open_project.has_error then
				open_project.open_project

			else
				check no_item_selected: False end
			end
			incoming_command_manager.notify_closing_starting_dialog

		end

	on_double_click (a_x: INTEGER; a_y: INTEGER; a_button: INTEGER;
					a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE;
					a_screen_x: INTEGER; a_screen_y: INTEGER)
			-- A radio button has been double clicked
		do
				-- Execute the selected radio button
			if a_button = 1 then
				on_ok
			end
		end

	on_wizards_selected (a_row: EV_GRID_ROW)
			-- Items in the wizards are selected.
		do
			open_project.remove_selection
			ok_button.set_text (interface_names.b_create)
			ok_button.enable_sensitive
		end

	on_project_selected
			-- Items in the project list selected.
		do
			wizards_list.remove_selection
			ok_button.set_text (interface_names.b_open)
			if not open_project.has_error then
				ok_button.enable_sensitive
			else
				ok_button.disable_sensitive
			end
		end

	create_blank_project
			-- Create a new blank project.
		require
			parent_window_not_void: parent_window /= Void
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

	create_new_project_using_wizard
			-- Create a new project using the ISE Wizard.
		require
			parent_window_not_void: parent_window /= Void
		local
			currently_selected_wizard: EB_NEW_PROJECT_WIZARD
		do
			if wizards_list.has_selected_row then
				if
					attached {EV_GRID_LABEL_ITEM} wizards_list.selected_rows.first.item (1) as li and then
					li.text.is_equal (Interface_names.l_basic_application)
				then
						-- Create a blank project
					create_blank_project
				else
					currently_selected_wizard := selected_wizard
					if currently_selected_wizard /= Void then
						start_wizard (currently_selected_wizard)
					end
				end
			else
				prompts.show_error_prompt (Warning_messages.w_Select_project_to_create, Current, Void)
			end
		end

feature {NONE} -- Implementation

	compile_project, freeze_project: BOOLEAN
			-- Should a compilation be launched upon completion of this dialog and possible frozen?

	update_preferences
			-- Update user preferences
		do
			if show_open_project_frame then
				preferences.dialog_data.show_starting_dialog_preference.set_value (not do_not_display_dialog_button.is_selected)
				preferences.dialog_data.starting_dialog_width_preference.set_value (width)
				preferences.dialog_data.starting_dialog_height_preference.set_value (height)
			end
		end

	create_and_fill_wizards_list
			-- Create and fill `wizards_list'
		do
			create wizards_list
			wizards_list.hide_header
			wizards_list.enable_single_row_selection

			load_available_wizards
			fill_list_with_available_wizards

				-- Add +1 to number of rows because on Unix it has the side effect to show/hide
				-- the scrollbards of the grid eventhough it is not necessary.
			wizards_list.set_minimum_height (((wizards_list.row_count + 1).min (10)) * wizards_list.row_height)
		ensure
			wizards_list_created: wizards_list /= Void
		end

	fill_list_with_available_wizards
			-- Fill in `wizard_list' with the available wizards
		local
			list_item: EV_GRID_LABEL_ITEM
			basic_application_item: EV_GRID_LABEL_ITEM
			l_column: EV_GRID_COLUMN
			i: INTEGER
		do
				-- Add the "blank project" item
			create basic_application_item.make_with_text (Interface_names.l_basic_application)
			basic_application_item.set_pixmap (pixmaps.icon_pixmaps.new_eiffel_project_icon)
			basic_application_item.pointer_double_press_actions.extend (agent on_double_click)
			wizards_list.set_item (1, 1, basic_application_item)

				-- Add a line per wizard.
			from
				available_wizards.start
				i := 2
			until
				available_wizards.after
			loop
					-- We have extracted names from .des files for internationalization.
				create list_item.make_with_text (try_to_translate_wizard (available_wizards.item.name))
				list_item.set_pixmap (pixmaps.icon_pixmaps.new_eiffel_project_icon)
				list_item.pointer_double_press_actions.extend (agent on_double_click)
				wizards_list.set_item (1, i, list_item)
				i := i + 1
				available_wizards.forth
			end

			basic_application_item.enable_select

			l_column := wizards_list.column (1)
			l_column.set_width (l_column.required_width_of_item_span (1, wizards_list.row_count))
		end

	load_available_wizards
			-- Enumerate the available wizards.
		local
			new_project_directory: DIRECTORY
			entries: ARRAYED_LIST [PATH]
			l_entry: PATH
			wizard: EB_NEW_PROJECT_WIZARD
			retried: BOOLEAN
		do
			if not retried then
				create available_wizards.make

				create new_project_directory.make_with_path (eiffel_layout.new_project_wizards_path)
				entries := new_project_directory.entries
				from
					entries.start
				until
					entries.after
				loop
					l_entry := entries.item
					if l_entry.has_extension ("dsc") then
						create wizard.make_with_file (eiffel_layout.new_project_wizards_path.extended_path (l_entry))
						if wizard.target_platform_supported then
							available_wizards.extend (wizard)
						end
					end
					entries.forth
				end
			end
		rescue
			add_error_message (warning_messages.w_unable_to_retrieve_wizard_list)
			display_error_message (Current)
			if catch_exception then
				retried := True
				retry
			end
		end

	selected_wizard: EB_NEW_PROJECT_WIZARD
			-- Currently selected wizard.
		do
			if
				wizards_list.has_selected_row and then
				attached {EV_GRID_LABEL_ITEM} wizards_list.selected_rows.first.item (1) as selected_item
			then
				from
					available_wizards.start
				until
					available_wizards.after or else Result /= Void
				loop
						-- Items in wizard list are translated, thus the check has
						-- to be done on the translated name
					if try_to_translate_wizard (available_wizards.item.name).same_string (selected_item.text) then
						Result := available_wizards.item
					end
					available_wizards.forth
				end
			end
		end

	create_project (directory_name, ace_file_name: PATH)
			-- Create a project in directory `directory_name', with ace file
			-- `ace_file_name'.
		require
			directory_name_not_void: directory_name /= Void
			ace_file_name_not_void: ace_file_name /= Void
		local
			l_loader: EB_GRAPHICAL_PROJECT_LOADER
			ebench_name: STRING_32
			ace_name, dir_name: PATH
		do
			ace_name := ace_file_name
			dir_name := directory_name

			if not Eiffel_project.initialized then
				create l_loader.make (Current)
				l_loader.set_is_project_location_requested (False)
				l_loader.open_project_file (ace_file_name, Void, directory_name, True, Void)
				if not l_loader.has_error and then compile_project then
					l_loader.set_is_compilation_requested (compile_project)
					if freeze_project then
						l_loader.freeze_project (False)
					else
						l_loader.melt_project (False)
					end
				end
			else
				ebench_name := eiffel_layout.studio_command_line (ace_name, Void, dir_name, True, True)
				if compile_project then
					if freeze_project then
						ebench_name.append_string_general (" -freeze")
					else
						ebench_name.append_string_general (" -melt")
					end
					compile_project := False
				end
				launch_ebench (ebench_name)
			end
		rescue
			set_error_message (warning_messages.w_unable_to_initiate_project)
		end

	start_wizard (a_wizard: EB_NEW_PROJECT_WIZARD)
			-- Start the selected wizard, wait for the wizard to
			-- terminate and load the generated wizard.
		local
			result_parameters: LIST [TUPLE [name: STRING_32; value: STRING_32]]
			ace_filename, directory_name: PATH
			retried: BOOLEAN
		do
			if not retried then
				compile_project := False
				freeze_project := False

					-- Disable all controls
				disable_sensitive

					-- Execute the wizard
				a_wizard.execute

					-- Enable controls
				enable_sensitive

				if a_wizard.successful then
					result_parameters := a_wizard.result_parameters
					from
						result_parameters.start
					until
						result_parameters.after
					loop
						if result_parameters.item.name.is_equal ("ace") then
							create ace_filename.make_from_string (result_parameters.item.value)
						elseif result_parameters.item.name.is_equal ("directory") then
							create directory_name.make_from_string (result_parameters.item.value)
						elseif result_parameters.item.name.is_equal ("compilation") then
							compile_project := result_parameters.item.value.is_case_insensitive_equal_general ("yes")
						elseif result_parameters.item.name.is_equal ("compilation_type") then
							freeze_project := result_parameters.item.value.is_case_insensitive_equal_general ("freeze")
						elseif result_parameters.item.name.is_equal ("success") then
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
				enable_sensitive
				compile_project := False
				if not error_messages.is_empty then
					display_error_message (Current)
				end
			end
		rescue
			retried := True
			retry
		end

	try_to_translate_wizard (a_name: READABLE_STRING_GENERAL): STRING_32
			-- Try to find translation in wizard context.
		require
			a_name_set: a_name /= Void
		do
			Result := interface_names.locale.translation_in_context (a_name, "wizard")
		ensure
			Result_set: Result /= Void
		end

feature {NONE} -- Private attributes

	controls_disabled: BOOLEAN
			-- Are all control disabled?

	available_wizards: LINKED_LIST [EB_NEW_PROJECT_WIZARD]
			-- All available wizards.

	show_open_project_frame: BOOLEAN
			-- Show the "Open project" frame.

	do_not_display_dialog_button: EV_CHECK_BUTTON
			-- Check button labeled "Don't show this dialog at start-up"

	ok_button: EV_BUTTON
			-- OK/Next button

	cancel_button: EV_BUTTON
			-- Cancel button

	wizards_list: ES_GRID
			-- Widget representing the list of all available wizard.

	parent_window: EV_WINDOW
			-- Parent window, Void if none.

	open_project: EB_OPEN_PROJECT_WIDGET;
			-- Widget for opening a project using a config file.

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

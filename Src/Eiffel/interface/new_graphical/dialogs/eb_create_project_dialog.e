﻿note
	description: "Command to create a new project"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Arnaud PICHERY [aranud@mail.dotcom.fr]"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CREATE_PROJECT_DIALOG

inherit
	EB_DIALOG

	EB_SHARED_PREFERENCES
		undefine
			default_create, copy
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

	EB_COMMAND_EXECUTOR
		rename
			execute as launch_ebench,
			project_location as compiler_project_location
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

	EB_FILE_DIALOG_CONSTANTS
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
	make_blank,
	make_with_ace

feature {NONE} -- Initialization

	make_blank (a_parent_window: EV_WINDOW)
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

	make_with_ace (a_parent_window: EV_WINDOW; ace_name: PATH; a_suggested_directory_name: PATH)
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

feature -- Access

	compile_project: BOOLEAN
			-- Should the generated project be compiled?

	success: BOOLEAN
			-- Was last operation sucessful?

	project_location: PATH
			-- Location for selected project
		require
			success: success
		do
			create Result.make_from_string (directory_field.text)
		ensure
			project_location_not_void: Result /= Void
		end

feature -- Execution

	show_modal_to_parent
			-- Show `Current' modal to `parent_window' provided in creation procedure.
		do
			show_modal_to_window (parent_window)
		end

	create_blank_project
			-- Create a blank project in directory `directory_name'.
		local
			blank_project_builder: BLANK_PROJECT_BUILDER
			retried: BOOLEAN
			cla, clu, f: STRING_32
			sc: EIFFEL_SYNTAX_CHECKER
			l_project_loader: EB_GRAPHICAL_PROJECT_LOADER
			l_project_initialized: BOOLEAN
		do
			success := False
			if not retried then
				create sc
					-- Retrieve System parameters
				if directory_field.text = Void or else directory_field.text.is_empty then
					add_error_message (Warning_messages.w_fill_in_location_field)
					raise_exception (Invalid_directory_exception)
				end
				create directory_name.make_from_string (directory_field.text)
				check_and_create_directory (directory_name)

				system_name := system_name_field.text
				if not sc.is_valid_system_name (system_name) then
					add_error_message (Warning_messages.w_fill_in_project_name_field)
					raise_exception (Invalid_project_name_exception)
				end
				cla := root_class_field.text
				cla.to_upper
				if not sc.is_valid_class_type_name (cla) then
					add_error_message (Warning_messages.w_invalid_class_name (cla))
					raise_exception (Invalid_project_name_exception)
				end
				clu := root_cluster_field.text
				clu.to_lower
				if not sc.is_valid_group_name (clu) then
					add_error_message (Warning_messages.w_invalid_cluster_name (clu))
					raise_exception (Invalid_project_name_exception)
				end
				f := root_feature_field.text
				f.to_lower
				if not sc.is_valid_identifier (f) then
					add_error_message (Warning_messages.w_invalid_feature_name (f))
					raise_exception (Invalid_project_name_exception)
				end

				create blank_project_builder.make (system_name, cla, clu, f, directory_name, scoop_check_button.is_selected)
				ace_file_name := blank_project_builder.ace_filename
				compile_project := compile_project_check_button.is_selected

				if (create {PLAIN_TEXT_FILE}.make_with_path (ace_file_name)).exists then
						-- Warn that the existing configuration file will be overwritten.
					prompts.show_warning_prompt_with_cancel (
						warning_messages.w_file_exists (ace_file_name.name),
						Current,
						agent do success := True end,
						Void
					)
				else
					success := True
				end

				if success then
						-- Project creation can still fail
					success := False
						-- Generate the files (ace file + root class)
					blank_project_builder.create_blank_project

						-- Create a new project using the previously generated files.
					create l_project_loader.make (Current)
					l_project_loader.set_is_project_location_requested (False)
					l_project_initialized := eiffel_project.initialized
					if l_project_initialized then
						l_project_loader.enable_project_creation_or_opening_not_requested
					end
					l_project_loader.open_project_file (ace_file_name, Void, directory_name, True, Void)
					if not l_project_loader.has_error then
						if compile_project then
							l_project_loader.set_is_compilation_requested (True)
							l_project_loader.melt_project (l_project_initialized)
						elseif l_project_initialized and l_project_loader.is_project_ok then
								-- Open a new EiffelStudio session for sure since current
								-- system is already initialized.
							l_project_loader.open_project (True)
						end
					end

						-- Update `success' state.
					success := not l_project_loader.has_error and then Eiffel_project.initialized and then
						(not Eiffel_ace.file_name.is_empty)

					if success then
						if last_saved_location_checkbox.is_selected then
							preferences.dialog_data.set_last_saved_basic_project_directory (directory_name.parent)
						else
							preferences.dialog_data.set_last_saved_basic_project_directory (Void)
						end
					end

					destroy
				end
			else
				if not is_destroyed and then is_displayed then
					display_error_message (Current)
				else
					display_error_message (parent_window)
				end
			end
		rescue
			retried := True
			retry
		end

	select_project_path
			--  Select a project in directory `directory_name', with ace file
			-- `ace_file_name'.
			--
			-- Use `parent_window' as parent window when displaying dialogs
		do
			success := False
				-- If the ace file or the directory is not yet specified,
				-- retrieve it from the text field.
			if directory_field.text.is_empty then
				add_error_message (Warning_messages.w_fill_in_location_field)
				if is_displayed then
					display_error_message (Current)
				else
					display_error_message (parent_window)
				end
				success := False
			else
				compile_project := compile_project_check_button.is_selected
				success := True
			end
			destroy
		end

feature {NONE} -- Implementation

	build_interface
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
			clal, clul, snl, fnl, scoop_label: EV_LABEL
			cb: EV_CHECK_BUTTON
			sz: INTEGER
		do
				-- Let the user choose the directory
			default_create

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
				create scoop_label.make_with_text (interface_names.l_concurrency)
				sz := clal.minimum_width.max
					(clul.minimum_width).max
					(snl.minimum_width).max
					(fnl.minimum_width).max
					(scoop_label.minimum_width)
				clal.set_minimum_width (sz)
				clal.align_text_left
				clul.set_minimum_width (sz)
				clul.align_text_left
				snl.set_minimum_width (sz)
				snl.align_text_left
				fnl.set_minimum_width (sz)
				fnl.align_text_left
				scoop_label.set_minimum_width (sz)
				scoop_label.align_text_left
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
					-- SCOOP flag
				create scoop_check_button.default_create
				create hb
				hb.extend (scoop_label)
				hb.disable_item_expand (scoop_label)
				hb.extend (scoop_check_button)
				main_vb.extend (hb)
				scoop_check_button.enable_select

				system_name_frame.extend (main_vb)
			else
					-- Ace file Name
				create label.make_with_text (ace_file_name.name)
				create system_name_frame.make_with_text (Interface_names.l_Ace_file_for_frame)
				create hb
				hb.set_border_width (layout_constants.small_border_size)
				hb.extend (label)
				hb.disable_item_expand (label)
				system_name_frame.extend (hb)
			end

				-- Project directory
			create project_directory_frame.make_with_text (Interface_names.l_location_colon)
			create vb
			vb.set_border_width (Layout_constants.Small_border_size)
			vb.set_padding (Layout_constants.Small_padding_size)

			create directory_field
			if suggested_directory_name /= Void then
				directory_field.set_text (suggested_directory_name.name)
			end
			create b.make_with_text_and_action (Interface_names.b_Browse, agent browse_directory)
			create hb
			hb.set_padding_width (Layout_constants.Small_border_size)
			hb.extend (directory_field)
			hb.extend (b)
			hb.disable_item_expand (b)
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create label.make_with_text (Interface_names.l_Project_location)
			label.align_text_left
			vb.extend (label)

			if ask_for_system_name then
					-- Remember location, only for project creation.
				create cb.make_with_text (Interface_names.l_remember_project_location)
				cb.set_tooltip (Interface_names.f_remember_project_location_tooltip)
				last_saved_location_checkbox := cb
				if preferences.dialog_data.last_saved_basic_project_directory /= Void then
					cb.enable_select
				else
					cb.disable_select
				end
				vb.extend (cb)
			end

			project_directory_frame.extend (vb)

				-- "Compile project" Check box
			create compile_project_check_button.make_with_text (Interface_names.l_compile_project)
			if compile_project then
				compile_project_check_button.enable_select
			else
				compile_project_check_button.disable_select
			end

				--| Action buttons box
			create ok_b.make_with_text_and_action (Interface_names.b_OK, agent on_ok)
			Layout_constants.set_default_width_for_button (ok_b)
			create cancel_b.make_with_text_and_action (Interface_names.b_Cancel, agent on_cancel)
			Layout_constants.set_default_width_for_button (cancel_b)
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
			set_width (Layout_constants.Dialog_unit_to_pixels (500))

				--| Setting default buttons
			set_default_push_button (ok_b)
			set_default_cancel_button (cancel_b)

			show_actions.extend (agent on_window_shown)
		end

	on_window_shown
			-- The window has just been shown.
			-- Set the focus to the first widget and show the beginning of each text field.
		do
			if ask_for_system_name then
				system_name_field.set_caret_position (1)
				system_name_field.set_focus
			else
				if not directory_field.text.is_empty then
					directory_field.set_caret_position (1)
					directory_field.set_focus
				end
			end
		end

	browse_directory
			-- Popup a "select directory" dialog.
		local
			dd: EV_DIRECTORY_DIALOG
			start_directory: PATH
		do
			create dd
			dd.set_title (Interface_names.t_select_a_directory)
			if directory_field /= Void then
				create start_directory.make_from_string (directory_field.text)
				if not start_directory.is_empty and then (create {DIRECTORY}.make_with_path (start_directory)).exists then
					dd.set_start_path (start_directory)
				end
			end
			dd.ok_actions.extend (agent retrieve_directory (dd))
			dd.show_modal_to_window (Current)
		end

	check_and_create_directory (a_directory_name: PATH)
			-- Check that the directory `a_directory_name' is valid and exists and MODIFY IT if needed.
			-- If `a_directory_name' is not valid or does not exits, a developper exception is raised.
		local
			d: DIRECTORY
		do
				-- Try to create the directory.
			create d.make_with_path (a_directory_name)
			d.recursive_create_dir
			if not d.exists then
				raise_exception ("Cannot create a directory.")
			end
		rescue
			add_error_message (Warning_messages.w_Invalid_directory_or_cannot_be_created (a_directory_name.name))
		end

	create_default_directory_name (project_name: READABLE_STRING_GENERAL): PATH
			-- Return the proposed directory for project `project_name'
		do
			if
				attached preferences.dialog_data.last_saved_basic_project_directory as p
			then
				Result := p
			else
				Result := eiffel_layout.user_projects_path
			end
			Result := Result.extended (project_name)
		end

	old_project_name: STRING_32
			-- Old project name, set by user

feature {NONE} -- Callbacks

	on_cancel
			-- User has clicked "Cancel"
		do
			success := False
			destroy
		end

	on_ok
			-- User has clicked "Ok"
		do
			if blank_project_creation then
				create_blank_project
			else
				select_project_path
			end
		end

	on_change_project_name
			-- The user has changed the project name, update the project location
		local
			curr_project_location: STRING_32
			curr_project_name: STRING_32
			sep_index: INTEGER
		do
			curr_project_name := system_name_field.text
			curr_project_location := directory_field.text

			if old_project_name = Void or else old_project_name.is_equal (root_cluster_field.text) then
				root_cluster_field.set_text (curr_project_name)
			end
			if not curr_project_location.is_empty then
				sep_index := curr_project_location.last_index_of (Operating_environment.Directory_separator, curr_project_location.count)
				curr_project_location.keep_head (sep_index)
				if curr_project_name /= Void then
					curr_project_location.append (curr_project_name)
				end

				directory_field.set_text (curr_project_location)
			end

			old_project_name := system_name_field.text
		ensure
			old_project_name_attached: old_project_name /= Void
			old_project_name_set: old_project_name.is_equal (system_name_field.text)
		end

	retrieve_directory (dialog: EV_DIRECTORY_DIALOG)
			-- Get callback information from `dialog', then send it to the directory field.
		local
			l_dir: PATH
		do
			l_dir := dialog.path
			if l_dir.is_empty then
				prompts.show_error_prompt (Warning_messages.w_directory_not_exist (""), Current, Void)
			else
				directory_field.set_text (l_dir.name)
			end
		end

feature {NONE} -- Private attributes

	blank_project_creation: BOOLEAN
			-- Should we create a blank project when user click "OK"?

	parent_window: EV_WINDOW
			-- Parent window

	ace_file_name: PATH
			-- Name of the ace file to create the project with.

	directory_name: PATH
			-- Directory to create the project in.

	system_name: STRING_32
			-- Name of the system of the project to create.

	suggested_directory_name: detachable PATH
			-- Initial directory (suggestion, can be Void)

	ask_for_system_name: BOOLEAN
			-- Should `build_interface' be built so that it asks for
			-- the system name? (if False, ask for the ace file)

	overwrite_project_confirmation_flag: BOOLEAN
			-- Should we display a confirmation dialog before deleting
			-- the EIFGEN?

feature {NONE} -- Vision2 architechture

	directory_field: EV_TEXT_FIELD

	last_saved_location_checkbox: EV_CHECK_BUTTON

	system_name_field: EV_TEXT_FIELD

	root_class_field: EV_TEXT_FIELD

	root_cluster_field: EV_TEXT_FIELD

	root_feature_field: EV_TEXT_FIELD

	scoop_check_button: EV_CHECK_BUTTON

	compile_project_check_button: EV_CHECK_BUTTON

feature {NONE} -- Constants

	Default_project_name: STRING_32 = "project"

	Default_root_class_name: STRING = "APPLICATION"

	Default_root_feature_name: STRING = "make"

	Default_root_cluster_name: STRING = "project"

	Invalid_ace_exception: STRING = "Invalid_ace"

	Invalid_directory_exception: STRING = "Invalid_directory"

	Invalid_project_name_exception: STRING = "Invalid_project_name";

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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

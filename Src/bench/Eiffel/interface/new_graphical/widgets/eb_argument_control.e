indexing
	description: 	"Abstraction of an control allowing adding, removal and in-place editing of%
					%project-wide and user customised program arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "08/05/2002"
	revision: "1.0"

class
	EB_ARGUMENT_CONTROL

inherit

	EV_VERTICAL_BOX
		redefine
			set_focus
		end

	EB_CONSTANTS
		undefine
			default_create, copy, is_equal
		end

	PROJECT_CONTEXT
		undefine
			default_create,	copy, is_equal
		end

	LACE_AST_FACTORY
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_INTERFACE_TOOLS
		rename
			mode as text_mode
		undefine
			default_create, copy, is_equal
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_ARGUMENTS
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_parent: EV_WINDOW; a_from_project_settings: BOOLEAN) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
		do
			default_create
			parent_window := a_parent
			set_padding (Layout_constants.Default_padding_size)
			extend (execution_frame)
			update
			from_project_settings := a_from_project_settings
		ensure
			from_project_settings_set: from_project_settings = a_from_project_settings
		end

feature -- Access

	from_project_settings: BOOLEAN
			-- Is current control in the project settings or not? If it is not, then
			-- we need to modify the Ace file on disk, otherwise we don't need to do anything,
			-- we simply update our AST.

feature {NONE} -- Retrieval		

	retrieve_config_arguments is
			-- Check content of config file and if valid set retrieve arguments.
		local
			argument_value: STRING
			wd: STRING
			l_row: EV_MULTI_COLUMN_LIST_ROW
		do
			config_arguments_list.wipe_out
			config_combo.wipe_out
			set_mode (Ace_mode)

			argument_value := lace.target.settings.item ("arguments")
			if argument_value /= Void then
					-- Add argument to list.
				create l_row
				l_row.extend (argument_value.twin)
				config_arguments_list.extend (l_row)
					-- Add argument to combo.
				config_combo.extend (create {EV_LIST_ITEM}.make_with_text (argument_value))
			end

			wd := universe.target.settings.item ("arguments")
			if wd /= Void then
				set_working_directory (wd)
			end
		end

	retrieve_user_arguments is
			-- Retrieve and initialize the user specific arguments from 'arguments.wb'.
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
			l_args: ARRAYED_LIST [STRING]
		do
			user_arguments_list.wipe_out
			user_combo.wipe_out
			set_mode (User_mode)
			l_args := lace.user_options.arguments
			if l_args /= Void then
				from
					l_args.start
				until
					l_args.after
				loop
						-- Add argument to list.
					create l_row
					l_row.extend (l_args.item)
					user_arguments_list.extend (l_row)
						-- Add argument to combo.
					user_combo.extend (create {EV_LIST_ITEM}.make_with_text (l_args.item))
					l_args.forth
				end
			end
		end

feature -- Storage

	store_config_arguments is
			-- Store new arguments in config file.
		do
			if not argument_check.is_selected or current_argument.text.is_empty then
				saved_argument := ""
			else
				saved_argument := current_argument.text
			end
			current_selected_cmd_line_argument.put (saved_argument)
			save_config_arguments
			synch_with_others
		end

	store_custom_arguments is
			-- Store new arguments in config file.
		do
			if not argument_check.is_selected or current_argument.text.is_empty then
				saved_argument := ""
			else
				saved_argument := current_argument.text
			end
			current_selected_cmd_line_argument.put (saved_argument)
			save_custom_arguments
			synch_with_others
		end

	store_arguments is
			-- Store the current arguments to their corresponding files and set current
			-- arguments for system execution.
		do
			if not argument_check.is_selected or current_argument.text.is_empty then
				saved_argument := ""
			else
				saved_argument := current_argument.text
			end
			current_selected_cmd_line_argument.put (saved_argument)
			save_config_arguments
			save_custom_arguments
			synch_with_others
		end

feature {NONE} -- Storage

	save_config_arguments is
			-- Store content of `ace_arguments_list' into config file.
		do
			if config_arguments_list /= Void and not config_arguments_list.is_empty then
				lace.target.settings.force (config_arguments_list.first.i_th (1), "arguments")
			else
				lace.target.settings.remove ("arguments")
			end
			lace.store
		end

	save_custom_arguments is
			-- Save user custom arguments to user options.
		local
			l_args: ARRAYED_LIST [STRING]
		do
			create l_args.make (user_arguments_list.count)
			from
				user_arguments_list.start
			until
				user_arguments_list.after
			loop
				l_args.extend (user_arguments_list.item.i_th (1))
				user_arguments_list.forth
			end
			lace.user_options.set_arguments (l_args)
			lace.store_user_options
		end

feature {NONE} -- GUI

	execution_frame: EV_VERTICAL_BOX is
			-- Frame widget containing argument controls.
		local
			vbox: EV_VERTICAL_BOX
			l_frame: EV_FRAME
		do
				-- Create all widgets.
			create working_directory.make_with_parent (parent_window)
			create argument_list.make (parent_window)
			create argument_combo
			create current_argument
			create config_arguments_list.make (parent_window)
			create config_combo
			create config_current_arg_text
			create user_arguments_list.make (parent_window)
			create user_combo
			create user_current_arg_text
			create notebook
			create Result


			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
				-- Working directory.
			create l_frame.make_with_text ("Working Directory")
			l_frame.extend (vbox)
			vbox.extend (working_directory)
			Result.extend (l_frame)
			Result.disable_item_expand (l_frame)

				-- Ace file arguments tab.
			set_mode (Ace_mode)
			create project_args_tab
			populate_by_template (project_args_tab)
			notebook.extend (project_args_tab)
			notebook.set_item_text (project_args_tab, "Project Arguments")

				-- My Arguments tab.
			set_mode (User_mode)
			create user_args_tab
			populate_by_template (user_args_tab)
			notebook.extend (user_args_tab)
			notebook.set_item_text (user_args_tab, "My Arguments")

			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
			create l_frame.make_with_text ("Arguments")
			create argument_check.make_with_text ("Enable arguments")
			l_frame.extend (vbox)
			vbox.extend (argument_check)
			vbox.disable_item_expand (argument_check)
			vbox.extend (notebook)
			Result.extend (l_frame)

			config_arguments_list.set_all_columns_editable
			user_arguments_list.set_all_columns_editable
			config_combo.disable_edit
			user_combo.disable_edit

				-- Global actions.
			pointer_leave_actions.extend (agent synch_with_others)

				-- Check button actions
			argument_check.select_actions.extend (agent arg_check_selected)

				-- Notebook actions.
			notebook.selection_actions.extend (agent on_tab_changed)

				-- List actions.
			config_arguments_list.focus_in_actions.extend (agent refresh)
			user_arguments_list.focus_in_actions.extend (agent refresh)
			config_arguments_list.select_actions.force_extend (agent argument_selected (config_arguments_list))
			user_arguments_list.select_actions.force_extend (agent argument_selected (user_arguments_list))
			config_arguments_list.end_edit_actions.extend (agent on_list_edited)
			user_arguments_list.end_edit_actions.extend (agent on_list_edited)

				-- Combo actions.
			config_combo.select_actions.extend (agent argument_selected (config_combo))
			user_combo.select_actions.extend (agent argument_selected (user_combo))

				-- Argument text actions.
			config_current_arg_text.key_release_actions.extend (agent arg_text_changed)
			user_current_arg_text.key_release_actions.extend (agent arg_text_changed)
		end

	populate_by_template (a_vbox: EV_VERTICAL_BOX) is
			-- Populate 'a_vbox' with widgets and associated events.
		require
			a_box_not_void: a_vbox /= Void
		local
			l_horizontal_box: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_label: EV_LABEL
			add_button,
			remove_button: EV_BUTTON
		do
			a_vbox.set_border_width (Layout_constants.Small_border_size)
			a_vbox.set_padding (Layout_constants.Small_padding_size)

				-- Argument combo box.
			a_vbox.extend (argument_combo)
			a_vbox.disable_item_expand (argument_combo)

				-- Argument list box.
			a_vbox.extend (argument_list)
			argument_list.set_minimum_size (400, 50)

			create l_horizontal_box
			l_horizontal_box.set_padding (Layout_constants.Default_padding_size)

			create l_label.make_with_text ("Current Argument")
			l_label.align_text_left
			a_vbox.extend (l_label)
			a_vbox.disable_item_expand (l_label)

			a_vbox.extend (current_argument)
			current_argument.set_minimum_height (50)

			create l_cell
			l_horizontal_box.extend (l_cell)

			create add_button.make_with_text_and_action ("Add", agent add_argument)
			l_horizontal_box.extend (add_button)
			l_horizontal_box.disable_item_expand (add_button)
			add_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)

			create remove_button.make_with_text_and_action ("Remove", agent remove_argument)
			l_horizontal_box.extend (remove_button)
			l_horizontal_box.disable_item_expand (remove_button)
			remove_button.set_minimum_size (Layout_constants.Default_button_width, Layout_constants.Default_button_height)

			create l_cell
			l_horizontal_box.extend (l_cell)

			a_vbox.extend (l_horizontal_box)
			a_vbox.disable_item_expand (l_horizontal_box)
		end

feature -- Access

	working_directory_path: STRING is
			-- Path of 'working_directory'.
		do
			Result := working_directory.path
		end

feature -- Status Setting

	synch_with_others is
			-- Synchronize other open controls due to changes in Current.
		local
			mem: MEMORY
			l_control: EB_ARGUMENT_CONTROL
			l_controls_list: SPECIAL [ANY]
			l_counter: INTEGER
		do
			create mem
			l_controls_list := mem.objects_instance_of (Current)
			from
				l_counter := 0
			until
				l_counter = l_controls_list.count
			loop
				if l_controls_list.item (l_counter) /= Current then
					l_control ?= l_controls_list.item (l_counter)
					l_control.update
				end
				l_counter := l_counter + 1
			end
		end

	synch_check_box (a_flag: BOOLEAN) is
			-- Synchronize the check box.
		do
			if a_flag and not argument_check.is_selected then
				argument_check.enable_select
			elseif argument_check.is_selected then
				argument_check.disable_select
			end
		end

	update is
			-- Update all elements after changes.
		do
			if not argument_check.is_selected then
				argument_check.enable_select
				is_with_argument := False
			end
			retrieve_config_arguments
			retrieve_user_arguments
				-- Determine last argument run and set mode and argument to this.
				-- If not use Ace mode as default.

			if saved_argument /= Void and not saved_argument.is_equal (No_argument_string) then
				if config_arguments_list.there_exists (agent row_duplicate (?)) then
					notebook.select_item (notebook.i_th (1))
					set_mode (Ace_mode)
					config_arguments_list.select_item (saved_argument, 1)
					select_combo_item (saved_argument)
				elseif user_arguments_list.there_exists (agent row_duplicate (?)) then
					notebook.select_item (notebook.i_th (2))
					set_mode (User_mode)
					user_arguments_list.select_item (saved_argument, 1)
					select_combo_item (saved_argument)
				else
					notebook.select_item (notebook.i_th (2))
					set_mode (User_mode)
				end
				current_argument.set_text (saved_argument)
			else
				current_argument.remove_text
				argument_check.disable_select
			end
			if not is_with_argument then
				argument_check.disable_select
			end
		end

	set_working_directory (a_path: STRING) is
			-- Set 'working directory' path to 'a_path'.
		require
			path_not_void: a_path /= Void
		do
			working_directory.set_path (a_path)
		end

feature {NONE} -- Status Setting

	set_mode (a_mode: INTEGER) is
			-- Set the current mode to 'a_mode'.
		require
			a_mode_is_valid: a_mode = 1 or a_mode = 2
		do
			mode := a_mode
			initialize_mode
		end

feature {NONE} -- Element Change

	initialize_mode is
			-- Initialize or reinitialize the current mode.
		do
			inspect mode
				when Ace_mode then
					argument_list := config_arguments_list
					argument_combo := config_combo
					current_argument := config_current_arg_text
				when User_mode then
					argument_list := user_arguments_list
					argument_combo := user_combo
					current_argument := user_current_arg_text
				else
			end
			argument_list.hide_title_row
		end

	update_arguments is
			-- Update the arguments lists due to changes.
		do
			inspect mode
				when Ace_mode then
					ace_modified := True
					config_arguments_list := argument_list
					store_config_arguments
				when User_mode then
					user_arguments_list := argument_list
					store_custom_arguments
			end
			synch_with_others
		end

feature -- Status setting

	set_focus is
			-- Grab keyboard focus.
		do
				-- Set focus to a new argument field or to a check box
				-- to allow arguments if they are not allowed yet.
			if argument_check.is_selected then
				current_argument.set_focus
			else
				argument_check.set_focus
			end
		end

feature {NONE} -- GUI Properties

	working_directory: EV_PATH_FIELD
			-- Directory from where user wants to launch its application.

	notebook: EV_NOTEBOOK
			-- The notebook containing project and user argument tabs.

	argument_check: EV_CHECK_BUTTON
			-- Check button to determine of arguments used or not.

	current_argument: EV_TEXT
			-- The current argument (either 'ace_current_arg_text' or 'user_current_arg_text').

	argument_list: EV_EDITABLE_LIST
			-- The current list with focus (either 'ace_arguments_list' or 'custom_arguments_list').

	argument_combo: EV_COMBO_BOX
			-- The current list of arguments (either 'ace_combo' or 'custom_combo').

	config_arguments_list: EV_EDITABLE_LIST
			-- Widget displaying arguments from config file.

	config_combo: EV_COMBO_BOX
			-- Widget displaying arguments from config file.

	user_arguments_list: EV_EDITABLE_LIST
			-- Widget displaying arguments from user specific file.

	user_combo: EV_COMBO_BOX
			-- Widget displaying arguments from user specific file.

	config_current_arg_text: EV_TEXT
			-- Widget displaying current program argument from config file.

	user_current_arg_text: EV_TEXT
			-- Widget displaying current program argument from user file.

	project_args_tab: EV_VERTICAL_BOX
			-- Widget containing project-wide argument settings.

	user_args_tab: EV_VERTICAL_BOX
			-- Widget containing user specific argument settings.

feature {NONE} -- Actions

	on_tab_changed is
			-- Action to be taken when user has changed mode.
		do
			if mode = 1 then
				set_mode (2)
			elseif mode = 2 then
				set_mode (1)
			end
			refresh
		end

	arg_check_selected is
			-- Argument check box has been selected.
		do
			if argument_check.is_selected then
				notebook.enable_sensitive
				is_with_argument := True
			else
				notebook.disable_sensitive
				is_with_argument := False
			end
			if notebook.index_of (notebook.selected_item, 1) = 1 then
				set_mode (Ace_mode)
			else
				set_mode (User_mode)
			end
		end

	arg_text_changed (key: EV_KEY) is
			-- Argument text has changed; check for new line and disallow.
		local
			l_text: STRING
			l_caret_pos: INTEGER
			l_argument_dialog: EB_ARGUMENT_DIALOG
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter then

					-- Disallow new line character.
				l_caret_pos := current_argument.caret_position
				l_text := current_argument.text.substring (1, l_caret_pos - 2)
				if not l_text.is_empty then
					l_text.replace_substring_all ("%N", "")
					l_caret_pos := l_text.count
					l_text := current_argument.text
					l_text.replace_substring_all ("%N", "")
					current_argument.set_text (l_text)
					current_argument.set_caret_position (l_caret_pos + 1)
				end

					-- Set focus to Run button if Current is in a dialog and not
					-- in the project settings.
				l_argument_dialog := Argument_dialog_cell.item
				if l_argument_dialog /= Void and then l_argument_dialog.has_focus then
					l_argument_dialog.run_and_close_button.set_focus
				end
			end
		end

	on_list_edited is
			-- Action to be performed when list row argument has been in-place edited.
		do
			if argument_combo.selected_item /= Void then
				argument_combo.go_i_th (argument_combo.index_of (argument_combo.selected_item, 1))
				argument_combo.replace (create {EV_LIST_ITEM}.make_with_text (argument_list.selected_item.i_th (1)))
				argument_combo.item.enable_select
				update_arguments
			end
		end

	add_argument is
			-- Action to take when user chooses to add a new argument.
		local
			l_row: EV_MULTI_COLUMN_LIST_ROW
			l_argument: STRING
		do
			if not current_argument.text.is_empty then
				l_argument := current_argument.text
				create l_row
				l_row.put_front (l_argument)
				saved_argument := l_argument
				if not argument_list.there_exists (agent row_duplicate (?)) then
					if argument_list.is_empty then
						argument_list.set_column_width (argument_list.width - 4, 1)
					end
					argument_list.extend (l_row)

					argument_combo.extend (create {EV_LIST_ITEM}.make_with_text (saved_argument))
					argument_list.last.enable_select
					argument_combo.last.enable_select
				end
				update_arguments
			end
		end

	current_new_arg_text: STRING
			-- Text of mostly recently added argument.

	row_duplicate (a_row: EV_MULTI_COLUMN_LIST_ROW): BOOLEAN is
			-- Does text in 'a_row' already exist in row in the list?
		do
			Result := a_row.first.is_equal (saved_argument)
		end

	remove_argument is
			-- Action to take when user chooses to remove an existing argument.
		do
			if
				argument_list.selected_item /= Void
			then
				argument_list.prune (argument_list.selected_item)
				argument_combo.prune (argument_combo.selected_item)
				if not argument_combo.is_empty then
					argument_combo.first.enable_select
					current_argument.set_text (argument_combo.selected_item.text)
				else
					argument_combo.wipe_out
					current_argument.remove_text
				end
				update_arguments
			end
		end

	argument_selected (a_widget: EV_WIDGET) is
			-- An argument was chosen in 'a_widget'
		local
			l_list: EV_EDITABLE_LIST
			l_combo: EV_COMBO_BOX
		do
			l_list ?= a_widget
			l_combo ?= a_widget
			if l_list /= Void then
				-- List argument was selected.
				if argument_list.selected_item /= Void then
					argument_combo.i_th (argument_list.index_of (argument_list.selected_item, 1)).enable_select
				end
			elseif l_combo /= Void then
				-- Combo argument was selected.
				if argument_combo.selected_item /= Void then
					argument_list.i_th (argument_combo.index_of (argument_combo.selected_item, 1)).enable_select
				end
			end
			refresh
		end

	refresh is
			-- Refresh control since it has been resized.
		do
			if not argument_list.is_empty then
				if argument_list.selected_item /= Void then
					current_argument.set_text (argument_list.selected_item.i_th (1))
				end
			else
				current_argument.remove_text
			end
		end

	select_combo_item (a_string: STRING) is
			-- Select in the 'argument_combo' first item matching text 'a_string'.
			-- Used for synchronization with other controls.
		local
			done: BOOLEAN
		do
			from
				argument_combo.start
			until
				argument_combo.after or done
			loop
				if argument_combo.item.text.is_equal (a_string) then
					argument_combo.item.enable_select
					done := True
				end
				argument_combo.forth
			end
		end

feature {NONE} -- Implementation

	is_with_argument: BOOLEAN
			-- Is current execution running supposed to be launched
			-- with or without an arguments?

	arguments_file: RAW_FILE
			-- File containing user specific arguments.

	mode: INTEGER
			-- Mode of control (can be ace or user mode).

	saved_argument: STRING
			-- The argument last used in opposite 'mode'

	parent_window: EV_WINDOW
			-- Parent window.

	ace_modified: BOOLEAN
			-- Have the Ace file arguments been modified since creation of
			-- the control?

feature {NONE} -- Constants

	Ace_mode: INTEGER is 1
			-- Ace mode constant.

	User_mode: INTEGER is 2
			-- User mode constant.

invariant
	parent_not_void: parent_window /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class EB_ARGUMENT_CONTROL

indexing
	description: 	"Abstraction of an control allowing adding, removal and in-place editing of%
					%program arguments"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

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

	make (a_parent: EV_WINDOW) is
			-- Initialization
		require
			parent_not_void: a_parent /= Void
		do
			default_create
			parent_window := a_parent
			set_padding (Layout_constants.Default_padding_size)
			extend (execution_frame)
			update
		end

feature {NONE} -- Retrieval		

	retrieve_arguments is
			-- Retrieve and initialize the arguments from user options.
		local
			l_args: ARRAYED_LIST [STRING]
			l_user_opts: USER_OPTIONS
			l_last_found: BOOLEAN
		do
			argument_combo.wipe_out
			l_user_opts := lace.user_options
			if l_user_opts.last_argument /= Void then
				current_argument.set_text (l_user_opts.last_argument)
			else
				current_argument.remove_text
			end
			l_args := l_user_opts.arguments
			argument_combo.select_actions.block
			if l_args /= Void then
				from
					l_args.start
				until
					l_args.after
				loop
						-- Add argument to combo.
					argument_combo.extend (create {EV_LIST_ITEM}.make_with_text (l_args.item))
					if l_args.item.is_equal (current_argument.text) then
						argument_combo.last.enable_select
						l_last_found := True
					end
					l_args.forth
				end
			end
			if not l_last_found then
				argument_combo.first.disable_select
			end
			argument_combo.select_actions.resume

			if l_user_opts.use_arguments then
				argument_check.enable_select
			else
				argument_check.disable_select
			end
			if l_user_opts.working_directory /= Void then
				working_directory.set_path (l_user_opts.working_directory)
			end
		end

feature -- Storage

	store_arguments is
			-- Store the current arguments and set current
			-- arguments for system execution.
		local
			l_args: ARRAYED_LIST [STRING]
			l_user_opts: USER_OPTIONS
		do
			l_user_opts := lace.user_options
			if argument_check.is_selected then
				l_user_opts.enable_arguments
			else
				l_user_opts.disable_arguments
			end
			create l_args.make (argument_combo.count)
			from
				argument_combo.start
			until
				argument_combo.after
			loop
				l_args.extend (argument_combo.item.text)
				argument_combo.forth
			end
			l_user_opts.set_arguments (l_args)
			l_user_opts.set_last_argument (current_argument.text)
			l_user_opts.set_working_directory (working_directory.path)

			lace.store_user_options
			synch_with_others
		end

feature {NONE} -- GUI

	execution_frame: EV_VERTICAL_BOX is
			-- Frame widget containing argument controls.
		local
			l_frame: EV_FRAME
			vbox: EV_VERTICAL_BOX
		do
				-- Create all widgets.
			create working_directory.make_with_parent (parent_window)
			create argument_combo
			create current_argument
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

			create arguments_box
			populate_by_template (arguments_box)

			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
			create l_frame.make_with_text ("Arguments")
			create argument_check.make_with_text ("Enable arguments")
			l_frame.extend (vbox)
			vbox.extend (argument_check)
			vbox.disable_item_expand (argument_check)
			vbox.extend (arguments_box)
			Result.extend (l_frame)

			argument_combo.disable_edit

				-- Global actions.
			pointer_leave_actions.extend (agent synch_with_others)

				-- Check button actions
			argument_check.select_actions.extend (agent arg_check_selected)

				-- Combo actions.
			argument_combo.select_actions.extend (agent argument_selected (argument_combo))
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

			create l_horizontal_box
			l_horizontal_box.set_padding (Layout_constants.Default_padding_size)

			create l_label.make_with_text ("Current Argument")
			l_label.align_text_left
			a_vbox.extend (l_label)
			a_vbox.disable_item_expand (l_label)

			a_vbox.extend (current_argument)
			current_argument.set_minimum_height (50)
			current_argument.key_release_actions.extend (agent arg_text_changed)

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

	update is
			-- Update all elements after changes.
		do
			retrieve_arguments
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

	argument_check: EV_CHECK_BUTTON
			-- Check button to determine of arguments used or not.

	current_argument: EV_TEXT
			-- Current argument.

	argument_combo: EV_COMBO_BOX
			-- Current list of arguments.

	arguments_box: EV_VERTICAL_BOX
			-- Widget containing argument settings.

feature {NONE} -- Actions

	arg_check_selected is
			-- Argument check box has been selected.
		do
			if argument_check.is_selected then
				arguments_box.enable_sensitive
			else
				arguments_box.disable_sensitive
			end
		end

	arg_text_changed (key: EV_KEY) is
			-- Argument text has changed; check for new line and disallow.
		local
			l_text: STRING
			l_argument_dialog: EB_ARGUMENT_DIALOG
		do
			if key.code = {EV_KEY_CONSTANTS}.key_enter then
					-- Disallow new line character.
				l_text := current_argument.text
				l_text.replace_substring_all ("%N", "")
				current_argument.set_text (l_text)

					-- Set focus to Run button if Current is in a dialog and not
					-- in the project settings.
				l_argument_dialog := Argument_dialog_cell.item
				if l_argument_dialog /= Void and then l_argument_dialog.has_focus then
					l_argument_dialog.run_and_close_button.set_focus
				end
			end
			if argument_combo.selected_item /= Void then
				argument_combo.selected_item.disable_select
			end
		end

	add_argument is
			-- Action to take when user chooses to add a new argument.
		local
			l_argument: STRING
		do
			l_argument := current_argument.text
			if not l_argument.is_empty then
				if not argument_combo.there_exists (agent row_duplicate (?)) then
					argument_combo.extend (create {EV_LIST_ITEM}.make_with_text (l_argument))
					argument_combo.last.enable_select
				end
				store_arguments
			end
		end

	row_duplicate (an_item: EV_LIST_ITEM): BOOLEAN is
			-- Does text in 'a_row' already exist in row in the list?
		do
			Result := an_item.text.is_equal (current_argument.text)
		end

	remove_argument is
			-- Action to take when user chooses to remove an existing argument.
		do
			if
				argument_combo.selected_item /= Void
			then
				argument_combo.prune (argument_combo.selected_item)
				if not argument_combo.is_empty then
					argument_combo.first.enable_select
				else
					argument_combo.wipe_out
					current_argument.remove_text
				end
				store_arguments
			end
		end

	argument_selected (a_widget: EV_WIDGET) is
			-- An argument was chosen in 'a_widget'
		do
			if not argument_combo.is_empty and argument_combo.selected_item /= Void and argument_combo.selected_item.data = Void then
				current_argument.set_text (argument_combo.selected_item.text)
			else
				current_argument.remove_text
			end
		end

feature {NONE} -- Implementation

	parent_window: EV_WINDOW
			-- Parent window.

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

end

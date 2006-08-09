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
			parent_window.show_actions.extend (
				agent
					local
						l_selected_rows: ARRAYED_LIST [EV_GRID_ROW]
					do
						l_selected_rows := arguments_grid.selected_rows
						if not l_selected_rows.is_empty then
							l_selected_rows.first.ensure_visible
						end
					end
				)
			set_padding (Layout_constants.Default_padding_size)
			extend (execution_frame)
			update
		end

feature {NONE} -- Retrieval

	retrieve_arguments is
			-- Retrieve and initialize the arguments from user options.
		local
			l_args: ARRAYED_LIST [STRING]
			l_user_opts: TARGET_USER_OPTIONS
			l_row: EV_GRID_ROW
		do
			arguments_grid.set_row_count_to (0)

			l_user_opts := lace.user_options.target
			l_args := l_user_opts.arguments
			if l_args /= Void and then l_args.count > 0 then
				from
					l_args.start
				until
					l_args.after
				loop
					l_row := added_argument_text_row (l_args.item, False)
					l_args.forth
				end
			end
			if l_user_opts.last_argument /= Void then
				l_row := grid_row_with_argument (l_user_opts.last_argument)
				if l_row /= Void then
					arguments_grid.select_row (l_row.index)
				else
					current_argument.set_text (l_user_opts.last_argument)
				end
			else
				current_argument.remove_text
			end

			if l_user_opts.use_arguments then
				argument_check.enable_select
			else
				argument_check.disable_select
			end
			if l_user_opts.working_directory /= Void and then not l_user_opts.working_directory.is_empty then
				working_directory.set_path (l_user_opts.working_directory)
			else
				working_directory.set_default_start_directory (application_working_directory)
			end
		end

feature -- Storage

	store_arguments is
			-- Store the current arguments and set current
			-- arguments for system execution.
		local
			l_args: ARRAYED_LIST [STRING]
			l_user_opts: TARGET_USER_OPTIONS
			l_user_factory: USER_OPTIONS_FACTORY
			r: INTEGER
			s: STRING
		do
			l_user_opts := lace.user_options.target
			if argument_check.is_selected then
				l_user_opts.enable_arguments
			else
				l_user_opts.disable_arguments
			end
			create l_args.make (arguments_grid.row_count)
			from
				r := 1
			until
				r > arguments_grid.row_count
			loop
				s ?= arguments_grid.row (r).data
				if s /= Void then
					l_args.extend (s)
				end
				r := r + 1
			end

			l_user_opts.set_arguments (l_args)
			l_user_opts.set_last_argument (current_argument.text)
			l_user_opts.set_working_directory (working_directory.path)

			create l_user_factory
			l_user_factory.store (lace.user_options)
			synch_with_others
		end

feature {NONE} -- GUI

	execution_frame: EV_VERTICAL_BOX is
			-- Frame widget containing argument controls.
		local
			l_frame: EV_FRAME
			vbox: EV_VERTICAL_BOX
		do
			create Result

				-- Create all widgets.

				-- Working directory.
			create l_frame.make_with_text ("Working Directory")
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
			l_frame.extend (vbox)
			create working_directory.make_with_parent (parent_window)
			vbox.extend (working_directory)

			Result.extend (l_frame)
			Result.disable_item_expand (l_frame)

			build_arguments_box
			check
				arguments_box_not_void: arguments_box /= Void
				current_argument_not_void: current_argument /= Void
				arguments_grid_not_void: arguments_grid /= Void
			end

				-- Arguments frame
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)
			vbox.set_padding (Layout_constants.Small_padding_size)
			create argument_check.make_with_text ("Enable arguments")
			vbox.extend (argument_check)
			vbox.disable_item_expand (argument_check)

			vbox.extend (arguments_box)

			create l_frame.make_with_text ("Arguments")
			l_frame.extend (vbox)

			Result.extend (l_frame)

				-- Global actions.
			pointer_leave_actions.extend (agent synch_with_others)

				-- Check button actions
			argument_check.select_actions.extend (agent arg_check_selected)
		end

	build_arguments_box is
			-- Populate 'arguments_box' with widgets and associated events.
		require
			arguments_box_void: arguments_box = Void
		local
			l_border_box: EV_VERTICAL_BOX
			l_horizontal_box: EV_HORIZONTAL_BOX
			l_cell: EV_CELL
			l_label: EV_LABEL
			add_button: EV_BUTTON
		do
			create arguments_box
			arguments_box.set_padding (Layout_constants.Small_padding_size)
			arguments_box.set_border_width (Layout_constants.Small_border_size)

				-- Arguments grid building
			create arguments_grid
			arguments_grid.hide_header
			arguments_grid.enable_border
			arguments_grid.set_separator_color (Stock_colors.default_background_color)
			arguments_grid.enable_single_row_selection
			arguments_grid.row_select_actions.extend (agent on_row_selected)
			arguments_grid.row_deselect_actions.extend (agent on_row_unselected)
			arguments_grid.resize_actions.extend (
				agent (x, y, width, height: INTEGER)
					do
						if arguments_grid.column_count > 0 then
							arguments_grid.column (1).set_width (width)
						end
					end)

			create l_border_box
			l_border_box.set_border_width (1)
			l_border_box.set_background_color (stock_colors.black)
			l_border_box.extend (arguments_grid)
			arguments_box.extend (l_border_box)

			create l_horizontal_box
			l_horizontal_box.set_padding (Layout_constants.Default_padding_size)

			create l_label.make_with_text ("Current Argument")
			l_label.align_text_left
			arguments_box.extend (l_label)
			arguments_box.disable_item_expand (l_label)

			create current_argument
			current_argument.set_minimum_height (70)
			current_argument.key_release_actions.extend (agent arg_text_changed)
			arguments_box.extend (current_argument)
			arguments_box.disable_item_expand (current_argument)

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

			arguments_box.extend (l_horizontal_box)
			arguments_box.disable_item_expand (l_horizontal_box)
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

	arguments_grid: ES_GRID
			-- Current list of arguments.

	arguments_box: EV_VERTICAL_BOX
			-- Widget containing argument settings.

	remove_button: EV_BUTTON

feature {NONE} -- Actions

	arg_check_selected is
			-- Argument check box has been selected.
		do
			set_arguments_box_state (argument_check.is_selected)
		end

	set_arguments_box_state (a_is_sensitive: BOOLEAN) is
		do
			if a_is_sensitive then
				arguments_box.enable_sensitive
				arguments_grid.set_background_color ((create {EV_STOCK_COLORS}).Color_read_write)
			else
				arguments_box.disable_sensitive
				arguments_grid.set_background_color ((create {EV_STOCK_COLORS}).Color_read_only)
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
			arguments_grid.remove_selection
		end

	add_argument is
			-- Action to take when user chooses to add a new argument.
		local
			l_row: EV_GRID_ROW
		do
			l_row := added_argument_text_row (current_argument.text, True)
			if l_row /= Void then
				l_row.enable_select
				l_row.ensure_visible
			end
		end

	added_argument_text_row (a_arg_text: STRING; store_right_after: BOOLEAN): EV_GRID_ROW is
			-- Action to take when user chooses to add a new argument.
			-- if `store_arguments' is true, store_arguments if any change occurred
		local
			s: STRING
			gi: EV_GRID_LABEL_ITEM
		do
			if a_arg_text /= Void then -- and then not a_arg_text.is_empty then
				s := a_arg_text.twin
				s.replace_substring_all ("%N", "")
				check
					no_eol: not a_arg_text.has ('%N')
				end
				Result := grid_row_with_argument (s)
				if Result = Void then
					create gi.make_with_text (s)
					gi.set_tooltip (s)
					arguments_grid.set_item (1, arguments_grid.row_count + 1, gi)
					Result := gi.row
					Result.set_data (s)
					if store_right_after then
						store_arguments
					end
				end
			end
		end

	grid_row_with_argument (s: STRING): EV_GRID_ROW is
		require
			s_not_void: s /= Void
		local
			r: INTEGER
			d: STRING
		do
			from
				r := 1
			until
				r > arguments_grid.row_count or Result /= Void
			loop
				Result := arguments_grid.row (r)
				d ?= Result.data
				if d = Void or else not d.is_equal (s) then
					Result := Void
				end
				r := r + 1
			end
		end

	remove_argument is
			-- Action to take when user chooses to remove an existing argument.
		local
			lrows: LIST [EV_GRID_ROW]
			l_row: EV_GRID_ROW
			r: INTEGER
		do
			lrows := arguments_grid.selected_rows
			if lrows.count > 0 then
				r := lrows.first.index
				arguments_grid.remove_row (r)
				if r <= arguments_grid.row_count then
					l_row := arguments_grid.row (r)
				elseif r - 1 > 0 then
					l_row := arguments_grid.row (r - 1)
				end
				if l_row /= Void then
					arguments_grid.select_row (l_row.index)
					l_row.ensure_visible
				end
				store_arguments
			end
		end

	on_row_selected (a_row: EV_GRID_ROW) is
		local
			s: STRING
			gi: EV_GRID_LABEL_ITEM
		do
			if a_row /= Void then
				if a_row.count > 0 then
					gi ?= a_row.item (1)
					if gi /= Void then
						gi.set_pixmap (pixmaps.mini_pixmaps.general_next_icon)
					end
				end
				s ?= a_row.data
			end
			if s /= Void then
				current_argument.set_text (s)
			else
				current_argument.remove_text
			end
			remove_button.enable_sensitive
		end

	on_row_unselected (a_row: EV_GRID_ROW) is
		local
			gi: EV_GRID_LABEL_ITEM
		do
			remove_button.disable_sensitive
			if a_row /= Void and then a_row.count > 0 then
				gi ?= a_row.item (1)
				if gi /= Void then
					gi.remove_pixmap
				end
			end
		end

feature {NONE} -- Implementation

	stock_colors: EV_STOCK_COLORS is
		once
			create Result
		end

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

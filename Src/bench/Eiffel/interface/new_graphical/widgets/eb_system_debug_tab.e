indexing
	description: "Graphical representation of debug tab in EB_SYSTEM_WINDOW"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SYSTEM_DEBUG_TAB

inherit
	EV_VERTICAL_BOX

	EB_SYSTEM_TAB
		rename
			make as tab_make
		undefine
			default_create, is_equal, copy
		redefine
			reset
		end

	EIFFEL_ENV
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_CONSTANTS
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

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature -- Access

	name: STRING is "Debug/Profile"
			-- Name of tab in System Window.

	arguments_control: EB_ARGUMENT_CONTROL
			-- Control containing arguments that can be given to current program execution.

feature -- System analyzis access

	debug_list: EV_MULTI_COLUMN_LIST
			-- Debug status for current system.

	debug_check: EV_CHECK_BUTTON
			-- Debug check button

	trace_check: EV_CHECK_BUTTON
			-- Trace status for current system.

	profile_check: EV_CHECK_BUTTON
			-- Profile status for current system.

feature -- Code generation access

	line_generation: EV_CHECK_BUTTON
			-- Line generation status for current system.

feature -- Parent access

	system_window: EB_SYSTEM_WINDOW
			-- Graphical parent of Current.

feature -- Store/Retrieve

	store (root_ast: ACE_SD) is
			-- Store content of widget into `root_ast'.
		local
			defaults: LACE_LIST [D_OPTION_SD]
			wd: STRING
		do
			defaults := root_ast.defaults
			if defaults = Void then
					-- No default option, we need to create them.
				create defaults.make (debug_list.count)
				root_ast.set_defaults (defaults)
			end

			defaults.finish

			store_arguments (root_ast)
			store_debug (root_ast)

			defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.line_generation, Void, line_generation.is_selected))

			if Has_profiler and then profile_check.is_sensitive then
				defaults.extend (new_special_option_sd (feature {FREE_OPTION_SD}.profile, Void, profile_check.is_selected))
			end

			if trace_check.is_sensitive then
				defaults.extend (new_trace_option_sd (trace_check.is_selected))
			end
			
		end

	retrieve (root_ast: ACE_SD) is
			-- Retrieve content of `root_ast' and update content of widget.
		local
			debug_tags: SEARCH_TABLE [STRING]
			sorted_debug_tags: SORTED_TWO_WAY_LIST [STRING]
			row: EV_MULTI_COLUMN_LIST_ROW
			debug_name: STRING
		do
			create debug_table.make (1)

			initialize_from_ast (root_ast)

			if Workbench.system_defined then
				debug_tags := System.debug_clauses
			end
			if debug_tags /= Void then
				from
					debug_tags.start
					create sorted_debug_tags.make
				until
					debug_tags.after
				loop
					sorted_debug_tags.extend (debug_tags.item_for_iteration)
					debug_tags.forth
				end

				from
					sorted_debug_tags.start
				until
					sorted_debug_tags.after
				loop
					create row
					debug_name := sorted_debug_tags.item
					row.extend (debug_name)
					if
						debug_table.has (debug_name) and then
						debug_table.item (debug_name)
					then
						row.extend (enabled_text)
					else
						row.extend (disabled_text)
					end
					row.pointer_button_press_actions.extend (~context_menu (?,?,?,?,?,?,?,?,row))
					debug_list.extend (row)
					sorted_debug_tags.forth
				end
			end

			debug_table := Void
		end

feature {NONE} -- Filling GUI

	initialize_from_ast (root_ast: ACE_SD) is
			-- Initialize window with all data taken from `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
		local
			defaults: LACE_LIST [D_OPTION_SD]
			precomp_opt: D_PRECOMPILED_SD
			opt: D_OPTION_SD
		do
			defaults := root_ast.defaults
			if defaults /= Void then
				from
					defaults.start
				until
					defaults.after
				loop
					opt := defaults.item
					precomp_opt ?= opt
					if precomp_opt = Void then
						initialize_with_default_option (opt)
						if is_item_removable then
							defaults.remove
						else
							defaults.forth
						end
					else
						defaults.forth
					end
				end
				arguments_control.update
			end
		end
		
	initialize_with_default_option (a_opt: D_OPTION_SD) is
			-- Initialize check buttons and text field associated with `a_opt'.
		require
			a_opt_not_void: a_opt /= Void
			a_opt_not_precompiled_option: not a_opt.is_precompiled
			a_opt_not_optional_option: not a_opt.is_optional
			a_opt_has_option: a_opt.option /= Void
			a_opt_has_no_precompiled_option: not a_opt.option.is_precompiled
			a_opt_has_value: a_opt.value /= Void
			debug_table_not_void: debug_table /= Void
			debug_list_not_void: debug_list /= Void
		local
			opt: OPTION_SD
			val: OPT_VAL_SD
			debug_sd: DEBUG_SD
			free_option: FREE_OPTION_SD
		do
			is_item_removable := False
			opt := a_opt.option
			val := a_opt.value
			if opt.is_debug then
				is_item_removable := True
				debug_sd ?= opt
				check
					debug_sd_not_void: debug_sd /= Void
				end
				if val.is_yes then
					enable_select (debug_check)
					update_debug_row (debug_sd.enabled, debug_list.i_th (1))
				elseif val.is_no then
					disable_select (debug_check)
				elseif val.is_name then
					debug_table.put (debug_sd.enabled, val.value)
				end
			elseif opt.is_free_option then
				free_option ?= opt
				is_item_removable := True
				inspect
					free_option.code

				when feature {FREE_OPTION_SD}.line_generation then
					set_selected (line_generation, val.is_yes)

				when feature {FREE_OPTION_SD}.working_directory then
					arguments_control.set_working_directory (val.value)

				when feature {FREE_OPTION_SD}.profile then
					if Has_profiler then
						set_selected (profile_check, val.is_yes)
					end
				else
					is_item_removable := False
				end
			elseif opt.is_optimize then
				is_item_removable := True
			elseif opt.is_trace then
				is_item_removable := True
				set_selected (trace_check, val.is_yes)
			end
		end

	debug_table: HASH_TABLE [BOOLEAN, STRING]
			-- List of debug clauses indexed by name. Items are status
			-- of debug clause.

feature {NONE} -- Filling AST

	store_arguments (root_ast: ACE_SD) is
			-- Store content of `arguments' into `root_ast'.
		do
			arguments_control.store_arguments (root_ast)
		end

	store_debug (root_ast: ACE_SD) is
			-- Store content of `debug_list' into `root_ast'.
		require
			root_ast_not_void: root_ast /= Void
			debug_list_not_void: debug_list /= Void
		local
			defaults: LACE_LIST [D_OPTION_SD]
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			defaults := root_ast.defaults

				-- Recreate all default debug option found in
				-- `debug_list'.
			from
				debug_list.start

					-- Handle special case of all debug clauses
				row := debug_list.item
				defaults.extend (new_debug_option_sd (
					row.i_th (2).is_equal (enabled_text), ""))

				debug_list.forth
			until
				debug_list.after
			loop
				row := debug_list.item
				check
					valid_row: row.count = debug_list_columns_count
				end
				defaults.extend (new_debug_option_sd (
					row.i_th (2).is_equal (enabled_text),
					row.i_th (1)))
				debug_list.forth
			end

			if not debug_list.is_sensitive then
					-- Create `debug (no)' option which will override 
					-- any previous options.
				defaults.extend (new_debug_option_sd (True, Void))
			end
		end

	new_debug_option_sd (enabled: BOOLEAN; a_name: STRING): D_OPTION_SD is
			-- Create new `D_OPTION_SD' node corresponding to a debug
			-- clause. If `enabled' it will be `debug' otherwise it will
			-- be `disabled_debug'. If `name' not void and empty, it 
			-- is equivalent to `debug (yes)' otherwise `debug (a_name)'.
			-- If `name' Void then `debug (no)'.
		local
			debug_sd: DEBUG_SD
			v: OPT_VAL_SD
		do
			create debug_sd.initialize (enabled)
			if a_name /= Void then
				if not a_name.is_empty then
					create v.make (new_id_sd (a_name, True))
				else
					create v.make_yes
				end
			else
				create v.make_no
			end
			create Result.initialize (debug_sd, v)
		end

feature -- Checking

	perform_check is
			-- Perform check on content of current pane.
		do
			set_is_valid (True)
		end

feature -- Initialization

	reset is
			-- Set graphical elements to their default value.
		do
			Precursor {EB_SYSTEM_TAB}
			disable_select (debug_check)
			clean_debug_list
			disable_select (line_generation)
			if Has_profiler then
				disable_select (profile_check)
			end
			disable_select (trace_check)
		end

feature {NONE} -- Graphical initialization

	make (top: like system_window) is
			-- Create widget corresponding to `General' tab in notebook.
		do
			system_window := top

			tab_make
			default_create

			set_border_width (Layout_constants.Small_border_size)
			set_padding (Layout_constants.Small_padding_size)

				-- Execution options notebook
			extend (execution_notebook)			

				-- Miscellaneous option
			extend (miscellaneous_frame ("Miscellaneous"))
			disable_item_expand (i_th (2))

				-- Add C specific widgets
			c_specific_widgets.extend (trace_check)
			if Has_profiler then
				c_specific_widgets.extend (profile_check)
			end
		end

	execution_notebook: EV_NOTEBOOK is
			-- A note book containing tabs for displaying system arguments
			-- and system debug options.
		local
			l_debug: EV_FRAME
		do
			create Result.default_create
				
				-- Debug clauses
			l_debug := debug_frame ("Default debug clauses")
			Result.extend (l_debug)
			Result.set_item_text (l_debug, "Default debug clauses")
				
				-- Argument Control
			create arguments_control.make (system_window.window)
			Result.extend (arguments_control)
			Result.set_item_text (arguments_control, "Program Arguments")
		end

	miscellaneous_frame (st: STRING): EV_FRAME is
			-- Frame containing all generation option
		require
			st_not_void: st /= Void
		local
			hbox: EV_HORIZONTAL_BOX
		do
			create Result.make_with_text (st)
			create hbox
			hbox.set_border_width (Layout_constants.Small_border_size)

			line_generation := new_check_button (hbox, "Line number generation")

			if Has_profiler then
				create profile_check.make_with_text ("Profiling")
				hbox.extend (profile_check)
			end

			trace_check := new_check_button (hbox, "Call tracing")

			Result.extend (hbox)
		end

	debug_frame (st: STRING): EV_FRAME is
			-- Frame containing all debug option
		require
			st_not_void: st /= Void
		local
			vbox: EV_VERTICAL_BOX
		do
			create Result.make_with_text (st)
			create vbox
			vbox.set_border_width (Layout_constants.Small_border_size)

				-- Create debug list with first element to enable/disable
				-- all debug clauses.
			create debug_list
			clean_debug_list

			create debug_check.make_with_text ("Enable debug")
			enable_select (debug_check)
			debug_check.select_actions.extend (~desactivation_action
								(debug_check, debug_list))
			vbox.extend (debug_check)
			vbox.disable_item_expand (debug_check)

			vbox.extend (debug_list)

			Result.extend (vbox)
		end

	clean_debug_list is
			-- Remove all elements of `debug_list' except first one
			-- used to enable/disable all debug clauses.
		require
			debug_list_not_void: debug_list /= Void
		local
			row: EV_MULTI_COLUMN_LIST_ROW
		do
			debug_list.wipe_out
			debug_list.set_column_titles (<<"Tag","Status">>)
			debug_list.set_column_width (Layout_constants.dialog_unit_to_pixels(200), 1)
			create row
			row.extend ("Unnamed debug clauses")
			row.extend (disabled_text)
			row.pointer_button_press_actions.extend (~context_menu (?,?,?,?,?,?,?,?,row))
			debug_list.extend (row)
		end

feature {NONE} -- Action

	context_menu (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER; a_row: EV_MULTI_COLUMN_LIST_ROW) is
			-- Action performed on right click on `a_row' from `debug_list' which
			-- pops up a menu to prompt user to choose status of selected debug clause.
		require
			a_row_not_void: a_row /= Void
			a_row_valid: a_row.count = debug_list_columns_count
		local
			menu: EV_MENU
			menu_item: EV_MENU_ITEM
			status: STRING
			enable: BOOLEAN
		do
			if a_button = 3 then
				status := a_row.i_th (2)
				create menu
				if status.is_equal (enabled_text) then
					create menu_item.make_with_text ("Disable")
				else
					enable := True
					create menu_item.make_with_text ("Enable")
				end
				menu_item.select_actions.extend (~update_debug_row (enable, a_row))
				menu.extend (menu_item)
				menu.show
			end
		end

	update_debug_row (enabled: BOOLEAN; a_row: EV_MULTI_COLUMN_LIST_ROW) is
		require
			a_row_not_void: a_row /= Void
			a_row_valid: a_row.count = debug_list_columns_count
		do
				-- Update text of second columns with choice made by user.
			a_row.go_i_th (2)
			if enabled then
				a_row.replace (enabled_text)
			else
				a_row.replace (disabled_text)
			end
		end

feature {NONE} -- Constants

	enabled_text: STRING is "enabled"
	disabled_text: STRING is "disabled"
			-- Text for status of debug statement.

	debug_list_columns_count: INTEGER is 2
			-- Number of columns in `debug_list'.

	Default_item_padding: INTEGER is 2
			-- Padding for items (label + textfield/combo)

invariant

	arguments_not_void: arguments_control /= Void
	debug_check_not_void: debug_check /= Void
	debug_list_not_void: debug_list /= Void
	debug_list_not_empty: not debug_list.is_empty
	line_generation_not_void: line_generation /= Void
	profile_check_not_void: Has_profiler implies profile_check /= Void
	trace_check_not_void: trace_check /= Void

end -- class EB_SYSTEM_DEBUG_TAB

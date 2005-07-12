indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class 
	ES_OBJECTS_TOOL

inherit
	REFACTORING_HELPER

	ES_OBJECTS_GRID_MANAGER
		rename
			objects_grid_item as get_object_display_item
		end

	ES_NOTEBOOK_ATTACHABLE

	EB_TOOL
		redefine
			menu_name,
			pixmap,
			make
		end

	EB_RECYCLABLE
		export
			{NONE} all
		end

	SHARED_APPLICATION_EXECUTION
		export
			{NONE} all
		end

	IPC_SHARED
		export
			{NONE} all
		end

	SHARED_DEBUG
		export
			{NONE} all
		end

	VALUE_TYPES
		export
			{NONE} all
		end

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	DEBUGGING_UPDATE_ON_IDLE
		redefine
			update,
			real_update
		end

create 
	make

feature {NONE} -- Initialization

	make (a_manager: EB_TOOL_MANAGER) is
			-- Initialize `Current'.
		do
			min_slice_ref.set_item (preferences.debug_tool_data.min_slice)
			max_slice_ref.set_item (preferences.debug_tool_data.max_slice)
			Precursor {EB_TOOL} (a_manager)
			display_first_attributes := True
			display_first_onces := False
			display_first_special := True
			display_first := True
			debugged_objects_grid_empty := True
			stack_objects_grid_empty := True
			cleaning_timer_delay := Preferences.debug_tool_data.delay_before_cleaning_objects_grid
		end

	build_interface is
			-- Build all the tool's widgets.
		local
			esgrid: ES_OBJECTS_GRID
			l_box: EV_HORIZONTAL_BOX
		do
			create displayed_objects.make
				--| Stack obj grid
			create esgrid.make ("Stack objects")
			esgrid.set_column_count_to (4)
			esgrid.column (col_name_index).set_title (col_titles @ col_name_index)
			esgrid.column (col_name_index).set_width (150)
			esgrid.column (col_address_index).set_title (col_titles @ col_address_index)
			esgrid.column (col_address_index).set_width (80)
			esgrid.column (col_value_index).set_title (col_titles @ col_value_index)
			esgrid.column (col_value_index).set_width (150)
			esgrid.column (col_type_index).set_title (col_titles @ col_type_index)
			esgrid.column (col_type_index).set_width (200)
			esgrid.set_mouse_wheel_scroll_size (preferences.editor_data.mouse_wheel_scroll_size)
			esgrid.set_mouse_wheel_scroll_full_page (preferences.editor_data.mouse_wheel_scroll_full_page)

			esgrid.set_item_veto_pebble_function (agent on_stacks_veto_pebble_function)
			esgrid.item_drop_actions.extend (agent on_drop_stack_element)
			esgrid.key_press_actions.extend (agent debug_value_key_action (esgrid, ?))
			esgrid.row_select_actions.extend (agent on_stack_objects_row_selected)
			

			stack_objects_grid := esgrid

				--| Debugged obj grid
			create esgrid.make ("Debugged objects")
			esgrid.set_column_count_to (4)
			esgrid.column (col_name_index).set_title (col_titles @ col_name_index)
			esgrid.column (col_name_index).set_width (150)
			esgrid.column (col_address_index).set_title (col_titles @ col_address_index)
			esgrid.column (col_address_index).set_width (80)
			esgrid.column (col_value_index).set_title (col_titles @ col_value_index)
			esgrid.column (col_value_index).set_width (150)
			esgrid.column (col_type_index).set_title (col_titles @ col_type_index)
			esgrid.column (col_type_index).set_width (200)
			esgrid.set_mouse_wheel_scroll_size (preferences.editor_data.mouse_wheel_scroll_size)
			esgrid.set_mouse_wheel_scroll_full_page (preferences.editor_data.mouse_wheel_scroll_full_page)

			esgrid.set_item_veto_pebble_function (agent on_debugged_objects_veto_pebble_function)
			esgrid.item_drop_actions.extend (agent on_add_debugged_object)
			esgrid.key_press_actions.extend (agent debugged_object_key_action)
			esgrid.key_press_actions.extend (agent debug_value_key_action (esgrid, ?))
			esgrid.row_select_actions.extend (agent on_debugged_objects_row_selected)
			esgrid.row_deselect_actions.extend (agent on_debugged_objects_row_deselected)
			
			debugged_objects_grid := esgrid

			create split
			
				-- The `stack_objects_grid' and `debugged_objects_grid' are
				-- inserted into a temporary box to provide a padding of one pixel
				-- so that it appears that they have a border. This makes the distinction
				-- between the edges of the control and the split area more pronounced.
				
			create l_box
			l_box.set_border_width (1)
			l_box.set_background_color ((create {EV_STOCK_COLORS}).gray)
			split.set_first (l_box)
			l_box.extend (stack_objects_grid)
			create l_box
			l_box.set_border_width (1)
			l_box.set_background_color ((create {EV_STOCK_COLORS}).gray)
			split.set_second (l_box)
			l_box.extend (debugged_objects_grid)
			expand_result := True
			expand_args := True
			expand_locals := True
			widget := split
			create_update_on_idle_agent
		end

	build_mini_toolbar is
			-- Build associated tool bar
		local
			tbb: EV_TOOL_BAR_BUTTON
		do
			create mini_toolbar

				--| Delete command
			create remove_debugged_object_cmd.make
			remove_debugged_object_cmd.set_mini_pixmaps (pixmaps.small_pixmaps.icon_delete)
			remove_debugged_object_cmd.set_tooltip (Interface_names.e_Remove_object)
			remove_debugged_object_cmd.add_agent (agent remove_selected_debugged_objects)
			tbb := remove_debugged_object_cmd.new_mini_toolbar_item
			tbb.drop_actions.extend (agent remove_dropped_debugged_object)
			tbb.drop_actions.set_veto_pebble_function (agent is_removable_debugged_object)
			remove_debugged_object_cmd.enable_sensitive

			mini_toolbar.extend (tbb)

			create slices_cmd.make (Current)
			slices_cmd.enable_sensitive
			mini_toolbar.extend (slices_cmd.new_mini_toolbar_item)

			create pretty_print_cmd.make
			pretty_print_cmd.enable_sensitive
			mini_toolbar.extend (pretty_print_cmd.new_mini_toolbar_item)

			create hex_format_cmd.make (agent set_hexadecimal_mode (?))
			hex_format_cmd.enable_sensitive
			mini_toolbar.extend (hex_format_cmd.new_mini_toolbar_item)
		ensure
			mini_toolbar_exists: mini_toolbar /= Void
		end

	build_explorer_bar_item (explorer_bar: EB_EXPLORER_BAR) is
			-- Build the associated explorer bar item and
			-- Add it to `explorer_bar'
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end
			if header_box = Void then
				build_header_box
			end			
			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_info (explorer_bar, widget, title, False, header_box, mini_toolbar)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

	build_notebook_item (nb: ES_NOTEBOOK) is
		do
			if mini_toolbar = Void then
				build_mini_toolbar
			end
			if header_box = Void then
				build_header_box
			end
			create notebook_item.make_with_info (nb, widget, title, header_box, mini_toolbar)
			nb.extend (notebook_item)
			notebook_item.drop_actions.extend (agent add_debugged_object)
			notebook_item.drop_actions.extend (agent drop_stack_element)			
		end
	
feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Associated mini tool bar.
			
	header_box: EV_HORIZONTAL_BOX
			-- Associated header box

	widget: EV_WIDGET
			-- Widget representing Current.

	title: STRING is
			-- Title of the tool.
		do
			Result := interface_names.t_object_tool
		end

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := interface_names.m_object_tools
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
		end

	debugger_manager: EB_DEBUGGER_MANAGER
			-- Manager in charge of all debugging operations.

feature {NONE} -- Notebook item's behavior

	clean_header_box is
		do
			if header_box /= Void then
				header_box.wipe_out
			end
		ensure
			header_box /= Void implies header_box.is_empty
		end
		
	build_header_box is
		do
			create header_box
		ensure
			header_box /= Void
		end
		
	update_header_box (dbg_stopped: BOOLEAN) is
		require
			header_box /= Void
		local
			ecse: EIFFEL_CALL_STACK_ELEMENT
			lab, flab, clab: EV_LABEL
			l_fstone: FEATURE_STONE
			l_cstone: CLASSC_STONE
			hbox: EV_BOX
			sep: EV_CELL
		do
			clean_header_box
			hbox := header_box
			create sep
			sep.set_minimum_width (30)
			hbox.extend (sep)
			hbox.disable_item_expand (sep)
			if 
				Application.is_running
			then
				if Application.is_stopped and then dbg_stopped then
					if not Application.current_call_stack_is_empty then
						ecse ?= current_stack_element
						if ecse /= Void then
							create lab.make_with_text ("{")
							hbox.extend (lab)
							hbox.disable_item_expand (lab)
							
							create clab.make_with_text (ecse.dynamic_class.name_in_upper)
							create l_cstone.make (ecse.dynamic_class)
							clab.set_pebble (l_cstone)
							clab.set_accept_cursor (l_cstone.stone_cursor)
							clab.set_deny_cursor (l_cstone.x_stone_cursor)
							clab.set_foreground_color (preferences.editor_data.class_text_color)
							hbox.extend (clab)
							hbox.disable_item_expand (clab)
							
							create lab.make_with_text ("}.")
							hbox.extend (lab)
							hbox.disable_item_expand (lab)
							
							create flab.make_with_text (ecse.routine_name)
							create l_fstone.make (ecse.routine)
							flab.set_pebble (l_fstone)
							flab.set_accept_cursor (l_fstone.stone_cursor)
							flab.set_deny_cursor (l_fstone.x_stone_cursor)
							flab.set_foreground_color (preferences.editor_data.feature_text_color)
							hbox.extend (flab)
							hbox.disable_item_expand (flab)
						end
					else
						create lab
						hbox.extend (lab)
						hbox.disable_item_expand (lab)
					end
				else
					create lab.make_with_text (Interface_names.l_System_running)
					hbox.extend (lab)
					hbox.disable_item_expand (lab)
				end
			else
				create lab.make_with_text (Interface_names.l_System_not_running)
				hbox.extend (lab)
				hbox.disable_item_expand (lab)
			end
			
			hbox.extend (create {EV_CELL})
		end
		
feature {ES_OBJECTS_GRID_SLICES_CMD} -- Query

	get_object_display_item (addr: STRING): ES_OBJECTS_GRID_LINE is
			-- Return managed object located at address `addr'.
		local
			found: BOOLEAN
		do
			from
				displayed_objects.start
			until
				displayed_objects.after or else found
			loop
				Result := displayed_objects.item
				check
					Result.object_address /= Void
				end
				found := Result.object_address.is_equal (addr)
				displayed_objects.forth
			end
			if not found then
				Result := Void
			end
		end
	
feature -- Properties setting

	hexadecimal_mode_enabled: BOOLEAN

	set_hexadecimal_mode (v: BOOLEAN) is
		local
			i: INTEGER
		do
			hexadecimal_mode_enabled := v
				--| update : Stack objects grid
			from
				i := 1
			until
				i > stack_objects_grid.row_count
			loop
				propagate_hexadecimal_mode (stack_objects_grid.row (i))
				i := i + 1
			end

				--| update : Objects grid
			from
				i := 1
			until
				i > debugged_objects_grid.row_count
			loop
				propagate_hexadecimal_mode (debugged_objects_grid.row (i))
				i := i + 1
			end
		end

	propagate_hexadecimal_mode (t: EV_GRID_ROW) is
		local
			l_eb_t: ES_OBJECTS_GRID_LINE
		do
			l_eb_t ?= t.data
			if l_eb_t /= Void then
				l_eb_t.update_value
			end
		end

feature {NONE} -- Row actions	

	on_stack_objects_row_selected (row: EV_GRID_ROW) is
			-- An item in the grid of stacks object was selected.
		do
			remove_debugged_object_cmd.disable_sensitive
		end

	on_debugged_objects_row_selected (row: EV_GRID_ROW) is
			-- An item in the list of expression was selected.
		do
			remove_debugged_object_cmd.enable_sensitive
		end

	on_debugged_objects_row_deselected (row: EV_GRID_ROW) is
			-- An item in the list of expression was selected.
		do
			remove_debugged_object_cmd.disable_sensitive
		end

feature -- Change

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			conv_stack: CALL_STACK_STONE
		do
			debug ("debug_recv")
				print ("ES_OBJECTS_TOOL.set_stone%N")
			end
			if can_refresh then
				conv_stack ?= a_stone
				if conv_stack /= Void then
					if application.status.is_stopped then
						clean_stack_objects_grid
						build_stack_objects_grid
						clean_debugged_objects_grid
						build_debugged_objects_grid
					end
				end
				if header_box /= Void then
					update_header_box (True)
				end
			end
		end

	enable_refresh is
			-- Set `can_refresh' to `True'.
		do
			can_refresh := True
		end

	disable_refresh is
			-- Set `can_refresh' to `False'.
		do
			can_refresh := False
		end

--| Not used for now, check if this was needed before ?
--	refresh is
--			-- Class has changed in `development_window'.
--		do
--			clean_stack_objects_grid
--			build_stack_objects_grid
--			clean_debugged_objects_grid
--			build_debugged_objects_grid
--		end

	update is
			-- Display current execution status.
		local
			l_status: APPLICATION_STATUS
		do
			cancel_process_real_update_on_idle
			l_status := application.status
			if l_status /= Void then
				process_real_update_on_idle (l_status.is_stopped)
			end
		end

	set_debugger_manager (a_manager: like debugger_manager) is
			-- Affect `a_manager' to `debugger_manager'.
		do
			debugger_manager := a_manager
		end

	change_manager_and_explorer_bar (a_manager: EB_TOOL_MANAGER; an_explorer_bar: EB_EXPLORER_BAR) is
			-- Change the window and explorer bar `Current' is in.
		require
			a_manager_exists: a_manager /= Void
			an_explorer_bar_exists: an_explorer_bar /= Void
		do
			if explorer_bar_item.is_visible then
				explorer_bar_item.close
			end
			explorer_bar_item.recycle
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end
	
feature -- Status report

	can_refresh: BOOLEAN
			-- Should we display the trees when a stone is set?
	
feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			preferences.debug_tool_data.min_slice_preference.set_value (min_slice_ref.item)
			preferences.debug_tool_data.max_slice_preference.set_value (max_slice_ref.item)
			debugger_manager.kept_objects.wipe_out
			displayed_objects.wipe_out
			pretty_print_cmd.end_debug
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			if current_object /= Void then
				display_first := current_object.display
				display_first_attributes := current_object.display_attributes
				display_first_onces := current_object.display_onces
				current_object.recycle
				current_object := Void
			end
			clean_stack_objects_grid
			clean_debugged_objects_grid
			clean_header_box
		end
	
feature {EB_DEBUGGER_MANAGER} -- Cleaning timer change

	set_cleaning_timer_delay (ms: INTEGER) is
		require
			timer_delay_positive_or_null: ms >= 0
		do
			cleaning_timer_delay := ms
		ensure
			cleaning_timer_delay = ms
		end

feature -- Disable refresh grid

	disable_grid_redraw is
		do
			stack_objects_grid.disable_grid_redraw
			debugged_objects_grid.disable_grid_redraw
		end

	enable_grid_redraw is
		do
			stack_objects_grid.enable_grid_redraw
			debugged_objects_grid.enable_grid_redraw
		end

feature {NONE} -- Layout Implementation

	cleaning_timer_delay: INTEGER
		-- Number of milliseconds waited before clearing debug output.
		-- By waiting for a short period of time, the flicker is removed
		-- for normal debug usage as it is only cleared immediately before
		-- being rebuilt, unless the timer period has been exceeded.
		
	stack_objects_grid_empty: BOOLEAN

	clean_stack_objects_grid is
		do
			cancel_delayed_clean_stack_objects_grid

			record_stack_layout
			internal_locals_row := Void
			internal_arguments_row := Void
			internal_result_row := Void
			
			stack_objects_grid.enable_grid_redraw
			if not stack_objects_grid_empty then
				stack_objects_grid.remove_and_clear_all_rows
				stack_objects_grid_empty := True
			end
		ensure
			stack_objects_grid_cleaned: stack_objects_grid_empty
			stack_objects_grid_clear_timer_destroyed: stack_objects_grid_clear_timer = Void			
		end

	stack_objects_grid_clear_timer: EV_TIMEOUT

	cancel_delayed_clean_stack_objects_grid is
		do
			if stack_objects_grid_clear_timer /= Void then
				stack_objects_grid.enable_sensitive
				stack_objects_grid_clear_timer.actions.wipe_out
				stack_objects_grid_clear_timer.destroy
				stack_objects_grid_clear_timer := Void
			end
		ensure
			stack_objects_grid_clear_timer_destroyed: stack_objects_grid_clear_timer = Void			
		end
		
	request_delayed_clean_stack_objects_grid is
		do
			if cleaning_timer_delay = 0 then
				clean_stack_objects_grid
			elseif stack_objects_grid_clear_timer = Void then
				stack_objects_grid.disable_sensitive
				create stack_objects_grid_clear_timer.make_with_interval (cleaning_timer_delay)
				stack_objects_grid_clear_timer.actions.extend (agent clean_stack_objects_grid)
			end
		ensure
			stack_objects_grid_clear_timer_created: cleaning_timer_delay >0 implies stack_objects_grid_clear_timer /= Void
		end

	debugged_objects_grid_empty: BOOLEAN
	clean_debugged_objects_grid is
		do
			cancel_delayed_clean_debugged_objects_grid
			record_objects_layout
			debugged_objects_grid.enable_grid_redraw
			if not debugged_objects_grid_empty then
				debugged_objects_grid.remove_and_clear_all_rows
				debugged_objects_grid_empty := True
			end
		ensure
			debugged_objects_grid_cleaned: debugged_objects_grid_empty	
			debugged_objects_grid_clear_timer_destroyed: debugged_objects_grid_clear_timer = Void
		end

	debugged_objects_grid_clear_timer: EV_TIMEOUT

	cancel_delayed_clean_debugged_objects_grid is
		do
			if debugged_objects_grid_clear_timer /= Void then
				debugged_objects_grid.enable_sensitive				
				debugged_objects_grid_clear_timer.actions.wipe_out
				debugged_objects_grid_clear_timer.destroy
				debugged_objects_grid_clear_timer := Void
			end
		ensure
			debugged_objects_grid_clear_timer_destroyed: debugged_objects_grid_clear_timer = Void
		end

	request_delayed_clean_debugged_objects_grid is
		do
			if cleaning_timer_delay = 0 then
				clean_debugged_objects_grid
			elseif debugged_objects_grid_clear_timer = Void then
				debugged_objects_grid.disable_sensitive
				create debugged_objects_grid_clear_timer.make_with_interval (cleaning_timer_delay)
				debugged_objects_grid_clear_timer.actions.extend (agent clean_debugged_objects_grid)
			end
		ensure
			debugged_objects_grid_clear_timer_created: cleaning_timer_delay >0 implies debugged_objects_grid_clear_timer /= Void
		end

	record_objects_layout is
		do
			if current_object /= Void then
				current_object.record_layout
			end
		end

	record_stack_layout is
		do
			if stack_objects_grid.row_count > 0 then
				if internal_locals_row /= Void and then internal_locals_row.parent /= Void then
					expand_locals := internal_locals_row.is_expanded
				end
				if internal_arguments_row /= Void and then internal_arguments_row.parent /= Void then
					expand_args := internal_arguments_row.is_expanded
				end
				if internal_result_row /= Void and then internal_result_row.parent /= Void then
					expand_result := internal_result_row.is_expanded
				end
			end
		end

	expand_result: BOOLEAN
			-- Should the "Result" tree item be expanded?

	expand_args: BOOLEAN
			-- Should the "Arguments" tree item be expanded?

	expand_locals: BOOLEAN
			-- Should the "Locals" tree item be expanded?

feature {NONE} -- Commands Implementation

	remove_debugged_object_cmd: EB_STANDARD_CMD
			-- Command that is used to remove objects from the tree.

feature {NONE} -- Implementation

	current_stack_element: CALL_STACK_ELEMENT is
			-- Stack element currently displayed in `stack_objects_grid'.
		do
			Result := application.status.current_call_stack_element
		end

	split: EV_HORIZONTAL_SPLIT_AREA
			-- Split area that contains both `stack_objects_grid' and `debugged_objects_grid'.

	real_update (dbg_was_stopped: BOOLEAN) is
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running
		local
			l_status: APPLICATION_STATUS
		do
			l_status := application.status
			if l_status /= Void then
				pretty_print_cmd.refresh
				request_delayed_clean_stack_objects_grid
				request_delayed_clean_debugged_objects_grid
				if l_status.is_stopped and dbg_was_stopped then
					if l_status.has_valid_call_stack and then l_status.has_valid_current_eiffel_call_stack_element then
						cancel_delayed_clean_debugged_objects_grid

						clean_stack_objects_grid
						build_stack_objects_grid

						clean_debugged_objects_grid
						build_debugged_objects_grid
					end
				else
					if current_object /= Void then
						display_first := current_object.display
						display_first_attributes := current_object.display_attributes
						display_first_onces := current_object.display_onces
					end
				end
			end
			if header_box /= Void then
				update_header_box (dbg_was_stopped)
			end
		end
	
feature {NONE} -- Current objects grid Implementation

	debugged_objects_grid: ES_OBJECTS_GRID

	displayed_objects: LINKED_LIST [ES_OBJECTS_GRID_LINE]
			-- All displayed objects, their addresses, types and display options.

	build_debugged_objects_grid is
			-- Create the rows that contains object information.
		require
			debugged_objects_grid_empty: debugged_objects_grid_empty
		local
			value: ABSTRACT_DEBUG_VALUE
			cse: EIFFEL_CALL_STACK_ELEMENT
			item: ES_OBJECTS_GRID_LINE
		do
			debugged_objects_grid_empty := False

			debug ("debug_recv")
				print (generator + ".build_object_grid%N")
			end
			if current_object /= Void then
				display_first 			 := current_object.display
				display_first_attributes := current_object.display_attributes
				display_first_onces		 := current_object.display_onces
			end
			current_object := Void
			if Application.is_dotnet then
				if not Application.current_call_stack_is_empty then
					value := application.imp_dotnet.status.current_call_stack_element_dotnet.current_object
					if value /= Void then
						create {ES_OBJECTS_GRID_VALUE_LINE} current_object.make_with_value (value, Current)
					end
				end
			else
				cse ?= current_stack_element
				check
					cse /= Void
				end
				create {ES_OBJECTS_GRID_ADDRESS_LINE} current_object.make_with_call_stack_element (cse, Current)
			end
			if current_object /= Void then
				current_object.set_display (display_first)
				current_object.set_display_attributes (display_first_attributes)
				current_object.set_display_onces (display_first_onces)
				item := current_object
				if item.title /= Void then
					item.set_title (Interface_names.l_Current_object + ": " + item.title)
				else
					item.set_title (Interface_names.l_Current_object)
				end
				item.attach_to_row (debugged_objects_grid.front_new_row)
				if application.is_running and then application.is_stopped then
					current_object.compute_grid_display
				end
			end
			add_displayed_objects_to_grid (debugged_objects_grid)
			if debugged_objects_grid.row_count > 0 then
					--| be sure the grid is redrawn, and the first row is visible
				debugged_objects_grid.row (1).ensure_visible
				debugged_objects_grid.row (1).redraw
			end
		end

	add_displayed_objects_to_grid (a_target_grid: ES_OBJECTS_GRID) is
		local
			item: ES_OBJECTS_GRID_LINE
		do
			from
				displayed_objects.start
			until
				displayed_objects.after
			loop
				item := displayed_objects.item
				if item.is_attached_to_row then
					item.unattach
				end
				item.attach_to_row (a_target_grid.extended_new_row)
				displayed_objects.forth
			end
		end
		
feature {NONE} -- Impl : Debugged objects grid specifics

	debugged_object_key_action (k: EV_KEY) is
			-- Actions performed when a key is pressed on a top-level object.
			-- Handle `Del'.
		do
			inspect
				k.code
			when {EV_KEY_CONSTANTS}.key_delete then
				remove_debugged_object_cmd.execute
			else

			end
		end

	on_debugged_objects_veto_pebble_function (a_item: EV_GRID_ITEM; a_pebble: ANY): BOOLEAN is
		local
			st: OBJECT_STONE
		do
			st ?= a_pebble
			Result := st /= Void
		end

	on_add_debugged_object (a_item: EV_GRID_ITEM; st: OBJECT_STONE) is
		do
			add_debugged_object (st)
		end

	add_debugged_object (a_stone: OBJECT_STONE) is
			-- Add the object represented by `a_stone' to the managed objects.
		local
			n_obj: ES_OBJECTS_GRID_LINE
			conv_spec: SPECIAL_VALUE
			abstract_value: ABSTRACT_DEBUG_VALUE
			exists: BOOLEAN
			l_item: EV_ANY
		do
			debug ("debug_recv")
				print (generator + ".add_object%N")
			end
			from
				displayed_objects.start
			until
				displayed_objects.after or else exists
			loop
				n_obj := displayed_objects.item
				check
					n_obj.object_address /= Void
				end
				exists := n_obj.object_address.is_equal (a_stone.object_address)
				displayed_objects.forth
			end
			n_obj := Void
			if not exists then
				l_item := a_stone.ev_item
				if application.is_dotnet then
					abstract_value ?= grid_data_from_widget (l_item)
--| FIXME jfiat : check if it is safe to use a Value ?
--					if abstract_value /= Void then
--						create {ES_OBJECTS_GRID_VALUE_LINE} n_obj.make_with_value (abstract_value, Current)
--					else
						create {ES_OBJECTS_GRID_ADDRESS_LINE} n_obj.make_with_address (a_stone.object_address, a_stone.dynamic_class, Current)
--					end
				else
					if l_item /= Void then
						conv_spec ?= grid_data_from_widget (l_item)
						if conv_spec /= Void then
							create {ES_OBJECTS_GRID_VALUE_LINE} n_obj.make_with_value (conv_spec, Current)
						end
					end
					if n_obj = Void then
						create {ES_OBJECTS_GRID_ADDRESS_LINE} n_obj.make_with_address (a_stone.object_address, a_stone.dynamic_class, Current)
					end
				end
				n_obj.set_title (a_stone.name + Left_address_delim + a_stone.object_address + Right_address_delim)
				debugger_manager.keep_object (a_stone.object_address)
				displayed_objects.extend (n_obj)
				debugged_objects_grid.insert_new_row (debugged_objects_grid.row_count + 1)
				n_obj.attach_to_row (debugged_objects_grid.row (debugged_objects_grid.row_count))
				n_obj.row.ensure_visible
				n_obj.row.enable_select
			end
		end
		
	remove_dropped_debugged_object (ost: OBJECT_STONE) is
		local
			row: EV_GRID_ROW
			gline: ES_OBJECTS_GRID_LINE
		do
			row ?= ost.ev_item
			if row /= Void then
				gline ?= row.data
				if gline /= Void then
					remove_debugged_object_line (gline)
				end
			end
		end

	remove_selected_debugged_objects is
		local
			glines: LIST [ES_OBJECTS_GRID_LINE]
		do
			glines := selected_debugged_object_lines
			if glines /= Void then
				from
					glines.start
				until
					glines.after
				loop
					check glines.item /= Void end
					remove_debugged_object_line (glines.item)
					glines.forth
				end
			end
		end

	remove_debugged_object_line (gline: ES_OBJECTS_GRID_LINE) is
		local
			row: EV_GRID_ROW
		do
			row := gline.row
			displayed_objects.prune_all (gline)
			debugged_objects_grid.remove_row (row.index)
		end

	selected_debugged_object_lines: LINKED_LIST [ES_OBJECTS_GRID_LINE] is
		local
			row: EV_GRID_ROW
			rows: ARRAYED_LIST [EV_GRID_ROW]
			gline: ES_OBJECTS_GRID_LINE
		do
			rows := debugged_objects_grid.selected_rows
			if not rows.is_empty then
				from
					rows.start
					create Result.make
				until
					rows.after
				loop
					row := rows.item
					if row.parent_row /= Void then
						row := row.parent_row_root
					end
					gline ?= row.data
					if gline /= Void then
						Result.extend (gline)
					end
					rows.forth
				end
			end
		end

	is_removable_debugged_object (ost: OBJECT_STONE): BOOLEAN is
		local
			addr: STRING
		do
			addr := ost.object_address
			from
				displayed_objects.start
			until
				displayed_objects.after or else Result
			loop
				Result := displayed_objects.item.object_address.is_equal (addr)
				displayed_objects.forth
			end
		end			
	
feature {NONE} -- Impl : Stack objects grid

	stack_objects_grid: ES_OBJECTS_GRID
			-- Graphical GRID displaying local variables, arguments and the result.

	internal_locals_row: EV_GRID_ROW

	internal_arguments_row: EV_GRID_ROW

	internal_result_row: EV_GRID_ROW

	build_stack_objects_grid is
		require
			stack_objects_grid_empty: stack_objects_grid_empty
		local
			row: EV_GRID_ROW
		do
			stack_objects_grid_empty := False
			build_stack_info (stack_objects_grid)
			build_stack_objects (stack_objects_grid)
			if stack_objects_grid.row_count > 0 then
				row := stack_objects_grid.row (1)
				row.ensure_visible
			end
		end

	build_stack_info (a_target_grid: ES_OBJECTS_GRID) is
			-- Create the grid rows that contains call stack info
		do
			if Application.current_call_stack_is_empty then
				build_exception_info (a_target_grid)
			else
				build_exception_info (a_target_grid)
			end
		end

	build_stack_objects (a_target_grid: ES_OBJECTS_GRID) is
			-- Create the tree that contains locals (Result) and parameters.
		local
			cse: EIFFEL_CALL_STACK_ELEMENT
		do
			if not Application.current_call_stack_is_empty then
				cse ?= current_stack_element
				if cse /= Void then
						--| Build other stack part
					build_arguments_row (a_target_grid, cse)
					if internal_arguments_row /= Void and expand_args then
						internal_arguments_row.expand
					end
					build_locals_row (a_target_grid, cse)
					if internal_locals_row /= Void and expand_locals then
						internal_locals_row.expand
					end
					build_result_row (a_target_grid, cse)
					if internal_result_row /= Void and expand_result then
						internal_result_row.expand
					end
				end
			end
		end

	show_exception_dialog (a_tag, a_msg: STRING) is
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG
		do
			create dlg.make (a_tag, a_msg)
			dlg.show_modal_to_window (debugger_manager.debugging_window.window)
		end

	build_exception_info (a_target_grid: ES_OBJECTS_GRID) is
			-- Display exception info
			-- for now only for Dotnet systems
		local
			row: EV_GRID_ROW
			exception_row: EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			es_glab: ES_OBJECTS_GRID_CELL
			l_exception_module_detail: STRING
			l_exception_tag, l_exception_message: STRING
		do
			if application.is_dotnet and then application.imp_dotnet.exception_occurred then
				l_exception_module_detail := application.imp_dotnet.exception_module_name
				if l_exception_module_detail /= Void then
						--| Details
					exception_row := a_target_grid.extended_new_row
					glab := folder_label_item (Cst_exception_raised_text)
					a_target_grid.grid_cell_set_pixmap (glab, Pixmaps.icon_debugger_exception)
					exception_row.set_item (1, glab)
					create glab
					if application.imp_dotnet.exception_handled then
						a_target_grid.grid_cell_set_text (glab, Cst_exception_first_chance_text)
					else
						a_target_grid.grid_cell_set_text (glab, Cst_exception_unhandled_text)
					end
					exception_row.set_item (2, glab)

						--| Tag
					l_exception_tag := application.imp_dotnet.exception_message
					if l_exception_tag /= Void then
						row := a_target_grid.extended_new_subrow (exception_row)
						glab := name_label_item ("Tag")
						a_target_grid.grid_cell_set_pixmap (glab, pixmaps.small_pixmaps.icon_dbg_error)
						row.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_tag)
						a_target_grid.grid_cell_set_text (es_glab, l_exception_tag)
						row.set_item (2, es_glab)
					end

						--| Module
					row := a_target_grid.extended_new_subrow (exception_row)
					glab := name_label_item ("Module")
					a_target_grid.grid_cell_set_pixmap (glab, pixmaps.small_pixmaps.icon_dbg_error)
					row.set_item (1, glab)
					create es_glab
					es_glab.set_data (l_exception_module_detail)
					a_target_grid.grid_cell_set_text (es_glab, l_exception_module_detail)
					row.set_item (2, es_glab)

						--| Nota/Message
					l_exception_message := application.imp_dotnet.exception_to_string
					if l_exception_message /= Void and then not l_exception_message.is_empty then
						row := a_target_grid.extended_new_subrow (exception_row)
						glab := name_label_item ("Nota")
						a_target_grid.grid_cell_set_pixmap (glab, pixmaps.small_pixmaps.icon_dbg_error)
						row.set_item (1, glab)
						create es_glab
						es_glab.set_data (l_exception_message)
						a_target_grid.grid_cell_set_text (es_glab, cst_exception_double_click_text)
						a_target_grid.grid_cell_set_tooltip (es_glab, l_exception_message)
						es_glab.pointer_double_press_actions.force_extend (agent show_exception_dialog (l_exception_tag, l_exception_message))
						row.set_item (2, es_glab)
					end
				end
			end
		end

	Cst_exception_double_click_text: STRING is "Double click to see Exception or Ctrl-C to copy to clipboard"

	Cst_exception_raised_text: STRING is "Exception raised"

	Cst_exception_first_chance_text: STRING is "First chance"

	Cst_exception_unhandled_text: STRING is "UnHandled"

	build_result_row (a_target_grid: ES_OBJECTS_GRID; cse: EIFFEL_CALL_STACK_ELEMENT) is
			-- Create the row containing Result
		require
			call_stack_not_void: cse /= Void
		local
			dv: ABSTRACT_DEBUG_VALUE
			glab: EV_GRID_LABEL_ITEM
		do
			if cse.has_result then
				internal_result_row := a_target_grid.extended_new_row
				glab := folder_label_item (Interface_names.l_result)
				a_target_grid.grid_cell_set_pixmap (glab, Pixmaps.Icon_feature_clause_any)
				internal_result_row.set_item (1, glab)
				dv := cse.result_value
				if dv /= Void then
					add_debug_value_to_grid_row (internal_result_row, dv)
				end
			else
				internal_result_row := Void
			end
		end

	build_arguments_row (a_target_grid: ES_OBJECTS_GRID; cse: EIFFEL_CALL_STACK_ELEMENT) is
			-- Create the row containing arguments
		require
			call_stack_not_void: cse /= Void
		local
			glab: EV_GRID_LABEL_ITEM
			list: LIST [ABSTRACT_DEBUG_VALUE]
		do
			list := cse.arguments
			if list /= Void and then not list.is_empty then
				internal_arguments_row := a_target_grid.extended_new_row
				glab := folder_label_item (Interface_names.l_Arguments)
				a_target_grid.grid_cell_set_pixmap (glab, Pixmaps.Icon_feature_clause_any)
				internal_arguments_row.set_item (1, glab)
				from
					list.start
				until
					list.after
				loop
					add_debug_value_to_grid_row (internal_arguments_row, list.item)
					list.forth
				end
			else
				internal_arguments_row := Void
			end
		end

	build_locals_row (a_target_grid: ES_OBJECTS_GRID; cse: EIFFEL_CALL_STACK_ELEMENT) is
			-- Create the row containing locals
		require
			call_stack_not_void: cse /= Void
		local
			i: INTEGER
			glab: EV_GRID_LABEL_ITEM
			list: LIST [ABSTRACT_DEBUG_VALUE]
			tmp: SORTABLE_ARRAY [ABSTRACT_DEBUG_VALUE]
			dbg_nb: INTEGER
		do
			list := cse.locals
			if list /= Void and then not list.is_empty then
				glab := folder_label_item (Interface_names.l_Locals)
				a_target_grid.grid_cell_set_pixmap (glab, Pixmaps.Icon_feature_clause_any)
				internal_locals_row := a_target_grid.extended_new_row
				internal_locals_row.set_item (1, glab)
				dbg_nb := list.count
				create tmp.make (1, dbg_nb)
				from
					list.start
					i := 1
				until
					list.after
				loop
					tmp.put (list.item, i)
					i := i + 1
					list.forth
				end
				tmp.sort
				from
					i := 1
				until
					i > dbg_nb
				loop
					add_debug_value_to_grid_row (internal_locals_row, tmp @ i)
					i := i + 1
				end
			else
				internal_locals_row := Void
			end
		end

	on_stacks_veto_pebble_function (a_item: EV_GRID_ITEM; a_pebble: ANY): BOOLEAN is
		local
			st: CALL_STACK_STONE
		do
			st ?= a_pebble
			Result := st /= Void
		end

	on_drop_stack_element (a_item: EV_GRID_ITEM; st: CALL_STACK_STONE) is
		do
			drop_stack_element (st)
		end
		
	drop_stack_element (st: CALL_STACK_STONE) is
			-- Display stack element represented by `st'.
		do
			debugger_manager.launch_stone (st)
		end

	debug_value_key_action (grid: ES_OBJECTS_GRID; k: EV_KEY) is
			-- Actions performed when a key is pressed on a debug_value.
			-- Handle `Ctrl+C'.
		local
			ost: OBJECT_STONE
		do
			inspect
				k.code
			when {EV_KEY_CONSTANTS}.key_c , {EV_KEY_CONSTANTS}.key_insert then
				if
					ev_application.ctrl_pressed
					and then not ev_application.alt_pressed
					and then not ev_application.shift_pressed
				then
					update_clipboard_string_with_selection (grid)
				end
			when {EV_KEY_CONSTANTS}.key_e then
				if
					ev_application.ctrl_pressed
					and then not ev_application.alt_pressed
					and then not ev_application.shift_pressed
				then
					if grid.selected_rows.count > 0 then
						ost ?= grid.grid_pebble_from_row (grid.selected_rows.first)
						pretty_print_cmd.set_stone (ost)
					end
				end
			when {EV_KEY_CONSTANTS}.key_right then
				expand_selected_rows (grid)
			when {EV_KEY_CONSTANTS}.key_left then
				collapse_selected_rows (grid)
			else
			end
		end
		
feature {NONE} -- Debugged objects grid Implementation

	current_object: ES_OBJECTS_GRID_LINE
			--EB_OBJECT_DISPLAY_PARAMETERS
			-- The display parameters for the current object (for the current stack)
			-- It is recreated at each execution step.

	display_first: BOOLEAN
			-- Memorize the display parameters of the current object.
			-- Was declared in ES_OBJECTS_TOOL as synonym of `display_first_attributes', `display_first_onces' and `display_first_special'.

	display_first_attributes: BOOLEAN
			-- Memorize the display parameters of the current object.
			-- Was declared in ES_OBJECTS_TOOL as synonym of `display_first', `display_first_onces' and `display_first_special'.

	display_first_onces: BOOLEAN
			-- Memorize the display parameters of the current object.
			-- Was declared in ES_OBJECTS_TOOL as synonym of `display_first', `display_first_attributes' and `display_first_special'.

	display_first_special: BOOLEAN
			-- Memorize the display parameters of the current object.
			-- Was declared in ES_OBJECTS_TOOL as synonym of `display_first', `display_first_attributes' and `display_first_onces'.
	
feature {NONE} -- Constants

	Left_address_delim: STRING is " <"
	Right_address_delim: STRING is ">"


feature {NONE} -- Grid related Constants

	Col_pixmap_index: INTEGER is 1
	Col_name_index: INTEGER is 1
	Col_value_index: INTEGER is 2
	Col_type_index: INTEGER is 3
	Col_address_index: INTEGER is 4
	Col_context_index: INTEGER is 5

	Col_titles: ARRAY [STRING] is
		do
			create Result.make (1, 5)
			Result.put ("Name", Col_name_index)
			Result.put ("Address", Col_address_index)
			Result.put ("Value", Col_value_index)
			Result.put ("Type", Col_type_index)
			Result.put ("Context ...", Col_context_index)
		end

end

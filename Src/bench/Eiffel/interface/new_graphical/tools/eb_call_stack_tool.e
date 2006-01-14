indexing
	description: "Tool that displays the call stack during a debugging session."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CALL_STACK_TOOL

inherit
	EB_TOOL
		redefine
			menu_name,
			pixmap
		end

	EB_RECYCLABLE

--	SHARED_APPLICATION_EXECUTION
--		export
--			{NONE} all
--		end

	IPC_SHARED
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	EV_KEY_CONSTANTS
		export
			{NONE} all
		end

	EB_SHARED_DEBUG_TOOLS
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EB_FILE_DIALOG_CONSTANTS
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

	build_interface is
			-- Build all the tool's widgets.
		local
			development_window: EB_DEVELOPMENT_WINDOW
			box: EV_VERTICAL_BOX
			box2: EV_VERTICAL_BOX
			box_exception: EV_HORIZONTAL_BOX
			tb_exception: EV_TOOL_BAR
			tb_but_exception: EV_TOOL_BAR_BUTTON
			box_stop_cause: EV_HORIZONTAL_BOX
			t_label: EV_LABEL
			special_label_col: EV_COLOR
		do
			development_window ?= manager

				--| UI look
			row_highlight_bg_color := Preferences.debug_tool_data.row_highlight_background_color
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.extend (agent set_row_highlight_bg_color)

			row_unsensitive_fg_color := Preferences.debug_tool_data.row_unsensitive_foreground_color
			Preferences.debug_tool_data.row_unsensitive_foreground_color_preference.change_actions.extend (agent set_row_unsensitive_fg_color)

				--| UI structure			
			create box
			create box2

			box2.set_padding (3)

			special_label_col := (create {EV_STOCK_COLORS}).blue
				--| Thread box
			create box_thread

			create t_label.make_with_text (" Thread = ")
			t_label.align_text_left
			t_label.set_foreground_color (special_label_col)
			box_thread.extend (t_label)
			box_thread.disable_item_expand (t_label)

			create thread_id
			thread_id.align_text_left
			thread_id.set_foreground_color (special_label_col)
			thread_id.set_text ("..Unknown..")
			thread_id.set_minimum_height (20)
			thread_id.set_minimum_width (thread_id.font.string_width ("0x00000000") + 10)
			thread_id.pointer_enter_actions.extend (agent bold_this_label (True, thread_id))
			thread_id.pointer_leave_actions.extend (agent bold_this_label (False, thread_id))
			thread_id.pointer_button_press_actions.extend (agent select_call_stack_thread (thread_id, ?,?,?,?,?,?,?,?))
			box_thread.extend (thread_id)

			create t_label.make_with_text (" -- Click to change. ")
			t_label.disable_sensitive
			t_label.align_text_right
			t_label.set_foreground_color (special_label_col)

			box_thread.extend (t_label)
			box_thread.disable_item_expand (t_label)

				--| Stop cause (step completed ...)
			create box_stop_cause
			create t_label.make_with_text (" Status = ")
			t_label.align_text_left
			t_label.set_foreground_color (special_label_col)

			box_stop_cause.extend (t_label)
			box_stop_cause.disable_item_expand (t_label)
			box_stop_cause.set_foreground_color (special_label_col)

			create stop_cause
			stop_cause.align_text_left
			stop_cause.set_minimum_width (stop_cause.font.string_width (interface_names.l_explicit_exception_pending))
			box_stop_cause.extend (stop_cause)

				--| Exception message
			create box_exception
			create exception
			box_exception.extend (exception)
			create tb_exception
			create tb_but_exception
			tb_but_exception.set_pixmap (pixmaps.Icon_open_exception_dialog)
			tb_but_exception.set_tooltip ("Open exception dialog for more details")
			tb_but_exception.pointer_button_press_actions.extend (agent show_call_stack_message)
			tb_exception.extend (tb_but_exception)
			box_exception.extend (tb_exception)
			box_exception.disable_item_expand (tb_exception)

				--| Top box2
			box2.extend (box_stop_cause)
			box2.disable_item_expand (box_stop_cause)

			box2.extend (box_thread)
			box2.disable_item_expand (box_thread)

			box2.extend (box_exception)
			box2.disable_item_expand (box_exception)

			box.extend (box2)
			box.disable_item_expand (box2)
			if eb_debugger_manager.application_is_executing then
				display_stop_cause (False)
			end
			exception.remove_text
				-- We set a minimum width to prevent the label from resizing the call stack.
			exception.set_minimum_width (40)
			exception.set_foreground_color (create {EV_COLOR}.make_with_8_bit_rgb (255, 0, 0))
			exception.disable_edit

				--| Stack grid
			create stack_grid
			stack_grid.enable_single_row_selection
			stack_grid.enable_border
----| FIXME XR: Use preferences to store/restore column widths			
			stack_grid.set_column_count_to (3)
			stack_grid.column (1).set_title (Interface_names.t_Feature)
			stack_grid.column (1).set_width (120)
			stack_grid.column (2).set_title (Interface_names.t_Dynamic_type)
			stack_grid.column (2).set_width (100)
			stack_grid.column (3).set_title (Interface_names.t_Static_type)
			stack_grid.column (3).set_width (100)

				--| Action/event on call stack grid
			stack_grid.drop_actions.extend (agent on_element_drop)
			stack_grid.key_press_actions.extend (agent key_pressed)
			stack_grid.set_item_pebble_function (agent on_grid_item_pebble_function)
			stack_grid.set_item_accept_cursor_function (agent on_grid_item_accept_cursor_function)
				--| Call stack level selection mode
			if preferences.debug_tool_data.select_call_stack_level_on_double_click then
				stack_grid.pointer_double_press_item_actions.extend (agent on_grid_item_pointer_pressed)
			else
				stack_grid.pointer_button_press_item_actions.extend (agent on_grid_item_pointer_pressed)
			end
			preferences.debug_tool_data.select_call_stack_level_on_double_click_preference.change_actions.extend (agent update_call_stack_level_selection_mode)


			box.extend (stack_grid)

			stack_grid.build_delayed_cleaning
			create_update_on_idle_agent
			widget := box
		end

	update_call_stack_level_selection_mode (dbl_click_bpref: BOOLEAN_PREFERENCE) is
			-- Update call stack level selection mode when preference select_call_stack_level_on_double_click_preference
			-- changes.
			-- if true then use double click
			-- otherwise use single click
		do
			stack_grid.pointer_double_press_item_actions.wipe_out
			stack_grid.pointer_button_press_item_actions.wipe_out
			if dbl_click_bpref.value then
				stack_grid.pointer_double_press_item_actions.extend (agent on_grid_item_pointer_pressed)
			else
				stack_grid.pointer_button_press_item_actions.extend (agent on_grid_item_pointer_pressed)
			end
		end

	build_mini_toolbar is
			-- Build the associated tool bar
		do
			create mini_toolbar
			create save_call_stack_cmd.make
			save_call_stack_cmd.set_mini_pixmaps (pixmaps.small_pixmaps.icon_save_call_stack)
			save_call_stack_cmd.set_tooltip (Interface_names.e_Save_call_stack)
			save_call_stack_cmd.add_agent (agent save_call_stack)
			mini_toolbar.extend (save_call_stack_cmd.new_mini_toolbar_item)
			create set_stack_depth_cmd.make
			set_stack_depth_cmd.set_mini_pixmaps (pixmaps.small_pixmaps.icon_set_stack_depth)
			set_stack_depth_cmd.set_tooltip (Interface_names.e_Set_stack_depth)
			set_stack_depth_cmd.add_agent (agent set_stack_depth)
			set_stack_depth_cmd.enable_sensitive
			mini_toolbar.extend (set_stack_depth_cmd.new_mini_toolbar_item)
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
			create {EB_EXPLORER_BAR_ITEM} explorer_bar_item.make_with_mini_toolbar (explorer_bar, widget, title, False, mini_toolbar)
			explorer_bar_item.set_menu_name (menu_name)
			if pixmap /= Void then
				explorer_bar_item.set_pixmap (pixmap)
			end
			explorer_bar.add (explorer_bar_item)
		end

feature -- Box management

	box_thread: EV_HORIZONTAL_BOX

	display_box_thread (b: BOOLEAN) is
			-- Show or hide box related to available Thread ids
		do
			if b then
				box_thread.show
			else
				box_thread.hide
			end
		end

feature -- Access

	mini_toolbar: EV_TOOL_BAR
			-- Associated mini toolbar.

	widget: EV_WIDGET
			-- Widget representing Current.

	thread_id: EV_LABEL
			-- Thread Identifier

	stop_cause: EV_LABEL
			-- Why did the execution stop? (encountered breakpoint, raised exception,...)

	exception: EV_TEXT_FIELD
			-- Exception application has encountered.

	title: STRING is
			-- Title of the tool.
		do
			Result := Interface_names.t_Call_stack_tool
		end

	stack_grid: ES_GRID
			-- Graphical representation of the execution stack.

	menu_name: STRING is
			-- Name as it may appear in a menu.
		do
			Result := Interface_names.m_Call_stack_tool
		end

	pixmap: ARRAY [EV_PIXMAP] is
			-- Pixmap as it may appear in toolbars and menus.
		do
--| To be done.
--			Result := Pixmaps.Icon_call_stack
		end

feature -- Status setting

	set_callstack_thread (tid: INTEGER) is
		local
			s: APPLICATION_STATUS
		do
				-- FIXME jfiat: check what happens if the application is not stopped ?
			s := eb_debugger_manager.application.status
			if s.current_thread_id /= tid then
				s.set_current_thread_id (tid)
				s.reload_current_call_stack
				update
			end
		end

	set_stone (a_stone: STONE) is
			-- Assign `a_stone' as new stone.
		local
			st: CALL_STACK_STONE
			new_level: INTEGER
			count: INTEGER
			l_row: EV_GRID_ROW
			old_current_level: INTEGER
		do
			st ?= a_stone
			if st /= Void then
				old_current_level := arrowed_level
				new_level := st.level_number

					-- Stack grid
				count := stack_grid.row_count
				if old_current_level >= 1 and then count >= old_current_level then
					l_row := stack_grid.row (old_current_level)
					refresh_stack_grid_row (l_row, new_level)
				end
				if new_level >= 1 and then count >= new_level then
					l_row := stack_grid.row (new_level)
					refresh_stack_grid_row (l_row, new_level)
					arrowed_level := new_level
				end
			end
		end

	refresh is
			-- Class has changed in `development_window'.
		do
		end

	update is
			-- Refresh `Current's display.
		local
			l_is_stopped: BOOLEAN
		do
			cancel_process_real_update_on_idle
			request_clean_stack_grid
			if eb_debugger_manager.application_is_executing then
				l_is_stopped := eb_debugger_manager.application_is_stopped
				display_stop_cause (l_is_stopped)
				refresh_threads_info
				process_real_update_on_idle (l_is_stopped)
			else
				display_stop_cause (False)
				display_box_thread (False)
			end
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
				-- Link with the manager and the explorer.
			manager := a_manager
			set_explorer_bar (an_explorer_bar)
		end

feature -- Memory management

	recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			if explorer_bar_item /= Void then
				explorer_bar_item.recycle
			end
			exception.remove_text
			exception.remove_tooltip
		end

feature {NONE} -- Grid Implementation

	level_from_row (a_row: EV_GRID_ROW): INTEGER is
			-- Call stack level related to `a_row'.
		require
			a_row /= Void
		local
			level_r: INTEGER_REF
		do
			level_r ?= a_row.data
			if level_r /= Void then
				Result := level_r.item
			end
		end

	on_grid_item_pointer_pressed (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM) is
			-- Action when mouse click on `stack_grid'
		local
			l_row: EV_GRID_ROW
			level: INTEGER
		do
			if a_button = 1 and a_item /= Void then
				if
					not ev_application.ctrl_pressed
					and not ev_application.shift_pressed
					and not ev_application.alt_pressed
				then
					l_row := a_item.row
					if l_row /= Void then
						level := level_from_row (l_row)
						if level > 0 then
							select_element_by_level (level)
						end
					end
				end
			end
		end

	on_grid_item_pebble_function (a_item: EV_GRID_ITEM): CALL_STACK_STONE is
			-- Returns the call_stack_stone of row related to a_item
		local
			l_row: EV_GRID_ROW
			level: INTEGER
			elem: EIFFEL_CALL_STACK_ELEMENT
		do
			if a_item /= Void then
				l_row := a_item.row
				if l_row /= Void then
					level := level_from_row (l_row)
					if level > 0 then
						elem ?= eb_debugger_manager.application.status.current_call_stack.i_th (level)
						if
							elem /= Void and then
							elem.dynamic_class /= Void and then
							elem.dynamic_class.has_feature_table
						then
							create Result.make (level)
						end
					end
				end
			end
		end

	on_grid_item_accept_cursor_function	(a_item: EV_GRID_ITEM): EV_CURSOR is
		do
			Result := Cursors.cur_Setstop
		end

feature {NONE} -- Implementation

	arrowed_level: INTEGER
			-- Line number in the stack that has an arrow displayed.

	save_call_stack_cmd: EB_STANDARD_CMD
			-- Command that saves the call stack to a file.

	set_stack_depth_cmd: EB_STANDARD_CMD
			-- Command that alters the displayed depth of the call stack.

	clean_stack_grid is
			-- Clean the stack_grid
		do
			stack_grid.call_delayed_clean
		ensure
			stack_grid_cleaned: stack_grid.row_count = 0
		end

	request_clean_stack_grid is
			-- Clean the stack_grid
		do
			stack_grid.request_delayed_clean
		end

	real_update (dbg_was_stopped: BOOLEAN) is
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running			
		local
			i: INTEGER
			stack: EIFFEL_CALL_STACK
			l_tooltipable_grid_row: EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			l_status: APPLICATION_STATUS
		do
			request_clean_stack_grid
			if eb_debugger_manager.application_is_executing then
				l_status := eb_debugger_manager.application.status
				if dbg_was_stopped then
					l_status.update_on_stopped_state
				end
				display_stop_cause (dbg_was_stopped)
				refresh_threads_info
				if
					dbg_was_stopped and l_status.is_stopped
				then
					clean_stack_grid
					stack := l_status.current_call_stack
					if stack /= Void and then not stack.is_empty then
						save_call_stack_cmd.enable_sensitive
						from
							stack.start
							stack_grid.insert_new_rows (stack.count, 1)
							i := 1
						until
							stack.after
						loop
							attach_element_to_row (stack.item, i, stack_grid.row (i))
							if not stack.item.is_eiffel_call_stack_element then
								stack_grid.row (i).disable_select
							end
							i := i + 1
							stack.forth
						end
					else
						l_tooltipable_grid_row := stack_grid.grid_extended_new_row (stack_grid)
						create glab.make_with_text ("Unable to get call stack data")
						glab.set_tooltip ("Double click to refresh call stack")
						glab.set_pixmap (Pixmaps.small_pixmaps.icon_dbg_error)
						glab.pointer_double_press_actions.force_extend (agent update)
						l_tooltipable_grid_row.set_item (1, glab)
					end
					stack_grid.request_columns_auto_resizing
				else
					save_call_stack_cmd.disable_sensitive
				end
			end
		end

	display_stop_cause (arg_is_stopped: BOOLEAN) is
			-- Fill in the `stop_cause' label with a message describing the application status.
			-- arg_is_stopped is ignore if Application/Debugger is not running
		local
			m: STRING
		do
			if not eb_debugger_manager.application_is_executing then
				stop_cause.set_text (Interface_names.l_System_launched)
				exception.remove_text
				exception.remove_tooltip
			elseif not arg_is_stopped then
				stop_cause.set_text (Interface_names.l_System_running)
				exception.remove_text
				exception.remove_tooltip
			else -- Application is stopped.
				create m.make (100)
				inspect eb_debugger_manager.application.status.reason
				when Pg_step then
					stop_cause.set_text (Interface_names.l_Stepped)
					m.append (Interface_names.l_Stepped)
				when Pg_break then
					stop_cause.set_text (Interface_names.l_Stop_point_reached)
					m.append (Interface_names.l_Stop_point_reached)
				when Pg_interrupt then
					stop_cause.set_text (Interface_names.l_Execution_interrupted)
					m.append (Interface_names.l_Execution_interrupted)
				when Pg_overflow then
					stop_cause.set_text (Interface_names.l_Possible_overflow)
					m.append (Interface_names.l_Possible_overflow)
				when Pg_raise then
					stop_cause.set_text (Interface_names.l_Explicit_exception_pending)
					m.append (Interface_names.l_Explicit_exception_pending)
					m.append (": ")
					m.append (exception_tag_text)
					display_exception
				when Pg_viol then
					stop_cause.set_text (Interface_names.l_Implicit_exception_pending)
					m.append (Interface_names.l_Implicit_exception_pending)
					m.append (": ")
					m.append (exception_tag_text)
					display_exception
				when Pg_new_breakpoint then
					stop_cause.set_text (Interface_names.l_New_breakpoint)
					m.append (Interface_names.l_New_breakpoint)
				else
					stop_cause.set_text (Interface_names.l_Unknown_status)
					m.append (Interface_names.l_Unknown_status)
				end
				Eb_debugger_manager.debugging_window.status_bar.display_message ( first_line_of (m) )
			end
		end

	display_exception is
			-- Fill in the `exception' label with a text describing the exception, if any.
		local
			m: STRING
		do
			m := exception_tag_text
--			exception.set_text (m)
--| FIXME jfiat [2004/03/19] : NewFeature keep only first line of exception text for callstack_tool
--| We'll enable this, once we have an exception window to display the full message
			exception.set_text (first_line_of (m))
			exception.set_tooltip (m)
		end

	show_call_stack_message (x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG
		do
			create dlg
			dlg.set_exception_tag (exception_tag_text)
			dlg.set_exception_message (exception_message_text)
			dlg.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
		end

	refresh_threads_info is
			-- Refresh thread info according to debugger data
		local
			ctid: INTEGER
			s: APPLICATION_STATUS
		do
			s := eb_debugger_manager.application.status
			if s.all_thread_ids_count > 1 then
				ctid := s.current_thread_id
				thread_id.set_text ("0x" + ctid.to_hex_string)
				thread_id.set_data (ctid)
				display_box_thread (True)
			else
				display_box_thread (False)
			end
		end

	first_line_of (m: STRING): STRING is
			-- keep the first line of the exception message
			-- the rest can be seen by double clicking on the widget
		local
			pos: INTEGER
		do
			Result := m
			pos := Result.index_of ('%N', 1)
			if pos > 0 then
				Result := Result.substring (1, pos -1)
			end
			pos := Result.index_of ('%R', 1)
			if pos > 0 then
				Result := Result.substring (1, pos -1)
			end
		ensure
			one_line: Result /= Void and then (not Result.has ('%R') and not Result.has ('%N'))
		end

	exception_tag_text: STRING is
			-- Text corresponding to the current exception.
		local
			e: EXCEPTIONS
			s: STRING
			l_status: APPLICATION_STATUS
		do
			create Result.make (100)
			fixme ("check how to get rid of the condition is_dotnet")
			l_status := eb_debugger_manager.Application.status
			if not eb_debugger_manager.Application.is_dotnet then
				Result.append ("Code: ")
				Result.append (l_status.exception_code.out)
				Result.append (" (")
				create e
				s := e.meaning (l_status.exception_code)
				if s = Void then
					s := "Undefined"
				end
				Result.append (s)
				Result.append (")")
			end
			Result.append (" Tag: ")
			s := l_status.exception_tag
			if s /= Void then
				Result.append_string (s)
			end

-- FIXME JFIAT: 2003/03/12 : what for this postcondition limitation ?
-- need to check if there is any reason for that ...
-- except we are using a TEXT_FIELD instead of multiple line widget
--		ensure
--			one_line: Result /= Void and then (not Result.has ('%R') and not Result.has ('%N'))
		end

	exception_message_text: STRING is
			-- Text corresponding to the current exception.
		local
			dotnet_status: APPLICATION_STATUS_DOTNET
		do
			dotnet_status ?= eb_debugger_manager.application.status
			if dotnet_status /= Void then
				if dotnet_status.exception_occurred then
					Result := dotnet_status.exception_to_string
				else
					Result := "No exception occurred"
				end
			end
			if Result = Void then
				Result := ""
			end
		end

	on_element_drop (st: CALL_STACK_STONE) is
			-- Change stack level to the one described by `st'.
		do
			Eb_debugger_manager.launch_stone (st)
		end

	attach_element_to_row (elem: CALL_STACK_ELEMENT; level: INTEGER; a_row: EV_GRID_ROW) is
			-- Display information about associated routine on `a_row'.
		require
			a_row_not_void: a_row /= Void
		local
			dc, oc: CLASS_C
			l_tooltip: STRING
			l_nb_stack: INTEGER
			e_cse: EIFFEL_CALL_STACK_ELEMENT
			ext_cse: EXTERNAL_CALL_STACK_ELEMENT
			dotnet_cse: CALL_STACK_ELEMENT_DOTNET
			l_feature_info: STRING
			l_class_info: STRING
			l_orig_class_info: STRING
			l_breakindex_info: STRING
			l_obj_address_info: STRING
			l_extra_info: STRING
			glab: EV_GRID_LABEL_ITEM
			app_exec: APPLICATION_EXECUTION
		do
			create l_tooltip.make (10)

			e_cse ?= elem
				--| Routine name
			l_feature_info := elem.routine_name.twin
			l_tooltip.append_string (l_feature_info)

					--| Class name
			l_class_info := elem.class_name
			l_tooltip.prepend_string ("{" + l_class_info + "}")

				--| Break Index
			l_breakindex_info := elem.break_index.out

				--| Object address
			l_obj_address_info := elem.object_address

			if e_cse /= Void then
					--| Origin class
				dc := e_cse.dynamic_class
				oc := e_cse.written_class
				if oc /= Void and then not oc.is_equal (dc) then
					l_orig_class_info := oc.name_in_upper
					l_tooltip.prepend_string (" (from " + l_orig_class_info + ")")
				else
					l_orig_class_info := Interface_names.l_Same_class_name
				end

					--| Routine name
				if e_cse.is_melted then
					l_feature_info.append_string ("*")
					l_tooltip.append_string ("%N   + compilation = melted")
				end

				dotnet_cse ?= e_cse
				if dotnet_cse /= Void and then dotnet_cse.dotnet_module_name /= Void then
					l_tooltip.append_string ("%N   + Module = " + dotnet_cse.dotnet_module_name)
				end

				a_row.set_data (level)
			else --| It means, this is an EXTERNAL_CALL_STACK_ELEMENT
				l_orig_class_info := ""
				ext_cse ?= elem
				if ext_cse /= Void then
					l_extra_info := ext_cse.info
				end
				a_row.set_data (-1) -- This is not a valid Eiffel call stack element.
			end

			app_exec := eb_debugger_manager.Application
				--| Tooltip addition
			l_nb_stack := app_exec.status.current_call_stack.count
			l_tooltip.prepend_string ((elem.level_in_stack).out + "/" + l_nb_stack.out + ": ")
			l_tooltip.append_string ("%N   + break index = " + l_breakindex_info)
			l_tooltip.append_string ("%N   + address     = <" + l_obj_address_info + ">")
			if l_extra_info /= Void then
				l_tooltip.append_string ("%N    + " + l_extra_info)
			end

				--| Fill columns
			create glab.make_with_text (l_feature_info)
			glab.set_tooltip (l_tooltip)
			a_row.set_item (1, glab)

			create glab.make_with_text (l_class_info)
			glab.set_tooltip (l_class_info)
			a_row.set_item (2, glab)

			create glab.make_with_text (l_orig_class_info)
			glab.set_tooltip (l_orig_class_info)
			a_row.set_item (3, glab)

				--| Set GUI behavior
			refresh_stack_grid_row (a_row, app_exec.current_execution_stack_number)
			if level = app_exec.current_execution_stack_number then
				arrowed_level := level
			end
		end

	refresh_stack_grid_row (a_row: EV_GRID_ROW; current_level: INTEGER) is
			-- Refresh row of stack_grid regarding the current_level information
		require
			a_row /= Void
		local
			glab: EV_GRID_LABEL_ITEM
			level: INTEGER
		do
			level := level_from_row (a_row)
			a_row.set_foreground_color (Void)
			a_row.set_background_color (Void)

				--| Set GUI behavior
			glab ?= a_row.item (1)
			if level = current_level then
				glab.set_pixmap (Pixmaps.Icon_green_arrow)
				a_row.set_background_color (row_highlight_bg_color)
			elseif level >= 0 then
				glab.set_pixmap (Pixmaps.Icon_arrow_empty)
			else
				glab.remove_pixmap
				glab.set_left_border (glab.left_border + glab.spacing + pixmaps.icon_arrow_empty.width)
				a_row.set_foreground_color (row_unsensitive_fg_color)
			end
		end

	select_element_by_level (level: INTEGER) is
			-- Set stone in the  develpment window.
		require
			valid_level: level > 0 and level <= stack_grid.row_count
		local
			st: CALL_STACK_STONE
		do
			create st.make (level)
			if st.is_valid then
				Eb_debugger_manager.launch_stone (st)
			end
		end

	select_element (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER; level: INTEGER) is
			-- Set `a_stone' in the development window.
		do
			if a_button = 1 then
				select_element_by_level (level)
			end
		end

	key_pressed (a_key: EV_KEY) is
			-- If `a_key' is enter, set the selected stack element as the new stone.
		local
			level: INTEGER_REF
			l_row: EV_GRID_ROW
		do
			if a_key.code = Key_enter then
				l_row := stack_grid.single_selected_row
				if l_row /= Void then
					level ?= l_row.data
					if level > 0 then
						select_element_by_level (level.item)
						stack_grid.set_focus
					end
				end
			end
		end

	save_call_stack is
			-- Saves the current call stack representation in a file.
		local
			fd: EB_FILE_SAVE_DIALOG
			standard_path: DIRECTORY_NAME
			f: RAW_FILE
			fn: FILE_NAME
			last_path: STRING
			i: INTEGER
			l_env: EXECUTION_ENVIRONMENT
			l_dir: STRING
		do
				--| Get last path from the preferences.
			last_path := preferences.debug_tool_data.last_saved_stack_path
			if last_path = Void or else last_path.is_empty then
					--| The first time, start in the project directory.
				create standard_path.make
				standard_path.extend (Eiffel_project.project_directory.name)
			else
				create standard_path.make
				standard_path.extend (last_path)
			end
			create fd.make_with_preference (preferences.dialog_data.last_saved_call_stack_directory_preference)
			set_dialog_filters_and_add_all (fd, <<Text_files_filter>>)
			fd.set_start_directory (standard_path)
				--| We try to find a file_name that does not exist.
			create fn.make
			fn.set_directory (standard_path)
			fn.set_file_name (Interface_names.default_stack_file_name)
			fn.add_extension ("txt")
			create f.make (fn)
			from
				i := 1
			until
				not f.exists
			loop
				create fn.make
				fn.set_directory (standard_path)
				fn.set_file_name (Interface_names.default_stack_file_name + i.out)
				fn.add_extension ("txt")
				create f.make (fn)
				i := i + 1
			end
				--| OK, now `fn' represents a file that does not exist.
			fd.set_file_name (fn)
			fd.save_actions.extend (agent save_call_stack_to_file (fd))
			create l_env
			l_dir := l_env.current_working_directory
			fd.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
			l_env.change_working_directory (l_dir)
		end

	save_call_stack_to_file (fd: EV_FILE_DIALOG) is
			-- Actually saves the call stack.
		require
			valid_dialog: fd /= Void
		local
			fn: PLAIN_TEXT_FILE
			retried: BOOLEAN
			wd: EV_WARNING_DIALOG
			stt: STRUCTURED_TEXT
		do
			if not retried then
					--| We create a file (or open it).
				create fn.make_create_read_write (fd.file_name)
				create stt.make
					--| We generate the call stack.
				eb_debugger_manager.Application.status.current_call_stack.display_stack (stt)
					--| We put it in the file.
				fn.put_string (stt.image)
				fn.close
					--| Save the path to the preferences.
				preferences.debug_tool_data.last_saved_stack_path_preference.set_value (fd.file_path)
				preferences.preferences.save_preference (preferences.debug_tool_data.last_saved_stack_path_preference)
			else
					-- The file name was probably incorrect (not creatable).
				create wd.make_with_text (Warning_messages.w_Not_creatable (fd.file_name))
				wd.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
			end
		rescue
			retried := True
			retry
		end

	show_thread_panel is
		local
			th_tools: ES_DBG_THREADS_TOOL
		do
			th_tools := Eb_debugger_manager.threads_tool
			if not th_tools.shown then
				th_tools.show
				th_tools.widget.set_focus
			end
		end

	select_call_stack_thread (lab: EV_LABEL; x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			tid: INTEGER
			i: INTEGER
			arr: ARRAY [INTEGER]
			wd: EV_WARNING_DIALOG
			l_item_text, s: STRING
			l_status: APPLICATION_STATUS
		do
			l_status := eb_debugger_manager.Application.status
			if l_status /= Void and then l_status.is_stopped then
				arr := l_status.all_thread_ids
				if arr /= Void and then not arr.is_empty then
					create m

					create mi.make_with_text_and_action ("Show threads panel", agent show_thread_panel)
					m.extend (mi)
					m.extend (create {EV_MENU_SEPARATOR})

					from
						i := arr.lower
					until
						i > arr.upper
					loop
						tid := arr @ i
						l_item_text := "0x" + tid.to_hex_string
						s := l_status.thread_name (tid)
						if s /= Void then
							l_item_text.append_string (" - " + s)
						end

						create mi
						if tid = l_status.current_thread_id then
							mi.set_pixmap (pixmaps.icon_green_arrow)
						end
						mi.set_text (l_item_text)
						mi.set_data (tid)
						mi.select_actions.extend (agent set_callstack_thread (tid))
						m.extend (mi)
						i := i + 1
					end
					m.show_at (lab, 0, thread_id.height)
				else
					create wd.make_with_text ("Sorry no information available on Threads for now")
					wd.show
				end
			else
				create wd.make_with_text ("Sorry you can not change thread while execution is running")
				wd.show
			end
		end

feature {NONE} -- Implementation: set stack depth command

	set_stack_depth is
			-- Display a dialog that lets the user change the maximum depth of the call stack.
		local
			rb2: EV_RADIO_BUTTON
			l: EV_LABEL
			okb, cancelb: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
				-- Create widgets.
			create dialog
			create show_all_radio.make_with_text (Interface_names.l_show_all_call_stack)
			create rb2.make_with_text (Interface_names.l_Show_only_n_elements)
			create l.make_with_text (Interface_names.l_Elements)
			create set_as_default.make_with_text (Interface_names.l_Set_as_default)
			create element_nb.make_with_value_range (1 |..| 500)
			create okb.make_with_text (Interface_names.b_Ok)
			create cancelb.make_with_text (Interface_names.b_Cancel)

				-- Set widget properties.
			dialog.set_title (Interface_names.t_Set_stack_depth)
			dialog.set_icon_pixmap (pixmaps.icon_dialog_window)
			dialog.disable_user_resize
			Layout_constants.set_default_size_for_button (okb)
			Layout_constants.set_default_size_for_button (cancelb)

				-- Organize widgets.
			create vb
			vb.set_border_width (Layout_constants.Default_border_size)
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.extend (show_all_radio)
			vb.extend (rb2)

			rb2.enable_select
			if Debugger_manager.maximum_stack_depth > 500 then
				element_nb.set_value (500)
			elseif Debugger_manager.maximum_stack_depth = -1 then
				element_nb.set_value (50)
				show_all_radio.enable_select
				element_nb.disable_sensitive
			else
				element_nb.set_value (Debugger_manager.maximum_stack_depth)
			end

			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (element_nb)
			hb.disable_item_expand (element_nb)
			hb.extend (l)
			hb.disable_item_expand (l)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			vb.extend (set_as_default)

			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (create {EV_CELL})
			hb.extend (okb)
			hb.disable_item_expand (okb)
			hb.extend (cancelb)
			hb.disable_item_expand (cancelb)
			hb.extend (create {EV_CELL})
			vb.extend (hb)

			dialog.extend (vb)

				-- Set up actions.
			cancelb.select_actions.extend (agent close_dialog)
			okb.select_actions.extend (agent accept_dialog)
			show_all_radio.select_actions.extend (agent element_nb.disable_sensitive)
			rb2.select_actions.extend (agent element_nb.enable_sensitive)
			dialog.set_default_push_button (okb)
			dialog.set_default_cancel_button (cancelb)
			dialog.show_actions.extend (agent element_nb.set_focus)

			dialog.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
		end

	set_as_default: EV_CHECK_BUTTON
			-- Button that decides whether the chosen stack depth should be saved in the preferences.

	element_nb: EV_SPIN_BUTTON
			-- Spin button that indicates how many stack elements should be displayed.

	dialog: EV_DIALOG
			-- Dialog that lets the user choose how many stack elements he wishes to see.

	show_all_radio: EV_RADIO_BUTTON
			-- Radio button that indicates whether all stack elements should be displayed.

	close_dialog is
			-- Close `dialog' without doing anything.
		do
			dialog.destroy
			dialog := Void
			element_nb := Void
			set_as_default := Void
			show_all_radio := Void
		end

	accept_dialog is
			-- Close `dialog' without doing anything.
		local
			nb: INTEGER
		do
			if show_all_radio.is_selected then
				nb := -1
			else
				nb := element_nb.value
			end
			if set_as_default.is_selected then
				preferences.debugger_data.default_maximum_stack_depth_preference.set_value (nb)
			end
			close_dialog
			debugger_manager.set_maximum_stack_depth (nb)
		end

feature {NONE} -- Implementation, cosmetic

	bold_this_label (is_bold: BOOLEAN; lab: EV_LABEL) is
		local
			f: EV_FONT
		do
			f := lab.font
			if is_bold  then
				f.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
			else
				f.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
			end
			lab.set_font (f)
		end

	set_row_highlight_bg_color (v: COLOR_PREFERENCE) is
		do
			row_highlight_bg_color := v.value
		end

	set_row_unsensitive_fg_color (v: COLOR_PREFERENCE) is
		do
			row_unsensitive_fg_color := v.value
		end

	row_highlight_bg_color: EV_COLOR

	row_unsensitive_fg_color: EV_COLOR

end -- class EB_CALL_STACK_TOOL

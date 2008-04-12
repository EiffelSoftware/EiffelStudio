indexing
	description: "Tool that displays the call stack during a debugging session."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CALL_STACK_TOOL_PANEL

inherit
	ES_DEBUGGER_DOCKABLE_STONABLE_TOOL_PANEL [EV_VERTICAL_BOX]
		redefine
			create_mini_tool_bar_items,
			on_after_initialized,
			internal_recycle,
			show,
			on_show
		end

	APPLICATION_STATUS_CONSTANTS
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

	EB_SHARED_DEBUGGER_MANAGER

	EB_FILE_DIALOG_CONSTANTS
		export
			{NONE} all
		end

	ES_SHARED_PROMPT_PROVIDER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	build_tool_interface (a_widget: EV_VERTICAL_BOX) is
			-- Build all the tool's widgets.
		local
			development_window: EB_DEVELOPMENT_WINDOW
			box2: EV_VERTICAL_BOX
			t_label: EV_LABEL
		do

				--| UI look
			row_highlight_bg_color := Preferences.debug_tool_data.row_highlight_background_color
			set_row_highlight_bg_color_agent := agent (v: COLOR_PREFERENCE)
						do
							row_highlight_bg_color := v.value
						end
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.extend (set_row_highlight_bg_color_agent)

			unsensitive_fg_color := Preferences.debug_tool_data.unsensitive_foreground_color
			set_unsensitive_fg_color_agent := agent (v: COLOR_PREFERENCE)
						do
							unsensitive_fg_color := v.value
						end
			Preferences.debug_tool_data.unsensitive_foreground_color_preference.change_actions.extend (set_unsensitive_fg_color_agent)

			row_replayable_bg_color := Preferences.debug_tool_data.row_replayable_background_color
			set_row_replayable_bg_color_agent := agent (v: COLOR_PREFERENCE)
						do
							row_replayable_bg_color := v.value
							if box_replay_controls /= Void then
								box_replay_controls.set_background_color (row_replayable_bg_color)
								box_replay_controls.propagate_background_color
							end
						end
			Preferences.debug_tool_data.row_replayable_background_color_preference.change_actions.extend (set_row_replayable_bg_color_agent)


				--| UI structure			
			create box2
			box2.set_padding (3)

			special_label_color := (create {EV_STOCK_COLORS}).blue

				--| Replay control box
			create_box_replay_controls

				--| Thread box
			create_box_thread

				--| Stop cause (step completed ...)
			create box_stop_cause
			create t_label.make_with_text (" Status = ")
			t_label.align_text_left
			t_label.set_foreground_color (special_label_color)

			box_stop_cause.extend (t_label)
			box_stop_cause.disable_item_expand (t_label)
			box_stop_cause.set_foreground_color (special_label_color)

			create stop_cause
			stop_cause.align_text_left
			stop_cause.set_minimum_width (stop_cause.font.string_width (interface_names.l_explicit_exception_pending))
			box_stop_cause.extend (stop_cause)

				--| Exception box
			create_box_exception

				--| Top box2
			box2.extend (box_stop_cause)
			box2.disable_item_expand (box_stop_cause)

			box2.extend (box_thread)
			box2.disable_item_expand (box_thread)
			display_box_thread (False)

			box2.extend (box_exception)
			box2.disable_item_expand (box_exception)

			box2.extend (box_replay_controls)
			box2.disable_item_expand (box_replay_controls)
			activate_execution_replay_mode (False, 0)

			a_widget.extend (box2)
			a_widget.disable_item_expand (box2)
			if Debugger_manager.application_is_executing then
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
			stack_grid.enable_partial_dynamic_content
			stack_grid.set_dynamic_content_function (agent compute_stack_grid_item)
			stack_grid.enable_border
			stack_grid.enable_resize_column (Feature_column_index)
			stack_grid.enable_resize_column (Position_column_index)

----| FIXME Jfiat: Use session to store/restore column widths
			stack_grid.set_column_count_to (4)
			stack_grid.column (Feature_column_index).set_title (Interface_names.t_Feature)
			stack_grid.column (Feature_column_index).set_width (120)
			stack_grid.column (Position_column_index).set_title (" @") --Interface_names.t_Position)
			stack_grid.column (Position_column_index).set_width (20)
			stack_grid.column (Dtype_column_index).set_title (Interface_names.t_Dynamic_type)
			stack_grid.column (Dtype_column_index).set_width (100)
			stack_grid.column (Stype_column_index).set_title (Interface_names.t_Static_type)
			stack_grid.column (Stype_column_index).set_width (100)

				--| Action/event on call stack grid
			stack_grid.drop_actions.extend (agent on_element_drop)
			stack_grid.key_press_actions.extend (agent key_pressed)
			stack_grid.set_item_pebble_function (agent on_grid_item_pebble_function)
			stack_grid.set_item_accept_cursor_function (agent on_grid_item_accept_cursor_function)
				--| Action/event on call stack grid (replay mode)
			stack_grid.row_expand_actions.extend (agent on_row_expanded)
			stack_grid.row_select_actions.extend (agent on_row_selected)
			stack_grid.row_deselect_actions.extend (agent on_row_deselected)

				--| Context menu handler
			development_window ?= develop_window
			stack_grid.set_configurable_target_menu_mode
			stack_grid.set_configurable_target_menu_handler (agent (development_window.menus.context_menu_factory).call_stack_menu)

				--| Call stack level selection mode
			update_call_stack_level_selection_mode (preferences.debug_tool_data.select_call_stack_level_on_double_click_preference)
			preferences.debug_tool_data.select_call_stack_level_on_double_click_preference.change_actions.extend (agent update_call_stack_level_selection_mode)

				--| Specific Grid's behavior
			stack_grid.build_delayed_cleaning

				--| Attach to Current dialog
			a_widget.extend (stack_grid)
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

    create_mini_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
            -- Retrieves a list of tool bar items to display on the window title
		local
			cmd: EB_STANDARD_CMD
        do
			create Result.make (5)

			create save_call_stack_cmd.make
			save_call_stack_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_save_icon)
			save_call_stack_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_save_icon_buffer)
			save_call_stack_cmd.set_tooltip (Interface_names.e_Save_call_stack)
			save_call_stack_cmd.add_agent (agent save_call_stack)
			Result.force_last (save_call_stack_cmd.new_mini_sd_toolbar_item)

			create cmd.make
			cmd.set_mini_pixmap (pixmaps.mini_pixmaps.general_copy_icon)
			cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.general_copy_icon_buffer)
			cmd.set_tooltip (Interface_names.e_Copy_call_stack_to_clipboard)
			cmd.add_agent (agent copy_call_stack_to_clipboard)
			Result.force_last (cmd.new_mini_sd_toolbar_item)
			copy_call_stack_cmd := cmd

			create set_stack_depth_cmd.make
			set_stack_depth_cmd.set_mini_pixmap (pixmaps.mini_pixmaps.debugger_callstack_depth_icon)
			set_stack_depth_cmd.set_mini_pixel_buffer (pixmaps.mini_pixmaps.debugger_callstack_depth_icon_buffer)
			set_stack_depth_cmd.set_tooltip (Interface_names.e_Set_stack_depth)
			set_stack_depth_cmd.add_agent (agent open_stack_depth_dialog)
			set_stack_depth_cmd.enable_sensitive
			Result.force_last (set_stack_depth_cmd.new_mini_sd_toolbar_item)

			if eb_debugger_manager.toggle_exec_replay_recording_mode_cmd /= Void then
				Result.force_last (eb_debugger_manager.toggle_exec_replay_recording_mode_cmd.new_mini_sd_toolbar_item)
			end
			if eb_debugger_manager.toggle_exec_replay_mode_cmd /= Void then
				Result.force_last (eb_debugger_manager.toggle_exec_replay_mode_cmd.new_mini_sd_toolbar_item)
			end
		end

	on_after_initialized
			-- Use to perform additional creation initializations, after the UI has been created.
		do
			Precursor {ES_DEBUGGER_DOCKABLE_STONABLE_TOOL_PANEL}
			request_update
		end

feature {NONE} -- Factory

	create_widget: EV_VERTICAL_BOX
			-- Create a new container widget upon request.
			-- Note: You may build the tool elements here or in `build_tool_interface'
		do
			Create Result
		end

	create_tool_bar_items: DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- Retrieves a list of tool bar items to display at the top of the tool.
		do
		end

	create_box_exception is
			-- Build `box_exception' widget
		local
			tb_but: like exception_dialog_button
			tb_exception: SD_TOOL_BAR
		do
			create box_exception
			create exception
			box_exception.extend (exception)
			create tb_exception.make
			create tb_but.make
			exception_dialog_button := tb_but
			tb_but.disable_sensitive
			tb_but.set_pixmap (pixmaps.icon_pixmaps.debug_exception_dialog_icon)
			tb_but.set_pixel_buffer (pixmaps.icon_pixmaps.debug_exception_dialog_icon_buffer)
			tb_but.set_tooltip (interface_names.l_open_exception_dialog_tooltip)
			tb_but.select_actions.extend (agent open_exception_dialog)
			tb_exception.extend (tb_but)
			tb_exception.compute_minimum_size
			box_exception.extend (tb_exception)
			box_exception.disable_item_expand (tb_exception)
		end

	create_box_thread is
			-- Build `box_thread' widget
		local
			t_label: EV_LABEL
		do

			create box_thread

			create t_label.make_with_text (" Thread = ")
			t_label.align_text_left
			t_label.set_foreground_color (special_label_color)
			box_thread.extend (t_label)
			box_thread.disable_item_expand (t_label)

			create thread_id
			thread_id.align_text_left
			thread_id.set_foreground_color (special_label_color)
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
			t_label.set_foreground_color (special_label_color)

			box_thread.extend (t_label)
			box_thread.disable_item_expand (t_label)
		end

	create_box_replay_controls is
			-- Build `box_replay_controls' widget
		local
			tb: SD_TOOL_BAR
			but: SD_TOOL_BAR_BUTTON
		do
			create box_replay_controls
			create tb.make
			box_replay_controls.extend (tb)
			tb.extend (eb_debugger_manager.exec_replay_back_cmd.new_sd_toolbar_item (True))
			tb.extend (eb_debugger_manager.exec_replay_forth_cmd.new_sd_toolbar_item (True))
			tb.extend (eb_debugger_manager.exec_replay_left_cmd.new_sd_toolbar_item (True))
			tb.extend (eb_debugger_manager.exec_replay_right_cmd.new_sd_toolbar_item (True))

			create but.make
			but.set_text (interface_names.b_Exec_replay_to)
			but.set_tooltip (interface_names.t_Exec_replay_to)
			but.set_pixel_buffer (pixmaps.mini_pixmaps.general_search_icon_buffer)
			but.select_actions.extend (agent replay_to_selected_row)
			tb.extend (but)
			replay_to_but := but
			replay_to_but.disable_sensitive

			create replay_controls_label
			box_replay_controls.extend (replay_controls_label)
			box_replay_controls.set_background_color (row_replayable_bg_color)
			box_replay_controls.propagate_background_color
			tb.compute_minimum_size
		end

	replay_to_but: SD_TOOL_BAR_BUTTON
			-- Replay to button

feature {NONE} -- Internal Properties

	execution_replay_activated: BOOLEAN
			-- Is Execution replay activated ?

	execution_replay_level_limit: INTEGER
			-- Maximal level limit

	stack_data: ARRAY [CALL_STACK_ELEMENT]
			-- Data associated to the `stack_grid' row's data

	arrowed_level: INTEGER
			-- Line number in the stack that has an arrow displayed.

	marked_level: INTEGER
			-- Line number in the stack that has an arrow marked.
			-- i.e: for replayed level cursor

feature {NONE} -- Internal Widgets

	thread_id: EV_LABEL
			-- Thread Identifier

	stop_cause: EV_LABEL
			-- Why did the execution stop? (encountered breakpoint, raised exception,...)

	exception: EV_TEXT_FIELD
			-- Exception application has encountered.

	exception_dialog_button: SD_TOOL_BAR_BUTTON
			-- Button to display exception dialog.

	stack_grid: ES_GRID
			-- Graphical representation of the execution stack.

	box_thread: EV_HORIZONTAL_BOX
			-- Box display the thread information

	box_exception: EV_HORIZONTAL_BOX
			-- Box display the exception information

	box_stop_cause: EV_HORIZONTAL_BOX
			-- Box display the stop reason information

	box_replay_controls: EV_HORIZONTAL_BOX
			-- Box display the execution replay controls (up, down...)

	replay_controls_label: EV_LABEL
			-- Label showing execution replay information

feature {NONE} -- Commands

	save_call_stack_cmd: EB_STANDARD_CMD
			-- Command that saves the call stack to a file.

	copy_call_stack_cmd: EB_STANDARD_CMD
			-- Command that copy the call stack to the clipboard.

	set_stack_depth_cmd: EB_STANDARD_CMD
			-- Command that alters the displayed depth of the call stack.

feature {ES_CALL_STACK_TOOL} -- UI access

	activate_execution_replay_mode (b: BOOLEAN; levlim: INTEGER) is
			-- Enable or disable execution replay
		do
			execution_replay_activated := b
			execution_replay_level_limit := levlim
			if b and then not box_replay_controls.is_show_requested then
				box_replay_controls.show
				replay_to_but.enable_sensitive
				debug
					replay_controls_label.set_text ("LevelMax=" + levlim.out)
				end
			else
				debug
					replay_controls_label.remove_text
				end
				replay_to_but.disable_sensitive
				box_replay_controls.hide
			end
			if stack_grid /= Void then
				clean_stack_grid
				if execution_replay_activated then
					stack_grid.enable_tree
				else
					stack_grid.disable_tree
				end
				marked_level := 1
				if debugger_manager.safe_application_is_stopped then
					populate_stack_grid (debugger_manager.application_status.current_call_stack)
				end
			end
		end

	set_execution_replay_level (lev: INTEGER; levlim: INTEGER; rep: REPLAYED_CALL_STACK_ELEMENT) is
			-- Set the execution replay level to `lev'
			-- in the limits of `levlim'
			-- i.e: refresh the stack_grid using the adapted colors
		require
			app_is_stopped: debugger_manager.safe_application_is_stopped
			in_range: levlim > 0 implies lev <= levlim
		do
			if rep /= Void then
				replay_controls_label.set_text (rep.depth.out + ".(" + rep.replayed_break_index.out + "," + rep.replayed_break_nested_index.out + ")")
			else
				replay_controls_label.remove_text
			end
			replay_controls_label.refresh_now

			if stack_grid /= Void then
				stack_grid.remove_selection
				replay_to_but.disable_sensitive
			end
			marked_level := lev
				--| We need to remove replayed rows,
				--| since the replayed info might have changed
			remove_replayed_rows
			stack_grid.clear
			if lev > 0 then
				select_element_by_level (lev)
			else
				select_element_by_level (1)
			end
		end

	remove_replayed_rows is
			-- Remove all rows related to replayed call
		local
			r: INTEGER
		do
			if execution_replay_activated and stack_grid.row_count > 0 then
				from
					r := 1
				until
					r > stack_grid.row_count
				loop
					stack_grid.grid_remove_and_clear_subrows_from (stack_grid.row (r))
					r := r + 1
				end
			end
		end

feature {NONE} -- Replay helpers

	replay_to_selected_row is
			-- Replay to selected row
		require
			execution_replay_activated: execution_replay_activated
		local
			b: BOOLEAN
			lev: INTEGER
			l_id: STRING
		do
			if {l_row: EV_GRID_ROW} stack_grid.single_selected_row then
				if {rcse: like replayed_call_stack_element_from_row} replayed_call_stack_element_from_row (l_row) then
					l_id := rcse.id
				else
					lev := level_from_row (l_row)
					if lev > 0 then
						l_id := "-" + lev.out
					end
				end
			end
			if l_id /= Void then
				b := debugger_manager.application.replay_to_point (l_id)
				if b then
					eb_debugger_manager.update_execution_replay
				end
			end
		end

feature -- Change

	refresh is
			-- Refresh call stack
		do
			remove_replayed_rows
			stack_grid.clear
		end

	show is
			-- Show tool
		do
			Precursor {ES_DEBUGGER_DOCKABLE_STONABLE_TOOL_PANEL}
			if stack_grid.is_displayed and then stack_grid.is_sensitive then
				stack_grid.set_focus
			end
			request_update
		end

feature {NONE} -- Even handlers

	on_show	is
			-- <Precursor>
		do
			Precursor
		end

feature {NONE} -- Update

	on_update_when_application_is_executing (dbg_stopped: BOOLEAN) is
			-- Update when debugging
		do
			request_clean_stack_grid
			display_stop_cause (dbg_stopped)
			refresh_threads_info
		end

	on_update_when_application_is_not_executing is
			-- Update when not debugging
		do
			request_clean_stack_grid
			save_call_stack_cmd.disable_sensitive
			copy_call_stack_cmd.disable_sensitive
			display_stop_cause (False)
			display_box_thread (False)
		end

	real_update (dbg_was_stopped: BOOLEAN) is
			-- Display current execution status.
			-- dbg_was_stopped is ignore if Application/Debugger is not running			
		local
			l_status: APPLICATION_STATUS
			stack: EIFFEL_CALL_STACK
		do
			request_clean_stack_grid
			save_call_stack_cmd.disable_sensitive
			copy_call_stack_cmd.disable_sensitive

			if Debugger_manager.application_is_executing then
				l_status := Debugger_manager.application_status
				if dbg_was_stopped then
					l_status.update_on_stopped_state
				end
				display_stop_cause (dbg_was_stopped)
				refresh_threads_info
				if
					dbg_was_stopped and l_status.is_stopped
				then
					stack := l_status.current_call_stack
					populate_stack_grid (stack)
					if l_status.is_stopped
						and then stack /= Void
						and then not stack.is_empty
					then
						select_element_by_level (1) -- ???
					end
				end
			end
		end

feature {ES_CALL_STACK_TOOL} -- Memory management

	reset_tool is
			-- Reset tool when debugging is terminated
		do
			reset_update_on_idle
			if is_initialized then
				exception.remove_text
				exception.remove_tooltip
				exception_dialog_button.disable_sensitive
				stop_cause.remove_text
				display_box_thread (False)
				save_call_stack_cmd.disable_sensitive
				copy_call_stack_cmd.disable_sensitive
				clean_stack_grid
			end
		end

feature {NONE} -- Internal memory management

	internal_recycle is
			-- Recycle `Current', but leave `Current' in an unstable state,
			-- so that we know whether we're still referenced or not.
		do
			reset_tool
			Preferences.debug_tool_data.row_highlight_background_color_preference.change_actions.prune_all (set_row_highlight_bg_color_agent)
			Preferences.debug_tool_data.row_replayable_background_color_preference.change_actions.prune_all (set_row_replayable_bg_color_agent)
			Preferences.debug_tool_data.unsensitive_foreground_color_preference.change_actions.prune_all (set_unsensitive_fg_color_agent)
			Precursor {ES_DEBUGGER_DOCKABLE_STONABLE_TOOL_PANEL}
		end

feature {NONE} -- Implementation: Stop

	display_stop_cause (arg_is_stopped: BOOLEAN) is
			-- Fill in the `stop_cause' label with a message describing the application status.
			-- arg_is_stopped is ignore if Application/Debugger is not running
		local
			m: STRING_32
		do
			exception_dialog_button.disable_sensitive
			if not Debugger_manager.application_is_executing then
				stop_cause.set_text (Interface_names.l_System_launched)
				exception.remove_text
				exception.remove_tooltip
			elseif not arg_is_stopped then
				stop_cause.set_text (Interface_names.l_System_running)
				exception.remove_text
				exception.remove_tooltip
			else -- Application is stopped.
				create m.make (100)
				inspect Debugger_manager.application_status.reason
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
					set_focus_if_visible
				when Pg_catcall then
					stop_cause.set_text (Interface_names.l_debugger_catcall_warning_message)
					m.append (Interface_names.l_debugger_catcall_warning_message)
					display_catcall_message
					set_focus_if_visible
				when Pg_raise then
					stop_cause.set_text (Interface_names.l_Explicit_exception_pending)
					m.append (Interface_names.l_Explicit_exception_pending)
					m.append (": ")
					m.append (exception_short_description)
					display_exception
					set_focus_if_visible
				when Pg_viol then
					stop_cause.set_text (Interface_names.l_Implicit_exception_pending)
					m.append (Interface_names.l_Implicit_exception_pending)
					m.append (": ")
					m.append (exception_short_description)
					display_exception
					set_focus_if_visible
				when Pg_update_breakpoint then
					stop_cause.set_text (Interface_names.l_Update_breakpoint)
					m.append (Interface_names.l_Update_breakpoint)
				else
					stop_cause.set_text (Interface_names.l_Unknown_status)
					m.append (Interface_names.l_Unknown_status)
				end
				Eb_debugger_manager.debugging_window.status_bar.display_message ( first_line_of (m) )
			end
		end

	open_stack_depth_dialog is
			-- Display a dialog that lets the user change the maximum depth of the call stack.
		local
			dlg: ES_CALL_STACK_DEPTH_DIALOG
		do
			create dlg.make_with_debugger (debugger_manager)
			dlg.set_is_modal (True)
			dlg.show_on_active_window
		end

feature {NONE} -- Implementation: Exceptions

	open_exception_dialog is
			-- Open exception dialog to show the exception details
		local
			dlg: EB_DEBUGGER_EXCEPTION_DIALOG
			w: EV_WINDOW
		do
			w := Eb_debugger_manager.debugging_window.window
			if debugger_manager.safe_application_is_stopped then
				create dlg.make
				dlg.set_exception (exception_value)
				dlg.set_is_modal (True)
				dlg.show_on_active_window
			else
				prompts.show_error_prompt (interface_names.l_Only_available_for_stopped_application, w, Void)
			end
		end

	display_exception is
			-- Fill in the `exception' label with a text describing the exception, if any.
		local
			m: STRING_32
		do
			m := exception_short_description
--| FIXME jfiat [2004/03/19] : NewFeature keep only first line of exception text for callstack_tool
--| We'll enable this, once we have an exception window to display the full message
			exception.set_text (first_line_of (m))
			exception.set_tooltip (m)
			exception_dialog_button.enable_sensitive
		end

	exception_value: EXCEPTION_DEBUG_VALUE is
			-- Current exception value
		local
			l_status: APPLICATION_STATUS
		do
			l_status := Debugger_manager.application_status
			if l_status /= Void then
				if l_status.exception_occurred then
					Result := l_status.exception
				end
			end
		end

	fake_exception_value: EXCEPTION_DEBUG_VALUE is
			-- Current exception value
		do
			Result := exception_value
			if Result = Void then
				create Result.make_fake ("No exception occurred")
			end
		ensure
			Result_not_void: Result /= Void
		end

	exception_short_description: STRING_32 is
			-- Text corresponding to the current exception.
		local
			e: like exception_value
		do
			e := exception_value
			if e = Void then
				e := fake_exception_value
			end
			Result := e.short_description
		end

feature {NONE} -- Catcall warning access

	display_catcall_message is
			-- Fill in the `exception' label with a text describing the catcall, if any.
		require
			reason_is_catcall: debugger_manager.application_status.reason_is_catcall
		local
			m: STRING_32
		do
			m := catcall_message
			exception.set_text (m)
			exception.set_tooltip (m)
			exception_dialog_button.disable_sensitive
		end

	catcall_message: STRING_32 is
			-- Catcall warning message
		require
			reason_is_catcall: debugger_manager.application_status.reason_is_catcall
		local
			rtcc: TUPLE [pos: INTEGER; expected: INTEGER; actual: INTEGER]
			l_fdtype: INTEGER
			l_max_type_id: INTEGER
			ct: CLASS_TYPE
			f: E_FEATURE
			argname: STRING
			l_static_argtypename,
			argtypename: STRING
			retried: BOOLEAN
			ecse: EIFFEL_CALL_STACK_ELEMENT
			l_status: APPLICATION_STATUS
		do
			if not retried then
				l_status := debugger_manager.application_status
				rtcc := l_status.catcall_data
				create Result.make_from_string ("Catcall detected")
				if rtcc /= Void and then rtcc.pos > 0 then
					if l_status.has_valid_current_eiffel_call_stack_element then
						ecse := l_status.current_eiffel_call_stack_element
						if ecse /= Void then
							f := ecse.routine
						end
					end

					Result.append_string (" for ")
						--| Get info with compiler data
					if f /= Void then
						if {args: E_FEATURE_ARGUMENTS} (f.arguments) and then args.count >= rtcc.pos then
							if {argnames: LIST [STRING]} (args.argument_names) then
								argnames.start
								argnames.move (rtcc.pos - 1)
								argname := argnames.item
							end
							args.start
							args.move (rtcc.pos - 1)
							if {typ: TYPE_A} args.item then
								l_static_argtypename := typ.name
							end
						end
					end
					Result.append_string (" argument#")
					Result.append_integer (rtcc.pos)

					if argname /= Void then
						Result.append_string (" `")
						Result.append_string (argname)
						Result.append_character (''')
					end
					l_max_type_id := system.class_types.count

					Result.append_string (": expected ")
					ct := Void

					l_fdtype := rtcc.expected
					if l_fdtype <= l_max_type_id then
							--| Try with compiler data						
						ct := System.class_type_of_id (l_fdtype)
						if ct /= Void and then ct.associated_class /= Void then
							if not ct.is_generic then
								argtypename := ct.associated_class.name_in_upper
							end
						end
					end
					if argtypename = Void then
							--| Try with evaluation on app						
						argtypename := debugger_manager.application.internal_type_name_of_type (l_fdtype - 1) --| -1: to convert to runtime type id
					end
					if argtypename = Void then
						if l_static_argtypename /= Void then
							argtypename := l_static_argtypename.twin
						else
							argtypename := ""
						end
						argtypename.append_string (" (type#")
						argtypename.append_integer (l_fdtype)
						argtypename.append_string (")")
					end
					Result.append_string (" ")
					Result.append_string (argtypename)
					argtypename := Void

					Result.append_string (" but got ")
					l_fdtype := rtcc.actual
						--| Try with compiler data
					if l_fdtype <= l_max_type_id then
						ct := System.class_type_of_id (l_fdtype)
						if ct /= Void and then ct.associated_class /= Void and then not ct.is_generic then
							argtypename := ct.associated_class.name_in_upper
						end
					end
						--| Try with evaluation on app
					if argtypename = Void then
						argtypename := debugger_manager.application.internal_type_name_of_type (l_fdtype - 1) --| -1: to convert to runtime type id
					end
					if argtypename /= Void then
						Result.append_string (argtypename)
					else
						Result.append_string ("type#")
						Result.append_integer (l_fdtype)
					end
					argtypename := Void
				end
			else
				create Result.make_from_string ("Catcall detected")
			end
		ensure
			Result_not_void: Result /= Void
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation: threads

	display_box_thread (b: BOOLEAN) is
			-- Show or hide box related to available Thread ids
		do
			if box_thread /= Void then
				if b then
					box_thread.show
				else
					box_thread.hide
				end
			end
		end

	refresh_threads_info is
			-- Refresh thread info according to debugger data
		require
			application_is_executing: debugger_manager.application_is_executing
		local
			ctid: INTEGER
			s: APPLICATION_STATUS
		do
			s := Debugger_manager.application_status
			if s.all_thread_ids_count > 1 then
				ctid := s.current_thread_id
				thread_id.set_text ("0x" + ctid.to_hex_string)
				thread_id.set_data (ctid)
				display_box_thread (True)
			else
				display_box_thread (False)
			end
		end

	select_call_stack_thread (lab: EV_LABEL; x, y, button: INTEGER; x_tilt, y_tilt, pressure: DOUBLE; screen_x, screen_y: INTEGER) is
			-- Select thread
		local
			m: EV_MENU
			mi: EV_MENU_ITEM
			tid: INTEGER
			arr: LIST [INTEGER]
			l_item_text, s: STRING
			l_status: APPLICATION_STATUS
		do
			l_status := Debugger_manager.application_status
			if l_status /= Void then
				if l_status.is_stopped then
					arr := l_status.all_thread_ids
					if arr /= Void and then not arr.is_empty then
						create m

						create mi.make_with_text_and_action ("Show threads panel", agent
								do
									if {th: ES_THREADS_TOOL} eb_debugger_manager.threads_tool then
										th.show (True)
									end
								end)
						m.extend (mi)
						m.extend (create {EV_MENU_SEPARATOR})

						from
							arr.start
						until
							arr.after
						loop
							tid := arr.item
							l_item_text := "0x" + tid.to_hex_string
							s := l_status.thread_name (tid)
							if s /= Void then
								l_item_text.append_string (" - " + s)
							end

							create mi
							if tid = l_status.current_thread_id then
								mi.set_pixmap (pixmaps.icon_pixmaps.callstack_active_arrow_icon)
							end
							mi.set_text (l_item_text)
							mi.set_data (tid)
							mi.select_actions.extend (agent debugger_manager.change_current_thread_id (tid)) --| it will trigger `update'
							m.extend (mi)
							arr.forth
						end
						m.show_at (lab, 0, thread_id.height)
					else
						prompts.show_info_prompt ("Sorry no information available on Threads for now", Eb_debugger_manager.debugging_window.window, Void)
					end
				else
					prompts.show_error_prompt (interface_names.l_Only_available_for_stopped_application, Eb_debugger_manager.debugging_window.window, Void)
				end
			else
				prompts.show_error_prompt (interface_names.l_Only_available_for_stopped_application, Eb_debugger_manager.debugging_window.window, Void)
			end
		end

feature {NONE} -- Export call stack

	save_call_stack is
			-- Saves the current call stack representation in a file.
		local
			fd: EB_FILE_SAVE_DIALOG
			standard_path: DIRECTORY_NAME
			f: RAW_FILE
			fn: FILE_NAME
			last_path: STRING
			i: INTEGER
		do
				--| Get last path from the preferences.
			last_path := preferences.debug_tool_data.last_saved_stack_path
			if last_path = Void or else last_path.is_empty then
					--| The first time, start in the project directory.
				create standard_path.make
				standard_path.extend (Eiffel_project.project_directory.path)
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
			fd.show_modal_to_window (Eb_debugger_manager.debugging_window.window)
		end

	save_call_stack_to_file (fd: EV_FILE_DIALOG) is
			-- Actually saves the call stack.
		require
			valid_dialog: fd /= Void
		local
			f: RAW_FILE
			fn, fp: STRING
			l_prompt: ES_QUESTION_PROMPT
			retried: BOOLEAN
		do
			if not retried then
				if debugger_manager.safe_application_is_stopped then
						--| We create a file (or open it).
					fn := fd.file_name
					fp := fd.file_path
					create f.make (fn)
					if f.exists then
						create l_prompt.make_standard (interface_names.l_file_exits (fn))
						l_prompt.set_button_text (l_prompt.dialog_buttons.yes_button, interface_names.b_overwrite)
						l_prompt.set_button_text (l_prompt.dialog_buttons.no_button, interface_names.b_append)
						l_prompt.set_button_action (l_prompt.dialog_buttons.yes_button, agent save_call_stack_to_filename (fp, fn, False))
						l_prompt.set_button_action (l_prompt.dialog_buttons.no_button, agent save_call_stack_to_filename (fp, fn, True))
						l_prompt.show (Eb_debugger_manager.debugging_window.window)
					else
						save_call_stack_to_filename	(fp, fn, False)
					end
				else
					prompts.show_error_prompt (interface_names.l_only_available_for_stopped_application, Eb_debugger_manager.debugging_window.window, Void)
				end
			else
					-- The file name was probably incorrect (not creatable).
				if fd /= Void then
					prompts.show_error_prompt (Warning_messages.w_Not_creatable (fd.file_name), Eb_debugger_manager.debugging_window.window, Void)
				end
			end
		rescue
			retried := True
			retry
		end

	save_call_stack_to_filename (a_fp: STRING; a_fn: STRING; is_append: BOOLEAN) is
			-- Save call stack into file named `a_fn'.
			-- if the file already exists and `is_append' is True
			-- then append the stack in the same file
		local
			fn: FILE_WINDOW
			retried: BOOLEAN
		do
			if not retried then
					--| We create a file (or open it).
				create fn.make (a_fn)
				if fn.exists and is_append then
					fn.open_append
				else
					fn.create_read_write
				end
					--| We generate the call stack.
				Eb_debugger_manager.text_formatter_visitor.append_stack (Debugger_manager.application_status.current_call_stack, fn)

					--| We put it in the file.
				if not fn.is_closed then
					fn.close
				end
					--| Save the path to the preferences.
				preferences.debug_tool_data.last_saved_stack_path_preference.set_value (a_fp)
				preferences.preferences.save_preference (preferences.debug_tool_data.last_saved_stack_path_preference)
			else
					-- The file name was probably incorrect (not creatable).
				prompts.show_error_prompt (Warning_messages.w_Not_creatable (a_fn), Eb_debugger_manager.debugging_window.window, Void)
			end
		rescue
			retried := True
			retry
		end

	copy_call_stack_to_clipboard is
		local
			l_output: YANK_STRING_WINDOW
			retried: BOOLEAN
			e: like exception_value
			s: STRING
			t: STRING
		do
			if not retried then
				if debugger_manager.safe_application_is_stopped then
						--| We generate the call stack.
					create s.make_empty
					if debugger_manager.application_status.exception_occurred then
						e := exception_value
						if e = Void then
							e := fake_exception_value
						end
						s.append (e.long_description)
					end
					create l_output.make;
					Eb_debugger_manager.text_formatter_visitor.append_stack (Debugger_manager.application_status.current_call_stack, l_output)
					t := l_output.stored_output
					if t /= Void and then not t.is_empty then
						s.append_string (t)
					end
					ev_application.clipboard.set_text (s)
					l_output.reset_output
				else
					ev_application.clipboard.set_text ("")
				end
			else
				ev_application.clipboard.set_text ("")
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Stack grid implementation

	clean_stack_grid is
			-- Clean the stack_grid
		do
			stack_grid.call_delayed_clean
			if stack_data /= Void then
				stack_data.discard_items
			end
		ensure
			stack_grid_cleaned: stack_grid.row_count = 0
		end

	request_clean_stack_grid is
			-- Clean the stack_grid
		do
			stack_grid.request_delayed_clean
		end

	populate_stack_grid (stack: EIFFEL_CALL_STACK) is
			-- Fill the satck_grid with `stack' data
		require
			application_stopped: debugger_manager.safe_application_is_stopped
		local
			g: ES_GRID
			row: EV_GRID_ROW
			l_tooltipable_grid_row: EV_GRID_ROW
			glab: EV_GRID_LABEL_ITEM
			i: INTEGER
		do
			clean_stack_grid
			g := stack_grid
			if stack /= Void and then not stack.is_empty then
				save_call_stack_cmd.enable_sensitive
				copy_call_stack_cmd.enable_sensitive
				from
					stack.start
					create stack_data.make (1, stack.count)
					g.insert_new_rows (stack.count, 1)
					i := 1
				until
					stack.after
				loop
					row := stack_grid.row (i)
					stack_data[i] := stack.item
					row.set_data (i)
					if not stack.item.is_eiffel_call_stack_element then
						row.disable_select
					end
					i := i + 1
					stack.forth
				end
			else
				save_call_stack_cmd.disable_sensitive
				copy_call_stack_cmd.disable_sensitive
				l_tooltipable_grid_row := g.grid_extended_new_row (g)
				create glab.make_with_text ("Unable to get call stack data")
				glab.set_tooltip ("Double click to refresh call stack")
				glab.set_pixmap (pixmaps.icon_pixmaps.general_mini_error_icon)
				glab.pointer_double_press_actions.force_extend (agent update)
				l_tooltipable_grid_row.set_item (1, glab)
			end
			stack_grid.request_columns_auto_resizing
			stack_grid.redraw
		end

	compute_stack_grid_item (c, r: INTEGER): EV_GRID_ITEM is
			-- Computed grid item corresponding to `c,r'.
		local
			row: EV_GRID_ROW
			i,n: INTEGER
		do
			row := stack_grid.row (r)
			if c <= row.count then
				Result := row.item (c)
			end
			if Result = Void then
				if execution_replay_activated then
					compute_replayed_stack_grid_row (row)
				else
					compute_stack_grid_row (row)
				end

					--| fill_empty_cells of `row'
				n := stack_grid.column_count
				from i := 1	until i > n loop
					if row.item (i) = Void then
						row.set_item (i, create {EV_GRID_ITEM})
					end
					i := i + 1
				end

					--| Now Result should not be Void
				Result := row.item (c)
			end
		end

	compute_stack_grid_row (a_row: EV_GRID_ROW) is
			-- Compute item for `a_row'
		require
			a_row_not_void: a_row /= Void
		local
			level: INTEGER
			cse: CALL_STACK_ELEMENT
			dc, oc: CLASS_C
			l_tooltip: STRING_32
			l_nb_stack: INTEGER
			e_cse: EIFFEL_CALL_STACK_ELEMENT
			ext_cse: EXTERNAL_CALL_STACK_ELEMENT
			dotnet_cse: CALL_STACK_ELEMENT_DOTNET
			l_feature_name: STRING
			l_is_melted: BOOLEAN
			l_has_rescue: BOOLEAN
			l_class_info: STRING
			l_orig_class_info: STRING_GENERAL
			l_same_name: BOOLEAN
			l_breakindex_info: STRING
			l_obj_address_info: STRING
			l_extra_info: STRING
			glab: EV_GRID_LABEL_ITEM
			glabp: EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM
			app_exec: APPLICATION_EXECUTION
		do
			level := level_from_row (a_row)
			if stack_data /= Void and then stack_data.valid_index (level) then
				cse := stack_data [level]
			end
			check cse_not_void: not execution_replay_activated implies cse /= Void end
			if cse /= Void then
				create l_tooltip.make (10)
				e_cse ?= cse

					--| Class name
				l_class_info := cse.class_name
				if l_class_info /= Void then
					l_tooltip.append ("{" + l_class_info + "}.")
				end

					--| Break Index
				l_breakindex_info := cse.break_index.out

					--| Routine name
				l_feature_name := cse.routine_name
				if l_feature_name /= Void then
					l_feature_name := l_feature_name.twin
				else
					create l_feature_name.make_empty
				end
--| Decide later, if we want the  "@bp-index" visible
--				if l_feature_name /= Void then
--					l_feature_name.append (" @" + l_breakindex_info.out)
--				end

				l_tooltip.append (l_feature_name)

					--| Object address
				l_obj_address_info := cse.object_address

				if e_cse /= Void then
						--| Origin class
					dc := e_cse.dynamic_class
					oc := e_cse.written_class
					if oc /= Void then
						l_orig_class_info := oc.name_in_upper
						l_same_name := dc /= Void and then oc.same_type (dc) and then oc.is_equal (dc)
						if not l_same_name then
							l_tooltip.prepend_string (interface_names.l_from_class (l_orig_class_info))
						end
					else
						l_orig_class_info := Interface_names.l_Same_class_name
					end

						--| Routine name
					l_has_rescue := e_cse.has_rescue
					if l_has_rescue then
						l_tooltip.append_string (interface_names.l_feature_has_rescue_clause)
					end
					l_is_melted := e_cse.is_melted
					if l_is_melted then
						l_tooltip.append_string (interface_names.l_compilation_equal_melted)
					end

					dotnet_cse ?= e_cse
					if dotnet_cse /= Void and then dotnet_cse.dotnet_module_name /= Void then
						l_tooltip.append_string (interface_names.l_module_is (dotnet_cse.dotnet_module_name))
					end

					a_row.set_data (level)
				else --| It means, this is an EXTERNAL_CALL_STACK_ELEMENT
					l_orig_class_info := ""
					ext_cse ?= cse
					if ext_cse /= Void then
						l_extra_info := ext_cse.info
					end
					a_row.set_data (- level) -- This is not a valid Eiffel call stack element.
				end

				check debugger_manager.application_is_executing end
				app_exec := Debugger_manager.application
					--| Tooltip addition
				l_nb_stack := app_exec.status.current_call_stack.count
				l_tooltip.prepend_string ((cse.level_in_stack).out + "/" + l_nb_stack.out + ": ")
				l_tooltip.append_string (interface_names.l_break_index_is (l_breakindex_info))
				l_tooltip.append_string (interface_names.l_address_is (l_obj_address_info))
				if l_extra_info /= Void then
					l_tooltip.append_string ("%N    + " + l_extra_info)
				end

					--| Fill columns
				if l_is_melted or l_has_rescue then
					create glabp.make_with_text (l_feature_name)
					glabp.set_pixmaps_on_right_count (2)
					if l_is_melted then
						glabp.put_pixmap_on_right (pixmaps.mini_pixmaps.callstack_is_melted_icon, 1)
					end
					if l_has_rescue then
						glabp.put_pixmap_on_right (pixmaps.mini_pixmaps.callstack_has_rescue_icon, 2)
					end
					glab := glabp
				else
					create glab.make_with_text (l_feature_name)
				end
				glab.set_tooltip (l_tooltip)
				a_row.set_item (Feature_column_index, glab)

					--| Position
				create glab.make_with_text (cse.break_index.out)
				a_row.set_item (Position_column_index, glab)

					--| Dynamic Type
				create glab.make_with_text (l_class_info)
				glab.set_tooltip (l_class_info)
				a_row.set_item (Dtype_column_index, glab)

					--| Origine Type
				create glab.make_with_text (l_orig_class_info)
				if l_same_name then
					glab.set_foreground_color (unsensitive_fg_color)
				end
				glab.set_tooltip (l_orig_class_info)
				a_row.set_item (Stype_column_index, glab)

					--| Set GUI behavior
				if level = app_exec.current_execution_stack_number then
					arrowed_level := level
				end
				if level = app_exec.current_execution_stack_number then
					arrowed_level := level
				end
				refresh_stack_grid_row (a_row, app_exec.current_execution_stack_number)
			end
		end

	refresh_stack_grid_row (a_row: EV_GRID_ROW; current_level: INTEGER) is
			-- Refresh row of stack_grid regarding the `current_level' information
		require
			a_row /= Void
		local
			glab: EV_GRID_LABEL_ITEM
			level: INTEGER
			ep: EV_PIXMAP
		do
			level := level_from_row (a_row)
			a_row.set_foreground_color (Void)
			a_row.set_background_color (Void)

			glab ?= a_row.item (Feature_column_index)
			if glab = Void then
				a_row.clear
			else
				if level = current_level then
					glab.set_pixmap (pixmaps.icon_pixmaps.callstack_active_arrow_icon)
					a_row.set_background_color (row_highlight_bg_color)
				else
					ep := pixmaps.icon_pixmaps.callstack_empty_arrow_icon
					if level >= 0 then
						glab.set_pixmap (ep)
					else
						glab.remove_pixmap
						glab.set_left_border (glab.left_border + glab.spacing + ep.width)
						a_row.set_foreground_color (unsensitive_fg_color)
					end
				end
			end
			if execution_replay_activated then
				if level - 1 <= execution_replay_level_limit then
					a_row.ensure_expandable
					a_row.set_background_color (row_replayable_bg_color)
				end
				if level = marked_level then
					if glab /= Void then
						glab.set_pixmap (pixmaps.icon_pixmaps.callstack_marked_arrow_icon)
					end
				end
			end
		end

	compute_replayed_stack_grid_row (a_row: EV_GRID_ROW) is
			-- Compute item for `a_row' when `execution_replay_activated' is True
		require
			a_row_not_void: a_row /= Void
		local
			rcse: REPLAYED_CALL_STACK_ELEMENT
			cse: REPLAYED_CALL_STACK_ELEMENT
			dc, oc: CLASS_C
			l_tooltip: STRING_32
			l_nb_stack: INTEGER
			l_feature_name: STRING
			rt_info_avail: BOOLEAN
			l_is_melted: BOOLEAN
			l_has_rescue: BOOLEAN
			l_class_info: STRING
			l_orig_class_info: STRING_GENERAL
			l_same_name: BOOLEAN
			l_breakindex_info: STRING
			featlab,glab: EV_GRID_LABEL_ITEM
			glabp: EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM
			app_exec: APPLICATION_EXECUTION
		do
			check debugger_manager.application_is_executing end
			app_exec := Debugger_manager.application
			rcse := app_exec.status.current_replayed_call

			cse := replayed_call_stack_element_from_row (a_row)
			if cse = Void then
				compute_stack_grid_row (a_row)
				if
					a_row.is_expandable and then
					rcse /= Void and then
					level_from_row (a_row) = level_associated_with (rcse)
				then
					a_row.expand
				end
			else
				if cse /= Void then
					create l_tooltip.make (10)

						--| Class name
					l_class_info := cse.class_name
					if l_class_info /= Void then
						l_tooltip.append ("{" + l_class_info + "}.")
					end

						--| Break Index
					l_breakindex_info := cse.break_index.out

						--| Routine name
					l_feature_name := cse.routine_name
					if l_feature_name /= Void then
						l_feature_name := l_feature_name.twin
					else
						create l_feature_name.make_empty
					end
--| Decide later, if we want the  "@bp-index" visible
--					if l_feature_name /= Void then
--						l_feature_name.append (" @" + l_breakindex_info.out)
--					end

					l_tooltip.append (l_feature_name)

						--| Origin class
					dc := cse.dynamic_class
					oc := cse.written_class
					if oc /= Void then
						l_orig_class_info := oc.name_in_upper
						l_same_name := dc /= Void and then oc.same_type (dc) and then oc.is_equal (dc)
						if not l_same_name then
							l_tooltip.prepend_string (interface_names.l_from_class (l_orig_class_info))
						end
					else
						l_orig_class_info := Interface_names.l_Same_class_name
					end

					rt_info_avail := cse.rt_information_available

						--| Routine name
					l_has_rescue := cse.has_rescue
					if l_has_rescue then
						l_tooltip.append_string (interface_names.l_feature_has_rescue_clause)
					end
					l_is_melted := cse.is_melted
					if l_is_melted then
						l_tooltip.append_string (interface_names.l_compilation_equal_melted)
					end

						--| Tooltip addition
					l_nb_stack := app_exec.status.current_call_stack.count
					l_tooltip.prepend_string (cse.remote_id + ": ")
					l_tooltip.append_string (interface_names.l_break_index_is (l_breakindex_info))
					l_tooltip.prepend_string (cse.id + "%N")

						--| Fill columns
					if l_is_melted or l_has_rescue then
						create glabp.make_with_text (cse.break_index.out + ": " + l_feature_name)
						glabp.set_pixmaps_on_right_count (2)
						if l_is_melted then
							glabp.put_pixmap_on_right (pixmaps.mini_pixmaps.callstack_is_melted_icon, 1)
						end
						if l_has_rescue then
							glabp.put_pixmap_on_right (pixmaps.mini_pixmaps.callstack_has_rescue_icon, 2)
						end
						glab := glabp
					else
						if cse.break_nested_index > 0 then
							create glab.make_with_text (cse.break_index.out + "." + cse.break_nested_index.out + ": " + l_feature_name)
						else
							create glab.make_with_text (cse.break_index.out + ": " + l_feature_name)
						end
					end
					if rt_info_avail then
						glab.set_font (fonts.highlighted_label_font)
					else
						glab.set_font (fonts.italic_label_font)
					end
					featlab := glab
					l_tooltip.append ("%NReplayed: (" + cse.replayed_break_index.out + ", " + cse.replayed_break_nested_index.out + ")")
					if cse.is_active_replayed then
						l_tooltip.append ("%NIsActive=True")
					end
					glab.set_tooltip (l_tooltip)
					a_row.set_item (Feature_column_index, glab)

						--| Position
					if cse.replayed_break_nested_index > 0 then
						create glab.make_with_text (cse.replayed_break_index.out + "." + cse.replayed_break_nested_index.out)
					else
						create glab.make_with_text (cse.replayed_break_index.out)
					end
					a_row.set_item (Position_column_index, glab)

						--| Dynamic type
					create glab.make_with_text (l_class_info)
					glab.set_tooltip (l_class_info)
					a_row.set_item (Dtype_column_index, glab)

						--| Original type
					create glab.make_with_text (l_orig_class_info)
					if l_same_name then
						glab.set_foreground_color (unsensitive_fg_color)
					end
					glab.set_tooltip (l_orig_class_info)
					a_row.set_item (Stype_column_index, glab)

						--| Set GUI behavior
--					refresh_stack_grid_row (a_row, app_exec.current_execution_stack_number)

					if cse.rt_information_available then
						if rcse /= Void and then cse.depth = rcse.depth then
							featlab.set_pixmap (pixmaps.icon_pixmaps.callstack_marked_arrow_icon)
							if a_row.is_expandable then
								a_row.expand
							end
						elseif level_associated_with (cse) = app_exec.current_execution_stack_number then
							featlab.set_pixmap (pixmaps.icon_pixmaps.callstack_active_arrow_icon)
						end
					else
						if cse.is_active_replayed then
							featlab.set_pixmap (pixmaps.icon_pixmaps.callstack_replayed_active_icon)
						else
							featlab.set_pixmap (pixmaps.icon_pixmaps.callstack_replayed_empty_icon)
						end
					end
				end
			end
		end

feature {NONE} -- Stone handlers

	on_stone_changed (a_old_stone: ?like stone) is
			-- Assign `a_stone' as new stone.
		do
			if {st: CALL_STACK_STONE} stone then
				arrowed_level := st.level_number
				stack_grid.clear
			end
		end

	on_element_drop (st: CALL_STACK_STONE) is
			-- Change stack level to the one described by `st'.
		do
			Eb_debugger_manager.launch_stone (st)
		end

feature {NONE} -- Grid Implementation

	replayed_call_stack_element_from_row (a_row: EV_GRID_ROW): REPLAYED_CALL_STACK_ELEMENT is
			-- Call stack level related to `a_row'.
		require
			a_row /= Void
		do
			Result ?= a_row.data
		end

	replayed_call_stack_element_from_row_with_rt_info (a_row: EV_GRID_ROW): REPLAYED_CALL_STACK_ELEMENT is
			-- Call stack level related to `a_row'.
		require
			a_row /= Void
		do
			Result := replayed_call_stack_element_from_row (a_row)
			if Result /= Void and then not Result.rt_information_available then
				if {p: EV_GRID_ROW} a_row.parent_row then
					Result := replayed_call_stack_element_from_row_with_rt_info (p)
				end
			end
		ensure
			Result_with_rt_info: Result /= Void implies Result.rt_information_available
		end

	level_associated_with (rep: REPLAYED_CALL_STACK_ELEMENT): INTEGER is
			-- Level associated with replayed call stack
		require
			rep_not_void: rep /= Void
		do
			if rep.rt_information_available and rep.depth > 0 then
				Result := debugger_manager.application_status.current_call_stack.stack_depth - rep.depth + 1
			end
		end

	level_from_row (a_row: EV_GRID_ROW): INTEGER is
			-- Call stack level related to `a_row'.
		require
			a_row /= Void
		do
			if {lev: INTEGER} a_row.data then
				Result := lev
			end
		end

	row_for_level (a_level: INTEGER): EV_GRID_ROW is
			-- Call stack row related to `a_level'.
		local
			row: EV_GRID_ROW
			g: EV_GRID
			r,n: INTEGER
		do
			g := stack_grid
			n := g.row_count
			if n > 0 then
				from r := 1 until r > n or Result /= Void loop
					row := g.row (r)
					if
						row.parent_row = Void and then
						level_from_row (row) = a_level
					then
						Result := row
					end
					r := r + 1
				end
			end
		end

	on_grid_item_pointer_pressed (a_x, a_y, a_button: INTEGER; a_item: EV_GRID_ITEM) is
			-- Action when mouse click on `stack_grid'
		local
			l_row: EV_GRID_ROW
		do
			if a_button = 1 and a_item /= Void then
				if
					not ev_application.ctrl_pressed
					and not ev_application.shift_pressed
					and not ev_application.alt_pressed
				then
					l_row := a_item.row
					if l_row /= Void then
						select_element_by_row (l_row)
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
						elem ?= Debugger_manager.application_status.current_call_stack.i_th (level)
						if
							elem /= Void and then
							elem.dynamic_class /= Void and then
							elem.dynamic_class.has_feature_table
						then
							if elem.routine /= Void then
								create Result.make (level)
							end
						end
					end
				end
			end
		end

	on_grid_item_accept_cursor_function	(a_item: EV_GRID_ITEM): EV_POINTER_STYLE is
			-- Accept Cursor for grid item
		do
			Result := Cursors.cur_setstop
		end

	select_element_by_row (a_row: EV_GRID_ROW) is
			-- Select element from `a_row'
		require
			a_row_not_void: a_row /= Void
		local
			st: FEATURE_STONE
			rst: REPLAYED_CALL_STACK_STONE
			l: INTEGER
		do
			if {lev: INTEGER} level_from_row (a_row) and then lev > 0 then
				select_element_by_level (lev)
			elseif {rep: like replayed_call_stack_element_from_row} replayed_call_stack_element_from_row (a_row) then
				if rep.rt_information_available then
					l := level_associated_with (rep)
					if
						rep.replayed_break_index /= rep.break_index --| later take also into account nested index...
					then
						if {rep_fe: E_FEATURE} rep.e_feature then
							create rst.make (rep_fe, [rep.replayed_break_index, rep.replayed_break_nested_index])
							st := rst
						end
					end
				end
				if l = 0 then
						--| Change call stack element with the best stack possible
					if
						{pr: EV_GRID_ROW} a_row.parent_row and then
						{rep_par: like replayed_call_stack_element_from_row} replayed_call_stack_element_from_row (pr)
					then
						if rep_par.rt_information_available then
								--| If parent has rt_information_available
							l := level_associated_with (rep_par)
						else --| Else find a parent replayed call with rt_information_available
							if {rep2: like replayed_call_stack_element_from_row} replayed_call_stack_element_from_row_with_rt_info (pr) then
								l := level_associated_with (rep2)
							end
						end
						if {rep_par_fe: E_FEATURE} rep_par.e_feature then
							create rst.make (rep_par_fe, [rep.break_index, rep.break_nested_index])
							st := rst
						end
					end

						--| And then switch to the associated feature
					if st = Void and {fe: E_FEATURE} rep.e_feature then
						create st.make (fe)
					end
				end
				if l > 0 then
					select_element_by_level	(l)
				end
				if st /= Void and then st.is_valid then
					eb_debugger_manager.launch_stone (st)
				end
			end
		end

	select_element_by_level (level: INTEGER) is
			-- Set stone in the  develpment window.
		require
			valid_level: level > 0 and level <= debugger_manager.application.number_of_stack_elements
		local
			st: CALL_STACK_STONE
		do
			create st.make (level)
			if st.is_valid then
				Eb_debugger_manager.launch_stone (st)
			end
		end

	key_pressed (a_key: EV_KEY) is
			-- If `a_key' is enter, set the selected stack element as the new stone.
		local
			l_row: EV_GRID_ROW
		do
			if a_key.code = Key_enter then
				l_row := stack_grid.single_selected_row
				if l_row /= Void then
					select_element_by_row (l_row)
					stack_grid.set_focus
				end
			end
		end

	on_row_selected	(a_row: EV_GRID_ROW) is
			-- `a_row' is selected
		do
			if execution_replay_activated then
				replay_to_but.enable_sensitive
			end
		end

	on_row_deselected	(a_row: EV_GRID_ROW) is
			-- `a_row' is deselected
		do
			if execution_replay_activated then
				replay_to_but.disable_sensitive
			end
		end

	on_row_expanded	(a_row: EV_GRID_ROW) is
			-- `a_row' is expanding
		require
			execution_replay_activated: execution_replay_activated
		local
			lev: INTEGER
			r: EV_GRID_ROW
		do
			if execution_replay_activated then
				if
					a_row /= Void and then a_row.parent /= Void and then a_row.subrow_count = 0
				then
					lev := level_from_row (a_row)
					if lev > 0 then
						if {rcse: REPLAYED_CALL_STACK_ELEMENT } debugger_manager.application.replay_callstack_details ((-lev).out, 1) then
							a_row.insert_subrows (1, a_row.subrow_count + 1)
							r := a_row.subrow (a_row.subrow_count)
							fill_replayed_call_stack (r, rcse)
						end
					elseif {rcse2: REPLAYED_CALL_STACK_ELEMENT} a_row.data then
						if rcse2.calls_count > 0 and then rcse2.calls = Void then
							if {rcse3: REPLAYED_CALL_STACK_ELEMENT} debugger_manager.application.replay_callstack_details (rcse2.id, 1) then
								rcse2.calls := rcse3.calls
								fill_replayed_call_stack (a_row, rcse2)
							end
						end
					end
				end
				stack_grid.request_columns_auto_resizing
			end
		end

	fill_replayed_call_stack (a_row: EV_GRID_ROW; rcse: REPLAYED_CALL_STACK_ELEMENT) is
		local
			r: EV_GRID_ROW
			i: INTEGER
		do
			if rcse /= Void then
				a_row.set_data (rcse)
				check a_row.subrow_count = 0 end
				if rcse.calls_count > 0 then
					if {subrcse: ARRAY [REPLAYED_CALL_STACK_ELEMENT]} rcse.calls then
						from
							i := subrcse.lower
						until
							i > subrcse.upper
						loop
							a_row.insert_subrows (1, a_row.subrow_count + 1)
							r := a_row.subrow (a_row.subrow_count)
							fill_replayed_call_stack (r, subrcse[i])
							i := i + 1
						end
					else
						a_row.ensure_expandable
					end
				end
			end
		end

feature {NONE} -- Constants

	Feature_column_index: INTEGER = 1
			-- Index of column for Feature name

	Position_column_index: INTEGER = 4
			-- Index of column for Position information

	Dtype_column_index: INTEGER = 2
			-- Index of column for Dynamic type

	Stype_column_index: INTEGER = 3
			-- Index of column for Static type

feature {NONE} -- Implementation, cosmetic

	set_focus_if_visible is
			-- Set focus if visible
		do
			if content /= Void and then content.is_visible then
				content.set_focus
			end
		end

	first_line_of (m: STRING_32): STRING_32 is
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

	bold_this_label (is_bold: BOOLEAN; lab: EV_LABEL) is
			-- Bold or unbold `lab'
		require
			lab_not_void: lab /= Void
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
			lab.refresh_now
		end

	set_unsensitive_fg_color_agent,
	set_row_highlight_bg_color_agent,
	set_row_replayable_bg_color_agent: PROCEDURE [ANY, TUPLE [COLOR_PREFERENCE]]
			-- agents associated with color assignment from preferences
			-- get properly removed when recycling.

	row_highlight_bg_color: EV_COLOR
			-- Background color for row highlighting

	row_replayable_bg_color: EV_COLOR
			-- Background color for row which can be replayed

	unsensitive_fg_color: EV_COLOR
			-- Foreground color for unsensitive row
			-- (i.e: row related to non Eiffel call stack element)

	special_label_color: EV_COLOR
			-- label foreground color for special labels
			-- such as display stop, threads ...


;indexing
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

end -- class EB_CALL_STACK_TOOL

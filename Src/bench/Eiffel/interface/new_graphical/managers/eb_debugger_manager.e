indexing
	description: "Shared object that manages all debugging actions."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_MANAGER

inherit
	SHARED_APPLICATION_EXECUTION

	EB_CONSTANTS

	EB_SHARED_INTERFACE_TOOLS
	
	EB_SHARED_GRAPHICAL_COMMANDS
	
	IPC_SHARED
		export
			{NONE} all
		end

	DEBUG_EXT
		export
			{NONE} all
		end
		
	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		do
			Application_notification_controller.on_launched_actions.extend (agent on_application_launched)
			Application_notification_controller.on_before_stopped_actions.extend (agent on_application_before_stopped)
			Application_notification_controller.on_after_stopped_actions.extend (agent on_application_just_stopped)
			Application_notification_controller.on_terminated_actions.extend (agent on_application_quit)

			create debug_run_cmd.make
			can_debug := True
			maximum_stack_depth := preferences.debugger_data.default_maximum_stack_depth
			init_commands

			objects_split_proportion := preferences.debug_tool_data.local_vs_object_proportion
			debug_splitter_position := preferences.debug_tool_data.main_splitter_position
			
			create watch_tool_list.make

			create observers.make (10)
			create kept_objects.make
			kept_objects.compare_objects
		end

feature -- Access

	debug_run_cmd: EB_DEBUG_RUN_COMMAND
		-- Command to run the project under debugger.

	toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_AND_MENUABLE_COMMAND]
			-- All commands that can be put in a toolbar.

	call_stack_tool: EB_CALL_STACK_TOOL
			-- A tool that represents the call stack in a graphical display.

	debugging_tools: ES_DOCKABLE_NOTEBOOK
			-- A tool that represents the call stack in a graphical display.

	objects_tool: ES_OBJECTS_TOOL

	watch_tool_list: LINKED_SET [ES_WATCH_TOOL]

	kept_objects: LINKED_SET [STRING]
			-- Objects represented by their address that should be kept during the execution.
			
	keep_object (add: STRING) is
			-- Add object identified by `add' to `kept_objects'
		require
			address_not_empty: add /= Void and then not add.is_empty
		do
			kept_objects.extend (add)
		end		

	new_toolbar: EB_TOOLBAR is
			-- Toolbar containing all debugging commands.
		do
			Result := preferences.debugger_data.retrieve_project_toolbar (toolbarable_commands)
		end

	new_project_toolbar: EV_VERTICAL_BOX is
			-- Create a new project toolbar.
			-- Obsolete. Use `new_toolbar' instead.
		local
			hsep: EV_HORIZONTAL_SEPARATOR
			a_toolbar: EV_HORIZONTAL_BOX
			tb: EV_TOOL_BAR
			b: EV_TOOL_BAR_BUTTON
		do
			create Result

			create a_toolbar
			create tb
			create hsep
			Result.set_padding (2)
			Result.extend (hsep)
			Result.disable_item_expand (hsep)
			Result.extend (tb)

					-- Stop points
			b := clear_bkpt.new_toolbar_item (False, False)
			tb.extend (b)

			b := disable_bkpt.new_toolbar_item (False, False)
			tb.extend (b)

			b := enable_bkpt.new_toolbar_item (False, False)
			tb.extend (b)

--| FIXME XR: TODO: Add:
--| 1) step into, step/step, step out, run through,
--| 2) interruption request, kill appli,
--| 3) edit feature, feature evaluation

			tb.extend (create {EV_TOOL_BAR_SEPARATOR})

			tb.extend (step_cmd.new_toolbar_item (False, False))
			tb.extend (into_cmd.new_toolbar_item (False, False))
			tb.extend (out_cmd.new_toolbar_item (False, False))

			tb.extend (create {EV_TOOL_BAR_SEPARATOR})

			tb.extend (debug_cmd.new_toolbar_item (False, False))
			tb.extend (no_stop_cmd.new_toolbar_item (False, False))

			tb.extend (create {EV_TOOL_BAR_SEPARATOR})

			tb.extend (stop_cmd.new_toolbar_item (False, False))
			tb.extend (quit_cmd.new_toolbar_item (False, False))

--			create {EB_EXEC_STEP_CMD} exec_cmd.make (Current)
--| FIXME XR: Preferences  should be used and updated
--			b := exec_cmd.new_toolbar_item (False)
--			tb.extend (b)
--			b.select_actions.extend (window_manager~quick_refresh_all_margins)

		end

	new_debug_menu: EV_MENU is
			-- Generate a menu that can be displayed in development windows.
		require
			--| commands_initialized: toolbarable_commands /= Void
		local
			sep: EV_MENU_SEPARATOR
			mit: EV_MENU_ITEM
		do
			create Result.make_with_text (Interface_names.m_Debug)

			Result.extend (clear_bkpt.new_menu_item)
			Result.extend (disable_bkpt.new_menu_item)
			Result.extend (enable_bkpt.new_menu_item)
			Result.extend (bkpt_info_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (step_cmd.new_menu_item)
			Result.extend (into_cmd.new_menu_item)
			Result.extend (out_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (debug_cmd.new_menu_item)
			Result.extend (no_stop_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (stop_cmd.new_menu_item)
			Result.extend (quit_cmd.new_menu_item)

				-- Separator.
			create sep
			Result.extend (sep)

			Result.extend (set_critical_stack_depth_cmd.new_menu_item)

			debug ("DEBUGGER_INTERFACE")
					-- Separator.
				create sep
				Result.extend (sep)
				create mit.make_with_text ("raise")
				mit.select_actions.extend (agent force_raise)
				Result.extend (mit)
				create mit.make_with_text ("unraise")
				mit.select_actions.extend (agent force_unraise)
				Result.extend (mit)
			end

--| FIXME XR: TODO: Add:
--| 3) edit feature, feature evaluation
		end

	create_new_watch_tool_inside_notebook (manager: EB_TOOL_MANAGER; nb: ES_NOTEBOOK) is
		require
			manager /= Void
		local
			l_watch_tool: ES_WATCH_TOOL
		do
			create l_watch_tool.make_with_title (manager, interface_names.t_watch_tool + " #" + new_watch_tool_number.out)
			l_watch_tool.attach_to_notebook (nb)
			watch_tool_list.extend (l_watch_tool)
		end

	close_watch_tool (wt: ES_WATCH_TOOL) is
		require
			wt /= Void
		do
			wt.close
			watch_tool_list.prune_all (wt)
		end

feature {NONE} -- watch tool numbering

	new_watch_tool_number: INTEGER is
		do
			last_watch_tool_number := last_watch_tool_number + 1
			Result := last_watch_tool_number
		end

	last_watch_tool_number: INTEGER

feature -- Status report

	debugging_window: EB_DEVELOPMENT_WINDOW
			-- Window in which the debugger was launched (via run...).

	raised: BOOLEAN
			-- Are the debugging tools currently raised?

	can_debug: BOOLEAN
			-- Is graphical debugging allowed?

	maximum_stack_depth: INTEGER
			-- Maximum number of call stack elements displayed.
			-- -1 means display all elements.

feature -- Status setting

	enable_debug is
			-- Allow graphic debugging.
		do
			can_debug := True
		end

	disable_debug is
			-- Disallow graphic debugging.
		do
			can_debug := False
		end

	set_debugging_window (a_window: EB_DEVELOPMENT_WINDOW) is
			-- Associate `Current' with `a_window'.
		do
			if not raised then
				debugging_window := a_window
			end
		end

	set_maximum_stack_depth (nb: INTEGER) is
			-- Set the maximum number of stack elements to be displayed to `nb'.
		require
			valid_nb: nb = -1 or nb > 0
		local
			pos: INTEGER
			cst: CALL_STACK_STONE
			ecs: EIFFEL_CALL_STACK
		do
			maximum_stack_depth := nb
			if Application.is_running then
				Application.status.set_max_depth (nb)
				if Application.is_stopped then
					pos := Application.current_execution_stack_number
					Application.status.reload_current_call_stack					
					ecs := Application.status.current_call_stack
					if ecs = Void or else ecs.is_empty then
						--| Nothing to display, maybe debugger had an issue getting call stack ..
					else
						if pos > Application.status.current_call_stack.count then
								-- We reloaded less elements than there were.
							pos := 1
						end
						call_stack_tool.update
						create cst.make (pos)
						if cst.is_valid then
							launch_stone (cst)
						end
					end
				end
			end
		end

	on_compile_start is
			-- A new compilation has started. Kill any debugged application and gray out all run* commands.
		do
			if Application.is_running then
				Application.kill
			end
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			step_cmd.disable_sensitive
			out_cmd.disable_sensitive
			into_cmd.disable_sensitive
		end

	on_compile_stop is
			-- A compilation is over. Make all run* commands sensitive.
		do
			if is_msil_dll_system then
				disable_debugging_commands (True)
			else
				step_cmd.enable_sensitive
				into_cmd.enable_sensitive
				no_stop_cmd.enable_sensitive
				debug_cmd.enable_sensitive
				enable_debug
			end
		end

	raise is
			-- Make the debug tools appear in `debugging_window'.
		require
			not_already_raised: not raised
			debugging_window_set: debugging_window /= Void
		local
			split: EV_SPLIT_AREA
			i: INTEGER
			rl, rr: ARRAY_PREFERENCE
			l_watch_tool: ES_WATCH_TOOL
		do
			disable_debugging_commands (False)
			initialize_debugging_window
			debugging_window.window.lock_update

			normal_left_layout := debugging_window.left_panel.save_to_resource
			normal_right_layout := debugging_window.right_panel.save_to_resource
			normal_splitter_position := debugging_window.panel.split_position
			debug ("DEBUGGER_INTERFACE")
				io.put_string ("Right normal layout: %N")
	 			from
	 				i := 1
	 			until
	 				i > normal_right_layout.count
	 			loop
	 				io.put_string (normal_right_layout @ i + "%N")
	 				i := i + 1
	 			end
				io.put_string ("Left normal layout: %N")
	 			from
	 				i := 1
	 			until
	 				i > normal_left_layout.count
	 			loop
	 				io.put_string (normal_left_layout @ i + "%N")
	 				i := i + 1
	 			end
			end

				-- Change the state of the debugging window.
			debugging_window.hide_tools
			debugging_window.context_tool.feature_view.pop_feature_flat

				--| Create tools. |--
				--| ES debugging tools |--
			if debugging_tools = Void then
				create debugging_tools.make (
						interface_names.t_Debugging_tool,
						interface_names.m_Debugging_tool,
						Void
					)
				debugging_tools.attach_to_explorer_bar (debugging_window.right_panel)
			else
				debugging_tools.change_attach_explorer (debugging_window.right_panel)
			end

				--| Grid Objects Tool
			if objects_tool = Void then
				create objects_tool.make (debugging_window)
				objects_tool.attach_to_notebook (debugging_tools)
			else
				objects_tool.set_manager (debugging_window)
				objects_tool.change_attach_notebook (debugging_tools)
			end
			objects_tool.set_debugger_manager (Current)
			objects_tool.set_cleaning_timer_delay (Preferences.Debug_tool_data.delay_before_cleaning_objects_grid)
			objects_tool.update

				--| Watches tool
			if watch_tool_list.count < Preferences.debug_tool_data.number_of_watch_tools  then
				from
				until
					watch_tool_list.count >= Preferences.debug_tool_data.number_of_watch_tools
				loop
					create_new_watch_tool_inside_notebook (debugging_window, debugging_tools)
				end
			else
				from
					watch_tool_list.start
				until
					watch_tool_list.after
				loop
					l_watch_tool := watch_tool_list.item
					if l_watch_tool /= Void then
						l_watch_tool.set_manager (debugging_window)
						l_watch_tool.change_attach_notebook (debugging_tools)
					end
					watch_tool_list.forth
				end
			end
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.prepare_for_debug)
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.update)

				--| Call Stack Tool
			if call_stack_tool = Void then
				create call_stack_tool.make (debugging_window)
				call_stack_tool.attach_to_explorer_bar (debugging_window.left_panel)
			else
				call_stack_tool.change_manager_and_explorer_bar (debugging_window, debugging_window.left_panel)
			end
			call_stack_tool.update
			debug ("DEBUGGER_INTERFACE")
				io.put_string ("editor height: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end

				-- Show Tools and final visual settings
			debugging_window.show_tools
			if debug_left_layout = Void then
				debug ("DEBUGGER_INTERFACE")
					io.put_string("Searching resource%N")
				end
				rl ?= preferences.preferences.get_resource (preferences.debug_tool_data.left_debug_layout_string)
				rr ?= preferences.preferences.get_resource (preferences.debug_tool_data.right_debug_layout_string)
				if rl /= Void and rr /= Void then
					debug ("DEBUGGER_INTERFACE")
						io.put_string("Found resource%N")
					end

					debugging_window.left_panel.load_from_resource (rl.value)
					debugging_window.right_panel.load_from_resource (rr.value)
				else
						--| Only minimize the editor.
					debugging_window.editor_tool.explorer_bar_item.minimize
				end
			else
				debugging_window.left_panel.load_from_resource (debug_left_layout)
				debugging_window.right_panel.load_from_resource (debug_right_layout)
			end

				--| Set the Grid Objects tool split position to 200 which is the default size of the local tree.
			split ?= objects_tool.widget
			if split /= Void then
				split.set_proportion (objects_split_proportion)
				split := Void
			end

			if debugging_window.panel.full then
				debugging_window.panel.set_split_position (debug_splitter_position.
						max (debugging_window.panel.minimum_split_position))
			end

			debug ("DEBUGGER_INTERFACE")
				io.put_string ("editor height during debug: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end

			raised := True

			debugging_window.window.unlock_update
		ensure
			raised
		end

	unraise is
			-- Make the debug tools disappear from `a_window'.
		require
			raised
		local
			i: INTEGER
			split: EV_SPLIT_AREA
		do
			debugging_window.window.lock_update

			debug ("DEBUGGER_INTERFACE")
				io.put_string ("editor height after debug: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end

			debug_left_layout := debugging_window.left_panel.save_to_resource
			debug_right_layout := debugging_window.right_panel.save_to_resource
			debug_splitter_position := debugging_window.panel.split_position
			
			split ?= objects_tool.widget
			if split /= Void then
				objects_split_proportion := split.split_position / split.width
			end
			preferences.debug_tool_data.left_debug_layout_preference.set_value (debug_left_layout)
			preferences.debug_tool_data.right_debug_layout_preference.set_value (debug_right_layout)
			preferences.debug_tool_data.main_splitter_position_preference.set_value (debug_splitter_position)
			preferences.debug_tool_data.set_local_vs_object_proportion (objects_split_proportion)
			
			debug ("DEBUGGER_INTERFACE")
				io.put_string ("Right debug layout: %N")
	 			from
	 				i := 1
	 			until
	 				i > debug_right_layout.count
	 			loop
	 				io.put_string (debug_right_layout @ i + "%N")
	 				i := i + 1
	 			end
				io.put_string ("Left debug layout: %N")
	 			from
	 				i := 1
	 			until
	 				i > debug_left_layout.count
	 			loop
	 				io.put_string (debug_left_layout @ i + "%N")
	 				i := i + 1
	 			end
			end

				-- Hide debugging tools.
			debugging_window.left_panel.block
			debugging_window.right_panel.block

				-- Free and recycle tools
			recycle_tools

			debugging_window.right_panel.unblock
			debugging_window.left_panel.unblock
			debug ("DEBUGGER_INTERFACE")
				io.put_string ("editor height after debug: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end

			raised := False
				-- Clear all tool windows from `debugging_window' as we will now rebuild
				-- the left and right panels. Note that it is only necessary to clear the tool
				-- windows after debugging, as a number of tools may be docked out that are
				-- not contained in the standard layout when not debugging so are not hidden
				-- as a result of rebuilding the panels.
			debugging_window.remove_all_tool_windows
				-- Change the state of the debugging window.
			if debugging_window.panel.full then
				debugging_window.panel.set_split_position (normal_splitter_position.
					max (debugging_window.panel.minimum_split_position))
			end
			debugging_window.left_panel.load_from_resource (normal_left_layout)
			debugging_window.right_panel.load_from_resource (normal_right_layout)

			debug ("DEBUGGER_INTERFACE")
				io.put_string ("editor height after debug: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end

			debugging_window.window.unlock_update
		ensure
			not raised
		end
		
	recycle_tools is
			-- Recycle tools to free unused data
		do
			call_stack_tool.recycle
			objects_tool.recycle
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.recycle)				
			application.recycle
		end

	set_stone (st: STONE) is
			-- Propagate `st' to tools.
		local
			cst: CALL_STACK_STONE
		do
			if raised then
				cst ?= st
				if cst /= Void then
					Application.set_current_execution_stack_number (cst.level_number)
				end
			
				call_stack_tool.set_stone (st)
				objects_tool.set_stone (st)
				watch_tool_list.do_all (agent {ES_WATCH_TOOL}.set_stone (st))
			end
		end

	save_interface (toolbar: EB_TOOLBAR) is
			-- Save the interface configuration using `toolbar'.
		do
			preferences.debugger_data.save_project_toolbar (toolbar)
--			save_resources
		end

feature -- Debugging events

	launch_stone (st: STONE) is
			-- Set `st' in the debugging window as the new stone.
		do
			debugging_window.context_tool.launch_stone (st)
		end

	on_application_launched is
			-- Application has just been launched.
		do
			Window_manager.display_message (Interface_names.E_running)
			Application.status.set_max_depth (maximum_stack_depth)
				-- Test whether application was really launched.
			output_manager.clear
			output_manager.display_application_status

				-- Modify the debugging window display.
			stop_cmd.enable_sensitive
			quit_cmd.enable_sensitive
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			debug_cmd.set_launched (True)
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			set_critical_stack_depth_cmd.disable_sensitive
			if dialog /= Void and then not dialog.is_destroyed then
				close_dialog
			end

			from
				observers.start
			until
				observers.after
			loop
				observers.item.on_application_launched
				observers.forth
			end
		end

	on_application_before_stopped is
			-- Execute command after application is
			-- stopped in a breakpoint or an exception
			-- occurred
		local
			status: APPLICATION_STATUS
			call_stack_elem	: CALL_STACK_ELEMENT
		do
			debug("debugger_trace_synchro") 
				io.put_string(generator + "a.on_application_before_stopped %N")
			end
			status := Application.status
			if status /= Void and then Application.is_stopped then
					-- Application has stopped
					-- after receiving and updating stack info
--				Window_manager.object_win_mgr.synchronize

					-- Display the callstack, the current object & the current stop point.
				Application.set_current_execution_stack_number (1)	-- go on top of stack
				call_stack_elem := status.current_call_stack_element
--				if call_stack_elem /= Void then
----					Project_tool.show_current_stoppoint
----					Project_tool.show_current_object
----					Project_tool.display_exception_stack
--				end

					-- Display the callstack arrow in all opened feature tools.
--				Window_manager.routine_win_mgr.synchronize_with_callstack

			else
					-- Before receiving and updating stack info
			end
		end

	on_application_just_stopped is
			-- Application was just stopped (by a breakpoint, ...).
		require
			application.is_running
		local
			st: CALL_STACK_STONE
			stt: STRUCTURED_TEXT
			cd: EV_CONFIRMATION_DIALOG
		do
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_just_stopped%N")
			end
			Window_manager.display_message (Interface_names.E_paused)
			Application.set_current_execution_stack_number (1)
			stop_cmd.disable_sensitive
			no_stop_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			step_cmd.enable_sensitive
			out_cmd.enable_sensitive
			into_cmd.enable_sensitive
			set_critical_stack_depth_cmd.enable_sensitive
			debug ("debugger_interface")
				io.put_string ("Application Stopped (dixit EB_DEBUGGER_MANAGER)%N")
			end

			objects_tool.enable_grid_redraw
			objects_tool.disable_refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.disable_refresh)
			if not Application.current_call_stack_is_empty then
				st := first_valid_call_stack_stone
				if st /= Void then
					launch_stone (st)
				end
			end
			objects_tool.enable_refresh
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.enable_refresh)				

			window_manager.quick_refresh_all_margins

				-- Fill in the stack tool.
			call_stack_tool.update
				-- Fill in the objects tool.
			objects_tool.update
				-- Update Watch tool
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.update)

			create stt.make
			stt.add_string ("Application stopped")
			stt.add_new_line
			output_manager.process_text (stt)

			if stopped_actions /= Void then
				stopped_actions.call (Void)
				stopped_actions := Void
			end

			debugging_window.window.raise
			from
				observers.start
			until
				observers.after
			loop
				observers.item.on_application_stopped
				observers.forth
			end
			if Application.status.reason = Pg_overflow then
				create cd.make_with_text_and_actions (Warning_messages.w_Overflow_detected, <<agent do_nothing, agent relaunch_application>>)
				cd.show_modal_to_window (debugging_window.window)
			end
			
			debug ("debugger_interface")
				io.put_string ("Application Stopped End (dixit EB_DEBUGGER_MANAGER)%N")
			end
		end

	on_application_resumed is
			-- Application was resumed after a stop.
		local
			stt: STRUCTURED_TEXT
		do
			debug ("debugger_trace_synchro")
				io.put_string (generator + ".on_application_resumed%N")
			end		
			Window_manager.display_message (Interface_names.E_running)
			stop_cmd.enable_sensitive
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			step_cmd.disable_sensitive
			out_cmd.disable_sensitive
			into_cmd.disable_sensitive
			set_critical_stack_depth_cmd.disable_sensitive
			
				-- Reset
			Application.on_resumed

				-- Fill in the stack tool.
			call_stack_tool.update
				-- Fill in the objects tool.
			objects_tool.update
			objects_tool.disable_grid_redraw
			
				-- Update Watch tool
			watch_tool_list.do_all (agent {ES_WATCH_TOOL}.update)

			create stt.make
			stt.add_string ("Application is running")
			stt.add_new_line
			output_manager.process_text (stt)
			window_manager.quick_refresh_all_margins
			if dialog /= Void and then not dialog.is_destroyed then
				close_dialog
			end

			from
				observers.start
			until
				observers.after
			loop
				observers.item.on_application_launched
				observers.forth
			end
		end

	on_application_quit is
			-- Application just quit.
		do
			if Application /= Void and then Application.is_running then
				disable_debugging_commands (False)
				Window_manager.display_message (Interface_names.E_not_running)
					-- Make all debugging tools disappear.
				if not debugging_window.destroyed then
					unraise
				else
					raised := False
				end
					-- Modify the debugging window display.
				window_manager.quick_refresh_all_margins
				debugging_window := Void
				output_manager.display_system_info
				kept_objects.wipe_out
				
				from
					observers.start
				until
					observers.after
				loop
					observers.item.on_application_killed
					observers.forth
				end

					-- Make related buttons insensitive.
				stop_cmd.disable_sensitive
				quit_cmd.disable_sensitive
				no_stop_cmd.enable_sensitive
				debug_cmd.enable_sensitive
				debug_cmd.set_launched (False)
				
				step_cmd.enable_sensitive
				into_cmd.enable_sensitive
				out_cmd.disable_sensitive
				set_critical_stack_depth_cmd.enable_sensitive
			end
		end
		
	first_valid_call_stack_stone: CALL_STACK_STONE is
			-- Stone of the first call stack valid for EiffelStudio.
		require
			Stopped: application.is_stopped
			Call_stack_non_empty: not Application.current_call_stack_is_empty
		local
			m, i: INTEGER
			st: CALL_STACK_STONE
		do
			from
				m := Application.number_of_stack_elements
				i := 1
			until
				Result /= Void or i > m
			loop
				create st.make (i)
				if st.is_valid then
					Result := st
				else
					i := i + 1
				end
			end
		ensure
			result_is_valid: Result /= Void implies Result.is_valid
		end

feature {EB_DEVELOPMENT_WINDOW} -- Implementation

	system_info_cmd: EB_STANDARD_CMD
			-- Command that displays information about current system in the output tool.

	display_error_help_cmd: EB_ERROR_INFORMATION_CMD
			-- Command to pop up a dialog giving help on compilation errors.

	eac_browser_cmd: EB_OPEN_EAC_BROWSER_CMD
			-- Command that displays the EAC browser tool.

feature {EB_DEBUGGER_OBSERVER} -- Manager implementation

	observers: ARRAYED_LIST [EB_DEBUGGER_OBSERVER]
			-- List of observers of `Current'.
			
feature {EB_DEVELOPMENT_WINDOW} -- Implementation

	save_original_layout is
			-- Save original layout of development window to resources.
			-- Called by the development window with the debugger when closed,
			-- so that the original layout of the window is stored in the registry.
		do
			preferences.development_window_data.left_panel_layout_preference.set_value (normal_left_layout)
			preferences.development_window_data.right_panel_layout_preference.set_value (normal_right_layout)
		end

feature -- One time action

	has_stopped_action: BOOLEAN is
			-- Has `stopped_actions' some actions to be executed?
		do
			Result := stopped_actions /= Void and then not stopped_actions.is_empty
		ensure
			has_stopped_action_definition:
				Result = (stopped_actions /= Void and then not stopped_actions.is_empty)
		end
		
	set_on_stopped_action (p: PROCEDURE [ANY, TUPLE]) is
			-- Add `p' to `stopped_actions' with `p'.
		require
			p_not_void: p /= Void
		do
			if stopped_actions = Void then
				create stopped_actions
			end
			stopped_actions.extend (p)
		ensure
			has_stopped_action: has_stopped_action
			stopped_action_set: stopped_actions.has (p)
		end

feature {NONE} -- Implementation

	stopped_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions called only once when application has stopped.

	saved_minimized: BOOLEAN
			-- Was the editor in the debugging window minimized before the debug session started?
			
	debug_right_layout, debug_left_layout: ARRAY [STRING]
			-- Used to save the display of the debugging window during debugging sessions.

	debug_splitter_position, normal_splitter_position: INTEGER
			-- Used to save the position of the main splitter of the debugging window.

	objects_split_proportion: REAL
			-- Position of the splitter inside the object tool.

	normal_right_layout, normal_left_layout: ARRAY [STRING]
			-- Used to save the display of the debugging window outside debugging sessions.

	clear_bkpt: EB_CLEAR_STOP_POINTS_COMMAND
			-- Command that can remove one or more breakpoints from the system.

	enable_bkpt: EB_DEBUG_STOPIN_HOLE_COMMAND
			-- Command that can enable one or more breakpoints in the system.

	disable_bkpt: EB_DISABLE_STOP_POINTS_COMMAND
			-- Command that can disable one or more breakpoints in the system.

	bkpt_info_cmd: EB_STANDARD_CMD
			-- Command that can display info concerning the breakpoints in the system.

	set_critical_stack_depth_cmd: EB_STANDARD_CMD
			-- Command that changes the depth at which we warn the user against a stack overflow.

	stop_cmd: EB_EXEC_STOP_CMD
			-- Command that can interrupt the execution.

	quit_cmd: EB_EXEC_QUIT_CMD
			-- Command that can kill the execution.

	step_cmd: EB_EXEC_STEP_CMD
			-- Step by step command.

	out_cmd: EB_EXEC_OUT_CMD
			-- Out of routine command.

	into_cmd: EB_EXEC_INTO_CMD
			-- Step into command.

	debug_cmd: EB_EXEC_DEBUG_CMD
			-- Run with stop points command.

	no_stop_cmd: EB_EXEC_NO_STOP_CMD
			-- Run without stop points command.

	init_commands is
			-- Create a new project toolbar.
		do
--| FIXME XR: TODO: Add:
--| 3) edit feature, feature evaluation
			create toolbarable_commands.make (20)

			create clear_bkpt
			clear_bkpt.enable_sensitive
			toolbarable_commands.extend (clear_bkpt)

			create enable_bkpt
			enable_bkpt.enable_sensitive
			toolbarable_commands.extend (enable_bkpt)

			create disable_bkpt
			disable_bkpt.enable_sensitive
			toolbarable_commands.extend (disable_bkpt)

			create bkpt_info_cmd.make
			bkpt_info_cmd.set_pixmaps (Pixmaps.Icon_bkpt_info)
			bkpt_info_cmd.set_tooltip (Interface_names.e_Bkpt_info)
			bkpt_info_cmd.set_menu_name (Interface_names.m_Bkpt_info)
			bkpt_info_cmd.set_tooltext (Interface_names.b_Bkpt_info)
			bkpt_info_cmd.set_name ("Bkpt_info")
			bkpt_info_cmd.add_agent (agent display_breakpoints)
			bkpt_info_cmd.enable_sensitive
			toolbarable_commands.extend (bkpt_info_cmd)

			create system_info_cmd.make
			system_info_cmd.set_pixmaps (Pixmaps.Icon_system_info)
			system_info_cmd.set_tooltip (Interface_names.e_Display_system_info)
			system_info_cmd.set_menu_name (Interface_names.m_Display_system_info)
			system_info_cmd.set_name ("System_info")
			system_info_cmd.set_tooltext (Interface_names.b_System_info)
			system_info_cmd.add_agent (agent output_manager.display_system_info)
			toolbarable_commands.extend (system_info_cmd)

			create set_critical_stack_depth_cmd.make
			set_critical_stack_depth_cmd.set_menu_name (Interface_names.m_Set_critical_stack_depth)
			set_critical_stack_depth_cmd.add_agent (agent change_critical_stack_depth)
			set_critical_stack_depth_cmd.enable_sensitive

			create display_error_help_cmd.make
			toolbarable_commands.extend (display_error_help_cmd)

			create step_cmd.make (Current)
			toolbarable_commands.extend (step_cmd)
			create into_cmd.make (Current)
			toolbarable_commands.extend (into_cmd)
			create out_cmd.make (Current)
			toolbarable_commands.extend (out_cmd)
			create debug_cmd.make (Current)
			toolbarable_commands.extend (debug_cmd)
			create no_stop_cmd.make (Current)
			toolbarable_commands.extend (no_stop_cmd)
			create stop_cmd.make
			toolbarable_commands.extend (stop_cmd)
			create quit_cmd.make
			toolbarable_commands.extend (quit_cmd)

			step_cmd.enable_sensitive
			into_cmd.enable_sensitive
			out_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			no_stop_cmd.enable_sensitive
			stop_cmd.disable_sensitive
			quit_cmd.disable_sensitive

			toolbarable_commands.extend (system_cmd)

			toolbarable_commands.extend (Melt_project_cmd)
			toolbarable_commands.extend (Quick_melt_project_cmd)
			toolbarable_commands.extend (Freeze_project_cmd)
			toolbarable_commands.extend (Finalize_project_cmd)
			run_finalized_cmd.enable_sensitive
			toolbarable_commands.extend (run_finalized_cmd)

				-- Disable commands if no project is loaded
			if not Eiffel_project.manager.is_project_loaded then
				if Eiffel_project.manager.is_created then
					enable_commands_on_project_created
				else
					disable_commands_on_project_unloaded
				end
			else
				enable_commands_on_project_loaded
			end

				-- Enable/Disable commands on project loading/unloading.
			Eiffel_project.manager.create_agents.extend (agent enable_commands_on_project_created)
			Eiffel_project.manager.load_agents.extend (agent enable_commands_on_project_loaded)
			Eiffel_project.manager.close_agents.extend (agent disable_commands_on_project_unloaded)
		end

	enable_commands_on_project_created is
			-- Enable commands when a new project has been created (not yet compiled)
		do
			display_error_help_cmd.enable_sensitive
		end

	enable_commands_on_project_loaded is
			-- Enable commands when a new project has been created and compiled
		do
			display_error_help_cmd.enable_sensitive

			if is_msil_dll_system then
				disable_debugging_commands (True)
			else
				debug_cmd.enable_sensitive
				no_stop_cmd.enable_sensitive
				clear_bkpt.enable_sensitive
				enable_bkpt.enable_sensitive
				disable_bkpt.enable_sensitive
				bkpt_info_cmd.enable_sensitive
				
				step_cmd.enable_sensitive
				into_cmd.enable_sensitive
				out_cmd.disable_sensitive					
			end			
		end

	disable_commands_on_project_unloaded is
			-- Enable commands when a project has been closed.
		do
			clear_bkpt.disable_sensitive
			enable_bkpt.disable_sensitive
			disable_bkpt.disable_sensitive
			bkpt_info_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			no_stop_cmd.disable_sensitive
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			out_cmd.disable_sensitive
			display_error_help_cmd.disable_sensitive			
		end
		
	disable_debugging_commands (full: BOOLEAN) is
			-- Disable commands related to debugging.
			-- If `full' disable also commands for manipulating breakpoints.
		do
			if full then
				clear_bkpt.disable_sensitive
				enable_bkpt.disable_sensitive
				disable_bkpt.disable_sensitive
				bkpt_info_cmd.disable_sensitive
			end
			
			debug_cmd.disable_sensitive
			no_stop_cmd.disable_sensitive
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
			out_cmd.disable_sensitive
		end		

	display_breakpoints is
			-- Show the list of breakpoints (set and disabled) in the output manager.
		do
			output_manager.display_stop_points
			output_manager.force_display
		end

	force_raise is
			-- Debug feature.
		do
			if not raised then
					-- Update `Current'.
				create kept_objects.make
				if debugging_window = Void then
					debugging_window ?= Window_manager.last_focused_window
				end
				raise
			end
		end

	force_unraise is
			-- Debug feature.
		do
			if raised then
				unraise
				kept_objects := Void
			end
		end

	relaunch_application is
			-- Quickly relaunch the application.
		require
			stopped: Application.status /= Void and then Application.status.is_stopped
		local
			rqst: EWB_REQUEST
		do
			create rqst.make (rqst_cont)
			rqst.send_breakpoints
			Application.status.set_is_stopped (False)
			rqst.send_rqst_3_integer (Rqst_resume, Resume_cont, Application.interrupt_number, application.critical_stack_depth)
			on_application_resumed
		end

	change_critical_stack_depth is
			-- Display a dialog that lets the user change the critical stack depth.
		require
			not_running: Application.status = Void or else Application.status.is_stopped
		local
			rb2: EV_RADIO_BUTTON
			l: EV_LABEL
			okb, cancelb: EV_BUTTON
			hb: EV_HORIZONTAL_BOX
			vb: EV_VERTICAL_BOX
		do
				-- Create widgets.
			create dialog
			create show_all_radio.make_with_text (Interface_names.l_Do_not_detect_stack_overflows)
			create rb2.make_with_text (Interface_names.l_Display_call_stack_warning)
			create l.make_with_text (Interface_names.l_Elements)
			create element_nb.make_with_value_range (1 |..| 30000)
			create okb.make_with_text (Interface_names.b_Ok)
			create cancelb.make_with_text (Interface_names.b_Cancel)
			
				-- Organize widgets.
			create vb
			vb.set_border_width (Layout_constants.Default_border_size)
			vb.set_padding (Layout_constants.Small_padding_size)
			vb.extend (show_all_radio)
			vb.extend (rb2)
			create hb
			hb.set_padding (Layout_constants.Small_padding_size)
			hb.extend (element_nb)
			hb.disable_item_expand (element_nb)
			hb.extend (l)
			hb.disable_item_expand (l)
			hb.extend (create {EV_CELL})
			vb.extend (hb)
			
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

				-- Set widget properties.
			dialog.set_title (Interface_names.t_Set_critical_stack_depth)
			dialog.disable_user_resize
			rb2.enable_select
			Layout_constants.set_default_size_for_button (okb)
			Layout_constants.set_default_size_for_button (cancelb)
			if preferences.debugger_data.critical_stack_depth > 30000 then
				element_nb.set_value (30000)
			elseif preferences.debugger_data.critical_stack_depth = -1 then
				element_nb.set_value (1000)
				show_all_radio.enable_select
				element_nb.disable_sensitive
			else
				element_nb.set_value (preferences.debugger_data.critical_stack_depth)
			end
			element_nb.set_minimum_width (100)
			
				-- Set up actions.
			cancelb.select_actions.extend (agent close_dialog)
			okb.select_actions.extend (agent accept_dialog)
			show_all_radio.select_actions.extend (agent element_nb.disable_sensitive)
			rb2.select_actions.extend (agent element_nb.enable_sensitive)
			dialog.set_default_push_button (okb)
			dialog.set_default_cancel_button (cancelb)
			if element_nb.is_sensitive then
				dialog.show_actions.extend (agent element_nb.set_focus)
			end
			
			dialog.show_modal_to_window (Window_manager.last_focused_development_window.window)
		end

	element_nb: EV_SPIN_BUTTON
			-- Spin button that indicates the critical call stack depth.

	dialog: EV_DIALOG
			-- Dialog that lets the user choose the critical call stack depth.

	show_all_radio: EV_RADIO_BUTTON
			-- Radio button that indicates that stack overflows shouldn't be detected.

	close_dialog is
			-- Close `dialog' without doing anything.
		do
			dialog.destroy
			dialog := Void
			element_nb := Void
			show_all_radio := Void
		end

	accept_dialog is
			-- Close `dialog' and change the critical stack depth.
		local
			nb: INTEGER
		do
			if show_all_radio.is_selected then
				nb := -1
			else
				nb := element_nb.value
			end
			close_dialog
			preferences.debugger_data.critical_stack_depth_preference.set_value (nb)
			Application.set_critical_stack_depth (nb)
			if Application.status /= Void and then Application.status.is_stopped then
				send_rqst_3_integer (Rqst_overflow_detection, 0, 0, nb)
			end
		end

	initialize_debugging_window is
			-- Set `debugging_window' with window requesting a debug session.
		do
			if debugging_window = Void then
				debugging_window ?= window_manager.last_focused_window
				if debugging_window = Void then
					debugging_window := window_manager.a_development_window
				end
			end
		ensure
			debugging_window_set: debugging_window /= Void
		end
		
feature {NONE} -- MSIL system implementation

	is_msil_dll_system: BOOLEAN is
			-- Is a MSIL DLL system ?
		do
			Result := Eiffel_project.initialized 
					and then Eiffel_project.system_defined
					and then Eiffel_system.System.il_generation
					and then Eiffel_system.System.msil_generation_type.is_equal (dll_type)			
		end
		
	dll_type: STRING is "dll"
			-- DLL type constant for MSIL system

end -- class EB_DEBUGGER_MANAGER

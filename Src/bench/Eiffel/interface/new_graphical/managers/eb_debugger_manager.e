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

	EB_DEBUGGER_DATA
	
	EB_SHARED_GRAPHICAL_COMMANDS
	
create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `Current'.
		local
			cmd: E_CMD
		do
			create {EB_AFTER_LAUNCH_CMD} cmd.make (Current)
			Application.set_launched_command (cmd)
			create {EB_APPLICATION_STOPPED_CMD} cmd.make (Current)
			Application.set_after_stopped_command (cmd)
			create {EB_APPLICATION_QUIT_CMD} cmd.make (Current)
			Application.set_termination_command (cmd)

			create debug_run_cmd.make
			can_debug := True
			maximum_stack_depth := default_maximum_stack_depth
			init_commands
			object_split_position := 200
		end

feature -- Access

	debug_run_cmd: EB_DEBUG_RUN_COMMAND
		-- Command to run the project under debugger.

	toolbarable_commands: ARRAYED_LIST [EB_TOOLBARABLE_AND_MENUABLE_COMMAND]
			-- All commands that can be put in a toolbar.

	call_stack_tool: EB_CALL_STACK_TOOL
			-- A tool that represents the call stack in a graphical display.

	object_tool: EB_OBJECT_TOOL
			-- A tool that represents the current call stack element and an object in a graphical display.

	evaluator_tool: EB_EXPRESSION_EVALUATOR
			-- A tool that evaluates expressions.

	kept_objects: LINKED_SET [STRING]
			-- Objects represented by their address that should be kept during the execution.

	new_toolbar: EB_TOOLBAR is
			-- Toolbar containing all debugging commands.
		do
			Result := retrieve_project_toolbar (toolbarable_commands)
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
--			b.select_actions.extend (window_manager~quick_refresh_all)

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

			debug ("DEBUGGER_INTERFACE")
					-- Separator.
				create sep
				Result.extend (sep)
				create mit.make_with_text ("raise")
				mit.select_actions.extend (~force_raise)
				Result.extend (mit)
				create mit.make_with_text ("unraise")
				mit.select_actions.extend (~force_unraise)
				Result.extend (mit)
			end

--| FIXME XR: TODO: Add:
--| 3) edit feature, feature evaluation
		end

feature -- Measurement

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
		do
			maximum_stack_depth := nb
			if Application.is_running then
				Application.status.set_max_depth (nb)
				if Application.is_stopped then
					pos := Application.current_execution_stack_number
					Application.status.reload_call_stack
					if pos > Application.status.where.count then
							-- We reloaded less elements than there were.
						pos := 1
					end
					call_stack_tool.update
					create cst.make (pos)
					launch_stone (cst)
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
			no_stop_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			step_cmd.enable_sensitive
			into_cmd.enable_sensitive
			enable_debug
		end

	raise is
			-- Make the debug tools appear in `debugging_window'.
		require
			not_already_raised: not raised
			debugging_window_set: debugging_window /= Void
		local
			split: EV_SPLIT_AREA
			i: INTEGER
			rl, rr: ARRAY_RESOURCE
		do
			normal_left_layout := debugging_window.left_panel.save_to_resource
			normal_right_layout := debugging_window.right_panel.save_to_resource
			normal_splitter_position := debugging_window.panel.split_position
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("Right normal layout: %N")
	 			from
	 				i := 1
	 			until
	 				i > normal_right_layout.count
	 			loop
	 				io.putstring (normal_right_layout @ i + "%N")
	 				i := i + 1
	 			end
				io.putstring ("Left normal layout: %N")
	 			from
	 				i := 1
	 			until
	 				i > normal_left_layout.count
	 			loop
	 				io.putstring (normal_left_layout @ i + "%N")
	 				i := i + 1
	 			end
			end
			
				-- Change the state of the debugging window.
			debugging_window.hide_tools
			debugging_window.context_tool.feature_view.pop_feature_flat
				-- Create tools.
			if call_stack_tool = Void then
				create call_stack_tool.make (debugging_window, debugging_window.left_panel)
			else
				call_stack_tool.change_manager (debugging_window, debugging_window.left_panel)
			end
			call_stack_tool.update
			call_stack_tool.show
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
			
			if object_tool = Void then
				create object_tool.make (debugging_window, debugging_window.right_panel)
			else
				object_tool.change_manager (debugging_window, debugging_window.right_panel)
			end
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
			
			object_tool.set_debugger_manager (Current)
			object_tool.update
			object_tool.show
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
			
			if evaluator_tool = Void then
				create evaluator_tool.make (debugging_window, debugging_window.left_panel)
			else
				evaluator_tool.change_manager (debugging_window, debugging_window.left_panel)
			end
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
			
			evaluator_tool.prepare_for_debug
			evaluator_tool.update
			evaluator_tool.show
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
			
			split ?= object_tool.widget
				--| 200 is the default size of the local tree.
			split.set_split_position (split.minimum_split_position.max (object_split_position).min (split.maximum_split_position))
			if debug_left_layout = Void then
				debug ("DEBUGGER_INTERFACE")
					io.putstring("Searching resource%N")
				end
				rl ?= resources.item ("left_debug_layout")
				rr ?= resources.item ("right_debug_layout")
				if rl /= Void and rr /= Void then
					debug ("DEBUGGER_INTERFACE")
						io.putstring("Found resource%N")
					end
					debugging_window.left_panel.load_from_resource (rl.actual_value)
					debugging_window.right_panel.load_from_resource (rr.actual_value)
				else
						--| Only minimize the editor.
					debugging_window.editor_tool.explorer_bar_item.minimize
				end
				debug_splitter_position := integer_resource_value ("splitter_position_during_debug", 250)
			else
				debugging_window.left_panel.load_from_resource (debug_left_layout)
				debugging_window.right_panel.load_from_resource (debug_right_layout)
			end
			debugging_window.panel.set_split_position (debug_splitter_position.max
					(debugging_window.panel.minimum_split_position).min
					(debugging_window.panel.maximum_split_position))
			debugging_window.show_tools
			debugging_window.left_panel.refresh_splitter
			debugging_window.right_panel.refresh_splitter
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height during debug: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
			
			raised := True
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
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height after debug: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
		
			debug_left_layout := debugging_window.left_panel.save_to_resource
			debug_right_layout := debugging_window.right_panel.save_to_resource
			debug_splitter_position := debugging_window.panel.split_position
			split ?= object_tool.widget
			if split /= Void then
				object_split_position := split.split_position
			end
			set_array ("left_debug_layout", debug_left_layout)
			set_array ("right_debug_layout", debug_right_layout)
			set_integer ("debug_main_splitter_position", debug_splitter_position)
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("Right debug layout: %N")
	 			from
	 				i := 1
	 			until
	 				i > debug_right_layout.count
	 			loop
	 				io.putstring (debug_right_layout @ i + "%N")
	 				i := i + 1
	 			end
				io.putstring ("Left debug layout: %N")
	 			from
	 				i := 1
	 			until
	 				i > debug_left_layout.count
	 			loop
	 				io.putstring (debug_left_layout @ i + "%N")
	 				i := i + 1
	 			end
			end
		
			debugging_window.hide_tools
				-- Hide debugging tools.
			call_stack_tool.recycle
			object_tool.recycle
			evaluator_tool.recycle
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height after debug: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
		
			raised := False

				-- Change the state of the debugging window.
			debugging_window.left_panel.load_from_resource (normal_left_layout)
			debugging_window.right_panel.load_from_resource (normal_right_layout)
			if debugging_window.panel.full then
				debugging_window.panel.set_split_position (normal_splitter_position.max
						(debugging_window.panel.minimum_split_position).min
						(debugging_window.panel.maximum_split_position))
			end
			debugging_window.show_tools
			debugging_window.left_panel.refresh_splitter
			debugging_window.right_panel.refresh_splitter
			debug ("DEBUGGER_INTERFACE")
				io.putstring ("editor height after debug: " + debugging_window.editor_tool.explorer_bar_item.widget.height.out + "%N")
			end
		ensure
			not raised
		end

	set_stone (st: STONE) is
			-- Propagate `st' to tools.
		local
			cst: CALL_STACK_STONE
		do
			if raised then
				cst ?= st
				if cst /= Void then
					Application.set_current_execution_stack (cst.level_number)
				end
				call_stack_tool.set_stone (st)
				object_tool.set_stone (st)
				evaluator_tool.set_stone (st)
			end
		end

	save_interface (toolbar: EB_TOOLBAR) is
			-- Save the interface configuration using `toolbar'.
		do
			save_project_toolbar (toolbar)
			save_resources
		end

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Debugging events

	launch_stone (st: STONE) is
			-- Set `st' in the debugging window as the new stone.
		do
			debugging_window.context_tool.launch_stone (st)
		end

	on_application_launched is
			-- Application has just been launched.
		require
--			debugging_window_set: debugging_window /= Void
		do
			Application.status.set_max_depth (maximum_stack_depth)
			if debugging_window = Void then
				debugging_window ?= Window_manager.last_focused_window
				if debugging_window = Void then
					debugging_window := Window_manager.a_development_window
				end
			end
				-- Test whether application was really launched.
			output_manager.clear
			output_manager.display_application_status
				-- Update `Current'.
			create kept_objects.make
				-- Raise debugging tools.
			raise
				-- Modify the debugging window display.
			stop_cmd.enable_sensitive
			quit_cmd.enable_sensitive
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			step_cmd.disable_sensitive
			into_cmd.disable_sensitive
		end

	on_application_will_stop is
			-- Application is going to stop soon.
		do
		end

	on_application_just_stopped is
			-- Application was just stopped (by a breakpoint, ...).
		local
			st: CALL_STACK_STONE
			stt: STRUCTURED_TEXT
		do
			Application.set_current_execution_stack (1)
			stop_cmd.disable_sensitive
			no_stop_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			step_cmd.enable_sensitive
			out_cmd.enable_sensitive
			into_cmd.enable_sensitive
			debug ("debugger_interface")
				io.putstring ("Application Stopped (dixit EB_DEBUGGER_MANAGER)%N")
			end
			create st.make (1)
			object_tool.disable_refresh
			if st.is_valid then
				launch_stone (st)
			end
			object_tool.enable_refresh
			debug ("debugger_interface")
				io.putstring ("refreshing display (dixit EB_DEBUGGER_MANAGER)%N")
			end
			window_manager.quick_refresh_all
				-- Fill in the stack tool.
			debug ("debugger_interface")
				io.putstring ("Displaying the call stack (dixit EB_DEBUGGER_MANAGER)%N")
			end
			call_stack_tool.update
				-- Fill in the object tool.
			debug ("debugger_interface")
				io.putstring ("Displaying the objects (dixit EB_DEBUGGER_MANAGER)%N")
			end
			object_tool.update
			evaluator_tool.update
			create stt.make
			stt.add_string ("Application stopped")
			stt.add_new_line
			output_manager.process_text (stt)
			debug ("debugger_interface")
				io.putstring ("Application Stopped End (dixit EB_DEBUGGER_MANAGER)%N")
			end
		end

	on_application_resumed is
			-- Application was resumed after a stop.
		local
			stt: STRUCTURED_TEXT
		do
			stop_cmd.enable_sensitive
			no_stop_cmd.disable_sensitive
			debug_cmd.disable_sensitive
			step_cmd.disable_sensitive
			out_cmd.disable_sensitive
			into_cmd.disable_sensitive
				-- Fill in the stack tool.
			call_stack_tool.update
				-- Fill in the object tool.
			object_tool.update
			evaluator_tool.update
			create stt.make
			stt.add_string ("Application is running")
			stt.add_new_line
			output_manager.process_text (stt)
			window_manager.quick_refresh_all
		end

	on_application_quit is
			-- Application just quit.
		do
				-- Make all debugging tools disappear.
			unraise
				-- Make related buttons insensitive.
			stop_cmd.disable_sensitive
			quit_cmd.disable_sensitive
			no_stop_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			step_cmd.enable_sensitive
			into_cmd.enable_sensitive
				-- Modify the debugging window display.
			window_manager.quick_refresh_all
			debugging_window := Void
			output_manager.display_system_info
			kept_objects.wipe_out
		end

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {EB_DEVELOPMENT_WINDOW} -- Implementation

	system_info_cmd: EB_STANDARD_CMD
			-- Command that displays information about current system in the output tool.

	display_error_help_cmd: EB_ERROR_INFORMATION_CMD
			-- Command to pop up a dialog giving help on compilation errors.

	dotnet_import_cmd: EB_DOTNET_IMPORT_CMD
			-- Manage .Net assemblies.

feature {NONE} -- Implementation

	saved_minimized: BOOLEAN
			-- Was the editor in the debugging window minimized before the debug session started?
			
	debug_right_layout, debug_left_layout: ARRAY [STRING]
			-- Used to save the display of the debugging window during debugging sessions.
			
	debug_splitter_position, normal_splitter_position: INTEGER
			-- Used to save the position of the main splitter of the debugging window.

	object_split_position: INTEGER
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
			bkpt_info_cmd.set_name ("Bkpt_info")
			bkpt_info_cmd.add_agent (~display_breakpoints)
			bkpt_info_cmd.enable_sensitive
			toolbarable_commands.extend (bkpt_info_cmd)

			create system_info_cmd.make
			system_info_cmd.set_pixmaps (Pixmaps.Icon_system_info)
			system_info_cmd.set_tooltip (Interface_names.e_Display_system_info)
			system_info_cmd.set_menu_name (Interface_names.m_Display_system_info)
			system_info_cmd.set_name ("System_info")
			system_info_cmd.add_agent (output_manager~display_system_info)
			toolbarable_commands.extend (system_info_cmd)

			create display_error_help_cmd.make
			toolbarable_commands.extend (display_error_help_cmd)

			create step_cmd.make (Current)
			step_cmd.enable_sensitive
			toolbarable_commands.extend (step_cmd)

			create into_cmd.make (Current)
			into_cmd.enable_sensitive
			toolbarable_commands.extend (into_cmd)

			create out_cmd.make (Current)
			out_cmd.enable_sensitive
			toolbarable_commands.extend (out_cmd)

			create debug_cmd.make (Current)
			debug_cmd.enable_sensitive
			toolbarable_commands.extend (debug_cmd)

			create no_stop_cmd.make (Current)
			no_stop_cmd.enable_sensitive
			toolbarable_commands.extend (no_stop_cmd)

			create stop_cmd.make
			toolbarable_commands.extend (stop_cmd)

			create quit_cmd.make
			toolbarable_commands.extend (quit_cmd)

			stop_cmd.disable_sensitive
			quit_cmd.disable_sensitive

			toolbarable_commands.extend (system_cmd)

			toolbarable_commands.extend (Melt_project_cmd)
			toolbarable_commands.extend (Freeze_project_cmd)
			toolbarable_commands.extend (Finalize_project_cmd)
			toolbarable_commands.extend (Wizard_precompile_cmd)
			run_finalized_cmd.enable_sensitive
			toolbarable_commands.extend (run_finalized_cmd)
			if display_dotnet_cmd then
				create dotnet_import_cmd.make
				dotnet_import_cmd.disable_sensitive
				toolbarable_commands.extend (dotnet_import_cmd)
			end

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
			Eiffel_project.manager.create_agents.extend (~enable_commands_on_project_created)
			Eiffel_project.manager.load_agents.extend (~enable_commands_on_project_loaded)
			Eiffel_project.manager.close_agents.extend (~disable_commands_on_project_unloaded)
		end

	enable_commands_on_project_created is
			-- Enable commands when a new project has been created (not yet compiled)
		do
			display_error_help_cmd.enable_sensitive
		end

	enable_commands_on_project_loaded is
			-- Enable commands when a new project has been created and compiled
		do
			clear_bkpt.enable_sensitive
			enable_bkpt.enable_sensitive
			disable_bkpt.enable_sensitive
			bkpt_info_cmd.enable_sensitive
			debug_cmd.enable_sensitive
			no_stop_cmd.enable_sensitive
			step_cmd.enable_sensitive
			into_cmd.enable_sensitive
			display_error_help_cmd.enable_sensitive
			if
				display_dotnet_cmd and then
				Eiffel_system.System.il_generation
			then
				dotnet_import_cmd.enable_sensitive
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
			if display_dotnet_cmd then
				dotnet_import_cmd.disable_sensitive
			end
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

end -- class EB_DEBUGGER_MANAGER

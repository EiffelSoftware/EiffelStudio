indexing
	description: "EiffelBench Debugger."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL

inherit
	EB_TEXT_TOOL
		redefine
			build_edit_menu,
			init_commands
		end

	EB_DEBUG_TOOL_DATA

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	build_toolbar (a_toolbar: EV_BOX) is
			-- Build editing buttons in `a_toolbar'
		local
			tb: EV_TOOL_BAR
			b: EV_TOOL_BAR_BUTTON
			sep: EV_TOOL_BAR_SEPARATOR
		do
			create tb.make (a_toolbar)
			a_toolbar.set_child_expandable (tb, False)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Up_stack)
			b.add_click_command (display_exception_cmd, display_exception_cmd.go_up)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Down_stack)
			b.add_click_command (display_exception_cmd, display_exception_cmd.go_down)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Debug_status)
			b.add_click_command (debug_status_cmd, Void)

			create sep.make (tb)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Debug_quit)
			b.add_click_command (debug_quit_cmd, debug_quit_cmd.kill_it)

			create sep.make (tb)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Exec_step)
			b.add_click_command (step_cmd, Void)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Exec_last)
			b.add_click_command (step_out_cmd, Void)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Exec_nostop)
			b.add_click_command (nostop_cmd, Void)

			create sep.make (tb)

			create tb.make_with_size (a_toolbar, 58, 22)

			create b.make (tb)
			b.set_pixmap (Pixmaps.bm_Debug_run)
			b.add_click_command (debug_run_cmd, Void)
		end

--	build_toolbar is
--			-- Build formatting buttons in `format_bar'.
--		local
--			step_out_cmd: EXEC_LAST
--			step_out_button: EB_BUTTON
--			step_out_menu_entry: EB_MENU_ENTRY
--			stop_menu_entry: EB_MENU_ENTRY
--			step_cmd: EXEC_STEP
--			step_button: EB_BUTTON
--			step_menu_entry: EB_MENU_ENTRY
--			nostop_cmd: EXEC_NOSTOP
--			nostop_button: EB_BUTTON
--			nostop_menu_entry: EB_MENU_ENTRY
--			sep: SEPARATOR
--			sep1, sep2, sep3: THREE_D_SEPARATOR
--			run_final_cmd: EXEC_FINALIZED
--			run_final_menu_entry: EB_MENU_ENTRY
--			debug_quit_cmd: DEBUG_QUIT
--			debug_quit_button: EB_BUTTON
--			debug_quit_menu_entry: EB_MENU_ENTRY
--			debug_run_cmd: DEBUG_RUN
--			debug_run_button: EB_BUTTON
--			debug_run_menu_entry: EB_MENU_ENTRY
--			debug_status_cmd: DEBUG_STATUS
--			debug_status_button: EB_BUTTON
--			debug_status_menu_entry: EB_MENU_ENTRY
--			display_exception_cmd: DISPLAY_CURRENT_STACK
--			up_exception_stack_button: EB_BUTTON
--			down_exception_stack_button: EB_BUTTON
--			display_exception_menu_entry: EB_MENU_ENTRY
--			do_nothing_cmd: DO_NOTHING_CMD
--		do
--			create debug_run_cmd.make (Current)
--			create debug_run_button.make (debug_run_cmd, format_bar)
--			create debug_run_menu_entry.make (debug_run_cmd, menus @ debug_menu)
--			create debug_run_cmd_holder.make (debug_run_cmd, debug_run_button, debug_run_menu_entry)
--			debug_run_button.add_third_button_action
--			debug_run_button.set_action ("Ctrl<Btn1Down>", debug_run_cmd, debug_run_cmd.melt_and_run)
--
--
--			create debug_status_cmd.make (Current)
--			create debug_status_button.make (debug_status_cmd, format_bar)
--			create debug_status_menu_entry.make (debug_status_cmd, menus @ debug_menu)
--			create debug_status_cmd_holder.make (debug_status_cmd, debug_status_button, debug_status_menu_entry)
--
--			create display_exception_cmd.make (True, Current)
--			create up_exception_stack_button.make (display_exception_cmd, format_bar)
--			create display_exception_menu_entry.make (display_exception_cmd, menus @ debug_menu)
--			create up_exception_stack_holder.make (display_exception_cmd,
--						up_exception_stack_button, display_exception_menu_entry)
--
--			create display_exception_cmd.make (False, Current)
--			create down_exception_stack_button.make (display_exception_cmd, format_bar)
--			create display_exception_menu_entry.make (display_exception_cmd, menus @ debug_menu)
--			create down_exception_stack_holder.make (display_exception_cmd,
--						down_exception_stack_button, display_exception_menu_entry)
--
--			create debug_quit_cmd.make (Current)
--			create debug_quit_button.make (debug_quit_cmd, format_bar)
--			create debug_quit_menu_entry.make_button_only (debug_quit_cmd, menus @ debug_menu)
--			create debug_quit_cmd_holder.make (debug_quit_cmd, debug_quit_button, debug_quit_menu_entry)
--			debug_quit_menu_entry.add_activate_action (debug_quit_cmd, debug_quit_cmd.kill_it)
--			debug_quit_button.set_action ("c<Btn1Down>", debug_quit_cmd, debug_quit_cmd.kill_it)
--
--			create sep.make (new_name, menus @ debug_menu)
--
--			create step_cmd.make (Current)
--			create step_button.make (step_cmd, format_bar)
--			create step_menu_entry.make (step_cmd, menus @ debug_menu)
--			create exec_step_frmt_holder.make (step_cmd, step_button, step_menu_entry)
--
--			create step_out_cmd.make (Current)
--			create step_out_button.make (step_out_cmd, format_bar)
--			create step_out_menu_entry.make (step_out_cmd, menus @ debug_menu)
--			create exec_last_frmt_holder.make (step_out_cmd, step_out_button, step_out_menu_entry)
--
--			create nostop_cmd. make (Current)
--			create nostop_button.make (nostop_cmd, format_bar)
--			create nostop_menu_entry.make (nostop_cmd, menus @ debug_menu)
--			create exec_nostop_frmt_holder.make (nostop_cmd, nostop_button, nostop_menu_entry)
--		end

	init_commands is
			-- Initialize commands.
		do
			Precursor
			create clear_bp_cmd.make (Current)
			create stop_points_cmd
			create stop_points_status_cmd			

			create debug_run_cmd.make (Current)
			create debug_status_cmd.make (Current)
			create display_exception_cmd.make (Current)
			create debug_quit_cmd.make
			create step_cmd.make (Current)
			create step_out_cmd.make (Current)
			create nostop_cmd.make (Current)
			create run_final_cmd.make (Current)
		end

feature -- Access

	default_name: STRING is "Debug Tool"
--| FIXME
--| Christophe, 19 oct 1999
--| This manifest constant should go in class INTERFACE_NAMES

feature -- Resource Update

	register is
			-- Ask the resource manager to notify Current (i.e. to call `update') each
			-- time one of the resources he needs has changed.
			-- Is called by `make'.
		do
			register_to ("debug_tool_bar")
		end

	update is
			-- Update Current with the registred resources.
		do
			if debug_tool_bar then
				toolbar.show
			else
				toolbar.hide
			end
			if toolbar_menu_item /= Void then
				toolbar_menu_item.set_selected (debug_tool_bar)
			end
		end

	unregister is
			-- Ask the resource manager not to notify Current anymore
			-- when a resource has changed.
			-- Is called by `destroy'.
		do
			unregister_to ("debug_tool_bar")
		end

--	update_boolean_resource (old_res, new_res: EB_BOOLEAN_RESOURCE) is
--		local
--			rout_cli_cmd: SHOW_ROUTCLIENTS
--			display_routine_cmd: DISPLAY_ROUTINE_PORTION
--			display_object_cmd: DISPLAY_OBJECT_PORTION
--			stop_cmd: SHOW_BREAKPOINTS
--			pr: like resources
--		do
--			pr := resources
--			if old_res = pr.command_bar then
--				if new_res.actual_value then
--					project_toolbar.add
--				else
--					project_toolbar.remove
--				end
--			elseif old_res = pr.format_bar then
--				if new_res.actual_value then
--					format_bar.add
--				else
--					format_bar.remove
--				end
--			else
--			if old_res = pr.debugger_show_all_callers then
--				if feature_displayer /= Void then
--					rout_cli_cmd ?= feature_displayer.showroutclients_frmt_holder.associated_command
--					rout_cli_cmd.set_show_all_callers (new_res.actual_value)
--				end
--			elseif old_res = pr.debugger_do_flat_in_breakpoints then
--				if feature_displayer /= Void then
--					stop_cmd ?= feature_displayer.showstop_frmt_holder.associated_command
--					stop_cmd.set_format_mode (new_res.actual_value)
--				end
--			end
--		end

--	update_integer_resource (old_res, new: EB_INTEGER_RESOURCE) is
--		local
--			pr: like resources
--		do
--			pr := resources
--			if new.actual_value >= 0 then
--				if old_res = pr.debugger_feature_height then
--					feature_displayer.set_height (new.actual_value)
--				elseif old_res = pr.interrupt_every_n_instructions then
--					Application.set_interrupt_number (new.actual_value)
--				end
--			end
--		end

feature -- Access

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects
		do
			Result := text_area.kept_objects
		end

	feature_displayer: EB_FEATURE_TOOL

	object_displayer: EB_OBJECT_TOOL


feature -- Update

	process_breakable (a_stone: BREAKABLE_STONE) is
			-- Process dropped stone `a_stone'.
		local
--			stop_points_button: EB_BUTTON_HOLE		
		do
--			stop_points_button := stop_points_hole_holder.associated_button
--			stop_points_button.associated_command.process_breakable (a_stone)
		end

feature

	synchronize_routine_tool_to_default is
			-- Synchronize the routine tool to the debug format.
		do
			if feature_displayer /= Void and then feature_displayer.shown then	
				feature_displayer.set_debug_format
			end
		end

	clear_object_tool is
			-- Clear the contents of the object tool if shown.
		do
			if object_displayer /= Void and then object_displayer.shown then	
				object_displayer.reset
			end
		end

	resynchronize_debugger is
		do
			if feature_displayer /= Void and then feature_displayer.shown then
				feature_displayer.resynchronize_debugger (Void)
			end
		end

	show_stoppoint (e_feature: E_FEATURE; index: INTEGER) is
			-- If stone feature is equal to feature `f' and if in debug
			-- mode then redisplay the sign of the `index'-th breakable point.
		require
			valid_feature: e_feature /= Void and then e_feature.body_id /= Void
		local
			new_stone: FEATURE_STONE
--			display_cmd: DISPLAY_ROUTINE_PORTION
		do
--			display_cmd ?= display_feature_cmd_holder.associated_command
--			if display_cmd.is_shown and then index > 0 then
				feature_displayer.show_stoppoint (e_feature, index)
--			end
		end

	show_current_stoppoint is
			-- Show breakable mark in the feature part if
			-- the part is displayed
		local
			status: APPLICATION_STATUS
--			display_cmd: DISPLAY_ROUTINE_PORTION
			new_stone: FEATURE_STONE
			call_stack: CALL_STACK_ELEMENT
			e_feature: E_FEATURE
			index: INTEGER
		do
			if Application.is_running and then Application.is_stopped then
--				display_cmd ?= display_feature_cmd_holder.associated_command
--				if display_cmd.is_shown then
					status := Application.status
					if status.e_feature /= Void then
						call_stack := status.current_stack_element
						if Application.current_execution_stack_number = 1 then
							e_feature := status.e_feature
							index := status.break_index
						else
							e_feature := call_stack.routine
						end
						if feature_displayer.last_format /= feature_displayer.format_list.stop_points_format then
							feature_displayer.set_debug_format
						end
						create new_stone.make (e_feature)
						feature_displayer.process_feature (new_stone)
						if index > 0 then
							feature_displayer.show_stoppoint (e_feature, index)
						end
					end
--				end
			end
		end

	show_current_object is
			-- Show the current object in exception 
			-- stack in object tool portion.
		local
--			display_cmd: DISPLAY_OBJECT_PORTION
			new_stone: OBJECT_STONE
			call_stack: CALL_STACK_ELEMENT
			object_address: STRING
			dynamic_class: CLASS_C
			status: APPLICATION_STATUS
		do
			if Application.is_running and then 
				Application.is_stopped 
			then
--				display_cmd ?= display_object_cmd_holder.associated_command
--				if display_cmd.is_shown then
					status := Application.status
					if status.e_feature /= Void then
						call_stack := status.current_stack_element
						if Application.current_execution_stack_number = 1 then
							dynamic_class := status.dynamic_class
							object_address := status.object_address
						else
							dynamic_class := call_stack.dynamic_class
							object_address := call_stack.object_address
						end
						create new_stone.make (object_address, call_stack.routine_name, dynamic_class)
						if new_stone.same_as (object_displayer.stone) then
							object_displayer.synchronize
						else
							object_displayer.process_object (new_stone)
						end
					end
--				end
			end
		end

	display_exception_stack is
			-- Display the exception stack in the text area.
		local
			st: STRUCTURED_TEXT
		do
			create st.make
			Application.status.display_status (st)
			text_area.clear_window
			text_area.freeze
			text_area.process_text (st)
			if saved_cursor /= Void then
				text_area.go_to (saved_cursor)
			end
			text_area.thaw
		end

	save_current_cursor_position is
			-- Save the current cursor position.
		do
			saved_cursor := text_area.position
		end

	clear_cursor_position is
			-- Clear the saved cursor position.
		do
			saved_cursor := Void
		end

	saved_cursor: INTEGER
		--| FIXME
		--| Christophe, 26 oct 1999
		--| Was previously supposed to be a CURSOR

feature -- Information

	display_system_info is
			-- Print information about the current project.
		local
			st: STRUCTURED_TEXT
		do
			st := structured_system_info
			if st /= Void then
				text_area.clear_window
				text_area.process_text (st)
--				text_area.set_top_character_position (0)
				text_area.show
			end
		end

	display_string (s: STRING) is
			-- Print `s' on the text area
		do
			text_area.clear_window
			text_area.put_string (s)
--			text_area.set_top_character_position (0)
			text_area.show
		end

	display_welcome_info is
			-- Display information on how to launch EiffelBench.
		do
			text_area.clear_window
			text_area.process_text (welcome_info)
--			text_area.set_top_character_position (0)
			text_area.show
		end

	welcome_info: STRUCTURED_TEXT is
			-- Information text on how to launch EiffelBench.
		local
		do
			create Result.make
			Result.add_new_line
			Result.add_comment_text ("To create or open a project using")
			Result.add_new_line
			Result.add_comment_text ("EiffelBench: On the File menu,")
			Result.add_new_line
			Result.add_comment_text ("click %"New...%" or %"Open...%".")
			Result.add_new_line
		ensure
			Result_not_void: Result /= Void
		end

	structured_system_info: STRUCTURED_TEXT is
			-- Information text about current project.
		local
			root_class_name: STRING
			root_class_c: CLASS_C
			creation_name: STRING
			st: STRUCTURED_TEXT
		do
			if eiffel_project.system /= Void then	
				root_class_name:= clone (eiffel_system.root_class_name)

				create st.make
				st.add_comment_text ("SYSTEM        : ")
				st.add_string (eiffel_system.name)

				if root_class_name /= Void then
					st.add_new_line
					st.add_comment_text("ROOT CLASS    : ")
					root_class_c := Eiffel_universe.compiled_classes_with_name (root_class_name).i_th(1).compiled_class
					root_class_name.to_upper
					st.add_classi(root_class_c.lace_class, root_class_name)

					creation_name := eiffel_ace.ast.root.creation_procedure_name
					if creation_name /= Void then
							-- We do have a creation routine in the Ace file
							--| This is not a precompilation or a fake compilation (root class = NONE)
						st.add_new_line
						st.add_comment_text ("CREATION      : ")
						st.add_feature_name (eiffel_ace.ast.root.creation_procedure_name, root_class_c)
					end

					st.add_new_line
					st.add_new_line
					st.add_comment_text ("ROOT CLUSTER  : ")
					st.add_string (eiffel_system.root_cluster.cluster_name)
					st.add_new_line
					st.add_comment_text ("ACE FILE      : ")
					st.add_string (eiffel_ace.file_name)
					st.add_new_line
					st.add_comment_text ("PROJECT PATH  : ")
					st.add_string (eiffel_project.name)
					st.add_new_line
--					st.add_new_line
-- 					st.add_comment_text ("$EIFFEL4      = ")
-- 					st.add_string (execution_environment.get ("EIFFEL4"))
-- 					st.add_new_line
-- 					st.add_comment_text ("$PLATFORM     = ")
-- 					st.add_string (execution_environment.get ("PLATFORM"))
-- 					st.add_new_line
-- 					st.add_comment_text ("$COMPILER     = ")
-- 					st.add_string (execution_environment.get ("COMPILER"))
-- 					st.add_new_line
				end
				Result := st
			end
		end

	close_windows is
			-- Not used; for compatibility only.
		do
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_edit_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- Build standard edit menu entries in `a_menu'
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (a_menu, Interface_names.m_Showstops)
			i.add_select_command (stop_points_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Clear_breakpoints)
			i.add_select_command (clear_bp_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Enable_stop_points)
			i.add_select_command (stop_points_status_cmd, stop_points_status_cmd.enable_it)

			create i.make_with_text (a_menu, Interface_names.m_Disable_stop_points)
			i.add_select_command (stop_points_status_cmd, stop_points_status_cmd.disable_it)
		end	

	build_debug_menu (a_menu: EV_MENU_ITEM_HOLDER) is
			-- build debug entries in the debug tool
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (a_menu, Interface_names.m_Debug_run)
			i.add_select_command (debug_run_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Debug_status)
			i.add_select_command (debug_status_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Up_stack)
			i.add_select_command (display_exception_cmd, display_exception_cmd.go_up)

			create i.make_with_text (a_menu, Interface_names.m_Down_stack)
			i.add_select_command (display_exception_cmd, display_exception_cmd.go_down)

			create i.make_with_text (a_menu, Interface_names.m_Debug_quit)
			i.add_select_command (debug_quit_cmd, debug_quit_cmd.kill_it)

			create i.make_with_text (a_menu, Interface_names.m_Exec_step)
			i.add_select_command (step_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Exec_last)
			i.add_select_command (step_out_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Exec_nostop)
			i.add_select_command (nostop_cmd, Void)

			create i.make_with_text (a_menu, Interface_names.m_Run_finalized)
			i.add_select_command (run_final_cmd, Void)
		end

feature -- Commands

	clear_bp_cmd: EB_CLEAR_STOP_POINTS_CMD
	stop_points_cmd: EB_DEBUG_STOPIN_HOLE_CMD
	stop_points_status_cmd: EB_STOPPOINTS_STATUS_CMD


	debug_run_cmd: EB_DEBUG_RUN_CMD
	step_out_cmd: EB_EXEC_LAST_CMD
	step_cmd: EB_EXEC_STEP_CMD
	nostop_cmd: EB_EXEC_NOSTOP_CMD
	run_final_cmd: EB_EXEC_FINALIZED_CMD
	debug_quit_cmd: EB_DEBUG_QUIT_CMD
	debug_status_cmd: EB_DEBUG_STATUS_CMD
	display_exception_cmd: EB_DISPLAY_CURRENT_STACK_CMD

end -- class EB_DEBUG_TOOL

indexing
	description: "$EiffelGraphicalCompiler$ Debugger."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL

inherit
	EB_TEXT_TOOL
		redefine
			build_edit_menu,
			init_commands,
			build_toolbar
		end

	EB_DEBUG_TOOL_DATA

	EXEC_MODES

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

	EB_SHARED_INTERFACE_TOOLS

create
	make

feature {NONE} -- Initialization

	build_toolbar is
			-- Build editing buttons in `a_toolbar'
		local
			tb: EV_TOOL_BAR
			b: EV_TOOL_BAR_BUTTON
			sep: EV_TOOL_BAR_SEPARATOR
			a_toolbar: EV_BOX
		do
			a_toolbar := toolbar
			create tb
			a_toolbar.extend (tb)
			a_toolbar.disable_item_expand (tb)

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Up_stack)
--|			b.select_actions.extend (display_exception_cmd~execute (display_exception_cmd.go_up))

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Down_stack)
--|			b.select_actions.extend (display_exception_cmd~execute (display_exception_cmd.go_down))

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Debug_status)
			b.select_actions.extend (~display_application_status)

			create sep
			tb.extend (sep)

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Debug_quit)
			b.select_actions.extend (debug_quit_cmd~kill)

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Debug_interrupt)
			b.select_actions.extend (debug_quit_cmd~interrupt)

			create sep
			tb.extend (sep)

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Exec_step)
			b.select_actions.extend (debug_run_cmd~execute (Step_by_step))

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Exec_into)
			b.select_actions.extend (debug_run_cmd~execute (Step_into))

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Exec_last)
			b.select_actions.extend (debug_run_cmd~execute (Out_of_routine))

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Exec_nostop)
			b.select_actions.extend (debug_run_cmd~execute (No_stop_points))

			create sep
			tb.extend (sep)

--			create tb.make_with_size (58, 22)
			create tb
			a_toolbar.extend (tb)

			create b
			tb.extend (b)
			b.set_pixmap (Pixmaps.bm_Debug_run)
			b.select_actions.extend (debug_run_cmd~execute (User_stop_points))
		end

	init_commands is
			-- Initialize commands.
		do
			Precursor
--			create clear_bp_cmd.make (Current)
--			create stop_points_cmd
--			create stop_points_status_cmd			

			create argument_cmd.make (Current)
			create debug_run_cmd.make (Current)
--			create debug_status_cmd.make (Current)
--			create display_exception_cmd.make (Current)
			create debug_quit_cmd.make
--			create run_final_cmd.make (Current)
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
				if debug_tool_bar then
					toolbar_menu_item.enable_select
				else
					toolbar_menu_item.disable_select
				end
			end
		end

	unregister is
			-- Ask the resource manager not to notify Current anymore
			-- when a resource has changed.
			-- Is called by `destroy'.
		do
			unregister_to ("debug_tool_bar")
		end

feature -- Access

	kept_objects: LINKED_SET [STRING] is
			-- Hector addresses of displayed clickable objects
		do
			Result := text_area.kept_objects
		end

	feature_displayer: EB_FEATURE_TOOL
		-- Feature tool where debug information is to be displayed.

	object_displayer: EB_OBJECT_TOOL
		-- Object tool where debug information is to be displayed.

feature -- Update

	force_stone (s: STONE) is
			-- Make `s' the new value of `stone', and
			-- change the display accordingly. Try to
			-- extract a class from `s' whenever possible.
		local
			bs: BREAKABLE_STONE
		do
			bs ?= s
			if bs /= Void then
				process_breakable (bs)
			end
		end

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

	show_stoppoint (body_index: INTEGER; index: INTEGER) is
			-- If stone feature is equal to feature `f' and if in debug
			-- mode then redisplay the sign of the `index'-th breakable point.
		require
			valid_feature: body_index >= 0
		local
--			display_cmd: DISPLAY_ROUTINE_PORTION
		do
--			display_cmd ?= display_feature_cmd_holder.associated_command
--			if display_cmd.is_shown and then index > 0 then
--				feature_displayer.show_stoppoint (body_index, index)
--			end
		end

	refresh_current_stoppoint is
			-- update the display for the current stop point.
		local
			current_call_stack_item: CALL_STACK_ELEMENT
		do
			if Application.status /= Void and then Application.status.where /= Void then
				current_call_stack_item := Application.status.current_stack_element
					-- remove the arrow
				show_stoppoint (current_call_stack_item.body_index, current_call_stack_item.break_index)
			end
		end

	show_current_stoppoint is
			-- Show breakable mark in the feature part if
			-- the part is displayed
		local
			status: APPLICATION_STATUS
--			display_cmd: DISPLAY_ROUTINE_PORTION
--			new_stone: FEATURE_STONE
			call_stack: CALL_STACK_ELEMENT
			e_feature: E_FEATURE
			index: INTEGER
			body_index: INTEGER
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
							body_index := e_feature.body_index
						else
							call_stack := status.current_stack_element
							e_feature := call_stack.routine
							body_index := call_stack.body_index
						end
-- FIXME ARNAUD
--						if feature_displayer.last_format /= feature_displayer.format_list.stop_points_format then
--							feature_displayer.set_debug_format
--						end
--						create new_stone.make (e_feature)
--						feature_displayer.process_feature (new_stone)
--						if index > 0 then
--							feature_displayer.show_stoppoint (body_index, index)
--						end
-- END FIXME ARNAUD
					end
--				end
			end
		end

	show_current_object is
			-- Show the current object in exception 
			-- stack in object tool portion.
		local
--			display_cmd: DISPLAY_OBJECT_PORTION
--			new_stone: OBJECT_STONE
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
--						create new_stone.make (object_address, call_stack.routine_name, dynamic_class)
--						if new_stone.same_as (object_displayer.stone) then
--							object_displayer.synchronize
--						else
--							object_displayer.process_object (new_stone)
--						end
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
			saved_cursor := 0
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
				text_area.display
			end
		end

	display_string (s: STRING) is
			-- Print `s' on the text area
		do
			text_area.clear_window
			text_area.put_string (s)
--			text_area.set_top_character_position (0)
			text_area.display
		end

	display_welcome_info is
			-- Display information on how to launch $EiffelGraphicalCompiler$.
		do
			text_area.clear_window
			text_area.process_text (welcome_info)
--			text_area.set_top_character_position (0)
			text_area.display
		end

	display_application_status is
			-- Display the status of the application, or "Not running" if
			-- the application is not running.
		local
			st: STRUCTURED_TEXT
			st_syst: STRUCTURED_TEXT
		do
			if Eiffel_project.initialized then
				create st.make
				if Application.is_running then
					Application.status.display_status (st)
					text_area.clear_window
					text_area.process_text (st)
--					text_area.set_top_character_position (0)
				else
					st.add_string ("System not launched")
					st.add_new_line
					st_syst := structured_system_info 
					if st_syst /= Void then
						st.append (st_syst)
					end
					text_area.clear_window
					text_area.process_text (st)
--					text_area.set_top_character_position (0)
				end
			end
		end

	welcome_info: STRUCTURED_TEXT is
			-- Information text on how to launch $EiffelGraphicalCompiler$.
		local
		do
			create Result.make
			Result.add_new_line
			Result.add_default_string ("To create or open a project using")
			Result.add_new_line
			Result.add_default_string (Interface_names.EiffelBench_name+": On the File menu,")
			Result.add_new_line
			Result.add_default_string ("click %"New...%" or %"Open...%".")
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
				st.add_default_string ("SYSTEM        : ")
				st.add_string (eiffel_system.name)

				if root_class_name /= Void then
					st.add_new_line
					st.add_default_string("ROOT CLASS    : ")
					root_class_c := Eiffel_universe.compiled_classes_with_name (root_class_name).i_th(1).compiled_class
					root_class_name.to_upper
					st.add_classi(root_class_c.lace_class, root_class_name)

					creation_name := eiffel_ace.ast.root.creation_procedure_name
					if creation_name /= Void then
							-- We do have a creation routine in the Ace file
							--| This is not a precompilation or a fake compilation (root class = NONE)
						st.add_new_line
						st.add_default_string ("CREATION      : ")
						st.add_feature_name (eiffel_ace.ast.root.creation_procedure_name, root_class_c)
					end

					st.add_new_line
					st.add_new_line
					st.add_default_string ("ROOT CLUSTER  : ")
					st.add_string (eiffel_system.root_cluster.cluster_name)
					st.add_new_line
					st.add_default_string ("ACE FILE      : ")
					st.add_string (eiffel_ace.file_name)
					st.add_new_line
					st.add_default_string ("PROJECT PATH  : ")
					st.add_string (eiffel_project.name)
					st.add_new_line
				end
				Result := st
			end
		end

	close_windows is
			-- Not used; for compatibility only.
		do
		end

feature {EB_TOOL_MANAGER} -- Menus Implementation

	build_edit_menu (a_menu: EV_MENU) is
			-- Build standard edit menu entries in `a_menu'
		local
			i: EV_MENU_ITEM
		do
			create i.make_with_text (Interface_names.m_Showstops)
			a_menu.extend (i)
--			i.select_actions.extend (stop_points_cmd~execute)

			create i.make_with_text (Interface_names.m_Clear_breakpoints)
			a_menu.extend (i)
--			i.select_actions.extend (clear_bp_cmd~execute)

			create i.make_with_text (Interface_names.m_Enable_stop_points)
			a_menu.extend (i)
--			i.select_actions.extend (stop_points_status_cmd, stop_points_status_cmd.enable_it)

			create i.make_with_text (Interface_names.m_Disable_stop_points)
			a_menu.extend (i)
--			i.select_actions.extend (stop_points_status_cmd, stop_points_status_cmd.disable_it)
		end	

	build_debug_menu (a_menu: EV_MENU) is
			-- Build debug entries in the debug tool
		local
			i: EV_MENU_ITEM
			sep: EV_MENU_SEPARATOR
		do
			create i.make_with_text (Interface_names.m_Argument)
			a_menu.extend (i)
			i.select_actions.extend (argument_cmd~execute)

			create i.make_with_text (Interface_names.m_Debug_run)
			a_menu.extend (i)
			i.select_actions.extend (debug_run_cmd~execute (User_stop_points))

			create sep
			a_menu.extend (sep)

			create i.make_with_text (Interface_names.m_Debug_status)
			a_menu.extend (i)
--			i.select_actions.extend (debug_status_cmd~execute)

			create i.make_with_text (Interface_names.m_Up_stack)
			a_menu.extend (i)
--			i.select_actions.extend (display_exception_cmd, display_exception_cmd.go_up)

			create i.make_with_text (Interface_names.m_Down_stack)
			a_menu.extend (i)
--			i.select_actions.extend (display_exception_cmd, display_exception_cmd.go_down)

			create sep
			a_menu.extend (sep)

			create i.make_with_text (Interface_names.m_Debug_kill)
			a_menu.extend (i)
			i.select_actions.extend (debug_quit_cmd~kill)

			create i.make_with_text (Interface_names.m_Debug_interrupt)
			a_menu.extend (i)
			i.select_actions.extend (debug_quit_cmd~interrupt)

			create i.make_with_text (Interface_names.m_Exec_step)
			a_menu.extend (i)
			i.select_actions.extend (debug_run_cmd~execute (Step_by_step))

			create i.make_with_text (Interface_names.m_Exec_into)
			a_menu.extend (i)
			i.select_actions.extend (debug_run_cmd~execute (Step_into))

			create i.make_with_text (Interface_names.m_Exec_last)
			a_menu.extend (i)
			i.select_actions.extend (debug_run_cmd~execute (Out_of_routine))

			create i.make_with_text (Interface_names.m_Exec_nostop)
			a_menu.extend (i)
			i.select_actions.extend (debug_run_cmd~execute (No_stop_points))

			create sep
			a_menu.extend (sep)

			create i.make_with_text (Interface_names.m_Run_finalized)
			a_menu.extend (i)
--			i.select_actions.extend (run_final_cmd~execute)
		end

feature -- Commands

--|	clear_bp_cmd: EB_CLEAR_STOP_POINTS_CMD
		-- Command to clear stop points

--|	stop_points_cmd: EB_DEBUG_STOPIN_HOLE_CMD
		-- Command to enable/disable stop points

--|	stop_points_status_cmd: EB_STOPPOINTS_STATUS_CMD
		-- Command to enable/disable ALL stop points
--| fixme chirstophe 15 dec 1999 disabled for merging. will be changed drastically.

	argument_cmd: EB_PROMPT_ARGUMENT_CMD
		-- Command to ask for execution arguments.

	debug_run_cmd: EB_DEBUG_RUN_CMD
		-- Command to run the project under degugger

--|	run_final_cmd: EB_EXEC_FINALIZED_CMD
		-- Command to run the finalized version of the project

	debug_quit_cmd: EB_DEBUG_QUIT_CMD
		-- Command to exit the program

--|	display_exception_cmd: EB_DISPLAY_CURRENT_STACK_CMD
		-- Command to display the execution stack

end -- class EB_DEBUG_TOOL

indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL

inherit
	EB_EDITOR

	EB_DEBUG_TOOL_DATA
		rename
			Debug_resources as resources
		end

	SHARED_APPLICATION_EXECUTION

	SHARED_EIFFEL_PROJECT

create
	make

feature {NONE} -- Initialization

	build_edit_bar is
			-- Build formatting buttons in `format_bar'.
		local
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
		do
--			!! debug_run_cmd.make (Current)
--			!! debug_run_button.make (debug_run_cmd, format_bar)
--			!! debug_run_menu_entry.make (debug_run_cmd, menus @ debug_menu)
--			!! debug_run_cmd_holder.make (debug_run_cmd, debug_run_button, debug_run_menu_entry)
--			debug_run_button.add_third_button_action
--			debug_run_button.set_action ("Ctrl<Btn1Down>", debug_run_cmd, debug_run_cmd.melt_and_run)
--
--
--			!! debug_status_cmd.make (Current)
--			!! debug_status_button.make (debug_status_cmd, format_bar)
--			!! debug_status_menu_entry.make (debug_status_cmd, menus @ debug_menu)
--			!! debug_status_cmd_holder.make (debug_status_cmd, debug_status_button, debug_status_menu_entry)
--
--			!! display_exception_cmd.make (True, Current)
--			!! up_exception_stack_button.make (display_exception_cmd, format_bar)
--			!! display_exception_menu_entry.make (display_exception_cmd, menus @ debug_menu)
--			!! up_exception_stack_holder.make (display_exception_cmd,
--						up_exception_stack_button, display_exception_menu_entry)
--
--			!! display_exception_cmd.make (False, Current)
--			!! down_exception_stack_button.make (display_exception_cmd, format_bar)
--			!! display_exception_menu_entry.make (display_exception_cmd, menus @ debug_menu)
--			!! down_exception_stack_holder.make (display_exception_cmd,
--						down_exception_stack_button, display_exception_menu_entry)
--
--			!! debug_quit_cmd.make (Current)
--			!! debug_quit_button.make (debug_quit_cmd, format_bar)
--			!! debug_quit_menu_entry.make_button_only (debug_quit_cmd, menus @ debug_menu)
--			!! debug_quit_cmd_holder.make (debug_quit_cmd, debug_quit_button, debug_quit_menu_entry)
--			debug_quit_menu_entry.add_activate_action (debug_quit_cmd, debug_quit_cmd.kill_it)
--			debug_quit_button.set_action ("c<Btn1Down>", debug_quit_cmd, debug_quit_cmd.kill_it)
--
--			!! sep.make (new_name, menus @ debug_menu)
--
--			!! step_cmd.make (Current)
--			!! step_button.make (step_cmd, format_bar)
--			!! step_menu_entry.make (step_cmd, menus @ debug_menu)
--			!! exec_step_frmt_holder.make (step_cmd, step_button, step_menu_entry)
--
--			!! step_out_cmd.make (Current)
--			!! step_out_button.make (step_out_cmd, format_bar)
--			!! step_out_menu_entry.make (step_out_cmd, menus @ debug_menu)
--			!! exec_last_frmt_holder.make (step_out_cmd, step_out_button, step_out_menu_entry)
--
--			!! nostop_cmd. make (Current)
--			!! nostop_button.make (nostop_cmd, format_bar)
--			!! nostop_menu_entry.make (nostop_cmd, menus @ debug_menu)
--			!! exec_nostop_frmt_holder.make (nostop_cmd, nostop_button, nostop_menu_entry)
--
--			!! run_final_cmd.make (Current)
--			!! run_final_menu_entry.make (run_final_cmd, menus @ debug_menu)
--
--			!! sep1.make (Interface_names.t_empty, format_bar)
--			sep1.set_horizontal (False)
--
--			!! sep2.make (Interface_names.t_empty, format_bar)
--			sep2.set_horizontal (False)
--
--			!! sep3.make (Interface_names.t_empty, format_bar)
--			sep3.set_horizontal (False)
--
		end

feature -- Resource Update

	update_boolean_resource (old_res, new_res: EB_BOOLEAN_RESOURCE) is
--		local
--			rout_cli_cmd: SHOW_ROUTCLIENTS
--			display_routine_cmd: DISPLAY_ROUTINE_PORTION
--			display_object_cmd: DISPLAY_OBJECT_PORTION
--			stop_cmd: SHOW_BREAKPOINTS
--			pr: like resources
--			progress_output: DEGREE_OUTPUT
		do
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
--				if feature_part /= Void then
--					rout_cli_cmd ?= feature_part.showroutclients_frmt_holder.associated_command
--					rout_cli_cmd.set_show_all_callers (new_res.actual_value)
--				end
--			elseif old_res = pr.debugger_do_flat_in_breakpoints then
--				if feature_part /= Void then
--					stop_cmd ?= feature_part.showstop_frmt_holder.associated_command
--					stop_cmd.set_format_mode (new_res.actual_value)
--				end
--			end
		end

	update_integer_resource (old_res, new: EB_INTEGER_RESOURCE) is
		local
--			pr: like resources
		do
--			pr := resources
--			if new.actual_value >= 0 then
--				if old_res = pr.debugger_feature_height then
--					feature_part.set_height (new.actual_value)
--				elseif old_res = pr.interrupt_every_n_instructions then
--					Application.set_interrupt_number (new.actual_value)
--				end
--			end
		end

feature

	resynchronize_debugger is
		do
--			if feature_part /= Void and then feature_form.managed then
--				feature_part.resynchronize_debugger (Void)
--			end
		end

	show_stoppoint (e_feature: E_FEATURE index: INTEGER) is
--			-- If stone feature is equal to feature `f' and if in debug
--			-- mode then redisplay the sign of the `index'-th breakable point.
--		require
--			valid_feature: e_feature /= Void and then e_feature.body_id /= Void
--		local
--			new_stone: FEATURE_STONE
--			display_cmd: DISPLAY_ROUTINE_PORTION
		do
--			display_cmd ?= display_feature_cmd_holder.associated_command
--			if display_cmd.is_shown and then index > 0 then
--				feature_part.show_stoppoint (e_feature, index)
--			end
		end

	show_current_stoppoint is
			-- Show breakable mark in the feature part if
			-- the part is displayed
		local
--			status: APPLICATION_STATUS
--			display_cmd: DISPLAY_ROUTINE_PORTION
--			new_stone: FEATURE_STONE
--			call_stack: CALL_STACK_ELEMENT
--			e_feature: E_FEATURE
--			index: INTEGER
		do
--			if Application.is_running and then Application.is_stopped then
--				display_cmd ?= display_feature_cmd_holder.associated_command
--				if display_cmd.is_shown then
--					status := Application.status
--					if status.e_feature /= Void then
--						call_stack := status.current_stack_element
--						if Application.current_execution_stack_number = 1 then
--							e_feature := status.e_feature
--							index := status.break_index
--						else
--							e_feature := call_stack.routine
--						end
--						if feature_part.last_format /= feature_part.showstop_frmt_holder then
--							feature_part.set_debug_format
--						end
--						create new_stone.make (e_feature)
--						feature_part.process_feature (new_stone)
--						if index > 0 then
--							feature_part.show_stoppoint (e_feature, index)
--						end
--					end
--				end
--			end
		end

	show_current_object is
			-- Show the current object in exception 
			-- stack in object tool portion.
		local
--			display_cmd: DISPLAY_OBJECT_PORTION
--			new_stone: OBJECT_STONE
--			call_stack: CALL_STACK_ELEMENT
--			object_address: STRING
--			dynamic_class: CLASS_C
--			status: APPLICATION_STATUS
		do
--			if Application.is_running and then 
--				Application.is_stopped 
--			then
--				display_cmd ?= display_object_cmd_holder.associated_command
--				if display_cmd.is_shown then
--					status := Application.status
--					if status.e_feature /= Void then
--						call_stack := status.current_stack_element
--						if Application.current_execution_stack_number = 1 then
--							dynamic_class := status.dynamic_class
--							object_address := status.object_address
--						else
--							dynamic_class := call_stack.dynamic_class
--							object_address := call_stack.object_address
--						end
--						create new_stone.make (object_address, call_stack.routine_name, dynamic_class)
--						if new_stone.same_as (object_part.stone) then
--							object_part.synchronize
--						else
--							object_part.process_object (new_stone)
--						end
--					end
--				end
--			end
		end

	display_exception_stack is
			-- Display the exception stack in the text window.
		local
			st: STRUCTURED_TEXT
		do
			create st.make
			Application.status.display_status (st)
			text_window.clear_window
			text_window.hide
			text_window.process_text (st)
			if saved_cursor /= Void then
				text_window.go_to (saved_cursor)
			end
			text_window.show
		end

	save_current_cursor_position is
			-- Save the current cursor position.
		do
			saved_cursor := text_window.position
		end

	clear_cursor_position is
			-- Clear the saved cursor position.
		do
			saved_cursor := Void
		end

	saved_cursor: INTEGER
		-- was previously supposed to be a CURSOR

feature -- Information

	display_system_info is
		local
			st: STRUCTURED_TEXT
		do
			st := structured_system_info
			if st /= Void then
				text_window.clear_window
				text_window.process_text (st)
--				text_window.set_top_character_position (0)
				text_window.show
			end
		end

	display_string (s: STRING) is
		do
			text_window.clear_window
			text_window.put_string (s)
--			text_window.set_top_character_position (0)
			text_window.show
		end

	display_welcome_info is
		do
			text_window.clear_window
			text_window.process_text (welcome_info)
--			text_window.set_top_character_position (0)
			text_window.show
		end

	welcome_info: STRUCTURED_TEXT is
			-- Display information on how to launch EiffelBench.
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
					root_class_c := Eiffel_universe.compiled_classes_with_name (root_class_name).i_th(0).compiled_class
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

close_windows is do end

end -- class EB_DEBUG_TOOL

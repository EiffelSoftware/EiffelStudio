indexing

	description:	
		"Keyboard accelerators for major functionalities of Bench.";
	date: "$Date$";
	revision: "$Revision$"

class ACCELERATOR_W

inherit

	COMMAND_W;
	SHARED_ACCELERATOR

feature {NONE} -- Execution

	work (argument: ANY) is
			-- Do some stuff for the execution of the commands.
		local
			default_argument: ANY
		do
			default_argument := Project_tool.text_window;
			if argument = melt_acc then
				Project_tool.update_command.execute (default_argument)
			elseif argument = melt_no_c_acc then
				Project_tool.update_command.execute (generate_code_only)
			elseif argument = run_acc then
				Project_tool.debug_run_command.execute (default_argument)
			elseif argument = freeze_acc then
				Project_tool.freeze_command.execute (default_argument)
			elseif argument = freeze_no_c_acc then
				Project_tool.freeze_command.execute (generate_code_only)
			elseif argument = finalize_acc then
				Project_tool.finalize_command.execute (default_argument)
			elseif argument = finalize_no_c_acc then
				Project_tool.finalize_command.execute (generate_code_only)
			elseif argument = quit_acc then
				Project_tool.quit_command.execute (default_argument)
			elseif argument = kill_it then
				Project_tool.debug_quit_command.execute (kill_it)
			elseif argument = interrupt_acc then
				Project_tool.debug_quit_command.execute (default_argument)
			elseif argument = specify_args then
				Project_tool.debug_run_command.execute (specify_args)
			elseif argument = melt_and_run then
				Project_tool.debug_run_command.execute (melt_and_run)
			elseif argument = status_acc then
				Project_tool.debug_status_command.execute (default_argument)
			elseif argument = stop_acc then
				Project_tool.stop_points_hole.execute (default_argument)
			elseif argument = object_acc then
				Project_tool.object_hole.execute (default_argument)
			elseif argument = class_acc then
				Project_tool.class_hole.execute (default_argument)
			elseif argument = feature_acc then
				Project_tool.routine_hole.execute (default_argument)
			elseif argument = system_acc then
				Project_tool.system_hole.execute (default_argument)
			elseif argument = explain_acc then
				Project_tool.explain_hole.execute (default_argument)
			elseif argument = next_acc then
				Project_tool.exec_stop.execute (default_argument)
			elseif argument = next_run_acc then
				Project_tool.exec_stop.execute (format_and_run)
			elseif argument = step_acc then
				Project_tool.exec_step.execute (default_argument)
			elseif argument = step_run_acc then
				Project_tool.exec_step.execute (format_and_run)
			elseif argument = out_rout_acc then
				Project_tool.exec_last.execute (default_argument)
			elseif argument = out_rout_run_acc then
				Project_tool.exec_last.execute (format_and_run)
			elseif argument = no_stop_acc then
				Project_tool.exec_nostop.execute (default_argument)
			elseif argument = no_stop_run_acc then
				Project_tool.exec_nostop.execute (format_and_run)
			elseif argument = raise_project_acc then
				Project_tool.raise

			elseif argument = raise_class_acc then
				Window_manager.raise_class_windows

			elseif argument = raise_feat_acc then
				Window_manager.raise_routine_windows

			elseif argument = raise_obj_acc then
				Window_manager.raise_object_windows

			elseif argument = raise_expl_acc then
				Window_manager.raise_explain_windows

			elseif argument = raise_sys_acc then
				System_tool.raise

			elseif argument = raise_warner_acc then
				if name_chooser.is_popped_up then
					name_chooser.raise
				end;
				if 
					last_confirmer /= Void and then 
					last_confirmer.is_popped_up 
				then
					last_confirmer.raise
				end;
				if last_warner /= Void and then last_warner.is_popped_up then
					last_warner.raise
				end
			end
		end;

feature {NONE} -- Inapplicable

	set_action (a_translation: STRING; a_command: COMMAND; argument: ANY) is
			-- Useless here.
		do
			-- Do nothing.
		end;

end -- class ACCELERATOR_W

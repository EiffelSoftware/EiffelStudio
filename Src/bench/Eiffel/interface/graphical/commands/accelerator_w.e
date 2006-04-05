indexing

	description:	
		"Keyboard accelerators for major functionalities of Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ACCELERATOR_W

inherit
	COMMAND_W

	SHARED_ACCELERATOR

feature {NONE} -- Execution

	work (argument: ANY) is
			-- Do some stuff for the execution of the commands.
		local
			default_argument: ANY
		do
			default_argument := Project_tool.text_window;
			if argument = melt_acc then
				Project_tool.update_cmd_holder.associated_command.execute (default_argument)
			elseif argument = melt_no_c_acc then
				Project_tool.update_cmd_holder.associated_command.execute (generate_code_only)
			elseif argument = run_acc then
				Project_tool.debug_run_cmd_holder.associated_command.execute (default_argument)
			elseif argument = freeze_acc then
				Project_tool.freeze_cmd_holder.associated_command.execute (default_argument)
			elseif argument = freeze_no_c_acc then
				Project_tool.freeze_cmd_holder.associated_command.execute (generate_code_only)
			elseif argument = finalize_acc then
				Project_tool.finalize_cmd_holder.associated_command.execute (default_argument)
			elseif argument = finalize_no_c_acc then
				Project_tool.finalize_cmd_holder.associated_command.execute (generate_code_only)
			elseif argument = quit_acc then
				Project_tool.quit_cmd_holder.associated_command.execute (default_argument)
			elseif argument = kill_it then
				Project_tool.debug_quit_cmd_holder.associated_command.execute (kill_it)
			elseif argument = interrupt_acc then
				Project_tool.debug_quit_cmd_holder.associated_command.execute (default_argument)
			elseif argument = specify_args then
				Project_tool.debug_run_cmd_holder.associated_command.execute (specify_args)
			elseif argument = melt_and_run then
				Project_tool.debug_run_cmd_holder.associated_command.execute (melt_and_run)
			elseif argument = status_acc then
				Project_tool.debug_status_cmd_holder.associated_command.execute (default_argument)
			elseif argument = stop_acc then
				Project_tool.stop_points_hole_holder.execute (default_argument)
			elseif argument = object_acc then
				Project_tool.object_hole_holder.execute (default_argument)
			elseif argument = class_acc then
				Project_tool.class_hole_holder.execute (default_argument)
			elseif argument = feature_acc then
				Project_tool.routine_hole_holder.execute (default_argument)
			elseif argument = system_acc then
				Project_tool.system_hole_holder.execute (default_argument)
			elseif argument = explain_acc then
				Project_tool.explain_hole_holder.execute (default_argument)
			elseif argument = next_acc then
				Project_tool.exec_stop_frmt_holder.execute (default_argument)
			elseif argument = next_run_acc then
				Project_tool.exec_stop_frmt_holder.execute (format_and_run)
			elseif argument = step_acc then
				Project_tool.exec_step_frmt_holder.execute (default_argument)
			elseif argument = step_run_acc then
				Project_tool.exec_step_frmt_holder.execute (format_and_run)
			elseif argument = out_rout_acc then
				Project_tool.exec_last_frmt_holder.execute (default_argument)
			elseif argument = out_rout_run_acc then
				Project_tool.exec_last_frmt_holder.execute (format_and_run)
			elseif argument = no_stop_acc then
				Project_tool.exec_nostop_frmt_holder.execute (default_argument)
			elseif argument = no_stop_run_acc then
				Project_tool.exec_nostop_frmt_holder.execute (format_and_run)
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
				if last_name_chooser.is_popped_up then
					last_name_chooser.raise
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

indexing
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

end -- class ACCELERATOR_W

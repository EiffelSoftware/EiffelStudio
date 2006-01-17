indexing
	description: "Constants to identify Managed Callback method"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_MANAGED_CALLBACK_CONSTANTS

feature {NONE} -- Constants

	Cst_managed_cb_breakpoint: INTEGER is 1

	Cst_managed_cb_step_complete: INTEGER is 2

	Cst_managed_cb_break: INTEGER is 3

	Cst_managed_cb_exception: INTEGER is 4

	Cst_managed_cb_eval_complete: INTEGER is 5

	Cst_managed_cb_eval_exception: INTEGER is 6

	Cst_managed_cb_create_process: INTEGER is 7

	Cst_managed_cb_exit_process: INTEGER is 8

	Cst_managed_cb_create_thread: INTEGER is 9

	Cst_managed_cb_exit_thread: INTEGER is 10

	Cst_managed_cb_load_module: INTEGER is 11

	Cst_managed_cb_unload_module: INTEGER is 12

	Cst_managed_cb_load_class: INTEGER is 13

	Cst_managed_cb_unload_class: INTEGER is 14

	Cst_managed_cb_debugger_error: INTEGER is 15

	Cst_managed_cb_log_message: INTEGER is 16

	Cst_managed_cb_log_switch: INTEGER is 17

	Cst_managed_cb_create_app_domain: INTEGER is 18

	Cst_managed_cb_exit_app_domain: INTEGER is 19

	Cst_managed_cb_load_assembly: INTEGER is 20

	Cst_managed_cb_unload_assembly: INTEGER is 21

	Cst_managed_cb_control_ctrap: INTEGER is 22

	Cst_managed_cb_name_change: INTEGER is 23

	Cst_managed_cb_update_module_symbols: INTEGER is 24

	Cst_managed_cb_edit_and_continue_remap: INTEGER is 25

	Cst_managed_cb_breakpoint_set_error: INTEGER is 26

	Cst_managed_cb2_function_remap_opportunity: INTEGER is 27
	Cst_managed_cb2_create_connection: INTEGER is 28
	Cst_managed_cb2_change_connection: INTEGER is 29
	Cst_managed_cb2_destroy_connection: INTEGER is 30
	Cst_managed_cb2_exception: INTEGER is 31
	Cst_managed_cb2_exception_unwind: INTEGER is 32
	Cst_managed_cb2_function_remap_complete: INTEGER is 33
	Cst_managed_cb2_mdanotification: INTEGER is 34

feature -- Query

	value_of_cst_managed_cb (cst: INTEGER): STRING is
		do
			inspect cst 
				when Cst_managed_cb_breakpoint then
				Result := "breakpoint"
				when Cst_managed_cb_step_complete then
				Result := "step_complete"
				when Cst_managed_cb_break then
				Result := "break"
				when Cst_managed_cb_exception then
				Result := "exception"
				when Cst_managed_cb_eval_complete then
				Result := "eval_complete"
				when Cst_managed_cb_eval_exception then
				Result := "eval_exception"
				when Cst_managed_cb_create_process then
				Result := "create_process"
				when Cst_managed_cb_exit_process then
				Result := "exit_process"
				when Cst_managed_cb_create_thread then
				Result := "create_thread"
				when Cst_managed_cb_exit_thread then
				Result := "exit_thread"
				when Cst_managed_cb_load_module then
				Result := "load_module"
				when Cst_managed_cb_unload_module then
				Result := "unload_module"
				when Cst_managed_cb_load_class then
				Result := "load_class"
				when Cst_managed_cb_unload_class then
				Result := "unload_class"
				when Cst_managed_cb_debugger_error then
				Result := "debugger_error"
				when Cst_managed_cb_log_message then
				Result := "log_message"
				when Cst_managed_cb_log_switch then
				Result := "log_switch"
				when Cst_managed_cb_create_app_domain then
				Result := "create_app_domain"
				when Cst_managed_cb_exit_app_domain then
				Result := "exit_app_domain"
				when Cst_managed_cb_load_assembly then
				Result := "load_assembly"
				when Cst_managed_cb_unload_assembly then
				Result := "unload_assembly"
				when Cst_managed_cb_control_ctrap then
				Result := "control_ctrap"
				when Cst_managed_cb_name_change then
				Result := "name_change"
				when Cst_managed_cb_update_module_symbols then
				Result := "update_module_symbols"
				when Cst_managed_cb_edit_and_continue_remap then
				Result := "edit_and_continue_remap"
				when Cst_managed_cb_breakpoint_set_error then
				Result := "breakpoint_set_error"
				when Cst_managed_cb2_function_remap_opportunity then
				Result := "function_remap_opportunity (2)"
				when Cst_managed_cb2_create_connection then
				Result := "create_connection (2)"
				when Cst_managed_cb2_change_connection then
				Result := "change_connection (2)"
				when Cst_managed_cb2_destroy_connection then
				Result := "destroy_connection (2)"
				when Cst_managed_cb2_exception then
				Result := "exception (2)"
				when Cst_managed_cb2_exception_unwind then
				Result := "exception_unwind (2)"
				when Cst_managed_cb2_function_remap_complete then
				Result := "function_remap_complete (2)"
				when Cst_managed_cb2_mdanotification then
				Result := "mdanotification (2)"
				when 0 then
				Result := "no callback"
				else
					Result := "ERROR : Unknown managed callback"
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class EIFNET_DEBUGGER_MANAGED_CALLBACK_CONSTANTS


indexing
	description: "Constants to identify Managed Callback method"
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

feature

	managed_callbacks: ARRAY[INTEGER] is
		do
			Result := <<
				Cst_managed_cb_breakpoint,
				Cst_managed_cb_step_complete,
				Cst_managed_cb_break,
				Cst_managed_cb_exception,
				Cst_managed_cb_eval_complete,
				Cst_managed_cb_eval_exception,
				Cst_managed_cb_create_process,
				Cst_managed_cb_exit_process,
				Cst_managed_cb_create_thread,
				Cst_managed_cb_exit_thread,
				Cst_managed_cb_load_module,
				Cst_managed_cb_unload_module,
				Cst_managed_cb_load_class,
				Cst_managed_cb_unload_class,
				Cst_managed_cb_debugger_error,
				Cst_managed_cb_log_message,
				Cst_managed_cb_log_switch,
				Cst_managed_cb_create_app_domain,
				Cst_managed_cb_exit_app_domain,
				Cst_managed_cb_load_assembly,
				Cst_managed_cb_unload_assembly,
				Cst_managed_cb_control_ctrap,
				Cst_managed_cb_name_change,
				Cst_managed_cb_update_module_symbols,
				Cst_managed_cb_edit_and_continue_remap,
				Cst_managed_cb_breakpoint_set_error
			>>
		end

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
				when 0 then
				Result := "no callback"
				else
					Result := "ERROR : Unknown managed callback"
			end
		end

end -- class EIFNET_DEBUGGER_MANAGED_CALLBACK_CONSTANTS


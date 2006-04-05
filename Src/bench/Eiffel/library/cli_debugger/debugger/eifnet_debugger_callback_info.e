indexing
	description: "[
					Objects that represents the debuggeur information 
					regarding callbacks status
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFNET_DEBUGGER_CALLBACK_INFO

inherit

	EIFNET_DEBUGGER_MANAGED_CALLBACK_CONSTANTS
	EIFNET_DEBUGGER_UNMANAGED_CALLBACK_CONSTANTS

create {EIFNET_DEBUGGER_INFO_ACCESSOR}
	make
	
feature {NONE}-- initialisation

	make is
		do
			init
		end

	init is
		do
		end
		
feature {EIFNET_EXPORTER} -- Reset data
	
	reset is
			-- Reset attribute
		do		
		end
		
feature {NONE} -- callbacks initialisation

	initialize_managed_callback_status is
			-- Initialize default callback to process
		do
			enable_managed_callback (Cst_managed_cb_breakpoint)
			enable_managed_callback (Cst_managed_cb_step_complete)
--			enable_managed_callback (Cst_managed_cb_break)
			enable_managed_callback (Cst_managed_cb_exception)
			enable_managed_callback (Cst_managed_cb_eval_complete)
			enable_managed_callback (Cst_managed_cb_eval_exception)
--			enable_managed_callback (Cst_managed_cb_create_process)
			enable_managed_callback (Cst_managed_cb_exit_process)
--			enable_managed_callback (Cst_managed_cb_create_thread)
--			enable_managed_callback (Cst_managed_cb_exit_thread)
--			enable_managed_callback (Cst_managed_cb_load_module)
--			enable_managed_callback (Cst_managed_cb_unload_module)
--			enable_managed_callback (Cst_managed_cb_load_class)
--			enable_managed_callback (Cst_managed_cb_unload_class)
			enable_managed_callback (Cst_managed_cb_debugger_error)
--			enable_managed_callback (Cst_managed_cb_log_message)
--			enable_managed_callback (Cst_managed_cb_log_switch)
--			enable_managed_callback (Cst_managed_cb_create_app_domain)
--			enable_managed_callback (Cst_managed_cb_exit_app_domain)
--			enable_managed_callback (Cst_managed_cb_load_assembly)
--			enable_managed_callback (Cst_managed_cb_unload_assembly)
--			enable_managed_callback (Cst_managed_cb_control_ctrap)
--			enable_managed_callback (Cst_managed_cb_name_change)
--			enable_managed_callback (Cst_managed_cb_update_module_symbols)
--			enable_managed_callback (Cst_managed_cb_edit_and_continue_remap)
--			enable_managed_callback (Cst_managed_cb_breakpoint_set_error)
		end

feature -- Callback ids

	last_managed_callback: INTEGER

	last_unmanaged_callback: INTEGER
	
	last_managed_callback_name: STRING is
			-- 	
		do
			Result := managed_callback_name (last_managed_callback)
		end

feature {APPLICATION_EXECUTION_DOTNET, EIFNET_EXPORTER} -- Callback nature

	managed_callback_name (cb_id: INTEGER): STRING is
			-- 	
		do
			Result := value_of_cst_managed_cb (cb_id)
		end

	managed_callback_is_breakpoint (cb_id: INTEGER): BOOLEAN is
		do
			Result := cb_id = Cst_managed_cb_breakpoint
		end

	managed_callback_is_step_complete (cb_id: INTEGER): BOOLEAN is
		do
			Result := cb_id = Cst_managed_cb_step_complete
		end

	managed_callback_is_eval_complete (cb_id: INTEGER): BOOLEAN is
		do
			Result := cb_id = Cst_managed_cb_eval_complete
		end

	managed_callback_is_eval_exception (cb_id: INTEGER): BOOLEAN is
		do
			Result := cb_id = Cst_managed_cb_eval_exception
		end

	managed_callback_is_exception (cb_id: INTEGER): BOOLEAN is
		do
			Result := cb_id = Cst_managed_cb_exception
		end

	managed_callback_is_exit_process (cb_id: INTEGER): BOOLEAN is
		do
			Result := cb_id = Cst_managed_cb_exit_process
		end

	managed_callback_is_an_end_of_eval (cb_id: INTEGER): BOOLEAN is
		do
			inspect
				cb_id
			when 
				cst_managed_cb_eval_complete,
				cst_managed_cb_eval_exception,
				cst_managed_cb_exit_process,
--				cst_managed_cb_exception, -- Check if it is valid ...
				cst_managed_cb_break,
				cst_managed_cb_debugger_error
			then
				Result := True
			else
				Result := False
			end
		end
		
feature {EIFNET_EXPORTER} -- Change Callbacks

	set_last_managed_callback (cst: INTEGER) is
			-- Set `last_managed_callback' value to `cst'.
		do
			last_managed_callback := cst
		end

	set_last_unmanaged_callback (cst: INTEGER) is
			-- Set `last_unmanaged_callback' value to `cst'.
		do
			last_unmanaged_callback := cst
		end
	
feature {EIFNET_EXPORTER} -- Callback status

	callback_enabled (cb_id: INTEGER): BOOLEAN is
			-- Do we process callback `cb_id' ?
		do
			Result := managed_callback_status_info.item (cb_id) --| = True
		end

	callback_disabled (cb_id: INTEGER): BOOLEAN is
			-- Do we ignore callback `cb_id' ?
		do
			Result := not callback_enabled (cb_id)
		end

feature {NONE} -- Callback status change

	set_managed_callback_status (cb_id: INTEGER; a_status: BOOLEAN) is
		do
			managed_callback_status_info.force (a_status, cb_id)
		end

	enable_managed_callback (cb_id: INTEGER) is
			-- Tell debugger to process  `cb_id' callback.
		do
			set_managed_callback_status (cb_id, True);
		end

	disable_managed_callback (cb_id: INTEGER) is
			-- Tell debugger to skip  `cb_id' callback.
		do
			set_managed_callback_status (cb_id, False);
		end

feature {EIFNET_EXPORTER} -- Callback status

	managed_callback_status_info: HASH_TABLE [BOOLEAN, INTEGER] is
			-- Callback information table
		once
			create Result.make (50)
			initialize_managed_callback_status
		end

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

end -- class EIFNET_DEBUGGER_CALLBACK_INFO


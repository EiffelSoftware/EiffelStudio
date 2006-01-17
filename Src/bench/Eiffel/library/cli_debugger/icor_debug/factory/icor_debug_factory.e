indexing
	description: "Create CorDebug instances."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICOR_DEBUG_FACTORY

inherit
	CLI_COM

feature {ICOR_EXPORTER} -- Initialization
		
	new_cordebug_pointer_for (a_dbg_version: STRING): POINTER is
			-- Create a new instance of ICorDebug for `a_dbg_version'.
		local
			l_hr: INTEGER
			l_version: UNI_STRING
		do
			initialize_com
			if a_dbg_version = Void then
				create l_version.make ((create {IL_ENVIRONMENT}).default_version)
			else
				create l_version.make (a_dbg_version)
			end		
			l_hr := c_get_cordebug (l_version.item, $Result)	
		end

	new_cordebug_managed_callback: ICOR_DEBUG_MANAGED_CALLBACK is
			-- Create a new instance of ICOR_DEBUG_MANAGED_CALLBACK.
		local
			p: POINTER
		do
			initialize_com
			p := cpp_new_cordebug_managed_callback
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			result_exist: Result /= Void
		end

	new_cordebug_unmanaged_callback: ICOR_DEBUG_UNMANAGED_CALLBACK is
			-- Create a new instance of ICOR_DEBUG_MUNANAGED_CALLBACK.
		local
			p: POINTER
		do
			initialize_com
			p := cpp_new_cordebug_unmanaged_callback
			if p /= default_pointer then
				create Result.make_by_pointer (p)
			end
		ensure
			result_exists: Result /= Void
		end

feature {NONE} -- Externals

	c_get_cordebug (a_dbg_version: POINTER; a_cor_debug: POINTER): INTEGER is
			-- New instance of ICorDebug
		external
			"C signature (LPWSTR, EIF_POINTER **): EIF_INTEGER use %"cli_debugger.h%""
		alias
			"get_cordebug"
		end

	cpp_new_cordebug_managed_callback (): POINTER is 
			-- create an instance of DebuggerManagedCallback
		external
			"[
				C++ creator DebuggerManagedCallback
				signature () 
				use %"cli_debugger_callback.h%"
				]"
		end

	cpp_new_cordebug_unmanaged_callback (): POINTER is 
			-- create an instance of DebuggerUnmanagedCallback
		external
			"[
				C++ creator DebuggerUnmanagedCallback
				signature () 
				use %"cli_debugger_callback.h%"
				]"
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

end -- class ICOR_DEBUG_FACTORY


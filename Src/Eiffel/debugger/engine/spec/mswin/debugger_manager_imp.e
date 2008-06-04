indexing
	description: "implementation for DEBUGGER_MANAGER"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DEBUGGER_MANAGER_IMP

inherit
	DEBUGGER_MANAGER_I
		redefine
			load_system_dependent_debug_info
		end

	SHARED_EIFFEL_PROJECT
		export {NONE} all end

	SHARED_IL_DEBUG_INFO_RECORDER

create {DEBUGGER_MANAGER}
	make

feature {DEBUGGER_MANAGER} -- Access

	load_system_dependent_debug_info is
		do
			Precursor
			if
				Eiffel_project.system_defined
				and then interface.is_dotnet_project
			then
				il_debug_info_recorder.load_data_for_debugging
				if not il_debug_info_recorder.load_successful then
					interface.debugger_warning_message (il_debug_info_recorder.loading_errors_message)
				end
			end
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

end

note
	description: "[
					Command to ignore current contract violation once
																			]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_IGNORE_CONTRACT_VIOLATION_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Creation method
		do
		end

feature -- Access

	description: STRING_GENERAL
			-- <Precursor>
		do
			Result := Interface_names.e_Exec_ignore_contract_violation
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := pixmaps.icon_pixmaps.execution_ignore_contract_violation_icon_buffer
		end

	pixmap: EV_PIXMAP
			-- <Precursor>
		do
			Result := pixmaps.icon_pixmaps.execution_ignore_contract_violation_icon
		end

	tooltip: STRING_GENERAL
			-- <Precursor>
		do
			Result := description
		end

	name: STRING = "Ignore_contract_violation"
			-- <Precursor>

	menu_name: STRING_GENERAL
			-- Menu entry corresponding to `Current'.
		do
			Result := Interface_names.m_Exec_ignore_contract_violation
		end

feature -- Execution

	execute
			-- <Precursor>
		local
			bpm: BREAKPOINTS_MANAGER
		do
			if attached {EB_DEBUGGER_MANAGER} debugger_manager as l_debugger then
				if attached l_debugger.application as l_app  then
					-- Set ignore current contract violation flag first
					l_app.ignore_current_assertion_violation
					-- Resume debuggee execution
					l_debugger.debug_run_cmd.execute
				end
			end
		end

;note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

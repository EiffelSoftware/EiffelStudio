note
	description: "Command to apply selected fixes to source code."

class
	ES_FIX_COMMAND

inherit
	ES_ERROR_LIST_COMMAND
		redefine
			make,
			tooltext
		end

create
	make

feature {NONE} -- Initialization

	make (a_commander: like tool_commander)
			-- Initialize command using a tool commander.
			--
			-- `a_commander': A errors and warnings tool commander.
		do
			Precursor (a_commander)
			if attached preferences.misc_shortcut_data.shortcuts.item ("apply_fix") as l_shortcut then
				set_global_shortcut (l_shortcut)
			end
		end

feature -- Access

	pixel_buffer: EV_PIXEL_BUFFER
			-- <Precursor>
		do
				-- Void here.
			Result := pixmaps.icon_pixmaps.errors_and_warnings_fix_apply_icon_buffer
		end

	menu_name: STRING_GENERAL
			-- <Precursor>
		do
			Result := interface_names.m_apply_fix
		end

	tooltext: STRING_GENERAL
			-- <Precursor>
		do
			Result := interface_names.b_apply_fix
		end

	description: STRING_GENERAL
			-- <Precursor>
		do
			Result := interface_names.l_apply_fix
		end

	tooltip: STRING_GENERAL
			-- <Precursor>
		do
			Result := interface_names.f_apply_fix
		end

feature -- Execution

	execute
			-- <Precursor>
		do
			tool_commander.apply_fix
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 1984-2014, Eiffel Software"
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

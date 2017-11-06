note
	description: "Summary description for {EB_SHOW_CLOUD_ACCOUNT_CMD}."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_SHOW_CLOUD_ACCOUNT_CMD

inherit
	EB_MENUABLE_COMMAND

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create this command.
		do
		end

feature {NONE} -- Execution

	execute
			-- Execute command.
		do
			if
				attached window_manager.last_focused_development_window as win and then
				attached win.tools.cloud_account_tool as l_tool
			then
				l_tool.show (True)
			end
		end

feature -- Properties

	name: STRING
			-- Command name
		do
			Result := "Account"
		end

	menu_name: STRING_GENERAL
			-- Name used in menu entry
		do
			Result := Interface_names.m_account
		end

note
	copyright: "Copyright (c) 1984-2017, Eiffel Software"
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

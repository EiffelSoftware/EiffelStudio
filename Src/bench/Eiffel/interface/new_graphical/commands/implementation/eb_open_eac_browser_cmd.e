indexing
	description: "Command used to launch Eiffel Assembly Cache Browser"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	EB_OPEN_EAC_BROWSER_CMD

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND

	EB_CONSTANTS
		export
			{NONE} all
		end

	EIFFEL_ENV
		export
			{NONE} all
		end

feature -- Access

	tooltip: STRING is
			-- Pop up help on the toolbar button.
		do
			Result := Interface_names.E_open_eac_browser
		end

	description: STRING is
			-- Pop up help on the toolbar button.
		do
			Result := Interface_names.E_open_eac_browser
		end

	name: STRING is
			-- Text identifier for `Current'.
		do
			Result := "Dotnet_import"
		end

	menu_name: STRING is
			-- Menu name identifier (empty since not in menu)
		do
			Result := Interface_names.m_Open_eac_browser
		end

	pixmap: EV_PIXMAP is
			-- Icon for `current'.
		do
			Result := Pixmaps.Icon_dotnet_import
		end

feature -- Basic operations

	execute is
			-- Command execution.
		do
			Execution_environment.launch (ISE_eac_browser_name)
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

end -- class EB_OPEN_EAC_BROWSER_CMD

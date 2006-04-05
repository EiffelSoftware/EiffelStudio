indexing
	description	: "This class is inherited by all the application"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	WIZARD_PROJECT_SHARED

inherit
	BENCH_WIZARD_SHARED

feature {NONE} -- Constants

	Eiffel_installation_dir_name: STRING is
			-- ISE_EIFFEL name.
		once
			Result := execution_environment.get ("ISE_EIFFEL")
		end

	Eiffel_platform: STRING is
			-- ISE_PLATFORM name.
		once
			Result := execution_environment.get ("ISE_PLATFORM")
		end

	Empty_string: STRING is ""
			-- Empty string

	execution_environment: EXECUTION_ENVIRONMENT is
			-- Shared execution environment object
		once
			create Result
		end	

	Wizard_icon_name: STRING is "eiffel_wizard_icon"
			-- .NET Wizard icon name

	Interface_names: INTERFACE_NAMES is
			-- Interface names for buttons, label, ...
		once
			create Result
		end

	New_line: STRING is "%N"
			-- New line

	Tab: STRING is "%T"
			-- Tabulation

	Unrelevant_data: STRING is "Irrelevant data: root class is NONE"
			-- Message appearing in window text fields in case the root class is NONE

	Windows_new_line: STRING is "%R%N";
			-- New line on Windows platform

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
end -- class WIZARD_PROJECT_SHARED

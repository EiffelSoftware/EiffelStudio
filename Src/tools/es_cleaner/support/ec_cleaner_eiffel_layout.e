indexing
	description: "[
		Specialize implementation of {EC_EIFFEL_LAYOUT} that overrides onces and allows `is_workbench' to be set irrespective on a containing
		project's compiled status.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	EC_CLEANER_EIFFEL_LAYOUT

inherit
	EC_EIFFEL_LAYOUT
		rename
			is_workbench as external_is_workbench
		redefine
			docking_data_name,
			eiffel_home,
			eiffel_preferences
		end

feature -- Access

	docking_data_name: STRING is
			-- Docking config data folder name
		do
			if not is_workbench then
				Result := "docking"
			else
				Result := "docking_wb"
			end
		end

	eiffel_home: DIRECTORY_NAME is
			-- Name of directory containing Eiffel specific data.
		local
			l_dir_name: STRING
		do
			create Result.make_from_string (Home)
			if platform.is_windows then
				l_dir_name := "EiffelSoftware"
			else
				l_dir_name := ".es"
			end
			if is_workbench then
				l_dir_name.append ("_wkbench")
			end
			Result.extend (l_dir_name)
		end

	eiffel_preferences: STRING is
			-- Preferences location
		local
			fname: FILE_NAME
		do
			if platform.is_windows then
				Result := "HKEY_CURRENT_USER\Software\ISE\" + product_version_name + "\"+application_name+"\Preferences"
				if is_workbench then
					Result.append ("_wkbench")
				end
			else
				create fname.make_from_string (eiffel_home)
				fname.set_file_name (application_name + "rc" + major_version.out + minor_version.out)
				Result := fname
			end
		end

feature -- Status report

	is_workbench: BOOLEAN is
			-- Is workbench
		do
			Result := internal_is_workbench
		end

feature {NONE} -- Status report

	internal_is_workbench: BOOLEAN
			-- Internal version of `is_workbench'

feature {PACKAGE} -- Status setting

	set_is_workbench (a_value: like is_workbench) is
			-- Set `is_workbench' with `a_value'
		do
			internal_is_workbench := a_value
		ensure
			is_workbench_set: is_workbench = a_value
		end

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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

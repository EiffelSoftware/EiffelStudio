indexing
	description: "[
		A provider used to proffer common file and directory locations, shared between platforms, to any client.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	PATH_PROVIDER

create
	make

feature {NONE} -- Initialization

	make (a_package: like package) is
			-- Initialize cleaner
		require
			a_package_attached: a_package /= Void
		do
			package := a_package
		ensure
			package_set: package = a_package
		end

feature -- Access

	package: PACKAGE
			-- Package associated with cleaner

feature -- Access

	docking_data_location: PATH_NAME is
			-- Location of docking data
		local
			l_ev: EIFFEL_ENV
		do
			l_ev := package.eiffel_env
			Result := l_ev.user_docking_path
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	docking_editing_layout_file: FILE_NAME is
			-- Docking layout file
		do
			create Result.make_from_string (docking_data_location)
			Result.set_file_name (once "layout.wb")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	docking_debug_layout_file: FILE_NAME is
			-- Docking layout file
		do
			create Result.make_from_string (docking_data_location)
			Result.set_file_name (once "debug_layout.wb")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

feature -- Query

	project_layout_path (a_location: STRING): FILE_NAME is
			-- Retrieve location of project layout file
		require
			a_location_attached: a_location /= Void
			not_a_location_is_empty: not a_location.is_empty
		do
			create Result.make_from_string (a_location)
			Result.set_file_name (once "layout.wb")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	project_preferences_path (a_location: STRING): FILE_NAME is
			-- Retrieve location of project preferences file
		require
			a_location_attached: a_location /= Void
			not_a_location_is_empty: not a_location.is_empty
		do
			create Result.make_from_string (a_location)
			Result.set_file_name (once "preferences.wb")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	project_session_path (a_location: STRING): FILE_NAME is
			-- Retrieve location of project session file
		require
			a_location_attached: a_location /= Void
			not_a_location_is_empty: not a_location.is_empty
		do
			create Result.make_from_string (a_location)
			Result.set_file_name (once "session.wb")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

invariant
	package_attached: package /= Void

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

note
	description: "[
		Used to read assemblies and extract basic metadata information.
	]"
	date:        "$Date$"
	revision:    "$Revision$"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ASSEMBLY_PROPERTIES_READER

inherit
	DISPOSABLE

create
	make

feature {NONE} -- Initialize

	make (a_runtime_version: STRING)
			-- Initialize Current. Initialize `exists' accordingly.
		require
			a_runtime_version_not_void: a_runtime_version /= Void
			not_a_runtime_version_is_empty: not a_runtime_version.is_empty
		do
		end

feature -- Clean up

	dispose
			-- Cleans up any allocated resources
		do
		ensure then
			not_exists: not exists
		end

feature -- Basic operations

	retrieve_assembly_properties (a_file_name: STRING): ASSEMBLY_PROPERTIES
			-- Retrieves assembly properties for `a_file_name'
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
			a_file_name_exists: (create {RAW_FILE}.make (a_file_name)).exists
			a_file_name_is_pe_file: (create {PE_FILE_INFO}).is_com2_pe_file (a_file_name)
			exists: exists
		do
			check False end
		end

feature -- Status report

	exists: BOOLEAN
			-- Indicates if reader was successfully initialized and is read for use.
		once
			Result := False
		end

note
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

end -- class ASSEMBLY_PROPERTIES_READER

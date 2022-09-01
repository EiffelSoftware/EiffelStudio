note
	description: "Information associated to a consumed assembly"
	legal: "See notice at end of class."
	status: "See notice at end of class."

frozen class
	CONSUMED_ASSEMBLY_INFO

create
	make

feature {NONE} -- Initialization

	make (ass: CONSUMED_ASSEMBLY; assembly_location, assembly_directory: STRING; f: INTEGER)
			-- Initialization
		require
			non_void_ass: ass /= Void
			non_void_assembly_location: assembly_location /= Void
			not_empty_assembly_location: not assembly_location.is_empty
			non_void_assembly_directory: assembly_directory /= Void
			not_empty_assembly_directory: not assembly_directory.is_empty
			positive_flag: f >= 0
		do
			assembly := ass
			location := assembly_location
			directory := assembly_directory
			flags := f
		ensure
			assembly_set: assembly = ass
			location_set: location = assembly_location
			directory_set: directory = assembly_directory
			flags_set: flags = f
		end

feature -- Access

	assembly: CONSUMED_ASSEMBLY
			-- Consumed assembly

	location: STRING
			-- Location of assembly.

	directory: STRING
			-- Directory where is stored `assembly'

	flags: INTEGER
			-- Provides information about an Assembly reference.

invariant
	non_void_assembly: assembly /= Void
	non_void_location: location /= Void
	not_empty_location: not location.is_empty
	non_void_directory: directory /= Void
	not_empty_directory: not directory.is_empty

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


end -- class CONSUMED_ASSEMBLY_INFO

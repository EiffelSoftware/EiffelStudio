note
	description: "A C/C++ interop structure corresponding to ASSEMBYMETADATA in cor.h"
	date: "$Date$"
	revision: "$Revision$"
	legal: "See notice at end of class."
	status: "See notice at end of class."

class
	ASSEMBLY_METADATA

inherit
	DISPOSABLE

create {ASSEMBLY_PROPERTIES_READER}
	make

convert
	to_pointer: {POINTER}

feature {NONE} -- Initialization

	make
			-- Initializes a default instance
		do
		ensure then
			not_item_is_null: item /= default_pointer
		end

feature -- Clean up

	dispose
			-- Cleans up allocated resources
		do
		ensure then
			item_is_null: item = default_pointer
		end

feature -- Access

	major_version: NATURAL_8
			-- The major version number of the referenced assembly
		do
			check False end
		end

	minor_version: NATURAL_8
			-- The minor version number of the referenced assembly
		do
			check False end
		end

	build_number: NATURAL_8
			-- The build number of the referenced assembly
		do
			check False end
		end

	revision_number: NATURAL_8
			-- The revision number of the referenced assembly
		do
			check False end
		end

	locales: LIST [STRING_32]
			-- A list of locale names conforming to the RFC1766 specification specifying the locales.
		do
			check False then end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature {ASSEMBLY_PROPERTIES_READER} -- Conversion

	to_pointer: POINTER
		do
			check False end
		ensure
			not_result_is_null: Result /= default_pointer
		end

feature {NONE} -- Implementation

	item: POINTER;
			-- Pointer to allocated ASSEMBLYMETADATA struct

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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

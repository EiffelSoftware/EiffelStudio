indexing
	description: "Encapsulation of ASSEMBLYMETADATA C structure"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_ASSEMBLY_INFO

inherit
	WEL_STRUCTURE
		rename
			structure_size as size
		end

create
	make

feature -- Settings

	set_major_version (m: NATURAL_16) is
			-- Set `major_version' to `m'.
		do
			c_set_major_version (item, m)
		end

	set_minor_version (m: NATURAL_16) is
			-- Set `minor_version' to `m'.
		do
			c_set_minor_version (item, m)
		end

	set_build_number (m: NATURAL_16) is
			-- Set `build_number' to `m'.
		do
			c_set_build_number (item, m)
		end

	set_revision_number (m: NATURAL_16) is
			-- Set `revision_number' to `m'.
		do
			c_set_revision_number (item, m)
		end

feature -- Measurement

	size: INTEGER is
			-- Size of current.
		do
			Result := structure_size
		end

	structure_size: INTEGER is
			-- Size of ASSEMBLYMETADATA structure.
		external
			"C++ macro use <cor.h>"
		alias
			"sizeof(ASSEMBLYMETADATA)"
		end

feature {NONE} -- Implementation

	c_set_major_version (an_item: POINTER; i: NATURAL_16) is
			-- Set `usMajorVersion' to `i'.
		external
			"C++ struct ASSEMBLYMETADATA access usMajorVersion type USHORT use <cor.h>"
		end

	c_set_minor_version (an_item: POINTER; i: NATURAL_16) is
			-- Set `usMinorVersion' to `i'.
		external
			"C++ struct ASSEMBLYMETADATA access usMinorVersion type USHORT use <cor.h>"
		end

	c_set_build_number (an_item: POINTER; i: NATURAL_16) is
			-- Set `usBuildNumber' to `i'.
		external
			"C++ struct ASSEMBLYMETADATA access usBuildNumber type USHORT use <cor.h>"
		end

	c_set_revision_number (an_item: POINTER; i: NATURAL_16) is
			-- Set `usRevisionNumber' to `i'.
		external
			"C++ struct ASSEMBLYMETADATA access usRevisionNumber type USHORT use <cor.h>"
		end

	c_set_locale (an_item: POINTER; locale: POINTER) is
			-- Set `szLocale' to `locale'.
		external
			"C++ struct ASSEMBLYMETADATA access szLocale type LPWSTR use <cor.h>"
		end

	c_set_locale_count (an_item: POINTER; nb: INTEGER) is
			-- Set `cbLocale' to `nb'.
		external
			"C++ struct ASSEMBLYMETADATA access cbLocale type ULONG use <cor.h>"
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

end -- class MD_ASSEMBLY_INFO

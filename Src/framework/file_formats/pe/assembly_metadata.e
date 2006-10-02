indexing
	description: "[
		A C/C++ interop structure corresponding to ASSEMBYMETADATA in cor.h
	]"
	date:        "$Date$"
	revision:    "$Revision$"
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

	make  is
			-- Initializes a default instance
		do
			alloc ($item).do_nothing
		ensure then
			not_item_is_null: item /= default_pointer
		end

feature -- Clean up

	dispose is
			-- Cleans up allocated resources
		do
			if item /= default_pointer then
				dealloc ($item)
			end
		ensure then
			item_is_null: item = default_pointer
		end

feature -- Access

	major_version: NATURAL_8 is
			-- The major version number of the referenced assembly
		do
			Result := get_major_version (item)
		end

	minor_version: NATURAL_8 is
			-- The minor version number of the referenced assembly
		do
			Result := get_minor_version (item)
		end

	build_number: NATURAL_8 is
			-- The build number of the referenced assembly
		do
			Result := get_build_number (item)
		end

	revision_number: NATURAL_8 is
			-- The revision number of the referenced assembly
		do
			Result := get_revision_number (item)
		end

	locales: LIST [STRING_8] is
			-- A list of locale names conforming to the RFC1766 specification specifying the locales.
		local
			l_p: POINTER
			l_str: WEL_STRING
		do
			l_p := get_locale (item)
			if l_p /= default_pointer then
				create l_str.share_from_pointer (l_p)
				Result := l_str.string.to_string_8.split (';')
			end
		ensure
			not_result_is_empty: Result /= Void implies not Result.is_empty
		end

feature {ASSEMBLY_PROPERTIES_READER} -- Conversion

	to_pointer: POINTER is
		do
			Result := item
		ensure
			not_result_is_null: Result /= default_pointer
		end

feature {NONE} -- Implementation

	item: POINTER
			-- Pointer to allocated ASSEMBLYMETADATA struct

feature {NONE} -- Memory management

	alloc (a_item: TYPED_POINTER [POINTER]): BOOLEAN is
			--
		external
			"C++ inline use %"cor.h%""
		alias
			"[
				*$a_item = (EIF_POINTER)calloc (1, sizeof (ASSEMBLYMETADATA));
				if (NULL != *$a_item) {
					LPWSTR psz = (LPWSTR) calloc (512, sizeof (WCHAR));
					if (NULL != psz) {
						((ASSEMBLYMETADATA*)*$a_item)->szLocale = psz;
						((ASSEMBLYMETADATA*)*$a_item)->cbLocale = 511;
					}
					return TRUE;
				}
				return FALSE;
			]"
		end

	dealloc (a_item: TYPED_POINTER [POINTER]) is
			--
		external
			"C++ inline use %"cor.h%""
		alias
			"[
				if (NULL != *$a_item){
					LPWSTR psz = ((ASSEMBLYMETADATA*)*$a_item)->szLocale;
					if (NULL != psz){
						free (psz);
					}
					free ((LPVOID)*$a_item);
					*$a_item = NULL;
				}
			]"
		end

feature {NONE} -- Extenral access

	get_major_version (a_item: POINTER): like major_version is
			-- Retrieves major version number for `a_item'
		require
			not_a_item_is_null: a_item /= default_pointer
		external
			"C++ inline use %"cor.h%""
		alias
			"return ((ASSEMBLYMETADATA*)$a_item)->usMajorVersion"
		end

	get_minor_version (a_item: POINTER): like minor_version is
			-- Retrieves minor version number for `a_item'
		require
			not_a_item_is_null: a_item /= default_pointer
		external
			"C++ inline use %"cor.h%""
		alias
			"return ((ASSEMBLYMETADATA*)$a_item)->usMinorVersion"
		end

	get_build_number (a_item: POINTER): like build_number is
			-- Retrieves build number for `a_item'
		require
			not_a_item_is_null: a_item /= default_pointer
		external
			"C++ inline use %"cor.h%""
		alias
			"return ((ASSEMBLYMETADATA*)$a_item)->usBuildNumber"
		end

	get_revision_number (a_item: POINTER): like revision_number is
			-- Retrieves revision number for `a_item'
		require
			not_a_item_is_null: a_item /= default_pointer
		external
			"C++ inline use %"cor.h%""
		alias
			"return ((ASSEMBLYMETADATA*)$a_item)->usRevisionNumber"
		end

	get_locale (a_item: POINTER): POINTER is
			-- Retrieves revision number for `a_item'
		require
			not_a_item_is_null: a_item /= default_pointer
		external
			"C++ inline use %"cor.h%""
		alias
			"[
				ULONG cbLocale = ((ASSEMBLYMETADATA*)$a_item)->cbLocale;
				if (cbLocale > 0) {
					return ((ASSEMBLYMETADATA*)$a_item)->szLocale;
				}
			]"
		end

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

end -- class {ASSEMBLY_METADATA}

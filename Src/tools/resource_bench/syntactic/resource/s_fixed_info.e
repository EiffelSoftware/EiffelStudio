indexing
	description: "xxx"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	product: "Resource Bench"
	date: "$Date$"
	revision: "$Revision$"

-- Fixed_info -> File_version Product_version File_flags_mask File_flags File_OS
--		 File_type File_subtype

class S_FIXED_INFO

inherit
	RB_AGGREGATE

feature 

	construct_name: STRING is
		once
			Result := "FIXED_INFO"
		end

	production: LINKED_LIST [CONSTRUCT] is
		local
			file_version: FILE_VERSION
			product_version: PRODUCT_VERSION
			file_flags_mask: FILE_FLAGS_MASK
			file_flags: FILE_FLAGS
			fileOS :FILE_OS
                        file_type: FILE_TYPE
			file_subtype: FILE_SUBTYPE
		once
			create Result.make
			Result.forth

			create file_version.make
			put (file_version)

			create product_version.make
			put (product_version)

			create file_flags_mask.make
			put (file_flags_mask)
			
			create file_flags.make
			put (file_flags)
			file_flags.set_optional

			create fileOS.make
			put (fileOS)

			create file_type.make
			put (file_type)

			create file_subtype.make
			put (file_subtype)
			file_subtype.set_optional
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
end -- class S_FIXED_INFO


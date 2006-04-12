indexing
	description: "Creator of User Defined Type Descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_USER_DEFINED_DATA_TYPE_CREATOR

inherit
	WIZARD_DATA_TYPE_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC;
				a_system_descriptor: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR is
		require
			valid_type_desc: a_type_desc /= Void
			valid_type_info: a_type_info /= Void
			valid_system_descriptor: a_system_descriptor /= Void
			valid_type_desc_type: a_type_desc.var_type = Vt_userdefined
		local
			l_handle: NATURAL_32
			l_index: INTEGER
			tmp_type_info: ECOM_TYPE_INFO
			tmp_guid: ECOM_GUID
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			type := a_type_desc.var_type

			l_handle := a_type_desc.href_type
			tmp_type_info := a_type_info.type_info (l_handle)
			l_index := tmp_type_info.index_in_type_lib + 1
			type_descriptor_index := l_index
			tmp_type_lib := tmp_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid
			if a_system_descriptor.has_library (tmp_guid) then
				tmp_library_descriptor := a_system_descriptor.library_descriptor (tmp_guid)
			else
				create tmp_library_descriptor.make (tmp_type_lib)
				a_system_descriptor.add_library_descriptor (tmp_library_descriptor)
				tmp_library_descriptor.generate
			end

			library_descriptor := tmp_library_descriptor

			create Result.make (Current)
		ensure
			valid_result: Result /= Void and then Result.type_descriptor_index /= 0
					and Result.library_descriptor /= Void and Result.type = Vt_userdefined
		end

	initialize_descriptor (a_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR) is
			-- Initialize `a_descriptor' attributes
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_type (type)
			a_descriptor.set_type_descriptor_index (type_descriptor_index)
			a_descriptor.set_library_descriptor (library_descriptor)
		end

feature {NONE} -- Implementation

	type_descriptor_index: INTEGER
			-- Index of type_descriptor in `descriptors' array
			-- of WIZARD_TYPE_LIBRARY_DESCRIPTOR

	library_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR;
			-- Description of type library

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
end -- class WIZARD_USER_DEFINED_DATA_TYPE_CREATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------


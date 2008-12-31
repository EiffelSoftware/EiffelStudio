note
	description: "Creator of Pointed Type Descriptors"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_POINTED_DATA_TYPE_CREATOR

inherit
	WIZARD_DATA_TYPE_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES

feature -- Basic operations

	create_descriptor (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC; 
				a_system_description: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_POINTED_DATA_TYPE_DESCRIPTOR
		require
			valid_type_desc: a_type_desc /= Void
			valid_type_desc_type: is_ptr (a_type_desc.var_type)
		do
			type := a_type_desc.var_type
			pointed_data_type_descriptor := data_type_descriptor_factory.create_data_type_descriptor (a_type_info, 
						a_type_desc.type_desc, a_system_description)
			create Result.make (Current)
		ensure
			valid_result: Result /= Void and then is_ptr (Result.type)
		end

	initialize_descriptor (a_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR)
			-- Initialize `a_descriptor' attributes.
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_type (type)
			a_descriptor.set_pointed_descriptor (pointed_data_type_descriptor)
		end

feature {NONE} -- Implementation

	pointed_data_type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
			-- Description of array element type

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
end -- class WIZARD_POINTED_DATA_TYPE_CREATOR



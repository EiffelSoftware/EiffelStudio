indexing
	description: "Factory of WIZARD_DATA_TYPE_DESCRIPTOR"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DATA_TYPE_DESCRIPTOR_FACTORY

inherit
	ECOM_VAR_TYPE
		export
			{NONE} all
		end

feature -- Basic operations

	create_data_type_descriptor (a_type_info: ECOM_TYPE_INFO; a_type_desc: ECOM_TYPE_DESC; 
				a_system_description: WIZARD_SYSTEM_DESCRIPTOR): WIZARD_DATA_TYPE_DESCRIPTOR is
			-- Create 'Result' according to type
		local
			l_var_type: INTEGER
			l_automation_creator: WIZARD_AUTOMATION_DATA_TYPE_CREATOR 
			l_pointed_creator: WIZARD_POINTED_DATA_TYPE_CREATOR 
			l_safearray_creator: WIZARD_SAFEARRAY_DATA_TYPE_CREATOR 
			l_array_creator: WIZARD_ARRAY_DATA_TYPE_CREATOR 
			l_user_defined_creator: WIZARD_USER_DEFINED_DATA_TYPE_CREATOR 
		do
			l_var_type := a_type_desc.var_type
			if is_user_defined (l_var_type) then
				create l_user_defined_creator
				Result := l_user_defined_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_carray (l_var_type) then
				create l_array_creator
				Result := l_array_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_ptr (l_var_type) then
				create l_pointed_creator
				Result := l_pointed_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			elseif is_safearray (l_var_type) then
				create l_safearray_creator
				Result := l_safearray_creator.create_descriptor (a_type_info, a_type_desc, a_system_description)
			else
				create l_automation_creator
				Result := l_automation_creator.create_descriptor (a_type_desc)
			end
			if is_iunknown (l_var_type) then
				a_system_description.set_iunknown
			end
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
end -- class WIZARD_DATA_TYPE_DESCRIPTOR_FACTORY

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


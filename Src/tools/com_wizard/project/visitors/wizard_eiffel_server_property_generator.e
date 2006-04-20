indexing
	description: "Eiffel server property generator."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR

inherit
	WIZARD_EIFFEL_EFFECTIVE_PROPERTY_GENERATOR

create
	generate

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate access and setting features from property.
		local
			access_name, setting_name, an_argument, a_comment, tmp_string: STRING
			visitor: WIZARD_DATA_TYPE_VISITOR
		do
			create access_feature.make
			create setting_feature.make
			create changed_names.make (2)

			if a_descriptor.is_renamed_in (a_component_descriptor) then
				property_renamed := True
				access_name := a_descriptor.component_eiffel_name (a_component_descriptor)
				changed_names.put (access_name, a_descriptor.interface_eiffel_name)

				create tmp_string.make (100)
				tmp_string.append (Set_clause)
				tmp_string.append (a_descriptor.interface_eiffel_name)

				create setting_name.make (100)
				setting_name.append (Set_clause)
				setting_name.append (access_name)
				changed_names.put (setting_name, tmp_string)
			else
				access_name := a_descriptor.interface_eiffel_name
				
				create setting_name.make (100)
				setting_name.append (Set_clause)
				setting_name.append (access_name)
			end
		
			access_feature.set_name (access_name)
			visitor := a_descriptor.data_type.visitor 

			access_feature.set_result_type (visitor.eiffel_type)
			access_feature.set_comment (a_descriptor.description)
			access_feature.set_attribute

			-- Setting feature name
			setting_feature.set_name (setting_name)

			-- Set arguments
			create an_argument.make (100)
			an_argument.append (An_item_variable)
			an_argument.append (Colon)
			an_argument.append (Space)
			an_argument.append (visitor.eiffel_type)
			setting_feature.add_argument (an_argument)

			-- Set description
			create a_comment.make (100)
			a_comment.append ("Set %'")
			a_comment.append (access_name)
			a_comment.append ("%' with %'an_item%'")
			setting_feature.set_comment (a_comment)
			
			setting_feature.set_effective
			setting_feature.set_body (Empty_function_body)		
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
end -- class WIZARD_EIFFEL_SERVER_PROPERTY_GENERATOR

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


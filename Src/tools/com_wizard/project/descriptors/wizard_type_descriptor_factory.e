indexing
	description: "Type descriptor factory"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TYPE_DESCRIPTOR_FACTORY

inherit
	ECOM_TYPE_KIND
		export
			{NONE} all
		end

	ECOM_TYPE_FLAGS
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_DATA
		export
			{NONE} all
		end

	ANY

feature -- Basic operations

	create_type_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_TYPE_DESCRIPTOR is
			-- Create type descriptor according to its type
		require
			valid_type_info: a_type_info /= Void
		local
			type: INTEGER
			Alias_creator: WIZARD_ALIAS_DESCRIPTOR_CREATOR
			Enum_creator: WIZARD_ENUM_DESCRIPTOR_CREATOR
			Record_creator: WIZARD_RECORD_DESCRIPTOR_CREATOR
			Interface_creator: WIZARD_INTERFACE_DESCRIPTOR_CREATOR
			Coclass_creator: WIZARD_COCLASS_DESCRIPTOR_CREATOR
		do
			type := a_type_info.type_attr.type_kind
			if type = Tkind_enum then
				create Enum_creator
				Result := Enum_creator.create_descriptor (a_documentation, a_type_info)
			elseif type = Tkind_record then
				create Record_creator
				Result := Record_creator.create_descriptor (a_documentation, a_type_info)
			elseif type = Tkind_interface then
				create Interface_creator
				Result := Interface_creator.create_descriptor (a_documentation, a_type_info)
			elseif type = Tkind_dispatch then
				create Interface_creator
				Result := Interface_creator.create_descriptor (a_documentation, a_type_info)
			elseif type = Tkind_coclass then
				create Coclass_creator
				Result := Coclass_creator.create_descriptor (a_documentation, a_type_info)
			elseif type = Tkind_alias then
				create Alias_creator
				Result := Alias_creator.create_descriptor (a_documentation, a_type_info)
			elseif type = Tkind_union then
				create Record_creator
				Result := Record_creator.create_descriptor (a_documentation, a_type_info)
			elseif type = Tkind_module then
				-- do nothing
			end
			if Result /= Void then
				message_output.add_message (Result.creation_message)
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
end -- class WIZARD_TYPE_DESCRIPTOR_FACTORY



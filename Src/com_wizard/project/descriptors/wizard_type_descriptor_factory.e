indexing
	description: "Type descriptor factory"
	status: "See notice at end of class"
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

end -- class WIZARD_TYPE_DESCRIPTOR_FACTORY

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


indexing
	description: "Type descriptor factory"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TYPE_DESCRIPTOR_FACTORY

inherit
	WIZARD_MESSAGE_OUTPUT
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

feature -- Basic operations

	create_type_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_TYPE_DESCRIPTOR is
			-- Create type descriptor according to its type
		require
			valid_type_info: a_type_info /= Void
		local
			type: INTEGER
		do
			type := a_type_info.type_attr.type_kind
			if type = Tkind_enum then
				create Enum_creator
				Result := Enum_creator.create_descriptor 
					(a_documentation, a_type_info)
			elseif type = Tkind_record then
				create Record_creator
				Result := Record_creator.create_descriptor  
					(a_documentation, a_type_info)
			elseif type = Tkind_interface then
				create Interface_creator
				Result := Interface_creator.create_descriptor 
					(a_documentation, a_type_info)
			elseif type = Tkind_dispatch then
				create Interface_creator
				Result := Interface_creator.create_descriptor 
					(a_documentation, a_type_info)
			elseif type = Tkind_coclass then
				create Coclass_creator
				Result := Coclass_creator.create_descriptor 
					(a_documentation, a_type_info)
			elseif type = Tkind_alias then
				create Alias_creator
				Result := Alias_creator.create_descriptor 
					(a_documentation, a_type_info)
			elseif type = Tkind_union then
				create Union_creator
				Result := Union_creator.create_descriptor 
					(a_documentation, a_type_info)
			elseif type = Tkind_module then
				add_warning (Current, Type_info_module)
			end
			if Result /= Void then
				add_message (Current, Result.creation_message)
			else
				--
			end
		end	

feature {NONE} -- Implementation

	Alias_creator: WIZARD_ALIAS_DESCRIPTOR_CREATOR 
--		once
--			create Result
--		end

	Enum_creator: WIZARD_ENUM_DESCRIPTOR_CREATOR 
--		once
--			create Result
--		end

	Record_creator: WIZARD_RECORD_DESCRIPTOR_CREATOR 
--		once
--			create Result
--		end

	Interface_creator: WIZARD_INTERFACE_DESCRIPTOR_CREATOR 
--		once
--			create Result
--		end

	Coclass_creator: WIZARD_COCLASS_DESCRIPTOR_CREATOR 
--		once
--			create Result
--		end

	Union_creator: WIZARD_UNION_DESCRIPTOR_CREATOR 
--		once
--			create Result
--		end

end -- class WIZARD_TYPE_DESCRIPTOR_FACTORY

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


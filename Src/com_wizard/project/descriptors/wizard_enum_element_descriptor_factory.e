indexing
	description: "Factory of Enumeration Element Descriptors"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; 
					a_value: INTEGER): WIZARD_ENUM_ELEMENT_DESCRIPTOR is
			-- Create description of element of enumerartion
		require
			valid_documentaion: a_documentation /= Void and then
				a_documentation.name /= Void
		do
			name := name_for_feature_with_keyword_check (a_documentation.name)
			name.put (name.item (1).upper, 1)
			value := a_value
			description := a_documentation.doc_string

			create Result.make (Current)
		ensure
			valid_name: not name.is_empty
			valid_value: value = a_value
		end

	initialize_descriptor (a_descriptor: WIZARD_ENUM_ELEMENT_DESCRIPTOR) is
			-- Initialize `a_descriptor' fields
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			a_descriptor.set_value (value)
			a_descriptor.set_description (description)
		end

feature {NONE} -- Implementation

	name: STRING
			-- element name

	value: INTEGER
			-- element value

	description: STRING
			-- help string

end -- class WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY

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


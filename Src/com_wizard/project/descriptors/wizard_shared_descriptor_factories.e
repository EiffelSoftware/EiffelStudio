indexing
	description: "Shared Factories of descriptors"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_DESCRIPTOR_FACTORIES

feature -- Access

	Data_type_descriptor_factory: WIZARD_DATA_TYPE_DESCRIPTOR_FACTORY is	
			-- Data type descriptor factory
		once
			create Result
		end

	Type_descriptor_factory: WIZARD_TYPE_DESCRIPTOR_FACTORY is
			-- Type descriptor main factory
		once
			create Result
		end

	Record_field_descriptor_factory: WIZARD_RECORD_FIELD_DESCRIPTOR_FACTORY is
			-- Record field descriptor factory
		once
			create Result
		end

	Enum_element_factory: WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY is
			-- Enumeration descriptor factory
		once
			create Result
		end

	Parameter_descriptor_factory: WIZARD_PARAMETER_DESCRIPTOR_FACTORY	is
			-- Parameter descriptor factory
		once
			create Result
		end

end -- class WIZARD_SHARED_DESCRIPTOR_FACTORIES

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


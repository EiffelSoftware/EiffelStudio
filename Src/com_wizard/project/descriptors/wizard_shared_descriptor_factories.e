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

	Function_descriptor_factory: WIZARD_FUNCTION_DESCRIPTOR_FACTORY is
			-- Function descriptor factory
		once
			create Result
		end

	Parameter_descriptor_factory: WIZARD_PARAMETER_DESCRIPTOR_FACTORY	is
			-- Parameter descriptor factory
		once
			create Result
		end

	Property_descriptor_factory: WIZARD_PROPERTY_DESCRIPTOR_FACTORY is
			-- Property descriptor factory
		once
			create Result
		end

end -- class WIZARD_SHARED_DESCRIPTOR_FACTORIES

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


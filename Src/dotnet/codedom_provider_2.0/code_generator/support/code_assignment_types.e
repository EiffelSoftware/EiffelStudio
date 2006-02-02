indexing
	description: "Assignment types"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_ASSIGNMENT_TYPES

feature -- Access

	Default_assignment: INTEGER is 1
			-- Assignment target is neither a field nor a property
	
	Property_assignment: INTEGER is 2
			-- Assignment target is a property
	
	Field_assignment: INTEGER is 3
			-- Assignment target is a field

	Array_assignment: INTEGER is 4
			-- Assignment target is an array element

feature -- Status Report

	is_valid_assignment_type (a_value: INTEGER): BOOLEAN is
			-- Is `a_value' a valid assignment type?
		do
			Result := a_value = Default_assignment or a_value = Property_assignment or a_value = Field_assignment or a_value = Array_assignment
		ensure
			definition: Result = (a_value = Default_assignment or a_value = Property_assignment or a_value = Field_assignment or a_value = Array_assignment)
		end

invariant
	default_assignment_is_valid: is_valid_assignment_type (Default_assignment)
	property_assignment_is_valid: is_valid_assignment_type (Property_assignment)
	field_assignment_is_valid: is_valid_assignment_type (Field_assignment)
	array_assignment_is_valid: is_valid_assignment_type (Array_assignment)

end -- class CODE_ASSIGNMENT_TYPES

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
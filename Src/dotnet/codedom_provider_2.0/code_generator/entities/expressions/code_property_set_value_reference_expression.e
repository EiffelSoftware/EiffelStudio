indexing 
	description: "Eiffel representation of a CodeDom property set value reference expression"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_property_type: CODE_TYPE_REFERENCE) is
			-- Creation routine
		require
			non_void_property_type: a_property_type /= Void
		do
			property_type := a_property_type
		ensure
			property_type_set: property_type = a_property_type
		end
		
feature -- Access
			
	property_type: CODE_TYPE_REFERENCE
			-- Associated property type

	code: STRING is
			-- | Result C# := "value"
			-- Eiffel code of property set value reference expression
		do
			Result := "value"
		end
		
feature -- Status Report
	
	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := property_type
		end

invariant
	non_void_property_type: property_type /= Void

end -- class CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
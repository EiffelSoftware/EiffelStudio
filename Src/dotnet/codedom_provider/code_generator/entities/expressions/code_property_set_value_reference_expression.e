indexing 
	-- Eiffel representation of a CodeDom property set value reference expression

class
	CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION

inherit
	CODE_REFERENCE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Creation routine
		do
			create arguments.make
		end
		
feature -- Access
			
	code: STRING is
			-- | Result C# := "value"
			-- Eiffel code of property set value reference expression
		do
			Result := ("value").twin
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is property reference expression ready to be generated?
		do
			Result := True
		end
	
	type: TYPE is
			-- Type
		do
			Result := Void
		end

end -- class CODE_PROPERTY_SET_VALUE_REFERENCE_EXPRESSION

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
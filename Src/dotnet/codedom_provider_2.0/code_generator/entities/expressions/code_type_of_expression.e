indexing 
	description: "Source code generator for type of expressions"
	date: "$$"
	revision: "$$"
	
class
	CODE_TYPE_OF_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target: like target) is
			-- Creation routine
		require
			non_void_target: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end
		
feature -- Access

	target: CODE_TYPE_REFERENCE
			-- Type of expression target
			
	code: STRING is
			-- | Result := "{TYPE_NAME}"
			-- | Result C# := "typeof(`type_name')"
			-- Eiffel code of `type of' expression
		do
			create Result.make (120)
			Result.append ("{")
			Result.append (target.eiffel_name)
			Result.append ("}")
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := Type_type_reference
		end

invariant
	non_void_target: target /= Void
	
end -- class CODE_TYPE_OF_EXPRESSION

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
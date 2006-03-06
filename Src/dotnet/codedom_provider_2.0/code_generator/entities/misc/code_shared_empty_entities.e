indexing
	description: "Empty entities used when CodeDom tree is corrupted"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_SHARED_EMPTY_ENTITIES

inherit
	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_CONSTANTS
		export
			{NONE} all
		end

feature -- Access

	Empty_snippet_feature: CODE_SNIPPET_FEATURE is
			-- Empty snippet feature
		once
			create Result.make ("empty_", "empty_ is do end" + Line_return)
		end

	Empty_attribute: CODE_ATTRIBUTE is
			-- Empty attribute
		once
			create Result.make ("empty_", "empty_")
			Result.set_result_type (Empty_type_reference)
		end

	Empty_routine: CODE_ROUTINE is
			-- Empty routine
		once
			create {CODE_ROUTINE_IMP} Result.make ("empty_", "empty_")
		end

	Empty_type_reference: CODE_TYPE_REFERENCE is
			-- Empty type reference
		local
			l_member_reference: CODE_MEMBER_REFERENCE
		once
			Result := None_type_reference
			create l_member_reference.make ("empty_", None_type_reference, False)
			l_member_reference.set_initialized
			Result.add_member (l_member_reference)
		end
		
	Empty_member_reference: CODE_MEMBER_REFERENCE is
			-- Empty member reference
		once
			Result := Empty_type_reference.member ("empty_", Void)
		end
	
	Empty_expression: CODE_EXPRESSION is
			-- Empty expression
		once
			create {CODE_PRIMITIVE_EXPRESSION} Result.make (("").to_cil)
		end

end -- class CODE_SHARED_EMPTY_ENTITIES

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
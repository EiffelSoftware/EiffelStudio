indexing 
	description: "Source code generator for type reference expressions"
	date: "$$"
	revision: "$$"	

class
	ECDP_TYPE_REFERENCE_EXPRESSION

inherit
	ECDP_REFERENCE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `type'.
		do
			create arguments.make
			create referred_type.make_empty
		ensure
			non_void_referred_type: referred_type /= Void
		end
		
feature -- Access

	referred_type: STRING
			-- Type which is referred to

	code: STRING is
			-- | Result := "`referred_type'"
			-- Eiffel code of type reference expression
		do
			Result := Resolver.eiffel_type_name (referred_type).twin
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is type reference expression ready to be generated?
		do
			Result := True
		end

	type: TYPE is
			-- Type
		do
			Result := referenced_type_from_name (referred_type)
		end

feature -- Status Setting

	set_referred_type (a_referred_type: like referred_type) is
			-- Set `referred_type' with `a_referred_type'.
		require
			non_void_referred_type: a_referred_type /= Void
			not_empty_referred_type: not a_referred_type.is_empty
		do
			referred_type := a_referred_type
		ensure
			referred_type_set: referred_type = a_referred_type
		end		

invariant
	non_void_referred_type: referred_type /= Void
	
end -- class ECDP_TYPE_REFERENCE_EXPRESSION

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
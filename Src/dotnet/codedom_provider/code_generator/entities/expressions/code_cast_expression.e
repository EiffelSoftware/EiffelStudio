indexing 
	description: "Source code generator for cast expression"
	date: "$$"
	revision: "$$"

class
	CODE_CAST_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_target_type: like target_type; a_source: CODE_EXPRESSION) is
			-- Initialize `target_type'.
		require
			non_void_target_type: a_target_type /= Void
			non_void_source: a_source /= Void
		do
			target_type := a_target_type
			source := a_source
		ensure
			target_type_set: target_type = a_target_type
			source_set: source = a_source
		end
		
feature -- Access

	source: CODE_EXPRESSION
			-- Expression to cast
			
	target_type: CODE_TYPE_REFERENCE
			-- Key from CODE_generated_types table to cast type
			
	code: STRING is
			-- | Result := " ?= `expression_to_cast'"
			-- Eiffel code of cast expression
		do
			Result := source.code
		end
		
feature -- Status Report
		
	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := target_type
		end
		
invariant
	non_void_target_type: target_type /= Void
	non_void_source: source /= Void
	
end -- class CODE_CAST_EXPRESSION

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
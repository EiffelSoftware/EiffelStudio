indexing 
	description: "Source code generator for cast expression"
	date: "$$"
	revision: "$$"

class
	ECD_CAST_EXPRESSION

inherit
	ECD_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `target_type'.
		do
			create target_type.make_empty
		ensure
			non_void_target_type: target_type /= Void
		end
		
feature -- Access

	expression_to_cast: ECD_EXPRESSION
			-- Expression to cast
			
	target_type: STRING
			-- Key from ECD_generated_types table to cast type
			
	code: STRING is
			-- | Result := " ?= `expression_to_cast'"
			-- Eiffel code of cast expression
		do
			Check
				not_empty_type: not target_type.is_empty
				non_void_expression: expression_to_cast /= Void
			end
		
			create Result.make (80)
			Result.append (expression_to_cast.code)
		end
		
feature -- Status Report
		
	ready: BOOLEAN is
			-- Is cast expression ready to be generated?
		do
			Result := expression_to_cast /= Void and then expression_to_cast.ready
		end

	type: TYPE is
			-- Type
		do
			Result := referenced_type_from_name (target_type)
		end

feature -- Status Setting

	set_expression_to_cast (an_expression: like expression_to_cast) is
			-- Set `expression_to_cast' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			expression_to_cast := an_expression
		ensure
			expression_to_cast_set: expression_to_cast = an_expression
		end		
		
	set_target_type (a_type: like target_type) is
			-- Set `target_type' with `a_type'.
		require
			non_void_type: a_type /= Void
		do
			target_type := a_type
		ensure
			target_type_set: target_type = a_type
		end		
		
invariant
	non_void_target_type: target_type /= Void
	
end -- class ECD_CAST_EXPRESSION

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
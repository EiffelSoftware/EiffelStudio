indexing
	description: "Source code generator for assignment attempt"
	date: "$$"
	revision: "$$"

class
	ECDP_ASSIGNMENT_ATTEMPT_STATEMENT

inherit
	ECDP_STATEMENT

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `expression' and `target_object'.
		do
			create target_object.make_empty
		ensure
			non_void_target_object: target_object /= Void
		end
		
feature -- Access

	expression_to_cast: ECDP_EXPRESSION
			-- Expression to cast
			
	target_object: STRING
			-- Key to corresponding cast target type in ECDP_generatd_type
			
	code: STRING is
			-- | Result := " `target_object' ?= `expression_to_cast'"
			-- Eiffel code of cast expression
		do
			Check
				not_empty_type: not target_object.is_empty
				non_void_expression: expression_to_cast /= Void
			end
		
			create Result.make (80)
			Result.append (indent_string)
			Result.append (target_object)
			Result.append (" ?= ")
			Result.append (expression_to_cast.code)
			Result.append (Dictionary.New_line)
		end
		
feature -- Status Report
		
	ready: BOOLEAN is
			-- Is cast expression ready to be generated?
		do
			Result := expression_to_cast /= Void and then expression_to_cast.ready
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
		
	set_target_object (an_object: like target_object) is
			-- Set `target_object' with `an_object'.
		require
			non_void_an_object: an_object /= Void
		do
			target_object := an_object
		ensure
			target_object_set: target_object = an_object
		end		
		
invariant
	non_void_target_object: target_object /= Void

end -- class ECDP_ASSIGNMENT_ATTEMPT_STATEMENT

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
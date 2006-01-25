indexing 
	description: "Source code generator for argument declaration expressions"
	date: "$$"
	revision: "$$"

class
	CODE_PARAMETER_DECLARATION_EXPRESSION

inherit
	CODE_EXPRESSION

	CODE_DIRECTIONS

create
	make

feature {NONE} -- Initialization

	make (a_variable: CODE_VARIABLE_REFERENCE; a_direction: INTEGER) is
			-- Initialize `variable'.
		require
			non_void_variable: a_variable /= Void
			valid_direction: is_valid_direction (a_direction)
		do
			variable := a_variable
			direction := a_direction
		ensure
			variable_set: variable = a_variable
			direction_set: direction = a_direction
		end
		
feature -- Access

	variable: CODE_VARIABLE_REFERENCE
			-- Corresponding variable

	direction: INTEGER
			-- Argument direction

	code: STRING is
			-- | Result := "`name': `SYSTEM_TYPE'"
			-- | or Result := "`name': TYPED_POINTER [`SYSTEM_TYPE']" if direction is out or inout
			-- Eiffel code of argument declaration expression
		local
			l_byref: BOOLEAN
		do
			create Result.make (120)
			Result.append (variable.eiffel_name)
			Result.append (": ")
			l_byref := direction = out_argument or direction = inout_argument
			if l_byref then
				Result.append ("TYPED_POINTER [")
			end
			Result.append (variable.type.eiffel_name)
			if l_byref then
				Result.append ("]")
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := variable.type
		end
		
invariant
	non_void_variable: variable /= Void
	valid_direction: is_valid_direction (direction)

end -- class CODE_ARGUMENT_DECLARATION_EXPRESSION

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
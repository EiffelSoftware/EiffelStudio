indexing
	description: "Eiffel representation of CodeDom assign statement"
	date: "$$"
	revision: "$$"	

class
	CODE_ASSIGN_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_source, a_target: CODE_EXPRESSION; a_is_property_assignment: BOOLEAN) is
			-- Initialize `target', `source' and `is_property_assignment'.
		require
			non_void_source: a_source /= Void
			non_void_target: a_target /= Void
		do
			source := a_source
			target := a_target
			is_property_assignment := a_is_property_assignment
		ensure
			source_set: source = a_source
			target_set: target = a_target
			is_propety_assignment_set: is_property_assignment = a_is_property_assignment
		end
		
feature -- Access

	target: CODE_EXPRESSION
			-- Assignment target
	
	source: CODE_EXPRESSION
			-- Assignment source

	is_property_assignment: BOOLEAN
			-- is property assignement?

	code: STRING is
			-- | Result := "`target' := `source'"
			-- | OR		:= "`target'(`source')" if `is_property_assignement'.
			-- | OR		:= "`source.expression'" if `source' is `CODE_OBJECT_CREATE_EXPRESSION' or `CODE_ARRAY_CREATE_EXPRESSION'.
			-- | Set `new_line' to false
			-- Eiffel code of assign statement
		local
			create_expression: CODE_OBJECT_CREATE_EXPRESSION
			create_array_expression: CODE_ARRAY_CREATE_EXPRESSION
		do
			create Result.make (120)
			Result.append (Indent_string)
			set_new_line (False)
			if is_property_assignment then
				Result.append (target.code)
				Result.append (" (")
				Result.append (source.code)
				Result.append_character (')')
			else
				create_expression ?= source
				if create_expression /= Void then
					--TODO: check for valid target expressions (codevariablereference etc...)
					create_expression.set_target (target.code)
					Result.append (create_expression.code)
				else
					create_array_expression ?= source
					if create_array_expression /= Void then
					--TODO: check for valid target expressions (codevariablereference etc...)
						create_array_expression.set_target (target.code)
						Result.append (create_array_expression.code)
					else	
						Result.append (target.code)
						Result.append (" := ")
						Result.append (source.code)
					end
				end
			end
			Result.append_character ('%N')
		end

end -- class CODE_ASSIGN_STATEMENT

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
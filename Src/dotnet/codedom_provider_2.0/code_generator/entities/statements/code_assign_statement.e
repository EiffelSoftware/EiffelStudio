indexing
	description: "Eiffel representation of CodeDom assign statement"
	date: "$$"
	revision: "$$"

class
	CODE_ASSIGN_STATEMENT

inherit
	CODE_STATEMENT

	CODE_ASSIGNMENT_TYPES
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_target, a_source: CODE_EXPRESSION; a_assignment_type: INTEGER) is
			-- Initialize `target', `source' and `is_property_assignment'.
		require
			non_void_source: a_source /= Void
			non_void_target: a_target /= Void
			valid_assignment_type: is_valid_assignment_type (a_assignment_type)
		do
			source := a_source
			target := a_target
			assignment_type := a_assignment_type
		ensure
			source_set: source = a_source
			target_set: target = a_target
			assignment_type_set: assignment_type = a_assignment_type
		end

feature -- Access

	target: CODE_EXPRESSION
			-- Assignment target

	source: CODE_EXPRESSION
			-- Assignment source

	assignment_type: INTEGER
			-- See class {CODE_ASSIGNMENT_TYPES} for possible values

	code: STRING is
			-- | Result := "`target' := `source'"
			-- | OR		:= "`target'(`source')" if `is_property_assignement' or `is_array_assignment'.
			-- | OR		:= "`source.expression'" if `source' is `CODE_OBJECT_CREATE_EXPRESSION' or `CODE_ARRAY_CREATE_EXPRESSION'.
			-- | Set `new_line' to false
			-- Eiffel code of assign statement
		local
			create_expression: CODE_OBJECT_CREATE_EXPRESSION
			create_array_expression: CODE_ARRAY_CREATE_EXPRESSION
			l_field_set: BOOLEAN
			l_field_expression: CODE_ATTRIBUTE_REFERENCE_EXPRESSION
		do
			create Result.make (120)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
			end
			Result.append (Indent_string)
			set_new_line (False)
			if assignment_type = Field_assignment then
				l_field_expression ?= target
				check
					is_field: l_field_expression /= Void
				end
				l_field_set := not l_field_expression.is_in_current
			end
			if assignment_type = Property_assignment or l_field_set then
				Result.append (target.code)
				Result.append (" (")
				Result.append (source.code)
				Result.append_character (')')
			elseif assignment_type = Array_assignment then
				Result.append (target.code)
				Result.append (", ")
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
			Result.append (Line_return)
		end

	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := False
		end

invariant
	valid_assignment_type: is_valid_assignment_type (assignment_type)

end -- class CODE_ASSIGN_STATEMENT

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

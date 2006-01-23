indexing
	description: "Eiffel representation of CodeDom assign statement"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			-- | OR		:= "`target'(`source')" if `is_property_assignement'.
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

	need_dummy: BOOLEAN is
			-- Does statement require dummy local variable?
		do
			Result := False
		end

invariant
	valid_assignment_type: is_valid_assignment_type (assignment_type)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


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
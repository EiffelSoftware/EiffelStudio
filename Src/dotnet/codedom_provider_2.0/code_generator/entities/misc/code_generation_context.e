indexing
	description: "Contains contextual information required to generate Eiffel code"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_GENERATION_CONTEXT

feature -- Access

	dummy_variable: BOOLEAN is
			-- Do we need a dummy variable?
		do
			Result := Dummy_variable_cell.item
		end

	new_line: BOOLEAN is
			-- is it a new line?
		do 
			Result := New_line_cell.item
		end

	tabulation_string: STRING is
			-- String used for indentation
		do 
			Result := Tabulation_string_cell.item
		ensure
			non_void_tabulation_string: Result /= Void
		end

	blank_lines_between_members: BOOLEAN is
			-- Should features be separated with blank lines?
		do
			Result := Blank_lines_between_members_cell.item			
		end
		
	else_on_closing: BOOLEAN is
			-- Should all if's be followed by a 'else' instruction?
		do
			Result := Else_on_closing_cell.item			
		end
	
	indent_string: STRING is
			-- Indentation string
		do
			Result := Indent_string_cell.item
		end

feature -- Element Settings

	set_blank_lines_between_members (a_value: like blank_lines_between_members) is
			-- Set `blank_lines_between_members' with `a_value'.
		do
			Blank_lines_between_members_cell.set_item (a_value)
		ensure
			blank_lines_between_members_set: blank_lines_between_members.is_equal (a_value)
		end
		
	set_else_on_closing (a_value: like else_on_closing) is
			-- Set `else_on_closing' with `a_value'.
		do
			Else_on_closing_cell.set_item (a_value)
		ensure
			else_on_closing_set: else_on_closing.is_equal (a_value)
		end
		
	set_indent_string (a_value: like indent_string) is
			-- Set `indent_string' with `a_value'.
		require
			non_void_indent_string: a_value /= Void
		do
			Indent_string_cell.put (a_value)
		ensure
			indent_string_set: indent_string.is_equal (a_value)
		end

	set_new_line (a_bool: like new_line) is
			-- Set `new_line' with `a_bool'.
		do
			New_line_cell.set_item (a_bool)
		ensure
			new_line_set: new_line = a_bool
		end

	set_dummy_variable (a_bool: like new_line) is
			-- Set `new_line' with `a_bool'.
		do
			Dummy_variable_cell.set_item (a_bool)
		ensure
			dummy_variable_set: dummy_variable = a_bool
		end

	increase_tabulation is
			-- add a tabulation to `indent_string'.
		local
			l_indent: STRING
		do
			create l_indent.make (Indent_string.count + Tabulation_string.count)
			l_indent.append (Indent_string)
			l_indent.append (Tabulation_string)
			Indent_string_cell.put (l_indent)
		ensure
			indent_set: indent_string.is_equal (old indent_string + Tabulation_string)
		end

	decrease_tabulation is
			-- Substract last character (a tabulation) from `indent_string'.
		require
			at_least_one_indent: indent_string.count > 0
		do
			Indent_string_cell.item.remove_tail (Tabulation_string.count)
		ensure
			indent_set: indent_string.is_equal ((old indent_string).substring (1, (old indent_string.count) - Tabulation_string.count))
		end

feature {NONE} -- Implementation

	Blank_lines_between_members_cell: BOOLEAN_REF is
			-- Shell for `blank_lines_between_members'
		once
			create Result
			Result.set_item (True)
		ensure
			cell_created: Result /= Void
		end
		
	Else_on_closing_cell: BOOLEAN_REF is
			-- Shell for `else_on_closing'
		once
			create Result
		ensure
			cell_created: Result /= Void
		end
		
	Tabulation_string_cell: CELL [STRING] is
			-- Shell for `tabulation_string'
		once
			create Result.put ("%T")
		ensure
			cell_created: Result /= Void
		end
		
	New_line_cell: BOOLEAN_REF is
			-- Shell for `new_line'
		once
			create Result
		ensure
			cell_created: Result /= Void
		end

	Dummy_variable_cell: BOOLEAN_REF is
			-- Shell for `dummy_variable'
		once
			create Result
		ensure
			cell_created: Result /= Void
		end

	Indent_string_cell: CELL [STRING] is
		-- Shell for `indent_string'
		once
			create Result.put ("")
		ensure
			cell_created: Result /= Void
		end

end -- class CODE_GENERATION_CONTEXT

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
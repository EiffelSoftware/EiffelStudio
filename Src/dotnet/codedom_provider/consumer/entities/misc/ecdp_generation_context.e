indexing
	description: "Contains contextual information required to generate Eiffel code"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_GENERATION_CONTEXT

feature -- Access

	from_eiffel: BOOLEAN
			-- Was Dom generated from Eiffel code?
			--| This value is set per entity (namespace or compile unit)

	dummy_variable: BOOLEAN is
			-- Do we need a dummy variable?
		do
			Result := internal_dummy_variable.item
		end

	new_line: BOOLEAN is
			-- is it a new line?
		do 
			Result := internal_new_line.item
		end

	indent_string: STRING is
			-- String used for indentation
		do 
			Result := internal_indent_string.item
		ensure
			non_void_indent_string: Result /= Void
		end

feature -- Status Setting

	set_from_eiffel (a_bool: like from_eiffel) is
			-- Set `from_eiffel' with `a_bool'.
		do
			from_eiffel := a_bool
		ensure
			from_eiffel_set: from_eiffel = a_bool
		end

	set_new_line (a_bool: like new_line) is
			-- Set `new_line' with `a_bool'.
		do
			internal_new_line.put (a_bool)
		ensure
			new_line_set: new_line = a_bool
		end

	set_dummy_variable (a_bool: like new_line) is
			-- Set `new_line' with `a_bool'.
		do
			internal_dummy_variable.put (a_bool)
		ensure
			dummy_variable_set: dummy_variable = a_bool
		end

	add_tab_to_indent_string is
			-- add a tabulation to `indent_string'.
		local
			l_indent: STRING
		do
			create l_indent.make (internal_indent_string.item.count + 1)
			l_indent.append (internal_indent_string.item)
			l_indent.append ("%T")
			internal_indent_string.put (l_indent)
		ensure
			indent_set: internal_indent_string.item.is_equal (old indent_string + "%T")
		end

	sub_tab_to_indent_string is
			-- substract last character (a tabulation) from `indent_string'.
		require
			at_least_one_indent: indent_string.count > 0
		do
			internal_indent_string.item.remove_tail (1)
		end

feature {NONE} -- Implementation

	internal_new_line: CELL [BOOLEAN] is
			-- Internal representation of `new_line'.
		once
			create Result.put (false)
		ensure
			cell_created: Result /= Void
		end

	internal_dummy_variable: CELL [BOOLEAN] is
			-- Internal representation of `dummy_variable'.
		once
			create Result.put (false)
		ensure
			cell_created: Result /= Void
		end

	internal_indent_string: CELL [STRING] is
			-- Internal representation of `indent_string'.
		once
			create Result.put ("")
		ensure
			cell_created: Result /= Void
		end

end -- class ECDP_GENERATION_CONTEXT

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
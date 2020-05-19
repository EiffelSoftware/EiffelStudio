note
	description: "A code analysis violation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test"

class
	EW_CODE_ANALYSIS_VIOLATION

inherit

	EW_CODE_ANALYSIS_CONSTANTS
		redefine
			is_equal
		end

	COMPARABLE
		redefine
			is_equal
		end

	EW_STRING_UTILITIES
		redefine
			is_equal
		end

create
	make_empty, make_with_everything

feature {NONE} -- Initialization

	make_empty
		do
		end

	make_with_everything (a_class_name: STRING; a_line_number: INTEGER; a_rule_id: READABLE_STRING_32; a_type: READABLE_STRING_32; a_message: READABLE_STRING_32)
		require
			valid_type: a_type = Void or else is_valid_violation_type (a_type)
		do
			class_name := a_class_name
			line_number := a_line_number
			rule_id := a_rule_id
			type := a_type
			message := a_message
		end

feature -- Properties

		-- All of these can in principle be Void if unknown.

	class_name: detachable READABLE_STRING_8
			-- Class in which the violation occurred.

	line_number: INTEGER
			-- Line number on which the violation occurred.

	rule_id: detachable READABLE_STRING_32
			-- ID of the violated rule.

	type: detachable READABLE_STRING_32
			-- Type of the violation (hint, suggestion, warning or error).

	message: detachable READABLE_STRING_32
			-- Message of the violation.

	summary: STRING_32
		do
			create Result.make_empty
			Result.append_string (type)
			if attached class_name as c and then not c.is_empty then
				Result.append ({STRING_32} " in class ")
				Result.append_string (from_utf_8 (c))
				if line_number /= 0 then
					Result.append ({STRING_32} " at line ")
					Result.append_integer (line_number)
				end
			end
			Result.append ({STRING_32} ". ")
			Result.append_string (rule_id)
			if attached rule_id as r and then not r.is_empty and attached message as m and then not m.is_empty then
				Result.append ({STRING_32} ": ")
			end
			Result.append_string (message)
		end

feature -- Modification

	set_class_name (a_name: like class_name)
		do
			class_name := a_name
		end

	set_line_number (a_line_number: INTEGER)
		do
			line_number := a_line_number
		end

	set_rule_id (a_rule_id: like rule_id)
		do
			rule_id := a_rule_id
		end

	set_type (a_type: like type)
		require
			valid_type: a_type = Void or else is_valid_violation_type (a_type)
		do
			type := a_type
		end

	set_message (a_message: READABLE_STRING_32)
		do
			message := a_message
		end

feature -- Comparison

	matches_pattern (other: like Current): BOOLEAN
			-- Are the properties which are explicitly specified in `other'
			-- equals to those in `Current'?
		do
			Result :=
				(not attached other.class_name or else is_string_equal_safe (class_name, other.class_name)) and
				(other.line_number = 0 or else line_number = other.line_number) and
				(not attached other.rule_id or else is_string_equal_safe (rule_id, other.rule_id)) and
				(not attached other.type or else is_string_equal_safe (type, other.type)) and
				(not attached other.message or else is_string_equal_safe (message, other.message))
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result :=
				is_string_equal_safe (class_name, other.class_name) and
				line_number = other.line_number and
				is_string_equal_safe (rule_id, other.rule_id) and
				is_string_equal_safe (type, other.type) and
				is_string_equal_safe (message, other.message)
		end

	is_less alias "<" (other: like Current): BOOLEAN
		do
			if not is_string_equal_safe (rule_id, other.rule_id) then
				Result := is_string_less_safe (rule_id, other.rule_id)
			elseif not is_string_equal_safe (class_name, other.class_name) then
				Result := is_string_less_safe (class_name, other.class_name)
			elseif line_number /= other.line_number then
				Result := line_number < other.line_number
			elseif not is_string_equal_safe (type, other.type) then
				Result := is_string_less_safe (type, other.type)
			else
				Result := is_string_less_safe (message, other.message)
			end
		end

feature {NONE} -- Implementation

	is_string_less_safe (a_smaller_string, a_greater_string: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_smaller_string' less than `a_greater_string', where not being attached
			-- (Void) is considered to be the least value?
		do
				-- Void is less than any other value, but if both strings are Void we want to
				-- to return False (as the first string is not *strictly* less than the second).
			if attached a_smaller_string and attached a_greater_string then
					-- Both are attached.
					-- Use string comparison.
				Result := a_smaller_string.is_less (a_greater_string)
			else
					-- One of the strings or both are void.
					-- The only case when the first is less than the second is when the second is attached.
					-- (In this case the first is Void.)
				Result := attached a_greater_string
			end
		end

	is_string_equal_safe (a_first, a_second: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_first' the same string as `a_second' (or are they both detached)?
		do
			if attached a_first and attached a_second then
					-- Use string equality.
				Result := a_first.same_string (a_second)
			else
					-- One of values is Void.
					-- The values are equal when the second is also Void.
				Result := a_first = a_second
			end
		end

invariant
	valid_type: attached type as t implies is_valid_violation_type (t)

note
	ca_ignore: "CA011", "CA011: too many arguments"
	date: "$Date$"
	revision: "$Revision$"
	author: "Alexander Kogtenkov"
	copyright: "[
			Copyright (c) 1984-2020, University of Southern California, Eiffel Software and contributors.
			All rights reserved.
		]"
	license: "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.
			
			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.
			
			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.
			
			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
	]"

end

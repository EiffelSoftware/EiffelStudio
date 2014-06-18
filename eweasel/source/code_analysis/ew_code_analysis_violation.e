note
	description: "A code analysis violation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "Eiffel test";
	date: "05/2014"

class
	EW_CODE_ANALYSIS_VIOLATION

inherit

	EW_CODE_ANALYSIS_CONSTANTS
		undefine
			is_equal
		end

	COMPARABLE
		redefine
			is_less,
			is_equal
		end

	EW_STRING_UTILITIES
		undefine
			is_equal
		end

create
	make_empty, make_with_everything

feature {NONE} -- Initialization

	make_empty
		do
				-- We do this because this field is (virtually) an enum.
			type := unknown_violation_type
		end

	make_with_everything (a_class_name: STRING; a_line_number: INTEGER; a_rule_id, a_type, a_message: STRING)
		require
			valid_type: a_type = Void or is_valid_violation_type (a_type)
		do
			class_name := a_class_name
			line_number := a_line_number
			rule_id := a_rule_id
			type := a_type
			message := a_message
		end

feature -- Properties

		-- All of these can in principle be Void if unknown.

	class_name: STRING
			-- Class in which the violation occurred

	line_number: INTEGER
			-- Line number on which the violation occurred

	rule_id: STRING
			-- ID of the violated rule

	type: STRING
			-- Type of the violation (hint, suggestion, warning or error)

	message: STRING
			-- Message of the violation

	summary: STRING
		do
			create Result.make (0);
			Result.append_string (type);
			if not equal (class_name, "") then
				Result.append (" in class ");
				Result.append_string (class_name);
				if line_number /= 0 then
					Result.append (" at line " + line_number.out);
				end
			end;
			Result.append (". ");
			Result.append_string (rule_id)
			if rule_id /= Void and then not rule_id.is_empty and message /= Void and then not message.is_empty then
				Result.append (": ")
			end
			Result.append_string (message)
		end;

feature -- Modification

	set_class_name (a_name: STRING)
		do
			class_name := a_name
		end

	set_line_number (a_line_number: INTEGER)
		do
			line_number := a_line_number
		end

	set_rule_id (a_rule_id: STRING)
		do
			rule_id := a_rule_id
		end

	set_type (a_type: STRING)
		require
			valid_type: a_type = Void or is_valid_violation_type (a_type)
		do
			type := a_type
		end

	set_message (a_message: STRING)
		do
			message := a_message
		end

feature -- Comparison

	matches_pattern (other: like Current): BOOLEAN
			-- Are the properties which are explicitly specified in `other'
			-- equals to those in `Current'?
		do
			Result := (other.class_name = Void or else class_name.same_string (other.class_name)) and (other.line_number = 0 or else line_number.is_equal (other.line_number)) and (other.rule_id = Void or else rule_id.is_equal (other.rule_id)) and (other.type = Unknown_violation_type or else type.same_string (other.type)) and (other.message = Void or else message.same_string (other.message))
		end

	is_equal (other: like Current): BOOLEAN
		do
			Result := is_string_equal_safe (class_name, other.class_name) and line_number.is_equal (other.line_number) and is_string_equal_safe (rule_id, other.rule_id) and is_string_equal_safe (type, other.type) and is_string_equal_safe (message, other.message)
		end

	is_less alias "<" (other: like Current): BOOLEAN
		do
			if not equal (rule_id, other.rule_id) then
				Result := is_string_less_safe (rule_id, other.rule_id)
			else
				if not equal (class_name, other.class_name) then
					Result := is_string_less_safe (class_name, other.class_name)
				else
					Result := line_number < other.line_number
				end
			end
		end

feature {NONE} -- Implementation

	is_string_less_safe (a_smaller_string, a_greater_string: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_smaller_string' less than `a_greater_string', where not being attached
			-- (Void) is considered to be the least value?
		do
				-- Void is less than any other value, but if both strings are Void we want to
				-- to return False (as the first string is not *strictly* less than the second).
			if not attached a_smaller_string and attached a_greater_string then
					-- The first is Void, the second is not.
				Result := True
			elseif not attached a_smaller_string or not attached a_greater_string then
					-- Both are Void (equal), or only the second is Void.
					-- In both cases, the result is false.
				Result := False
			else
					-- Both are attached.
				Result := a_smaller_string.is_less (a_greater_string)
			end
		end

	is_string_equal_safe (a_first, a_second: detachable READABLE_STRING_GENERAL): BOOLEAN
			-- Is `a_first' the same string as `a_second' (or are they both detached)?
		do
			if a_first = Void and a_second = Void then
				Result := True
			elseif a_first = Void or a_second = Void then
				Result := False
			else
				Result := a_first.same_string (a_second)
			end
		end

invariant
	valid_type: is_valid_violation_type (type)

note
	copyright: "[
		Copyright (c) 1984-2007, University of Southern California and contributors.
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

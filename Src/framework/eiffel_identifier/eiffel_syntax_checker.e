note
	description: "Utilities relative to the Eiffel syntax"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SYNTAX_CHECKER

inherit
	SYNTAX_STRINGS

feature -- Status report

	is_valid_class_type_name (ct: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `ct' a valid class type?
			-- according to ECMA-367 Section 8.11.1
		require
			ct_not_void: ct /= Void
		do
			Result := (create {CLASS_TYPE_NAME_SYNTAX_CHECKER}).is_valid_class_type_name (ct)
		end

	is_valid_class_name (cn: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `cn' a valid class name?
		do
			Result := is_valid_identifier (cn) and then not keywords.has (cn)
		end

	is_valid_group_name (gn: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `cn' a valid group name?
		do
			Result := is_valid_config_identifier (gn)
		end

	is_valid_feature_name_32 (fn: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `fn' a valid feature name?
		local
			u: UTF_CONVERTER
		do
			Result := is_valid_feature_name (u.utf_32_string_to_utf_8_string_8 (fn))
		end

	is_valid_target_name (tn: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `tn' a valid target name?
		do
			Result := is_valid_config_identifier (tn)
		end

	is_valid_system_name (cn: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `cn' a valid system name?
		do
			Result := is_valid_config_identifier (cn)
		end

	is_valid_identifier (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a valid Eiffel identifier?
		local
			i: INTEGER
			cc: CHARACTER_32
		do
			Result := s /= Void and then not s.is_empty and then is_alpha (s.item (1))
			from
				i := 2
			until
				not Result or else i > s.count
			loop
				cc := s.item (i)
				Result := is_alpha (cc) or is_digit (cc) or cc = '_'
				i := i + 1
			end
		end

	is_valid_config_identifier (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a valid config identifier which is similar to `is_valid_identifier' but also allows the '.' and '-'?
		local
			i: INTEGER
			cc: CHARACTER_32
		do
			Result := s /= Void and then not s.is_empty and then is_alpha (s.item (1))
			from
				i := 2
			until
				not Result or else i > s.count
			loop
				cc := s.item (i)
				Result := is_alpha (cc) or is_digit (cc) or cc = '_' or cc = '.' or cc = '-'
				i := i + 1
			end
		end

	is_valid_operator (op: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `op' a valid operator name?
		obsolete
			"Use OPERATOR_SYNTAX_CHECKER from the parser library instead. [2021-11-30]"
		do
			Result := op /= Void and then (basic_operators.has (op.as_lower) or else is_valid_free_operator (op))
		end

	is_valid_binary_operator (op: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `op' a valid binary operator?
		obsolete
			"Use OPERATOR_SYNTAX_CHECKER from the parser library instead. [2021-11-30]"
		do
			Result := op /= Void and then (binary_operators.has (op.as_lower) or else is_valid_free_operator (op))
		end

	is_valid_unary_operator (op: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `op' a valid unary operator?
		obsolete
			"Use OPERATOR_SYNTAX_CHECKER from the parser library instead. [2021-11-30]"
		do
			Result := op /= Void and then (unary_operators.has (op.as_lower) or else is_valid_free_operator (op))
		end

	is_valid_free_operator (op: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `op' a valid free operator name?
			-- If `op' is a READABLE_STRING_8 instance, we treat it as UTF-8 encoded.
		obsolete
			"Use OPERATOR_SYNTAX_CHECKER from the parser library instead. [2021-11-30]"
		local
			i: INTEGER
			cc: CHARACTER_32
			l_str32: STRING_32
			u: UTF_CONVERTER
		do
			if op /= Void and then not op.is_empty then
				if attached {READABLE_STRING_8} op as l_op then
						-- We have a UTF-8 encoded string.
					l_str32 := u.utf_8_string_8_to_string_32 (l_op)
				else
					l_str32 := op.as_string_32
				end
					-- Allow Unicode codepoint greater than 255.
				Result := free_operators_start.has (op.item (1)) or l_str32 [1] > {CHARACTER_32} '%/127/'
				from
					i := 2
				until
					not Result or else i > l_str32.count
				loop
					cc := l_str32.item (i)
					Result := is_alpha (cc) or is_digit (cc) or free_operators_characters.has (cc) or cc > {CHARACTER_32} '%/127/'
					i := i + 1
				end
			end
		ensure then
			Result implies not basic_operators.has (op)
		end

	is_bracket_alias_name (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a bracket alias name?
		obsolete
			"Use OPERATOR_SYNTAX_CHECKER from the parser library instead. [2021-11-30]"
		do
			Result := s /= Void and then s.same_string (bracket_str)
		end

	is_parentheses_alias_name (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a parentheses  alias name?
		obsolete
			"Use OPERATOR_SYNTAX_CHECKER from the parser library instead. [2021-11-30]"
		do
			Result := s /= Void and then s.same_string (parentheses_str)
		end

	is_constant (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result :=
				is_integer_constant (s) or
				is_double_constant (s) or
				is_string_constant (s) or
				is_boolean_constant (s)
		end

	is_integer_constant (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_integer
		end

	is_double_constant (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_double
		end

	is_string_constant (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.count >= 2 and then (s.item (1) = '%"' and s.item (s.count) = '%"')
		end

	is_boolean_constant (s: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_boolean
		end

feature {NONE} -- Status report

	is_valid_feature_name (fn: READABLE_STRING_GENERAL): BOOLEAN
			-- Is `fn' a valid feature name?
		do
			Result := fn /= Void and then not keywords.has (fn) and is_valid_identifier (fn)
		end

	is_alpha (a_char: CHARACTER_32): BOOLEAN
			-- Is `a_char' an extended ASCII character that is alphabetic.
		do
			Result := a_char.is_character_8 and then a_char.to_character_8.is_alpha
		ensure
			class
		end

	is_digit (a_char: CHARACTER_32): BOOLEAN
			-- Is `a_char' an extended ASCII character that is a digit.
		do
			Result := a_char.is_character_8 and then a_char.to_character_8.is_digit
		ensure
			class
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

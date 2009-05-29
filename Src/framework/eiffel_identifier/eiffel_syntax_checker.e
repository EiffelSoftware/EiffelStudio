note
	description: "Utilities relative to the Eiffel syntax"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_SYNTAX_CHECKER

inherit

	SYNTAX_STRINGS

feature -- Status report

	is_valid_class_type_name (ct: STRING): BOOLEAN
			-- Is `cn' a valid class type?
			-- according to ECMA-367 Section 8.11.1
		require
			ct_not_void: ct /= Void
		local
			type_checker: CLASS_TYPE_NAME_SYNTAX_CHECKER
		do
			create type_checker
			Result := type_checker.is_valid_class_type_name (ct)
		end

	is_valid_class_name (cn: STRING): BOOLEAN
			-- Is `cn' a valid class name?
		do
			Result := is_valid_identifier (cn) and then not keywords.has (cn.as_lower)
		end

	is_valid_group_name (cn: STRING): BOOLEAN
			-- Is `cn' a valid group name?
		do
			Result := is_valid_config_identifier (cn)
		end

	is_valid_feature_name (fn: STRING): BOOLEAN
			-- Is `fn' a valid feature name?
		do
			Result := fn /= Void and then not keywords.has (fn) and (is_valid_identifier (fn) or
					-- Is `fn' a prefix operator?
				((fn.count > Prefix_str.count + 1) and then
				 ((fn.substring_index_in_bounds (Prefix_str, 1, Prefix_str.count) = 1) and
				  (fn.item (fn.count) = '%"') and
				  (is_valid_operator (fn.substring (Prefix_str.count + 1, fn.count - Quote_str.count))))) or
				  	-- Is `fn' an infix operator?
				((fn.count > Infix_str.count + 1) and then
				 ((fn.substring_index_in_bounds (Infix_str, 1, Infix_str.count) = 1) and
				  (fn.item (fn.count) = '%"') and
				  (is_valid_operator (fn.substring (Infix_str.count + 1, fn.count - Quote_str.count))))))
		end

	is_valid_target_name (tn: STRING): BOOLEAN
			-- Is `tn' a valid target name?
		do
			Result := is_valid_config_identifier (tn)
		end

	is_valid_system_name (cn: STRING): BOOLEAN
			-- Is `cn' a valid system name?
		do
			Result := is_valid_config_identifier (cn)
		end

	is_valid_identifier (s: STRING): BOOLEAN
			-- Is `s' a valid Eiffel identifier?
		local
			i: INTEGER
			cc: CHARACTER
		do
			Result := s /= Void and then not s.is_empty and then s.item (1).is_alpha
			from
				i := 2
			until
				not Result or else i > s.count
			loop
				cc := s.item (i)
				Result := cc.is_alpha or cc.is_digit or cc = '_'
				i := i + 1
			end
		end

	is_valid_config_identifier (s: STRING): BOOLEAN
			-- Is `s' a valid config identifier which is similar to `is_valid_identifier' but also allows the '.' and '-'?
		local
			i: INTEGER
			cc: CHARACTER
		do
			Result := s /= Void and then not s.is_empty and then s.item (1).is_alpha
			from
				i := 2
			until
				not Result or else i > s.count
			loop
				cc := s.item (i)
				Result := cc.is_alpha or cc.is_digit or cc = '_' or cc = '.' or cc = '-'
				i := i + 1
			end
		end

	is_valid_operator (op: STRING): BOOLEAN
			-- Is `op' a valid operator name?
		do
			Result := op /= Void and then (basic_operators.has (op.as_lower) or else is_valid_free_operator (op))
		end

	is_valid_binary_operator (op: STRING): BOOLEAN
			-- Is `op' a valid binary operator?
		do
			Result := op /= Void and then (binary_operators.has (op.as_lower) or else is_valid_free_operator (op))
		end

	is_valid_unary_operator (op: STRING): BOOLEAN
			-- Is `op' a valid unary operator?
		do
			Result := op /= Void and then (unary_operators.has (op.as_lower) or else is_valid_free_operator (op))
		end

	is_valid_free_operator (op: STRING): BOOLEAN
			-- Is `op' a valid free operator name?
		local
			i: INTEGER
			cc: CHARACTER
		do
			Result := op /= Void and then not op.is_empty and then free_operators_start.has (op.item (1))
			from
				i := 2
			until
				not Result or else i > op.count
			loop
				cc := op.item (i)
				Result := cc.is_alpha or cc.is_digit or free_operators_characters.has (cc)
				i := i + 1
			end
		ensure then
			Result implies not basic_operators.has (op);
		end

	is_bracket_alias_name (s: STRING): BOOLEAN
			-- Is `s' a bracket alias name?
		do
			Result := s /= Void and then s.is_equal (bracket_str)
		end

	is_constant (s: STRING): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := 	is_integer_constant (s) or
						is_double_constant (s) or
						is_string_constant (s) or
						is_boolean_constant (s)
		end

	is_integer_constant (s: STRING): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_integer
		end

	is_double_constant (s: STRING): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_double
		end

	is_string_constant (s: STRING): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.count >= 2 and then (s.item (1) = '%"' and s.item (s.count) = '%"')
		end

	is_boolean_constant (s: STRING): BOOLEAN
			-- Is `s' a valid Eiffel constant?
		do
			Result := s.is_boolean
		end

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EIFFEL_SYNTAX_CHECKER


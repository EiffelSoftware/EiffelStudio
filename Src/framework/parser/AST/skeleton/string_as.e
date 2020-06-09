note

	description: "Node for string constants. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class STRING_AS

inherit
	ATOMIC_AS
		undefine
			text
		redefine
			string_value_32
		end

	LEAF_AS
		redefine
			first_token
		end

	CHARACTER_ROUTINES

create {INTERNAL_COMPILER_STRING_EXPORTER}
	initialize

feature {NONE} -- Initialization

	initialize (s: STRING; l, c, p, n, cc, cp, cn: INTEGER)
			-- Create a new STRING AST node.
		require
			s_not_void: s /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
			cc_non_negative: cc >= 0
			cp_non_negative: cp >= 0
			cn_non_negative: cn >= 0
		do
			value := s
			set_position (l, c, p, n, cc, cp, cn)
		ensure
			value_set: value = s
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_string_as (Current)
		end

feature -- Properties

	is_once_string: BOOLEAN
			-- Is current preceded by `once' keyword?

	value_32: STRING_32
			-- Real string value in UTF-32.
		do
			Result := encoding_converter.utf8_to_utf32 (value)
		ensure
			Result_set: Result /= Void
		end

	is_code_point_valid_string_8: BOOLEAN
			-- Is current string able to be represented by STRING_8 in Unicode code point?
			-- Unicode code point between 0-255.
		do
			Result := encoding_converter.is_code_point_valid_string_8 (value)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	value: STRING
			-- Real string value in UTF-8.

	value_is_lower: BOOLEAN
			-- Is value with all characters in lower case?
		local
			s: READABLE_STRING_32
		do
			s := value_32
			Result := s.is_case_insensitive_equal (s.as_lower)
		end

	value_to_lower
			-- Convert `value` to the UTF-8 lower case version of `value_32`.
		local
			s: STRING_8
		do
			s := encoding_converter.utf32_to_utf8 (value_32.as_lower)
			value.wipe_out
			value.append (s)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Roundtrip/Text

	string_text (a_match_list: LEAF_AS_LIST): STRING
			-- Text of the string part (not including the type).
		require
			a_match_list_attached: a_match_list /= Void
		do
			Result := a_match_list.text (create {ERT_TOKEN_REGION}.make (index, index))
		end

feature -- Settings

	set_is_once_string (v: like is_once_string)
			-- Set `is_once_string' with `v'.
		do
			is_once_string := v
		ensure
			is_once_string_set: is_once_string = v
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
				-- `value' cannot be Void
			Result := is_once_string = other.is_once_string and then value.is_equal (other.value) and then
				equivalent (type, other.type)
		end

feature -- Output

	string_value_32: STRING_32
			-- Formatted value.
		do
			Result := eiffel_string_32 (value_32)
			Result.precede ('"')
			Result.extend ('"')
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Output

	string_value: STRING
			-- Formatted value.
		do
			Result := eiffel_string (value)
			Result.precede ('"')
			Result.extend ('"')
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Status setting

	set_value (s: STRING)
		require
			s_attached: s /= Void
		do
			value := s
		ensure
			value_set: value = s
		end

feature -- Roundtrip

	once_string_keyword_index: INTEGER
			-- Once string keyword.

	once_string_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Once string keyword.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := once_string_keyword_index
			if a_list.valid_index (i) and then attached {like once_string_keyword} a_list.i_th (i) as l_keyword then
				Result := l_keyword
			end
		end

	set_once_string_keyword (k_as: detachable KEYWORD_AS)
			-- Set `once_keyword' with `k_as'.
		do
			if k_as /= Void then
				once_string_keyword_index := k_as.index
			end
		ensure
			once_string_keyword_set: k_as /= Void implies once_string_keyword_index = k_as.index
		end

	type: detachable TYPE_AS
			-- Type that associated with this string.

	set_type (t_as: like type)
			-- Set `type' with `t_as'.
		do
			type := t_as
		ensure
			type_set: type = t_as
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): LEAF_AS
		do
			if a_list = Void then
				Result := Current
			else
				if attached type as l_type and then attached l_type.first_token (a_list) as l_result then
					Result := l_result
				else
					Result := Current
				end
			end
		end

invariant
	value_not_void: value /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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

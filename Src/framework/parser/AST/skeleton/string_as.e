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
			is_equivalent
		end

	LEAF_AS
		redefine
			first_token
		end

	CHARACTER_ROUTINES

create
	initialize

feature {NONE} -- Initialization

	initialize (s: STRING; l, c, p, n: INTEGER)
			-- Create a new STRING AST node.
		require
			s_not_void: s /= Void
			l_non_negative: l >= 0
			c_non_negative: c >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			value := s
			set_position (l, c, p, n)
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

	value: STRING
			-- Real string value.

	is_once_string: BOOLEAN
			-- Is current preceded by `once' keyword?

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
			-- Is `other' equivalent to the current object ?
		do
				-- `value' cannot be Void
			Result := is_once_string = other.is_once_string and then value.is_equal (other.value)
		end

feature -- Output

	string_value: STRING
			-- Formatted value.
		do
			Result := eiffel_string (value)
			Result.precede ('"')
			Result.extend ('"')
		end

feature -- Status setting

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

	once_string_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Once string keyword
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := once_string_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	set_once_string_keyword (k_as: KEYWORD_AS)
			-- Set `once_keyword' with `k_as'.
		do
			if k_as /= Void then
				once_string_keyword_index := k_as.index
			end
		ensure
			once_string_keyword_set: k_as /= Void implies once_string_keyword_index = k_as.index
		end

	type: TYPE_AS
			-- Type that associated with this string.

	set_type (t_as: TYPE_AS)
			-- Set `type' with `t_as'.
		do
			type := t_as
		ensure
			type_set: type = t_as
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if a_list = Void then
				Result := Current
			else
				if type /= Void then
					Result := type.first_token (a_list)
				else
					Result := Current
				end
			end
		end

invariant
	value_not_void: value /= Void

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

end -- class STRING_AS

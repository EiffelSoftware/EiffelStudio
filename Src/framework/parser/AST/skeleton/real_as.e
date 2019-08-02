note

	description: "Node for real constant. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class REAL_AS

inherit
	ATOMIC_AS
		undefine
			text
		end

	LEAF_AS
		redefine
			first_token
		end

create
	make

feature {NONE} -- Initialization

	make (a_type: like constant_type; r: READABLE_STRING_8)
			-- Create a new REAL_AS node of type `a_type' with `r'
			-- containing the textual representation
			-- of the real value.
			-- `r' is ascii compatible.
		require
			r_not_void: r /= Void
		do
			value := r.string
			value.replace_substring_all ("_","")
			constant_type := a_type
		ensure
			value_not_void: value /= Void
			value_set: not r.has ('_') implies value.same_string (r)
				-- and then r.has ('_') implies value.is_equal (r) (modulo removed underscores)
			constant_type_set: constant_type = a_type
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_real_as (Current)
		end

feature -- Roundtrip

	sign_symbol_index: INTEGER
			-- Index of symbol "+" or "-" associated with this structure.

	sign_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "+" or "-" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := sign_symbol_index
			if a_list.valid_index (i) and then attached {like sign_symbol} a_list.i_th (i) as l_symbol then
				Result := l_symbol
			end
		end

	set_sign_symbol (s_as: detachable SYMBOL_AS)
			-- Set `sign_symbol' with `s_as'.
		do
			if s_as /= Void then
				sign_symbol_index := s_as.index
			end
		ensure
			sign_symbol_set: s_as /= Void implies sign_symbol_index = s_as.index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): LEAF_AS
		do
			if a_list = Void then
				Result := Current
			else
				if attached constant_type as l_type and then attached l_type.first_token (a_list) as l_result then
					Result := l_result
				elseif attached sign_symbol (a_list) as l_symbol then
					Result := l_symbol
				else
					Result := Current
				end
			end
		end

feature -- Roundtrip/Text

	number_text (a_match_list: LEAF_AS_LIST): STRING
			-- Text of the number part (not including `constant_type' and `sign_symbol')
			-- Can converted to STRING_32 safely.
		require
			a_match_list_attached: a_match_list /= Void
		do
			Result := a_match_list.text (create {ERT_TOKEN_REGION}.make (index, index))
		end

feature -- Access

	value: STRING
			-- Real value
			-- Can converted to STRING_32 safely.

	constant_type: detachable TYPE_AS
			-- Actual type of real constant if specified.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := value.is_equal (other.value) and then equivalent (constant_type, other.constant_type)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING
		do
			Result := value.twin
		end

note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software"
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

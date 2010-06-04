note
	description: "Objects that represent a typed char ast node"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPED_CHAR_AS

inherit
	CHAR_AS
		rename
			initialize as char_initialize
		redefine
			first_token, process, type
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (t_as: TYPE_AS; c: CHARACTER_32; l, co, p, n: INTEGER)
			-- Create a new CHARACTER AST node.
		require
			t_as_not_void: t_as /= Void
			l_non_negative: l >= 0
			co_non_negative: co >= 0
			p_non_negative: p >= 0
			n_non_negative: n >= 0
		do
			value := c
			set_position (l, co, p, n)
			type := t_as
		ensure
			value_set: value = c
			type_set: type = t_as
		end

feature -- Roundtrip

	type: TYPE_AS
		-- Type associated with this node.

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			Result := type.first_token (a_list)
			if Result = Void then
				Result := Current
			end
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Roundtrip/Text

	character_text (a_match_list: LEAF_AS_LIST): STRING
			-- Text of the number part (not including `constant_type')
		require
			a_match_list_attached: a_match_list /= Void
		do
			Result := a_match_list.text (create {ERT_TOKEN_REGION}.make (index, index))
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process this node.
		do
			v.process_typed_char_as (Current)
		end

invariant
	type_attached: type /= Void

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

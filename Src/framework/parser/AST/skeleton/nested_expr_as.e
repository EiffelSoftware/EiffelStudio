note
	description:
			"Abstract description of a nested call `target.message' where %
			%the target is a parenthesized expression. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class NESTED_EXPR_AS

inherit
	CALL_AS

create
	initialize

feature {NONE} -- Initialization

	initialize (t: like target; m: like message; d_as: like dot_symbol)
			-- Create a new NESTED CALL AST node.
		require
			t_not_void: t /= Void
			m_not_void: m /= Void
		do
			target := t
			message := m
			if d_as /= Void then
				dot_symbol_index := d_as.index
			end
		ensure
			target_set: target = t
			message_set: message = m
			dot_symbol_set: d_as /= Void implies dot_symbol_index = d_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_nested_expr_as (Current)
		end

feature -- Roundtrip

	dot_symbol_index: INTEGER
			-- Index of symbol "." associated with this structure.

	dot_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol "." associated with this structure.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, dot_symbol_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := dot_symbol_index
		end

feature -- Attributes

	target: EXPR_AS
			-- Target of the call.

	message: ACCESS_FEAT_AS
			-- Message send to the target.

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := target.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := message.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object?
		do
			Result := equivalent (message, other.message) and
				equivalent (target, other.target)
		end

invariant
	message_not_void: message /= Void
	target_not_void: target /= Void

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

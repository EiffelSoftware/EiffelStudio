indexing
	description: "Object test node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class OBJECT_TEST_AS

inherit
	EXPR_AS

create
	make

feature {NONE} -- Creation

	make (l: like lcurly_symbol; n: like name; t: like type; e: like expression) is
			-- Create new node with given attributes.
		require
			n_attached: n /= Void
			t_attached: t /= Void
			e_attached: e /= Void
		do
			lcurly_symbol := l
			name := n
			type := t
			expression := e
		ensure
			lcurly_symbol_set: lcurly_symbol = l
			name_set: name = n
			type_set: type = t
			expression_set: expression = e
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_object_test_as (Current)
		end

feature -- Attributes

	name: ID_AS
			-- Name of read-only entity

	type: TYPE_AS
			-- Type to check

	expression: EXPR_AS
			-- Expression to be tested

feature -- Roundtrip

	lcurly_symbol: SYMBOL_AS
			-- Symbol "{" associated with current AST node

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if lcurly_symbol /= Void then
				Result := lcurly_symbol.first_token (a_list)
			else
				Result := name.first_token (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := expression.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (name, other.name) and then
				equivalent (type, other.type) and then
				equivalent (expression, other.expression)
		end

indexing
	copyright:	"Copyright (c) 2007, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

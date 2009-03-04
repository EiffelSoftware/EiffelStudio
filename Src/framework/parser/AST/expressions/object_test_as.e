note
	description: "Object test node."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class OBJECT_TEST_AS

inherit
	EXPR_AS

create
	make, make_curly

feature {NONE} -- Creation

	make (l_att: like attached_keyword; t: like type; e: like expression; l_as: like as_keyword; n: like name)
			-- Create new node with given attributes.
		require
			e_attached: e /= Void
		do
			if l_att /= Void then
				attached_keyword_index := l_att.index
			end
			is_attached_keyword := True
			type := t
			expression := e
			if l_as /= Void then
				as_keyword_index := l_as.index
			end
			name := n
		ensure
			is_attached_keyword: is_attached_keyword
			attached_keyword_index_set: l_att /= Void implies attached_keyword_index = l_att.index
			type_set: type = t
			expression_set: expression = e
			as_keyword_index_set: l_as /= Void implies as_keyword_index = l_as.index
			name_set: name = n
		end

	make_curly (l: like lcurly_symbol; n: like name; t: like type; e: like expression)
			-- Create new node with given attributes.
		require
			n_attached: n /= Void
			t_attached: t /= Void
			e_attached: e /= Void
		do
			if l /= Void then
				lcurly_symbol_index := l.index
			end
			name := n
			type := t
			expression := e
		ensure
			lcurly_symbol_index_set: l /= Void implies lcurly_symbol_index = l.index
			not_is_attached_keyword: not is_attached_keyword
			name_set: name = n
			type_set: type = t
			expression_set: expression = e
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_object_test_as (Current)
		end

feature -- Attributes

	name: detachable ID_AS
			-- Name of read-only entity

	type: detachable TYPE_AS
			-- Type to check

	expression: EXPR_AS
			-- Expression to be tested

	is_attached_keyword: BOOLEAN
			-- Are we using the new syntax with attached keyword?

feature -- Roundtrip

	lcurly_symbol_index: INTEGER
			-- Index in a match list for tokens.

	lcurly_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Left curly symbol(s) associated with this structure if any.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := lcurly_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	attached_keyword_index, as_keyword_index: INTEGER
			-- Index of keyword "attached" and "as" associated with this structure.

	attached_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "attached" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := attached_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	as_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "as" associated with this structure.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := as_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if is_attached_keyword then
				if a_list /= Void and attached_keyword_index /= 0 then
					Result := attached_keyword (a_list)
				end
				if Result = Void and type /= Void then
					Result := type.first_token (a_list)
				elseif Result = Void then
					Result := expression.first_token (a_list)
				end
			else
				if a_list /= Void and lcurly_symbol_index /= 0 then
					Result := lcurly_symbol (a_list)
				else
					check name_attached: name /= Void end
					Result := name.first_token (a_list)
				end
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS
		do
			if is_attached_keyword then
				if name /= Void then
					Result := name
				else
					Result := expression.first_token (a_list)
				end
			else
				Result := expression.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (name, other.name) and then
				equivalent (type, other.type) and then
				equivalent (expression, other.expression)
		end

invariant
	name_and_type_attached: not is_attached_keyword implies name /= Void and then type /= Void

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

end

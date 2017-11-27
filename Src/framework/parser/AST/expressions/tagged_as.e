note
	description: "Abstract description of a tagged expression."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision	: "$Revision$"

class
	TAGGED_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

create
	initialize,
	make_class

feature {NONE} -- Initialization

	initialize (t: like tag; e: like expr; s_as: like colon_symbol)
			-- Create a new TAGGED AST node.
		require
			exclusive: not (t = Void and e = Void)
		do
			tag := t
			expr := e
			if s_as /= Void then
				colon_symbol_index := s_as.index
			end
		ensure
			tag_set: tag = t
			expr_set: expr = e
			colon_symbol_set: s_as /= Void implies colon_symbol_index = s_as.index
			not_is_class: not is_class
		end

	make_class (t: like tag; c: like class_keyword; s_as: like colon_symbol)
			-- Create an assertion clause node for a class postcondition.
		do
			tag := t
			if c /= Void then
				class_keyword_index := c.index
			end
			if s_as /= Void then
				colon_symbol_index := s_as.index
			end
			is_class := True
		ensure
			tag_set: tag = t
			class_keyword_set: attached c implies class_keyword_index = c.index
			colon_symbol_set: attached s_as implies colon_symbol_index = s_as.index
			is_class: is_class
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- Process current element.
		do
			v.process_tagged_as (Current)
		end

feature -- Roundtrip

	colon_symbol_index: INTEGER
			-- Index of symbol colon associated with this structure.

	colon_symbol (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Symbol colon associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, colon_symbol_index)
		end

	class_keyword_index: INTEGER
			-- Index of a class keyword if used, or 0 otherwise.

	class_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Symbol colon associated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, class_keyword_index)
		end

	is_complete: BOOLEAN
			-- Is this tagged structure complete?
			-- e.g. in form of "tag:expr", "expr", but not "tag:".
		do
			Result := attached expr
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := colon_symbol_index
		end

feature -- Attributes

	tag: detachable ID_AS
			-- Expression tag

	expr: detachable EXPR_AS
			-- Expression

	is_class: BOOLEAN
			-- Is it a class assertion indicator?

feature -- Status report

	is_detachable_expression: BOOLEAN
			-- <Precursor>
		do
			Result := attached expr as l_expr and then l_expr.is_detachable_expression
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached tag as l_tag then
				Result := l_tag.first_token (a_list)
			elseif attached a_list and then class_keyword_index > 0 then
				Result := class_keyword (a_list)
			elseif attached expr as l_expr then
				Result := l_expr.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached expr as l_expr then
				Result := l_expr.last_token (a_list)
			elseif attached a_list and class_keyword_index > 0 then
				Result := class_keyword (a_list)
			elseif a_list /= Void and colon_symbol_index /= 0 then
				Result := colon_symbol (a_list)
			elseif attached tag as l_tag then
				Result := l_tag.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result :=
				equivalent (tag, other.tag) and then
				is_class = other.is_class and then
				equivalent (expr, other.expr)
		end

	is_equiv (other: like Current): BOOLEAN
			-- Is `other' tagged as equivalent to Current?
		do
			Result :=
				equivalent (tag, other.tag) and then
				is_class = other.is_class and then
				equivalent (expr, other.expr)
		end

invariant
	not_both_tag_and_expr_void: not (tag = Void and expr = Void and not is_class)
	expression_is_not_class: attached expr implies not is_class
	class_is_not_expression: is_class implies not attached expr

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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

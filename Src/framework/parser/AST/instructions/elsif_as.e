note
	description:
			"Abstract description of a elsif clause of a condition %
			%instruction. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ELSIF_AS

inherit
	AST_EIFFEL
		redefine
			is_equivalent
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; c: like compound; l_as, t_as: like elseif_keyword)
			-- Create a new ELSIF AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			compound := c
			if l_as /= Void then
				elseif_keyword_index := l_as.index
			end
			if t_as /= Void then
				then_keyword_index := t_as.index
			end
		ensure
			expr_set: expr = e
			compound_set: compound = c
			elseif_keyword_set: l_as /= Void implies elseif_keyword_index = l_as.index
			then_keyword_set: t_as /= Void implies then_keyword_index = t_as.index
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_elseif_as (Current)
		end

feature -- Roundtrip

	elseif_keyword_index, then_keyword_index: INTEGER
			-- Index of keyword "elseif" and "then" assoicated with this structure

	elseif_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "elseif" assoicated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, elseif_keyword_index)
		end

	then_keyword (a_list: LEAF_AS_LIST): detachable KEYWORD_AS
			-- Keyword "then" assoicated with this structure
		require
			a_list_not_void: a_list /= Void
		do
			Result := keyword_from_index (a_list, then_keyword_index)
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := elseif_keyword_index
		end

feature -- Attributes

	expr: EXPR_AS
			-- Conditional expression

	compound: detachable EIFFEL_LIST [INSTRUCTION_AS]
			-- Compound

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and elseif_keyword_index /= 0 then
				Result := elseif_keyword (a_list)
			else
				Result := expr.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if attached compound as l_compound then
				Result := l_compound.last_token (a_list)
			elseif a_list /= Void and then_keyword_index /= 0 then
				Result := then_keyword (a_list)
			else
				Result := expr.last_token (a_list)
			end
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr) and
				equivalent (compound, other.compound)
		end

feature {ELSIF_AS} -- Replication

	set_expr (e: like expr)
		require
			valid_arg: e /= Void
		do
			expr := e
		end

	set_compound (c: like compound)
		do
			compound := c
		end

invariant
	expr_not_void: expr /= Void

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software"
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

end -- class ELSIF_AS

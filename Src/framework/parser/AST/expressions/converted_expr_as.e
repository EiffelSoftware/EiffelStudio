note
	description: "Node which is the result of a conversion."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONVERTED_EXPR_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (e: like expr; d: like data)
			-- Initialize new CONVERTED_EXPR_AS node
		require
			e_not_void: e /= Void
			d_not_void: d /= Void
		do
			if attached {like Current} e as l_already_converted then
				expr := l_already_converted.expr
			else
				expr := e
			end
			data := d
		ensure
			data_set: data = d
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_converted_expr_as (Current)
		end

feature -- Access

	expr: EXPR_AS
			-- Parenthesized expression

	data: ANY
			-- Data needed for conversion. Implementation specific.

feature -- Status Report

	is_detachable_expression: BOOLEAN
			-- <Precursor>
		do
			Result := expr.is_detachable_expression
		end

feature -- Roundtrip

	index: INTEGER
			-- <Precursor>
		do
			Result := expr.index
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := expr.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := expr.last_token (a_list)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

invariant
	expr_not_void: expr /= Void
	data_not_void: data /= Void

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software"
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

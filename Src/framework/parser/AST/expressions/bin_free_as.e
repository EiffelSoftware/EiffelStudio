note
	description: "Free binary expression description. Version for Bench"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class BIN_FREE_AS

inherit
	BINARY_AS
		rename
			initialize as initialize_binary_as
		redefine
			is_equivalent, operator
		end

	PREFIX_INFIX_NAMES

create
	initialize

feature {NONE} -- Initialization

	initialize (l: like left; op: like op_name; r: like right)
			-- Create a new BIN_FREE AST node.
		require
			l_not_void: l /= Void
			op_not_void: op /= Void
			r_not_void: r /= Void
		do
			make_id_set
			op_name := op
			initialize_binary_as (l, r, op)
		ensure
			left_set: left = l
			op_name_set: op_name = op
			right_set: right = r
			no_routine_id: routine_ids.is_empty
		end

feature -- Access

	op_name: ID_AS
			-- Free operator name

	operator (a_list: LEAF_AS_LIST): LEAF_AS
			-- <Precursor>
		do
			Result := op_name
		ensure then
			operator_not_void: Result /= Void
		end

	operator_id: like alias_id
			-- <Precursor>
		do
			Result := alias_id (op_name.name_id, is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask ⦶ is_binary_kind_mask)
		ensure then
			is_valid_unary_alias_id (Result)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (op_name, other.op_name) and then
				equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_bin_free_as (Current)
		end

invariant
	op_name_not_void: op_name /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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

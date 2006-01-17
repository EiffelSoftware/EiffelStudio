indexing
	description: "Associate each BINARY_AS and UNARY_AS descendants with their corresponding %
		%BINARY_B and UNARY_B instances."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	AST_BYTE_NODE_ANCHOR

inherit
	AST_NULL_VISITOR
		redefine
			process_un_free_as, process_un_minus_as, process_un_not_as, process_un_old_as,
			process_un_plus_as, process_bin_and_then_as, process_bin_free_as,
			process_bin_implies_as, process_bin_or_as, process_bin_or_else_as, process_bin_xor_as,
			process_bin_ge_as, process_bin_gt_as, process_bin_le_as, process_bin_lt_as,
			process_bin_div_as, process_bin_minus_as, process_bin_mod_as, process_bin_plus_as,
			process_bin_power_as, process_bin_slash_as, process_bin_star_as, process_bin_and_as,
			process_bin_eq_as, process_bin_ne_as
		end

feature -- Byte node

	binary_node (a_node: BINARY_AS): BINARY_B is
			-- Associated byte node for `a_node'
		require
			a_node_not_void: a_node /= Void
		do
			a_node.process (Current)
			Result := last_binary_node
		ensure
			binary_node_not_void: Result /= Void
		end

	unary_node (a_node: UNARY_AS): UNARY_B is
			-- Associated byte node for `a_node'
		require
			a_node_not_void: a_node /= Void
		do
			a_node.process (Current)
			Result := last_unary_node
		ensure
			unary_node_not_void: Result /= Void
		end

feature {NONE} -- Access

	last_binary_node: BINARY_B
	last_unary_node: UNARY_B

feature {NONE} -- Implementation

	process_un_free_as (l_as: UN_FREE_AS) is
		do
			create {UN_FREE_B} last_unary_node
		end

	process_un_minus_as (l_as: UN_MINUS_AS) is
		do
			create {UN_MINUS_B} last_unary_node
		end

	process_un_not_as (l_as: UN_NOT_AS) is
		do
			create {UN_NOT_B} last_unary_node
		end

	process_un_old_as (l_as: UN_OLD_AS) is
		do
			create {UN_OLD_B} last_unary_node
		end

	process_un_plus_as (l_as: UN_PLUS_AS) is
		do
			create {UN_PLUS_B} last_unary_node
		end

	process_bin_and_then_as (l_as: BIN_AND_THEN_AS) is
		do
			create {B_AND_THEN_B} last_binary_node
		end

	process_bin_free_as (l_as: BIN_FREE_AS) is
		do
			create {BIN_FREE_B} last_binary_node
		end

	process_bin_implies_as (l_as: BIN_IMPLIES_AS) is
		do
			create {B_IMPLIES_B} last_binary_node
		end

	process_bin_or_as (l_as: BIN_OR_AS) is
		do
			create {BIN_OR_B} last_binary_node
		end

	process_bin_or_else_as (l_as: BIN_OR_ELSE_AS) is
		do
			create {B_OR_ELSE_B} last_binary_node
		end

	process_bin_xor_as (l_as: BIN_XOR_AS) is
		do
			create {BIN_XOR_B} last_binary_node
		end

	process_bin_ge_as (l_as: BIN_GE_AS) is
		do
			create {BIN_GE_B} last_binary_node
		end

	process_bin_gt_as (l_as: BIN_GT_AS) is
		do
			create {BIN_GT_B} last_binary_node
		end

	process_bin_le_as (l_as: BIN_LE_AS) is
		do
			create {BIN_LE_B} last_binary_node
		end

	process_bin_lt_as (l_as: BIN_LT_AS) is
		do
			create {BIN_LT_B} last_binary_node
		end

	process_bin_div_as (l_as: BIN_DIV_AS) is
		do
			create {BIN_DIV_B} last_binary_node
		end

	process_bin_minus_as (l_as: BIN_MINUS_AS) is
		do
			create {BIN_MINUS_B} last_binary_node
		end

	process_bin_mod_as (l_as: BIN_MOD_AS) is
		do
			create {BIN_MOD_B} last_binary_node
		end

	process_bin_plus_as (l_as: BIN_PLUS_AS) is
		do
			create {BIN_PLUS_B} last_binary_node
		end

	process_bin_power_as (l_as: BIN_POWER_AS) is
		do
			create {BIN_POWER_B} last_binary_node
		end

	process_bin_slash_as (l_as: BIN_SLASH_AS) is
		do
			create {BIN_SLASH_B} last_binary_node
		end

	process_bin_star_as (l_as: BIN_STAR_AS) is
		do
			create {BIN_STAR_B} last_binary_node
		end

	process_bin_and_as (l_as: BIN_AND_AS) is
		do
			create {BIN_AND_B} last_binary_node
		end

	process_bin_eq_as (l_as: BIN_EQ_AS) is
		do
			create {BIN_EQ_B} last_binary_node
		end

	process_bin_ne_as (l_as: BIN_NE_AS) is
		do
			create {BIN_NE_B} last_binary_node
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

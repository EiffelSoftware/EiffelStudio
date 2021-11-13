note
	description: "Free unary expression description."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class UN_FREE_AS

inherit
	UNARY_AS
		rename
			initialize as initialize_unary_as
		redefine
			is_equivalent
		end

	PREFIX_INFIX_NAMES

create
	initialize

feature {NONE} -- Initialization

	initialize (op: like op_name; e: like expr)
			-- Create a new UN_FREE AST node.
		require
			op_not_void: op /= Void
			e_not_void: e /= Void
		do
			op_name := op
			initialize_unary_as (e, op)
		ensure
			op_name_set: op_name = op
			expr_set: expr = e
			no_routine_id: routine_ids.is_empty
			operator_set: operator_index = op.index
		end

feature -- Access

	op_name: ID_AS
			-- Operator name

	operator_id: like alias_id
			-- <Precursor>
		do
			Result := alias_id (op_name.name_id, is_valid_binary_kind_mask ⦶ is_valid_unary_kind_mask ⦶ is_unary_kind_mask)
		ensure then
			is_valid_binary_alias_id (Result)
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_un_free_as (Current)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	prefix_feature_name: STRING
			-- Internal name
		do
			Result := prefix_feature_name_with_symbol (op_name.name)
		end

	operator_name: STRING
		do
			Result := op_name.name
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result :=
				equivalent (op_name, other.op_name) and then
				equivalent (expr, other.expr)
		end

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

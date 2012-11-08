note
	description: "Abstract class for binary expression nodes, Bench version"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class BINARY_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

	ID_SET_ACCESSOR
		rename
			make as make_id_set,
			id_set as routine_ids,
			set_id_set as set_routine_ids
		undefine
			is_equal, copy
		end

	SHARED_ENCODING_CONVERTER
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	initialize (l: like left; r: like right; o: like operator)
			-- Create a new BINARY AST node.
		require
			l_not_void: l /= Void
			r_not_void: r /= Void
		do
			left := l
			right := r
			if o /= Void then
				operator_index := o.index
			end
		ensure
			left_set: left = l
			right_set: right = r
			operator_set: o /= Void implies operator_index = o.index
		end

feature -- Attributes

	left: EXPR_AS
			-- Left operand

	right: EXPR_AS
			-- Right opernad

	class_id: INTEGER
			-- The class id of the qualified call.

feature -- Roundtrip

	operator_index: INTEGER
			-- Index of binary operation AST node.

	operator (a_list: LEAF_AS_LIST): detachable LEAF_AS
			-- Binary operation AST node.
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := operator_index
			if a_list.valid_index (i) then
				Result := a_list.i_th (i)
			end
		end

	index: INTEGER
			-- <Precursor>
		do
			Result := operator_index
		end

feature -- Status report

	is_detachable_expression: BOOLEAN = True
			-- <Precursor>

feature -- Location

	operator_location: LOCATION_AS
			-- Location of operator
		local
			l_left, l_right: LOCATION_AS
			l_line, l_column, l_pos, l_count: INTEGER
		do
			l_left := left.end_location
			l_right := right.start_location

			l_line := l_left.line
			l_count := (l_right.position) - (l_left.position + l_left.location_count)
			check l_count >= 0 end
			l_column := l_left.column + l_left.location_count
			l_pos := l_left.position + l_left.location_count

			create Result.make (l_line, l_column, l_pos, l_count)
		ensure
			operator_location_not_void: Result /= Void
		end

	operator_ast: ID_AS
			-- Approximation of current operator AST without a match_list.
		local
			l_location: LOCATION_AS
		do
			l_location := operator_location
			Result := op_name.twin
			Result.set_position (l_location.line, l_location.column, l_location.position, l_location.location_count)
		ensure
			operator_ast_not_void: Result /= Void
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := left.first_token (a_list)
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := right.last_token (a_list)
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	infix_function_name: detachable STRING
			-- Internal name of the infix feature associated to the
			-- binary expression
		deferred
		end

feature -- Properties

	infix_function_name_32: detachable STRING_32
			-- Internal name of the infix feature associated to the
			-- binary expression
		do
			if attached infix_function_name as l_name then
				Result := encoding_converter.utf8_to_utf32 (l_name)
			end
		end

	op_name: ID_AS
			-- Symbol representing the operator (without the infix).
		deferred
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

feature -- Setting

	set_class_id (a_class_id: like class_id)
			-- Set `class_id' to `a_class_id'.
		require
			a_class_id_ok: a_class_id > 0 or a_class_id = -1
		do
			class_id := a_class_id
		end

	set_left (a_left: like left)
			-- Set `left' with `a_left'
		require
			a_left_not_void: a_left /= Void
		do
			left := a_left
		ensure
			left_set: left = a_left
		end

	set_right (a_right: like right)
			-- Set `right' with `a_right'
		require
			a_right_not_void: a_right /= Void
		do
			right := a_right
		ensure
			right_set: right = a_right
		end

invariant
	left_not_void: left /= Void
	right_not_void: right /= Void

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

end -- class BINARY_AS


note
	description: "Abstract class for unary expression, Bench version"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class UNARY_AS

inherit
	EXPR_AS
		redefine
			is_detachable_expression
		end

	SYNTAX_STRINGS
		export
			{NONE} all
		end

	ID_SET_ACCESSOR
		rename
			make as make_id_set,
			id_set as routine_ids,
			set_id_set as set_routine_ids
		undefine
			is_equal, copy
		end

feature {NONE} -- Initialization

	initialize (e: like expr; o: like operator)
			-- Create a new UNARY AST node.
		require
			e_not_void: e /= Void
		do
			expr := e
			if o /= Void then
				operator_index := o.index
			end
		ensure
			expr_set: expr = e
			operator_set: o /= Void implies operator_index = o.index
		end

feature -- Roundtrip

	operator_index: INTEGER
			-- Index of unary operation AST node.

	operator (a_list: LEAF_AS_LIST): detachable LEAF_AS
			-- Unary operation AST node.
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

feature -- Attributes

	expr: EXPR_AS
			-- Expression

	class_id: INTEGER
			-- The class id of the qualified call.

feature -- Status report

	is_detachable_expression: BOOLEAN = True
			-- <Precursor>

feature -- Location

	operator_location: LOCATION_AS
			-- Location of operator
		local
			l_location: LOCATION_AS
			l_count, l_character_count: INTEGER
		do
			l_location := start_location
				-- We add `+1' because often there is a space between the operator and the expression.
			l_count := operator_name.count + 1
			l_character_count := operator_name_32.count + 1
			create Result.make (l_location.line, (l_location.column - l_count).max (0),
				(l_location.position - l_count).max (0), l_count,
				(l_location.character_column - l_character_count).max (0),
				(l_location.character_position - l_character_count).max (0), l_character_count)
		ensure
			operator_location_not_void: Result /= Void
		end

	operator_ast: ID_AS
			-- Approximation of current operator AST without a match_list.
		local
			l_location: LOCATION_AS
		do
			l_location := operator_location
			create Result.initialize (operator_name)
			Result.set_position (l_location.line, l_location.column, l_location.position, l_location.location_count,
				l_location.character_column, l_location.character_position, l_location.character_count)
		ensure
			operator_ast_not_void: Result /= Void
		end

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and operator_index /= 0 then
				Result := operator (a_list)
			else
				Result := expr.first_token (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			Result := expr.last_token (a_list)
		end

feature -- Properties

	prefix_feature_name_32: STRING_32
			-- Internal name of the prefixed feature
		do
			if attached prefix_feature_name as l_name then
				Result := encoding_converter.utf8_to_utf32 (l_name)
			end
		end

	operator_name_32: STRING_32
		do
			if attached operator_name as l_name then
				Result := encoding_converter.utf8_to_utf32 (l_name)
			end
		end

	is_minus: BOOLEAN
			-- Is Current prefix "-"?
		do
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Properties

	prefix_feature_name: STRING
			-- Internal name of the prefixed feature
		do
			Result := Prefix_str + operator_name + Quote_str
		end

	operator_name: STRING
		deferred
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (expr, other.expr)
		end

feature -- Setting

	set_class_id (a_class_id: like class_id)
			-- Set `class_id' to `a_class_id'.
		do
			class_id := a_class_id
		end

feature {UNARY_AS} -- Replication

	set_expr (e: like expr)
			-- Set `expr' with `e'.
		require
			valid_arg: e /= Void
		do
			expr := e
		ensure
			expr_set: expr = e
		end

invariant
	expr_not_void: expr /= Void

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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


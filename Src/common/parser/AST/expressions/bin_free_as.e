indexing
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
			is_equivalent
		end

	PREFIX_INFIX_NAMES

create
	initialize

feature {NONE} -- Initialization

	initialize (l: like left; op: like op_name; r: like right) is
			-- Create a new BIN_FREE AST node.
		require
			l_not_void: l /= Void
			op_not_void: op /= Void
			r_not_void: r /= Void
		do
			left := l
			op_name := op
			right := r
			operator := op
		ensure
			left_set: left = l
			op_name_set: op_name = op
			right_set: right = r
		end

feature -- Attributes

	op_name: ID_AS
			-- Free operator name

feature -- Properties

	infix_function_name: STRING is
			-- Internal name of the infixed feature associated to the
			-- binary expression
		do
			Result := infix_feature_name_with_symbol (op_name)
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (op_name, other.op_name) and then
				equivalent (left, other.left) and then
				equivalent (right, other.right)
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_bin_free_as (Current)
		end

feature {BINARY_AS}

	set_infix_function_name (name: ID_AS) is
		do
			create op_name.initialize (extract_symbol_from_infix (name))
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

end -- class BIN_FREE_AS

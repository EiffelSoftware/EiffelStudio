indexing
	description: "Hold byte code information of a custom attribute creation%
		%with or without named argument."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CUSTOM_ATTRIBUTE_B

inherit
	EXPR_B

create
	make

feature {NONE} -- Initialization

	make (a_creation: CREATION_EXPR_B) is
			-- Create new instance of Current.
		require
			a_creation_not_void: a_creation /= Void
		do
			creation_expr := a_creation
		ensure
			creation_expr_set: creation_expr = a_creation
		end
		
feature -- Visitor

	process (v: BYTE_NODE_VISITOR) is
			-- Process current element.
		do
			v.process_custom_attribute_b (Current)
		end
	
feature -- Access

	creation_expr: CREATION_EXPR_B
			-- Associated creation expression.
			
	named_arguments:  ARRAYED_LIST [TUPLE [STRING_B, EXPR_B]]
			-- Associated data for named arguments.

feature -- Settings

	set_named_arguments (n: like named_arguments) is
			-- Set `named_arguments' with `n'.
		do
			named_arguments := n
		ensure
			named_arguments_set: named_arguments = n
		end
		
feature {NONE} -- Not applicable

	type: TYPE_I is
			-- Expression type.
		do
			Result := creation_expr.type
		end
		
	used (r: REGISTRABLE): BOOLEAN is
			-- Is register `r' used in local or forthcomming dot calls ?
		do
			check
				not_callable: False
			end
		end
		
invariant
	creation_expr_not_void: creation_expr /= Void

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

end -- class CUSTOM_ATTRIBUTE_B

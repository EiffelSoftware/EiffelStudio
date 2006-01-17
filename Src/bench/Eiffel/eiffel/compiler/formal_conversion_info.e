indexing
	description: "Information about converting a formal to its constraint type."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FORMAL_CONVERSION_INFO

inherit
	CONVERSION_INFO
		rename
			make as old_make
		end

	COMPILER_EXPORTER

create
	make
	
feature {NONE} -- Implementation

	make (a_formal: like formal_type; a_target_type: like target_type) is
		require
			a_formal_not_void: a_formal /= Void
			a_target_type_not_void: a_target_type /= Void
		do
			formal_type := a_formal
			target_type := a_target_type
		ensure
			formal_type_set: formal_type = a_formal
			target_type_set: target_type = a_target_type
		end

feature -- Access

	formal_type: FORMAL_A
			-- Source of conversion which is formal

feature -- Byte code generation

	byte_node (an_expr: EXPR_B): EXPR_B is
			-- Generate byte node needed to convert `an_expr' to `target_type'
		do
			create {FORMAL_CONVERSION_B} Result.make (an_expr, target_type.type_i, False)
		end

invariant
	formal_type_not_void: formal_type /= Void

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

end -- class FORMAL_CONVERSION_INFO

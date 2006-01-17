indexing
	description: "Error when a class performs inheritance of a frozen class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	VIFI1

inherit
	VIFI
		redefine
			subcode
		end

create
	make

feature -- Access

	subcode: INTEGER is 1
			-- Identifier for VIFI error.

	parent_class: CLASS_C
			-- Class from which user tries to inherit from in `class_c'.

feature -- Setting

	set_parent_class (cl: CLASS_C) is
			-- Set `parent_class' with `cl'.
		require
			cl_not_void: cl /= Void
		do
			parent_class := cl
		ensure
			parent_class_set: parent_class = cl
		end
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			check
				parent_class_set: parent_class /= Void
			end
			st.add_string ("Class: ")
			class_c.append_signature (st, False)
			st.add_new_line
			st.add_string ("Inherited frozen class: ")
			parent_class.append_signature (st, False)			
			st.add_new_line
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

end -- class VIFI1

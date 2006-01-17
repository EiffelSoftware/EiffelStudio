indexing
	description: "Error when an expanded class inherits  classes that are either%
		%external classes or that inherit from external classes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VIFI3

inherit
	VIFI
		rename
			make as make_with_class
		redefine
			subcode
		end

create
	make

feature {NONE} -- Creation

	make (c: like class_c; parents: like parent_classes) is
			-- Create error for class `c' with offfending parent classes `parents'.
		require
			c_not_void: c /= Void
			parents_not_void: parents /= Void
			parents_not_empty: not parents.is_empty
		do
			make_with_class (c)
			parent_classes := parents
		ensure
			class_c_set: class_c = c
			parent_classes_set: parent_classes = parents
		end

feature -- Access

	subcode: INTEGER is 3
			-- Identifier for VIFI error.

	parent_classes: LIST [CLASS_C]
			-- Classes from which user tries to inherit from in `class_c'.

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Display error message
		do
			check
				parent_classes_set: parent_classes /= Void
			end
			st.add_string ("Classes that cannot be inherited:")
			st.add_new_line
			from
				parent_classes.start
			until
				parent_classes.after
			loop
				parent_classes.item.append_signature (st, False)
				parent_classes.forth
				if not parent_classes.after then
					st.add_string (", ")
				end
			end
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

end

indexing

	description: 
		"Error when the topological sort on classes finds a cycle."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class VHPR1 

inherit
	ERROR
		redefine
			build_explain, subcode
		end

	SHARED_EIFFEL_PROJECT
		undefine
			is_equal
		end

feature -- Properties

	involved_classes: LINKED_LIST [INTEGER];
			-- Id's of classes invloved in the inheritance graph

	code: STRING is "VHPR";
			-- Error code

	subcode: INTEGER is 1;

	file_name: STRING is
			-- No associated file name
		do
		end

feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation explain for current error
			-- in `st'.
		do
			st.add_string ("Names of classes involved in cycle:");
			st.add_new_line;
			from
				involved_classes.start
			until
				involved_classes.after
			loop
				if not (involved_classes.item = involved_classes.first) then
					st.add_string (", ");
				end;
				Eiffel_system.class_of_id (involved_classes.item)
						.append_name (st);
				involved_classes.forth;
			end;
			st.add_new_line;
		end;

feature {COMPILER_EXPORTER} -- Setting

	set_involved_classes (l: LINKED_LIST [INTEGER]) is
			-- Assign `l' to `involved_classes'.
		do
			involved_classes := l;
		end;

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

end -- class VHPR1

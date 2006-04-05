indexing

	description:
		"Displays warnings and errors specifically for bench"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class BENCH_ERROR_DISPLAYER

inherit

	SHARED_EIFFEL_PROJECT;
	DEFAULT_ERROR_DISPLAYER
		redefine 
			display_additional_info 
		end

create
	make

feature -- Output

	display_additional_info (st: STRUCTURED_TEXT) is
			-- Add additional information to `st'.
		local
			degree_nbr: INTEGER;
			to_go: INTEGER
		do
			degree_nbr := Degree_output.current_degree;
			if degree_nbr > 0 then
					-- Case has degree_number equal to 0
				st.add_string ("Degree: ");
				st.add_string (degree_nbr.out);
			end;
			st.add_string (" Processed: ")
			st.add_string (Degree_output.processed.out);
			st.add_string (" To go: ")
			to_go := Degree_output.total_number - Degree_output.processed;
			st.add_string (to_go.out);
			st.add_string (" Total: ")
			st.add_string (Degree_output.total_number.out);
			st.add_new_line;
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class BENCH_ERROR_DISPLAYER

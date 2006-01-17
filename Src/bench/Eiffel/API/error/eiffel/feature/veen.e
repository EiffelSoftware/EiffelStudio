indexing
	description: "Error for undeclared identifier."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class VEEN 

inherit
	FEATURE_ERROR
		redefine
			build_explain
		end
	
feature -- Access

	identifier: STRING
			-- Undeclared identifier

	parameter_count: INTEGER
			-- Number of expected arguments.

	code: STRING is "VEEN"
			-- Error code

feature -- Settings

	set_identifier (s: STRING) is
			-- Assign `s' to `identifier'.
		require
			s_not_void: s /= Void
		do
			identifier := s
		ensure
			identifier_set: identifier = s
		end

	set_parameter_count (i: INTEGER) is
			-- Assign `i to `parameter_count'.
		require
			i_positive: i >= 0
		do
			parameter_count := i
			is_parameter_count_set := True
		ensure
			parameter_countt_set: parameter_count = i
		end
		
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- Build specific explanation image for current error
			-- in `st'.
		do
			st.add_string ("Identifier: ")
			st.add_string (identifier)
			st.add_new_line
			if is_parameter_count_set then
				st.add_string ("Taking ")
				if parameter_count = 0 then
					st.add_string ("no argument")
				else
					if parameter_count = 1 then
						st.add_string ("1 argument")
					else
						st.add_int (parameter_count)
						st.add_string (" arguments")
					end
				end
				st.add_new_line
			end
		end

feature {NONE} -- Implementation

	is_parameter_count_set: BOOLEAN;
			-- Did we call `set_parameter_count'?

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

end -- class VEEN

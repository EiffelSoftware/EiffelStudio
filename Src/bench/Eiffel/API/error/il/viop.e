indexing
	description	: "[
		Warning when user selected to use ompitimized version of a precompiled library,
		but precompiled library has not been optimized.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	definition: "VIOP = Optimized Precompiled library has not be created"
	date: "$Date$"
	revision: "$Revision$"

class
	VIOP

inherit
	WARNING

create
	make

feature {NONE} -- Initialization
	
	make (a_path: STRING) is
			-- create warning with path to directory `a_path'
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		do
			precompiled_path := a_path.twin
		ensure
			precompiled_path_set: a_path.is_equal (precompiled_path)
		end
		

feature -- Properties

	code: STRING is "VIOP"
		-- Error code
		
	precompiled_path: STRING
		-- Path to precompiled library
		
	file_name: STRING is
			-- No associated file name
		do
		end
	
feature -- Output

	build_explain (st: STRUCTURED_TEXT) is
			-- No need for an error message.
		do
			st.add_string ("Precompiled Library: ")
			st.add_string (precompiled_path)
			st.add_new_line
		end

invariant
	non_void_precompiled_path: precompiled_path /= Void
	valid_precompiled_path: not precompiled_path.is_empty

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

end -- class VIOP

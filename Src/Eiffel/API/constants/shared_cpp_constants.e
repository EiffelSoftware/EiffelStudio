indexing
	description: "Constants used by C++ encapsulation."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SHARED_CPP_CONSTANTS

feature -- Validity

	valid_type (i: INTEGER): BOOLEAN is
			-- Does `i' represent a kind of C++ external.
		do
			Result := i = standard or i = creator or i = delete or i = static 
						or i = data_member or i = static_data_member
		end

feature {NONE} -- Constants

    standard: INTEGER is 1
	new, creator: INTEGER is 2
	delete: INTEGER is 3
	static: INTEGER is 4
	data_member: INTEGER is 5
	static_data_member: INTEGER is 6
 
    data_member_keyword: STRING is "data_member"
 
    delete_keyword: STRING is "delete"
 
    new_keyword: STRING is "new"
 
    static_keyword: STRING is "static";

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

end -- class SHARED_CPP_CONSTANTS

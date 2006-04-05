indexing
	description: "Project Shared variables"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_PROJECT_SHARED

feature -- Access

	is_oracle (code: INTEGER): BOOLEAN is
			-- Is selected DBMS Oracle?
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := code = Available_dbms.Oracle_code
		end

	is_odbc (code: INTEGER): BOOLEAN is
			-- Is selected DBMS ODBC?
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := code = Available_dbms.Odbc_code
		end

	db_manager (code: INTEGER): DATABASE_MANAGER [DATABASE] is
			-- Database manager, responsible for interactions
			-- with the database.
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := Available_dbms.db_manager_list.i_th (code)
		ensure
			exists: Result /= Void
		end

	db_display_name (code: INTEGER): STRING is
			-- DBMS display name.
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := Available_dbms.db_display_name_list.i_th (code)
		ensure
			exists: Result /= Void
		end

	handle_name (code: INTEGER): STRING is
			-- DBMS handle name.
		require
			is_valid_code: Available_dbms.is_valid_code (code)
		do
			Result := db_manager (code).database_handle_name
		ensure
			exists: Result /= Void
		end

	Available_dbms: AVAILABLE_DBMS is
			-- Available DBMS information.
		once
			create Result
		ensure
			exists: Result /= Void
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
end -- class WIZARD_PROJECT_SHARED

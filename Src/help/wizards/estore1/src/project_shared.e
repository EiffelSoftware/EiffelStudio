indexing
	description: "Project Shared variables"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PROJECT_WIZARD_SHARED

feature -- Access

	odbc: STRING is "odbc"

	oracle: STRING is "oracle"

	db_manager: DATABASE_MANAGER[DATABASE] is
			-- Database manager. Allows to perform
			-- connection, deconnection, request and 
			-- query execution.
		do
			if database_type.is_equal(odbc) then
--				Result := db_manager_odbc 
				Result := db_manager_oracle
			elseif database_type.is_equal(oracle) then
				Result := db_manager_oracle
--				Result := db_manager_odbc
			end	
		ensure
			exists: Result /= Void
		end

	is_oracle: BOOLEAN is
		do
			Result := (database_type.is_equal(oracle))
		end

	is_odbc: BOOLEAN is
		do
			Result := (database_type.is_equal(odbc))
		end

feature -- Settings

	set_database(s: STRING) is
		require
			supported: s /= Void and then (s.is_equal(odbc) or s.is_equal(oracle))
		do
			database_type.wipe_out
			database_type.append(s)
		end

feature {NONE} -- Implementation

	database_type: STRING is
			-- Database type.
		once
			Create Result.make(10)
			Result.append(odbc)
		end
		
	db_manager_oracle: DATABASE_MANAGER[ORACLE] is
			-- Database manager. Allows to perform
			-- connection, deconnection, request and 
			-- query execution.
		once
			Create Result
		ensure
			exists: Result /= Void
		end

--	db_manager_odbc: DATABASE_MANAGER[ODBC] is
			-- Database manager. Allows to perform
			-- connection, deconnection, request and 
			-- query execution.
--		once
--			Create Result
--		ensure
--			exists: Result /= Void
--		end

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
end -- class PROJECT_WIZARD_SHARED

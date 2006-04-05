indexing
	description: "Specific information for the Oracle wizard."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David S"
	date: "$Date$"
	revision: "$Revision$"

class
	AVAILABLE_DBMS

feature {WIZARD_PROJECT_SHARED} -- Access

	is_valid_code (code: INTEGER): BOOLEAN is
			-- Is `code' a valid DBMS code?
		do
			Result := code = Oracle_code or else code = Odbc_code
		end

	Oracle_code: INTEGER is 1
			-- Code for Oracle DBMS.

	Odbc_code: INTEGER is 2
			-- Code for ODBC DBMS.

	handle_b: EV_RADIO_BUTTON

	db_manager_list: ARRAYED_LIST [DATABASE_MANAGER [DATABASE]] is
			-- List of database managers for every DBMS.
		once
			create Result.make (2)
			Result.extend (create {DATABASE_MANAGER [ORACLE]})
			Result.extend (create {DATABASE_MANAGER [ODBC]})
		ensure
			exists: Result /= Void
		end

	db_display_name_list: ARRAYED_LIST [STRING] is
			-- List of DBMS display names.
		once
			create Result.make (2)
			Result.extend ("Oracle")
			Result.extend ("ODBC")
		ensure
			exists: Result /= Void
		end

invariant
	same_count: db_manager_list.count = db_display_name_list.count

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
end -- class AVAILABLE_DBMS

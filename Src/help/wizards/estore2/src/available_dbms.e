indexing
	description: "Specific information for the Oracle wizard."
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

end -- class AVAILABLE_DBMS

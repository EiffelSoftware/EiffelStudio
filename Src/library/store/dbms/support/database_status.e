note
	description: "Implementation of DB_STATUS"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	DATABASE_STATUS [G -> DATABASE create default_create end]

inherit

	HANDLE_SPEC [G]

feature -- Status report

	is_error_updated: BOOLEAN
			-- Has an Oracle/ODBC function been called since last update which may have
			-- updated error code, error message or warning message?
		do
			Result := db_spec.is_error_updated
		end

	error_message_32: STRING_32
			-- Error message from database server
		do
			Result := db_spec.get_error_message_string
		end

	error_code: INTEGER
			-- Error code from database server
		do
			Result := db_spec.get_error_code
		end

	no_error_code: INTEGER
			-- Code indicating no error
		do
			Result := db_spec.no_error_code
		end

	is_warning_updated: BOOLEAN
			-- Has an Oracle/ODBC function been called since last update which may have
			-- updated warning message?
		do
			Result := db_spec.is_warning_updated
		end

	warning_message_32: STRING_32
			-- Warning message from database server
		do
			Result := db_spec.get_warn_message_string
		end

	found: BOOLEAN
			-- Is there any record matching the last
			-- selection condition used ?
		do
			Result := db_spec.found
		end

	reset
			--Reset database error status.
		do
			db_spec.clear_error
		end

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class DATABASE_STATUS



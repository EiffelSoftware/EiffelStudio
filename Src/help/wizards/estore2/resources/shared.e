indexing
	description: "Project shared objects."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SHARED

inherit
	DB_TABLES_ACCESS_USE
		undefine
			is_valid_code,
			tables
		end
	
	DB_SPECIFIC_TABLES_ACCESS_USE

feature -- Access

	db_manager: DB_TABLE_MANAGER is
			-- Create database manager.
		local
			db_appl: DATABASE_MANAGER [<FL_HANDLE>]
		once
			create db_appl
			create Result.make (db_appl)
		end
		
	factory: SPECIFIC_FACTORY is
			-- DataView widgets factory.
		once
			create Result.make
		end

feature -- Messages

	Ok_text: STRING is "OK"
			-- 'OK' button text.

	Cancel_text: STRING is "Cancel"
			-- 'Cancel' button text.

	Not_connected: STRING is "Not connected"
			-- Connection to database is not established.
	
	Connection_established: STRING is
			-- Connection to database is established.
		do
			Result := "Connection to '" + Username + "' established."
		end
		
	Main_window_title: STRING is
			-- Main window title.
		do
			Result := "Welcome!"
		end

	table_window_title (table_name: STRING): STRING is
			-- Table window title.
		do
			Result := table_name + " Editor"
		end

	Table_select_label_text: STRING is "Please select a database table to browse:"
			-- Table selection label text (on main window).

	Table_select_button_text: STRING is "Go!"
			-- Table selection button text (on main window).

	Exit_button_text: STRING is "Exit"
			-- Exit button text (on main window).

feature -- Constants

	Username: STRING is "<TAG_USERNAME>"
			-- Database username.
	
	Password: STRING is "<TAG_PASSWORD>"
			-- Database password.

	Data_source: STRING is "<TAG_DATA_SOURCE>"
			-- Database data source (for ODBC).

	Border_width: INTEGER is 5
			-- Standard border width.

	Padding: INTEGER is 5
			-- Standard padding.

	Attribute_field_width: INTEGER is 120
			-- Attribute field standard width.

end -- class SHARED

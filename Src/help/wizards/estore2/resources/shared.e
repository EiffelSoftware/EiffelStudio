note
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

	db_manager: DB_TABLE_MANAGER
			-- Create database manager.
		local
			db_appl: DATABASE_MANAGER [<FL_HANDLE>]
		once
			create db_appl
			create Result.make (db_appl)
		end
		
	factory: SPECIFIC_FACTORY
			-- DataView widgets factory.
		once
			create Result.make
		end

feature -- Messages

	Ok_text: STRING = "OK"
			-- 'OK' button text.

	Cancel_text: STRING = "Cancel"
			-- 'Cancel' button text.

	Not_connected: STRING = "Not connected"
			-- Connection to database is not established.
	
	Connection_established: STRING
			-- Connection to database is established.
		do
			Result := "Connection to database established."
		end
		
	Main_window_title: STRING
			-- Main window title.
		do
			Result := "Welcome!"
		end

	table_window_title (table_name: STRING): STRING
			-- Table window title.
		do
			Result := table_name + " Editor"
		end

	Table_select_label_text: STRING = "Please select a database table to browse:"
			-- Table selection label text (on main window).

	Table_select_button_text: STRING = "Go!"
			-- Table selection button text (on main window).

	Exit_button_text: STRING = "Exit"
			-- Exit button text (on main window).

feature -- Constants

	Username: STRING = "<TAG_USERNAME>"
			-- Database username.
	
	Password: STRING = "<TAG_PASSWORD>"
			-- Database password.

	Data_source: STRING = "<TAG_DATA_SOURCE>"
			-- Database data source (for ODBC).

	Border_width: INTEGER = 5
			-- Standard border width.

	Padding: INTEGER = 5
			-- Standard padding.

	Attribute_field_width: INTEGER = 120
			-- Attribute field standard width.

end

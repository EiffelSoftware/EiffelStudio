indexing
	description	: "Application (root class)"
	note		: "Initial version automatically generated"

class
	APPLICATION

inherit
	SHARED

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			create ev_application
			setup_display_components_db_objects
			connect
			setup_boxes
			create main_window.make_from_application (Current)
			main_window.show
			main_window.set_initial_focus
			if db_manager.has_error then
				main_window.send_status (Not_connected)
				main_window.send_warning (db_manager.error_message)
			else
				main_window.send_status (Connection_established)
			end
			ev_application.launch
		end

feature -- Basic operations

	destroy is
			-- Kills the graphic application.
		do
			ev_application.destroy
		end

feature -- Access

	main_window: MAIN_WINDOW
			-- Application main window.

	ev_application: EV_APPLICATION
			-- Graphic application.

feature {NONE} -- Implementation

	connect is
			-- Connect to the database.
		do
			db_manager.set_connection_information (Username, Password, Data_source)
			db_manager.establish_connection
		end

	setup_display_components_db_objects is
			-- Sets the database manager and table access objects
			-- used by the display components.
		local
			default_dc: DV_DATABASE_HANDLE
		do
				-- Sets the specific database tables to the general access system.
			set_tables (tables)
			
			create default_dc.make_for_settings
			default_dc.set_database_handler (db_manager)
		end

	setup_boxes is
			-- Set up boxes.
		local
			box: DV_VERTICAL_BOX
		do
			create box.make
			box.set_default_border_width (Border_width)
			box.set_default_padding (Padding)
		end

end -- class APPLICATION

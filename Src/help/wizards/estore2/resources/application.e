indexing
	description	: "Application (root class)"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
end -- class APPLICATION

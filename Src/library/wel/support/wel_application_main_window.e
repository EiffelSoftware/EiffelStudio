note
	description: "Class to share the application's main window object."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_APPLICATION_MAIN_WINDOW

feature -- Access

	application_main_window: detachable WEL_COMPOSITE_WINDOW
			-- Application's main window
		do
			Result := application_main_window_cell.item
		end

	application: detachable WEL_APPLICATION
			-- Current application
		do
			Result := application_cell.item
		end

feature -- Status report

	is_application_main_window (window: WEL_COMPOSITE_WINDOW): BOOLEAN
			-- Is `window' the application's main window?
		require
			window_not_void: window /= Void
		do
			Result := window = application_main_window
		ensure
			Result = (window = application_main_window)
		end

feature {WEL_APPLICATION} -- Element change

	set_application_main_window (window: WEL_COMPOSITE_WINDOW)
			-- Set `application_main_window' with `window'.
		require
			window_not_void: window /= Void
			parent_window_is_void: window.parent = Void
		do
			application_main_window_cell.put (window)
		ensure
			application_main_window_set: application_main_window = window
		end

	set_application (app: WEL_APPLICATION)
			-- Set the `application' with `app'.
		require
			app_not_void: app /= Void
		do
			application_cell.put (app)
		ensure
			application_set: application = app
		end

feature {NONE} -- Implementation

	application_main_window_cell: CELL [detachable WEL_COMPOSITE_WINDOW]
			-- Application's main window cell
		once ("PROCESS")
			create Result.put (Void)
		ensure
			result_not_void: Result /= Void
		end

	application_cell: CELL [detachable WEL_APPLICATION]
			-- Application cell
		once ("PROCESS")
			create Result.put (Void)
		ensure
			result_not_void: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class WEL_APPLICATION_MAIN_WINDOW


indexing
	description:
		"Eiffel Vision Environment. Implementation interface.%N%
		%See ev_environment.e"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "environment, global, system"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ENVIRONMENT_I

inherit
	EV_ANY_I
		redefine
			interface
		end
		
feature {EV_APPLICATION_I, EV_ENVIRONMENT} -- Status report
		
	application: EV_APPLICATION is
			-- Single application object for system.
		require
			not_destroyed: not is_destroyed
		do
			Result := application_cell.item
		ensure
			Result = application_cell.item
		end
		
	supported_image_formats: LINEAR [STRING] is
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, ICO
		require
			not_destroyed: not is_destroyed
		deferred
		ensure
			result_not_void: Result /= Void
			object_comparison_set: Result.object_comparison
		end
		
	font_families: LINEAR [STRING] is
			-- All font families available on current platform.
		deferred
		ensure
			Result_not_void: Result /= Void
		end
		
	mouse_wheel_scroll_lines: INTEGER is
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		deferred
		end
		
	has_printer: BOOLEAN is
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		deferred
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_ENVIRONMENT
            -- Provides a common user interface to platform dependent
            -- functionality implemented by `Current'
            
feature {EV_APPLICATION_I, EV_ENVIRONMENT} -- Access

	set_application (an_application: EV_APPLICATION) is
			-- Specify `an_application' as the single application object for the
			-- system. Must be called exactly once from EV_APPLICATION's
			-- creation procedure.
		require
			not_destroyed: not is_destroyed
			application_not_already_set: application = Void
		do
			application_cell.put (an_application)
		ensure
			application_assigned: application = an_application
		end

feature {NONE} -- Implementation

	Application_cell: CELL [EV_APPLICATION] is
			-- A global cell where `item' is the single application object for
			-- the system.
		indexing
			once_status: global
		require
			not_destroyed: not is_destroyed
		once
			create Result.put (Void)
		end

feature -- Command

	destroy is
			-- Render current unusable.
		do
			set_is_destroyed (True)
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_ENVIRONMENT_I


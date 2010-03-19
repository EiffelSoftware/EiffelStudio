note
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

feature {EV_ANY, EV_ANY_I, EV_ENVIRONMENT, EV_SHARED_TRANSPORT_I, EV_ANY_HANDLER, EV_ABSTRACT_PICK_AND_DROPABLE} -- Status report

	application: detachable EV_APPLICATION
			-- Single application object for system.
		require
			not_destroyed: not is_destroyed
		local
			l_result: detachable EV_APPLICATION_I
		do
			l_result := application_cell.item
			if attached l_result then
				Result := l_result.interface
			end
		end

	application_i: EV_APPLICATION_I
			-- Single application implementation object for system.
		local
			l_result: detachable EV_APPLICATION_I
		do
			l_result := application_cell.item
				-- If EV_APPLICATION_IMP has not been created yet, or was just
				-- destroyed, we recreate a fresh one.
			if not attached l_result or else l_result.is_destroyed then
				application_cell.put (create {EV_APPLICATION_IMP}.make)
				l_result := application_cell.item
			end
			check l_result /= Void end
			Result := l_result
		end

	supported_image_formats: LINEAR [STRING_32]
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

	font_families: LINEAR [STRING_32]
			-- All font families available on current platform.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	mouse_wheel_scroll_lines: INTEGER
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		deferred
		end

	default_pointer_style_width: INTEGER
			-- Default pointer style width.
		deferred
		end

	default_pointer_style_height: INTEGER
			-- Default pointer style height.
		deferred
		end

	has_printer: BOOLEAN
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ENVIRONMENT note option: stable attribute end
            -- Provides a common user interface to platform dependent
            -- functionality implemented by `Current'

--feature {EV_APPLICATION, EV_ENVIRONMENT} -- Access

--	set_application (an_application: EV_APPLICATION)
--			-- Specify `an_application' as the single application object for the
--			-- system. Must be called exactly once from EV_APPLICATION's
--			-- creation procedure.
--		require
--			not_destroyed: not is_destroyed
--			application_not_already_set: application = Void
--		do
--			application_cell.put (an_application)
--		ensure
--			application_assigned: application = an_application
--		end

feature {NONE} -- Implementation

	Application_cell: CELL [detachable EV_APPLICATION_I]
			-- A global cell where `item' is the single application object for
			-- the system.
		require
			not_destroyed: not is_destroyed
		once ("PROCESS")
			create Result.put (Void)
		end

feature -- Command

	destroy
			-- Render current unusable.
		do
			set_is_destroyed (True)
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




end -- class EV_ENVIRONMENT_I











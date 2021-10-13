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

feature {EV_ANY, EV_ANY_I, EV_ENVIRONMENT, EV_SHARED_TRANSPORT_I, EV_ANY_HANDLER, EV_ABSTRACT_PICK_AND_DROPABLE} -- Access

	application: detachable EV_APPLICATION
			-- Single application object for system in processor that created it.
		require
			same_processor_as_application: is_application_processor
		do
			if attached {EV_APPLICATION_I} application_cell_item (application_cell) as l_application_i then
				Result := l_application_i.interface
			end
		end

	separate_application: detachable separate EV_APPLICATION
			-- Single application object for system.
		do
			if attached application_cell_item (application_cell) as l_application_i then
				Result := application_interface (l_application_i)
			end
		end

	application_i: EV_APPLICATION_I
			-- Single application implementation object for system.
			-- If it does not yet exist or if it was destroyed it will create it.
			-- If it is separate to the current processor, throws an exception.
			-- Otherwise returns the existing instance.
		require
			same_processor_as_application: is_application_processor
		do
			if attached {EV_APPLICATION_I} application_cell_item (application_cell) as l_application_i and then not l_application_i.is_destroyed then
				Result := l_application_i
			else
				Result := new_application_i (application_cell)
			end
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

feature -- Status report

	has_printer: BOOLEAN
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		deferred
		end

	is_application_processor: BOOLEAN
			-- Is current instance of EV_ENVIRONMENT on the same processor as EV_APPLICATION?
			-- True if this is the same processor, or if EV_APPLICATION has not been created yet.
		do
			Result := not attached application_cell_item (application_cell) as l_result or else attached {EV_APPLICATION_I} l_result
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ENVIRONMENT note option: stable attribute end
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

	is_gtk3_implementation: BOOLEAN
			-- Is vision implementation gtk3 ?
		do
			Result := False
		end

feature {NONE} -- Implementation

	application_cell: separate CELL [detachable separate EV_APPLICATION_I]
			-- A global cell where `item' is the single application object for
			-- the system.
		require
			not_destroyed: not is_destroyed
		once ("PROCESS")
			create <NONE> Result.put (Void)
		end

	application_interface (a_separate_application: separate EV_APPLICATION_I): detachable separate EV_APPLICATION
			-- SCOOP wrapper to get `interface' of `a_separate_application'.
		do
			Result := a_separate_application.interface
		end

	application_cell_item (a_cell: like application_cell): detachable separate EV_APPLICATION_I
			-- SCOOP wrapper to get the content of `application_cell'.
		do
			Result := a_cell.item
		end

	new_application_i (a_cell: like application_cell): EV_APPLICATION_I
			-- If `a_cell''s content has been set, use it if not destroyed, otherwise
			-- create a new instance of EV_APPLICATION_IMP on the current processor and
			-- set `a_cell' with that new instance.
		require
			same_processor_as_application: not attached a_cell.item as l_result or else attached {EV_APPLICATION_I} l_result
		do
				-- If EV_APPLICATION_IMP has not been created yet we create a fresh one.
			if not attached a_cell.item as l_application_i then
				create {EV_APPLICATION_IMP} Result.make
				a_cell.put (Result)
			elseif attached {EV_APPLICATION_I} l_application_i as l_result then
					-- We already have an instance on the same processor.
				if l_result.is_destroyed then
						-- Application was destroyed, we recreate a fresh one.
					create {EV_APPLICATION_IMP} Result.make
					a_cell.put (Result)
				else
						-- We return the one we currently have.
					Result := l_result
				end
			else
				check is_same_processor: False then end	-- It is not on the same processor, precondition states this should not happen.
			end
		end

feature -- Command

	destroy
			-- Render current unusable.
		do
			set_is_destroyed (True)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

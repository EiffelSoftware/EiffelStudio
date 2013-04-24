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

	application: detachable separate EV_APPLICATION
			-- Single application object for system.
		require
			not_destroyed: not is_destroyed
		do
			Result := application_internal (environment_handler)
		end

	application_i: EV_APPLICATION_I
			-- Single application implementation object for system.
		do
			check attached {EV_APPLICATION_I} application_i_internal (environment_handler) as l_result then
				Result := l_result
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

	has_printer: BOOLEAN
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		deferred
		end

feature {EV_ANY} -- Separate Object Factory

	new_object_from_type (a_type: TYPE [EV_ANY]): separate EV_ANY
		do
			Result := new_object_from_type_id_internal (environment_handler, a_type.type_id)
		end

	separate_string_from_string (a_string: READABLE_STRING_GENERAL): separate READABLE_STRING_GENERAL
			-- Create a new string on the same processor as EV_APPLICATION object.
		do
			Result := separate_string_from_string_internal (environment_handler, a_string)
		end

	string_from_separate_string (a_string: separate READABLE_STRING_GENERAL): READABLE_STRING_GENERAL
			-- Return a representation of `a_string' on the same processor as `Current'.
		local
			i, l_count: INTEGER
			l_string: STRING_GENERAL
			l_code: NATURAL_32
		do
			if attached {READABLE_STRING_GENERAL} a_string as l_result then
					-- String is on the same processor so it may be safely returned.
				Result := l_result
			else
				l_count := a_string.count
				if a_string.is_string_8 then
						-- If `a_string' contains CHARACTER_8 values then make `Result' a STRING_8 to save memory.
					create {STRING_8} l_string.make_filled ('%U', l_count)
				else
					create {STRING_32} l_string.make_filled ('%U', l_count)
				end
				from
					i := 1
				until
					i > l_count
				loop
					l_code := a_string.code (i)
					l_string.put_code (l_code, i)
					i := i + 1
				end
				Result := l_string
			end
		end


feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_ENVIRONMENT note option: stable attribute end
            -- Provides a common user interface to platform dependent
            -- functionality implemented by `Current'

feature {EV_APPLICATION} -- Implementation

	environment_handler: separate EV_ENVIRONMENT_HANDLER
			-- A global cell where `item' is the single application object for
			-- the system.
		require
			not_destroyed: not is_destroyed
		once ("PROCESS")
			create {EV_ENVIRONMENT_HANDLER} Result.make
		end

feature {NONE} -- Implementation

	application_internal (a_environment_handler: like environment_handler): detachable separate EV_APPLICATION
		do
			Result := a_environment_handler.application
		end

	application_i_internal (a_environment_handler: like environment_handler): detachable separate EV_APPLICATION_I
		do
			Result := a_environment_handler.application_i
		end

	new_object_from_type_id_internal (a_environment_handler: like environment_handler; a_type_id: INTEGER): separate EV_ANY
		do
			Result := a_environment_handler.new_object_from_type_id (a_type_id)
		end

	separate_string_from_string_internal (a_environment_handler: like environment_handler; a_string: READABLE_STRING_GENERAL): separate READABLE_STRING_GENERAL
			-- Create a new string on the same processor as EV_APPLICATION object.
		do
			Result := a_environment_handler.string_from_separate_string (a_string)
		end

feature -- Command

	destroy
			-- Render current unusable.
		do
			set_is_destroyed (True)
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




end -- class EV_ENVIRONMENT_I











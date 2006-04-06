indexing
	description:
		"Facilities for inspecting global environment information."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "environment, application, global, system"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT

inherit
	EV_ANY
		redefine
			implementation,
			application_exists
		end

create
	default_create

feature -- Access

	application: EV_APPLICATION is
			-- Single application object for system.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.application
		ensure
			bridge_ok: Result = implementation.application
		end

	supported_image_formats: LINEAR [STRING_32] is
			-- `Result' contains all supported image formats
			-- on current platform, as a three letter uppercase
			-- extension. e.g. PNG, BMP, ICO.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.supported_image_formats
		ensure
			result_not_void: Result /= Void
			object_comparison_set: Result.object_comparison
		end

	font_families: LINEAR [STRING_32] is
			-- All fonts families available on current platform.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.font_families
		ensure
			Result_not_void: Result /= Void
		end

	font_families_8: LINEAR [STRING] is
			-- All fonts families available on current platform.
		require
			not_destroyed: not is_destroyed
		local
			l_list: like font_families
			l_family: STRING
			l_result: ARRAYED_LIST [STRING]
		do
			l_list := implementation.font_families
			create l_result.make (50)
			from
				l_list.start
			until
				l_list.after
			loop
				l_family := l_list.item
				if l_family.is_valid_as_string_8 then
					l_result.extend (l_family.to_string_8)
				end
				l_list.forth
			end
			Result := l_result
		ensure
			Result_not_void: Result /= Void
		end


	mouse_wheel_scroll_lines: INTEGER is
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mouse_wheel_scroll_lines
		end

	has_printer: BOOLEAN is
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_printer
		end

feature {NONE} -- Contract support

	application_exists: BOOLEAN is
			-- Does the application exist? This is used to stop
			-- manipulation of widgets before an application is created.
			-- As we are now in the process of creating the application,
			-- we return True.
		do
			Result := True
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_ENVIRONMENT_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_ENVIRONMENT_IMP} implementation.make (Current)
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




end -- class EV_ENVIRONMENT


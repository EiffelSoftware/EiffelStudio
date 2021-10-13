note
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
			implementation
		end

create
	default_create

feature -- Access

	application: detachable EV_APPLICATION
			-- Single application object for system.
		require
			same_processor_as_application: is_application_processor
		do
			Result := implementation.application
		ensure
			bridge_ok: Result = implementation.application
		end

	separate_application: detachable separate EV_APPLICATION
			-- Single application object for system.
		do
			Result := implementation.separate_application
		ensure
			bridge_ok: Result = implementation.separate_application
		end

	supported_image_formats: LINEAR [STRING_32]
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

	font_families: LINEAR [STRING_32]
			-- All fonts families available on current platform.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.font_families
		ensure
			Result_not_void: Result /= Void
		end

	font_families_8: LINEAR [STRING]
			-- All fonts families available on current platform.
		obsolete
			"Use `font_families' instead. [2017-05-31]"
		require
			not_destroyed: not is_destroyed
		local
			l_list: like font_families
			l_family: STRING_32
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

	mouse_wheel_scroll_lines: INTEGER
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.mouse_wheel_scroll_lines
		end

	default_pointer_style_width: INTEGER
			-- Default pointer style width.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.default_pointer_style_width
		end

	default_pointer_style_height: INTEGER
			-- Default pointer style height.
		require
			not_destoryed: not is_destroyed
		do
			Result := implementation.default_pointer_style_height
		end

feature -- Status report

	has_printer: BOOLEAN
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.has_printer
		end

	is_application_processor: BOOLEAN
			-- Is current processor running on the same processor as `application'?
		do
			Result := implementation.is_application_processor
		end

feature {EV_ANY, EV_ANY_I, EV_SHARED_TRANSPORT_I, EV_ANY_HANDLER, EV_ABSTRACT_PICK_AND_DROPABLE} -- Implementation

	implementation: EV_ENVIRONMENT_I
			-- Responsible for interaction with native graphics toolkit.

	is_gtk3_implementation: BOOLEAN
			-- Is vision implementation gtk3 ?
			-- warning: this function is likely to be removed in the future.
		do
			Result := implementation.is_gtk3_implementation
		end

feature {NONE} -- Implementation

	create_interface_objects
			-- <Precursor>
		do

		end

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			implementation := environment_i
				-- Reset creation flags so that `implementation' may be reused.
			implementation.set_is_initialized (False)
			implementation.set_state_flag ({EV_ANY_I}.interface_is_initialized_flag, False)
			implementation.set_state_flag ({EV_ANY_I}.interface_default_create_called_flag, False)
			implementation.set_state_flag ({EV_ANY_I}.base_make_called_flag, False)
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




end -- class EV_ENVIRONMENT










note
	description:
		"Eiffel Vision Environment. GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "environment, global, system"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT_IMP

inherit
	EV_ENVIRONMENT_I
		export
			{ANY} is_destroyed
		end

	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Pass `an_interface' to base make.
		do
			base_make (an_interface)
		end

	initialize
			-- No initialization needed.
		do
			set_is_initialized (True)
		end

feature -- Access

	supported_image_formats: LINEAR [STRING_32]
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, ICO
		do
			Result := (<<("PNG").to_string_32>>).linear_representation
			Result.compare_objects
		end

	mouse_wheel_scroll_lines: INTEGER
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		do
			Result := 3
		end

	default_pointer_style_width: INTEGER = 16
			-- Default pointer style width.

	default_pointer_style_height: INTEGER = 16
			-- Default pointer style height.

	has_printer: BOOLEAN
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		do
			system ("which lpr >& /dev/null")
			Result := return_code = 0
		end

	font_families: LINEAR [STRING_32]
			-- List of fonts available on the system
		local
			font_list: ARRAYED_LIST [STRING_32]
		do
			create font_list.make (5)
			font_list.extend ("Helvetica")
			Result := font_list
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




end -- class EV_ENVIRONMENT_IMP


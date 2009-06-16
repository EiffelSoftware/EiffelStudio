note
	description:
		"Eiffel Vision Environment. Cocoa implementation."
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

	old_make (an_interface: like interface)
			-- Pass `an_interface' to base make.
		do
			assign_interface (an_interface)
		end

	make
			-- No initialization needed.
		do
			set_is_initialized (True)
		end

feature -- Access

	supported_image_formats: LINEAR [STRING_32]
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, ICO
		once
			Result := create {ARRAYED_LIST [STRING_32]}.make_from_array (<<"PNG">>)
			Result.compare_objects
		end

	mouse_wheel_scroll_lines: INTEGER
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		do
			Result := 3
		end

	default_pointer_style_width: INTEGER
			-- Default pointer style width.
		do
		end

	default_pointer_style_height: INTEGER
			-- Default pointer style height.
		do
		end

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
			app_imp: EV_APPLICATION_IMP
		once
			check
				not_implemented: False
			end
			app_imp ?= application.implementation
			--Result := app_imp.font_names_on_system.linear_representation
			Result.compare_objects
		end

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_ENVIRONMENT_IMP


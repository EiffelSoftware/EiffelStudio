indexing
	description:
		"Eiffel Vision Environment. GTK implementation."
	status: "See notice at end of class"
	keywords: "environment, global, system"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_ENVIRONMENT_IMP

inherit
	EV_ENVIRONMENT_I
	
	EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Pass `an_interface' to base make.
		do
			base_make (an_interface)
		end

	initialize is
			-- No initialization needed.
		do
			set_is_initialized (True)
		end
		
feature -- Access
		
	supported_image_formats: LINEAR [STRING] is
			-- `Result' contains all supported image formats
			-- on current platform, in the form of their three letter extension.
			-- e.g. PNG, BMP, ICO
		local
			app_imp: EV_APPLICATION_IMP
		once
			app_imp ?= application.implementation
			Result := app_imp.readable_pixbuf_formats.linear_representation
			Result.compare_objects
		end

	mouse_wheel_scroll_lines: INTEGER is
			-- Default number of lines to scroll in response to
			-- a mouse wheel scroll event.
		do
			Result := 3
		end
		
	has_printer: BOOLEAN is
			-- Is a default printer available?
			-- `Result' is `True' if at least one printer is installed.
		do
			system ("which lpr >& /dev/null")
			Result := return_code = 0
		end

	font_families: LINEAR [STRING] is
			-- List of fonts available on the system
		local
			app_imp: EV_APPLICATION_IMP
		once
			app_imp ?= application.implementation
			Result := app_imp.font_names_on_system.linear_representation
			Result.compare_objects
		end

end -- class EV_ENVIRONMENT_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


class
	MAIN_WINDOW

inherit
	WEL_MAIN_DIALOG
		redefine
			setup_dialog
		end

	APPLICATION_IDS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS

creation
	make

feature -- Initialization

	make is
			-- Make the main window
		do
			<FL_CREATION>
		end

	setup_dialog is
		do
			set_icon (class_icon, class_icon)
		end

feature {NONE} -- Implementation

	class_background: WEL_BRUSH is
			-- White background
		once
			create Result.make_by_sys_color (Color_btnface + 1)
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Idi_application)
		end

end -- class MAIN_WINDOW

--|-------------------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1995, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-------------------------------------------------------------------------

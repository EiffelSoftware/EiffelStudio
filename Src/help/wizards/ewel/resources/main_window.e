class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_icon,
			class_background,
			on_paint
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
			make_top ("WEL Hello")
		end

feature {NONE} -- Implementation

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Draw a centered text
		do
			paint_dc.draw_centered_text ("Hello, World!",
				client_rect)
		end

	class_background: WEL_BRUSH is
			-- White background
		once
			create Result.make_by_sys_color (Color_btnface)
		end

	class_icon: WEL_ICON is
			-- Window's icon
		once
			create Result.make_by_id (Id_ico_application)
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

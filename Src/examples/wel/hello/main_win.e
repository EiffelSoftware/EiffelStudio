class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			on_paint
		end

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

	class_background: WEL_WHITE_BRUSH is
			-- White background
		once
			create Result.make
		end

end -- class MAIN_WINDOW

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


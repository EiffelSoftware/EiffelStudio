indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	MAIN_WINDOW

inherit
	WEL_FRAME_WINDOW
		redefine
			class_background,
			on_paint
		end

create
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


end -- class MAIN_WINDOW


note
	description: "Default GUI font (default font to draw dialogs)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DEFAULT_GUI_FONT

obsolete
	"Access default gui font via WEL_SHARED_FONTS instead (4 Apr 2011)"

inherit
	WEL_FONT
		rename
			make as font_make
		end

	WEL_GDI_STOCK

create
	make

feature {NONE} -- Implementation

	stock_id: INTEGER
			-- GDI stock object identifier
		once
			Result := Default_gui_font
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




end -- class WEL_DEFAULT_GUI_FONT


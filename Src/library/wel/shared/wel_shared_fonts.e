indexing
	description: "Shared reference to predefined font object."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_SHARED_FONTS

feature -- Access

	gui_font: WEL_DEFAULT_GUI_FONT is
			-- Default screen (WEL) font.
		once
			create Result.make
		ensure
			font_created: Result /= Void
		end

end -- class WEL_SHARED_FONTS

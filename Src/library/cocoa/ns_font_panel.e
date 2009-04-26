note
	description: "Summary description for {NS_FONT_PANEL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_FONT_PANEL

inherit
	NS_PANEL

create
	shared_font_panel

feature

	shared_font_panel
		do
			cocoa_object := font_panel_shared_font_panel
		end

feature -- Objective-C implementation

	frozen font_panel_shared_font_panel: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSFontPanel sharedFontPanel];"
		end

end

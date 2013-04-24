note
	description: "EiffelVision fontable, Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_FONTABLE_IMP

inherit
	EV_FONTABLE_I

feature -- Access

	font: EV_FONT
			-- Character appearance for `Current'.
		do
			if attached internal_font as l_font then
				Result := l_font.twin
			else
				create Result
				-- Default create is standard Cocoa font
			end
		end

feature -- Status setting

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		do
			internal_font := a_font
		end

feature {NONE} -- Implementation

	internal_font: detachable EV_FONT

end -- class EV_FONTABLE_IMP

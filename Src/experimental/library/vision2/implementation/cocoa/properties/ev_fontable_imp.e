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
			if private_font = void then
				create Result
				-- Default create is standard Cocoa font
			else
				Result := private_font.twin
			end
		end

feature -- Status setting

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		do
			private_font := a_font
		end

feature {NONE} -- Implementation

	private_font: EV_FONT

	internal_font: EV_FONT
		do
			if private_font = void then
				create Result
			else
				Result := private_font
			end
		end

end -- class EV_FONTABLE_IMP

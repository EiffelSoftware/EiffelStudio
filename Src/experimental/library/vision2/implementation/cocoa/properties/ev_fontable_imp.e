note
	description: "EiffelVision fontable, Cocoa implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_FONTABLE_IMP

inherit
	EV_FONTABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

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

	interface: EV_FONTABLE;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- class EV_FONTABLE_IMP


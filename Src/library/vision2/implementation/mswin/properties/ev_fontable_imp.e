indexing
	description:"EiffelVision fontable, mswindows implementation."
	note : "When a heir of this class inherits from a WEL object,%
			% it needs to rename `font' as `wel_font' and%
			% `set_font' as `wel_set_font'"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONTABLE_IMP

inherit
	EV_FONTABLE_I

feature -- Access

	font: EV_FONT is
			-- Font of `Current'.
		local
			font_imp: EV_FONT_IMP
		do
			if private_font = Void then
				create Result
				font_imp ?= Result.implementation
				font_imp.set_by_wel_font (clone (private_wel_font))
				private_font := Result
				private_wel_font := Void
			else
				Result := private_font	
			end
		end
	
feature -- Status setting

	set_font (ft: EV_FONT) is
			-- Make `ft' new font of `Current'.
		local
			local_font_windows: EV_FONT_IMP
		do
			private_font := ft
			local_font_windows ?= private_font.implementation
			check
				valid_font: local_font_windows /= Void
			end
			wel_set_font (local_font_windows.wel_font)

				-- We don't need the WEL private font anymore since it is set by user.
			private_wel_font := Void
		end

	set_default_font is
			-- Make system to use default font.
		do
			private_wel_font := wel_default_font
			wel_set_font (wel_default_font)
		end

feature {EV_ANY_I} -- Implementation

	private_font: EV_FONT
			-- font used for implementation

	private_wel_font: WEL_FONT
			-- WEL font used for implementation

feature {NONE} -- Implementation : The wel values, are deferred here, but
			   -- they need to be defined by their heirs.

	wel_default_font: WEL_FONT is
			-- Default font of system.
		once
			Result := (create {WEL_SHARED_FONTS}).gui_font
		end

	wel_font: WEL_FONT is
			-- The wel_font
		deferred
		end

	wel_set_font (a_font: WEL_FONT) is
			-- Make `a_font' the new font of the widget.
		deferred
		end

end -- class EV_FONTABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


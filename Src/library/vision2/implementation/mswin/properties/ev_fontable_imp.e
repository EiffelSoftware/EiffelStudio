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
			-- font of current primitive
		local
			font_windows: EV_FONT_IMP
			default_font: WEL_FONT
		do
			if private_font = Void then
				!! private_font.make
				!WEL_ANSI_VARIABLE_FONT! default_font.make
				font_windows ?= private_font.implementation
				font_windows.make_by_wel (default_font)
			end
			Result := private_font	
		end
	
feature -- Status setting

	set_font (ft: EV_FONT) is
			-- Make `ft' the new font.
		local
			local_font_windows: EV_FONT_IMP
		do
			private_font := ft
			local_font_windows ?= private_font.implementation
			check
				valid_font: local_font_windows /= Void
			end
			wel_set_font (local_font_windows.wel_font)
		end

	private_font: EV_FONT
			-- font used for the implementation

feature {NONE} -- Implementation : the wel values, are deferred here, but
			   -- they need to be define by the heir

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
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


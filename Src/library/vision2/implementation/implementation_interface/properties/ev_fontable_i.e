indexing
	description: "Eiffel Vision fontable, implementation interface."
	status: "See notice at end of class"
	keywords: "font, name, property"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONTABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end

feature -- Access

	font: EV_FONT is
			-- Typeface appearance for `Current'.
		deferred
		ensure
			not_void: Result /= Void
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		deferred
		ensure
			assigned: is_usable implies font.is_equal (a_font)
		end

feature {NONE} -- Implementation

	interface: EV_FONTABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	font_not_void: is_usable implies font /= Void

end -- class EV_FONTABLE_I

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


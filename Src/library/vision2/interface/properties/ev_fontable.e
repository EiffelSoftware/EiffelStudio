indexing
	description:
		"Abstraction for objects that have a font property."
	status: "See notice at end of class"
	keywords: "font, name, property"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FONTABLE

inherit
	EV_ANY
		redefine
			implementation
		end

feature -- Access

	font: EV_FONT is
			-- Typeface appearance for `Current'.
		require
			not_destroyed: not is_destroyed
		do
			Result := implementation.font
		ensure
			not_void: Result /= Void
			bridge_ok: Result.is_equal (implementation.font)
		end

feature -- Element change

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			not_destroyed: not is_destroyed
			a_font_not_void: a_font /= Void
		do
			implementation.set_font (a_font)
		ensure
			font_assigned: font.is_equal (a_font) and font /= a_font
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_FONTABLE_I
		-- Responsible for interaction with native graphics toolkit.

end -- class EV_FONTABLE

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


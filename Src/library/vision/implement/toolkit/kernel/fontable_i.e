indexing

	description: "Widgets which define a font";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	FONTABLE_I 

feature -- Access

	font: FONT is
			-- Font name of label
		deferred
		end

feature -- Element change

	set_font (a_font: FONT) is
			-- Set font label to `font_name'.
		require
			a_font_exists: a_font /= Void
			a_font_specified: a_font.is_specified
		deferred
		end

end -- class FONTABLE_I

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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


indexing
	description: "EiffelVision fontable, an object which can%
				% change its font";
	status: "See notice at end of class";
	date: "$Date$";
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
			-- Font name of label
		require
			exists: not destroyed
		do
			Result := implementation.font
		end

feature -- Element change

	set_font (ft: EV_FONT) is
			-- Set font label to `font_name'.
		require
			exists: not destroyed
			valid_font: is_valid (ft)
		do
			implementation.set_font (ft)
		end

	set_font_name (str: STRING) is
			-- Set font label to `str'.
		require
			exists: not destroyed
			valid_name: str /= Void
		local
			ft: EV_FONT
		do
			!! ft.make
			ft.set_name (str)
			set_font (ft)
		end

feature {NONE} -- Implementation

	implementation: EV_FONTABLE_I
			-- Implementation of widget

end -- class EV_FONTABLE

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


indexing

	description: 
		"A widget that has a font.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FONTABLE

inherit

	MEL_FONTABLE_RESOURCES
		export
			{NONE} all
		end;

	MEL_OBJECT

feature -- Access

	font_list: MEL_FONT_LIST is
			-- Font list of gadget label
		require
			exists: not is_destroyed
		do
			Result := get_xm_font_list (screen_object, XmNFontList)
		ensure
			font_list_is_valid: Result /= Void and then Result.is_valid
		end;

feature -- Status setting

	set_font_list (a_font_list: MEL_FONT_LIST) is
			-- Set `font_list' to `a_font_list'.
		require
			exists: not is_destroyed;
			a_font_list_is_valid: a_font_list /= Void and then a_font_list.is_valid
		do
			set_xm_font_list (screen_object, XmNFontList, a_font_list)
		end;

end -- class MEL_FONTABLE

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------

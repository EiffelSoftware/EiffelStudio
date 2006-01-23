indexing

	description: 
		"A widget that has a font."
	legal: "See notice at end of class.";
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
			Result_is_valid: Result /= Void and then Result.is_valid;
			Result_is_shared: Result.is_shared
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class MEL_FONTABLE



indexing
	description: "MSBOXPARAMS structure used by cwin_message_box_indirect"
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_MSGBOXPARAMS

inherit
	WEL_STRUCTURE
		rename
			make as structure_make
		end

creation
	make_by_id,
	make_basic

feature {NONE} -- initialization

	make_basic (a_window: WEL_WINDOW; a_text, a_title: STRING; a_style,a_language,a_sublanguage: INTEGER) is
			-- create a MSGBOXPARAMS structure
			-- without user icon.
			-- With `a_window' as parent, `a_text' displayed as message, `a_title' displayed in title bar.
			-- `a_style' as the window style.
			-- `a_language' and `a_sublanguage' specify in which language the text on the buttons is displayed.
			-- Note that in order for the langauge settings to work, the necessary components must be installed
			-- on the system.
		require
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
			valid_language: a_language > 0
			valid_sublanguage: a_sublanguage > 0
		local
			a_wel_string1, a_wel_string2: WEL_STRING
			handle: POINTER
		do
			create a_wel_string1.make (a_text)
			create a_wel_string2.make (a_title)
			if a_window /= Void then
				handle := a_window.item
			else
				handle := default_pointer
			end
			structure_make
			cwel_msgboxparams_set (item, handle, a_main_arguments.current_instance.item, a_wel_string1.item,
			a_wel_string2.item, a_style, default_pointer, cwin_make_lang_id (a_language, a_sublanguage))
		end

	make_by_id (a_window: WEL_WINDOW; a_text, a_title: STRING; a_style, an_id, a_language, a_sublanguage: INTEGER)is
			-- create a MSGBOXPARAMS structure 
			-- with user icon defined by `an_id, `a_window' as parent, `a_text' displayed as message,
			--`a_title' displayed in title bar and `a_style' as the window style.
			-- `a_language' and `a_sublanguage' specify in which language the text on the buttons is displayed.
			-- Note that in order for the langauge settings to work, the necessary components must be installed
			-- on the system.

		require
			text_not_void: a_text /= Void
			title_not_void: a_title /= Void
			valid_id: an_id > 0
			valid_lang: a_language > 0
			valid_sublang: a_sublanguage > 0
		local
			a_wel_string1,a_wel_string2: WEL_STRING
			handle: POINTER
		do
			create a_wel_string1.make (a_text)
			create a_wel_string2.make (a_title)
			if a_window /= Void then
				handle := a_window.item
			else
				handle := default_pointer
			end
			structure_make
			cwel_msgboxparams_set (item, a_window.item, a_main_arguments.current_instance.item, a_wel_string1.item,
			a_wel_string2.item, a_style, cwin_make_int_resource (an_id),
			cwin_make_lang_id (a_language, a_sublanguage))
		end

	structure_size: INTEGER is
 		-- size of structure `MSGBOXPARAMS'
 		do
			Result := c_size_of_msgboxparams
		end

feature {NONE} -- Implementation	

	a_main_arguments: WEL_MAIN_ARGUMENTS is
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

feature {NONE} -- Externals

	cwel_msgboxparams_set (a_msgboxparams, a_window, a_hinstance, a_text, a_title: POINTER; a_style:INTEGER; an_icon: POINTER; a_language_id: INTEGER) is
			-- Set the fields of
			-- MSGBOXPARAMS
		external
			"C [macro <msgboxpa.h>] (LPMSGBOXPARAMS, HWND, HINSTANCE, LPCSTR, LPCSTR, DWORD, LPCSTR, DWORD)"
		end

	c_size_of_msgboxparams: INTEGER is
		external
			"C [macro <wel.h>]"
		alias
			"sizeof (MSGBOXPARAMS)"
		end
	cwin_make_int_resource (an_id: INTEGER): POINTER is
			-- Convert `an_id' to a pointer
			-- SDK MAKEINTRESOURCE
		external
			"C [macro <wel.h>] (WORD): EIF_POINTER"
		alias
			"MAKEINTRESOURCE"
		end

	cwin_make_lang_id (a_language, a_sublanguage: INTEGER): INTEGER is
			-- Create a language identifier
			-- from `a_language' and `a_sublanguage'
		external
			"C [macro <wel.h>] (USHORT, USHORT): EIF_INTEGER"
		alias
			"MAKELANGID"
		end

end -- class WEL_MSGBOXPARAMS


--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
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


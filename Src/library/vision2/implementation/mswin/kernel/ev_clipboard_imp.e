indexing
	description: "Objects that allow access to the operating %N%
	% system clipboard."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLIPBOARD_IMP

inherit
	EV_CLIPBOARD_I
		redefine
			interface
		end

	WEL_CLIPBOARD

create
	make

feature {NONE}-- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
		end

	initialize is
			-- initialize `Current'.
		do
			is_initialized := True
		end

	destroy is
		do
			--| FIXME
		end

feature -- Access

	text:STRING is
			-- `Result' is text of clipboard.
		local
			window: EV_WINDOW
			wel_window: WEL_WINDOW
		do
			create window
			wel_window ?= window.implementation
			open_clipboard (wel_window)
			if is_clipboard_format_available (Cf_text) then
				retrieve_clipboard_text
				Result := last_string
				Result.prune_all ('%R')
			end
			close_clipboard
		end

feature -- Status Setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to clipboard.
		local
			window: EV_WINDOW
			wel_window: WEL_WINDOW
			local_text: STRING
		do
			create window
			wel_window ?= window.implementation
			open_clipboard (wel_window)
			empty_clipboard
			local_text := clone (a_text)
			if local_text.substring_index ("%R%N", 1) = 0 then
				local_text.replace_substring_all ("%N", "%R%N")
			end
			set_clipboard_text (local_text)
			close_clipboard
		end

feature {EV_ANY_I}

	interface: EV_CLIPBOARD
		-- Interface of `Current'

end -- class EV_CLIPBOARD_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.3  2001/07/14 12:16:29  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.2  2001/06/07 23:08:12  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.6  2001/03/19 23:28:23  rogers
--| `Text' now prunes all %R's.
--|
--| Revision 1.1.2.5  2001/03/19 21:06:22  rogers
--| Fixed set_text. We now insert "%R%N" wherever there was "%N", as Windows
--| uses %R%N instead of %N.
--|
--| Revision 1.1.2.4  2000/12/13 19:00:50  rogers
--| Fixed bug which would cause a crash if you did not have at least one window
--| created in your application when attempting to access the clipboard.
--| Simplified set_text and text.
--|
--| Revision 1.1.2.3  2000/11/03 16:53:38  rogers
--| Implemented set_text.
--|
--| Revision 1.1.2.2  2000/11/02 03:18:19  manus
--| Removed non-used local variables
--|
--| Revision 1.1.2.1  2000/10/27 01:00:19  rogers
--| initial build.
--|
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

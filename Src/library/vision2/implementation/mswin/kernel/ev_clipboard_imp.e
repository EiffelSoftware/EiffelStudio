indexing
	description: "Objects that allow access to the operating %N%
		%system clipboard."
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
			-- Initialize `Current'.
		do
			is_initialized := True
		end

	destroy is
		do
			--| FIXME
		end

feature -- Access

	text: STRING is
			-- Text content of clipboard.
		local
			window: EV_WINDOW
			wel_window: WEL_WINDOW
		do
			create window
			wel_window ?= window.implementation
			open_clipboard (wel_window)
			if clipboard_open and then is_clipboard_format_available (feature {WEL_CLIPBOARD_CONSTANTS}.Cf_text) then
				retrieve_clipboard_text
				Result := last_string
				Result.prune_all ('%R')
			end
			close_clipboard
			if Result = Void then
				Result := ""
			end
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
			if clipboard_open then
				empty_clipboard
				local_text := clone (a_text)
				if local_text.substring_index ("%R%N", 1) = 0 then
					local_text.replace_substring_all ("%N", "%R%N")
				end
				set_clipboard_text (local_text)
				close_clipboard
			end
		end

feature {EV_ANY_I}

	interface: EV_CLIPBOARD
		-- Interface of `Current'

end -- class EV_CLIPBOARD_IMP

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


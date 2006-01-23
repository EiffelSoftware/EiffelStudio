indexing
	description: "Objects that allow access to the operating %N%
		%system clipboard."
	legal: "See notice at end of class."
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
			set_is_initialized (True)
		end

	destroy is
		do
			--| FIXME
			set_is_destroyed (True)
		end

feature -- Access

	text: STRING is
			-- Text content of clipboard.
		do
			open_clipboard (Void)
			if clipboard_open and then is_clipboard_format_available ({WEL_CLIPBOARD_CONSTANTS}.Cf_text) then
				retrieve_clipboard_text
				Result := last_string
				Result.prune_all ('%R')
			end
			close_clipboard
			if Result = Void then
				Result := ""
			end
		end
		
	has_text: BOOLEAN is
			-- Does the clipboard currently contain text?
		do
			open_clipboard (Void)
			Result := clipboard_open and is_clipboard_format_available ({WEL_CLIPBOARD_CONSTANTS}.Cf_text)
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
			if clipboard_open then
				empty_clipboard
				local_text := a_text.twin
				if local_text.substring_index ("%R%N", 1) = 0 then
					local_text.replace_substring_all ("%N", "%R%N")
				end
				set_clipboard_text (local_text)
				close_clipboard
			end
		end

feature {EV_ANY_I}

	interface: EV_CLIPBOARD;
		-- Interface of `Current'

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




end -- class EV_CLIPBOARD_IMP


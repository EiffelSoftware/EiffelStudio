note
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
		undefine
			default_create
		redefine
			interface
		end

	WEL_CLIPBOARD

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			create last_string.make_empty
			set_is_initialized (True)
		end

	destroy
		do
			--| FIXME
			set_is_destroyed (True)
		end

feature -- Access

	text: STRING_32
			-- Text content of clipboard.
		local
			l_result: detachable STRING_32
		do
			open_clipboard (Void)
			if clipboard_open then
				if is_clipboard_format_available ({WEL_CLIPBOARD_CONSTANTS}.Cf_unicodetext) then
					retrieve_clipboard_text_discarding_carriage_return
					l_result := last_string
				end
				close_clipboard
			end
			if l_result = Void then
				create Result.make_empty
			else
				Result := l_result
			end
		end

	has_text: BOOLEAN
			-- Does the clipboard currently contain text?
		do
			open_clipboard (Void)
			if clipboard_open then
				Result := is_clipboard_format_available ({WEL_CLIPBOARD_CONSTANTS}.Cf_unicodetext)
				close_clipboard
			end
		end

feature -- Status Setting

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to clipboard.
		local
			l_app_imp: detachable EV_APPLICATION_IMP
			wel_window: detachable WEL_WINDOW
		do
				-- Retrieve silly main window from application for clipboard retrieval.
			l_app_imp ?= (create {EV_ENVIRONMENT}).implementation.application_i
			check l_app_imp /= Void then end
			wel_window ?= l_app_imp.silly_main_window
			check wel_window /= Void then end
			open_clipboard (wel_window)
			if clipboard_open then
				empty_clipboard
				if not a_text.is_empty then
					set_clipboard_text_with_newline_conversion (a_text)
				end
				close_clipboard
			end
		end

feature {EV_ANY, EV_ANY_I}

	interface: detachable EV_CLIPBOARD note option: stable attribute end;
		-- Interface of `Current'

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_CLIPBOARD_IMP












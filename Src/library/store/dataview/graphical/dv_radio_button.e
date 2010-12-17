note
	description: "Radio button."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DV_RADIO_BUTTON

inherit
	EV_RADIO_BUTTON
		redefine
			selected_peer
		end

	DV_SENSITIVE_CHECK
		rename
			enable_checked as enable_select,
			disable_checked as disable_select
		undefine
			default_create,
			copy
		end

create
	make_with_text

feature -- Status report

	selected_peer: EV_RADIO_BUTTON
			-- Item in `peers' that is currently selected.
		do
			Result := implementation.selected_peer
		end

feature -- Access

	checked: BOOLEAN
			-- Boolean value held.
		do
			Result := is_selected
		end

feature -- Basic operations

	disable_select
			-- Do nothing.
		do
			check
				False
			end
		end

	request_sensitive
			-- Request display sensitive.
		do
			enable_sensitive
		end

	request_insensitive
			-- Request display insensitive.
		do
			disable_sensitive
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

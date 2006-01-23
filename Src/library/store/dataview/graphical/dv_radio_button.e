indexing
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
			implementation, create_implementation
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

feature -- Access

	checked: BOOLEAN is
			-- Boolean value held.
		do
			Result := is_selected
		end

feature -- Basic operations

	disable_select is
			-- Do nothing.
		do
			check
				False
			end
		end

	request_sensitive is
			-- Request display sensitive.
		do
			enable_sensitive
		end

	request_insensitive is
			-- Request display insensitive.
		do
			disable_sensitive
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: DV_RADIO_BUTTON_I

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {DV_RADIO_BUTTON_IMP} implementation.make (Current)
		end

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





end -- class DV_CHECK_BUTTON



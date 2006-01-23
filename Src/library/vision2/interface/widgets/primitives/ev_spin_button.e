indexing
	description:
		"[
			Displays `value' and two buttons that allow it to be adjusted up and
			down within `range'.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "gauge, edit, text, number, up, down"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SPIN_BUTTON

inherit
	EV_GAUGE
		redefine
			create_implementation,
			implementation,
			is_in_default_state
		end

	EV_TEXT_FIELD
		rename
			change_actions as text_change_actions
		redefine
			create_implementation,
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_value_range,
	make_with_text
	
feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN is
			-- Is `Current' in its default state.
		do
			Result := Precursor {EV_GAUGE} and then
				text.is_equal ("0")
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_SPIN_BUTTON_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_SPIN_BUTTON_IMP} implementation.make (Current)
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




end -- class EV_SPIN_BUTTON


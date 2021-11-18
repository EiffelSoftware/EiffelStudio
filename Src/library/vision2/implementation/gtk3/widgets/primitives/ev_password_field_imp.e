note
	description:
		"Eiffel Vision password field. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PASSWORD_FIELD_IMP

inherit
	EV_PASSWORD_FIELD_I
		undefine
			hide_border,
			return_actions
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		redefine
			make,
			interface
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create password field with `*'.
		do
			Precursor {EV_TEXT_FIELD_IMP}
			{GTK}.gtk_entry_set_visibility (entry_widget, False)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_PASSWORD_FIELD note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2014, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_PASSWORD_FIELD_IMP

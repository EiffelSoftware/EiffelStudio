note
	description: "Eiffel Vision password field. Mswindows implementation."
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
			text_length
		redefine
			interface
		end

	EV_TEXT_FIELD_IMP
		redefine
			interface,
			default_style
		end

create
	make

feature {NONE} -- Implementation

	default_style: INTEGER
			-- Password field style.
		do
			Result := Precursor | Es_password

				-- We have to make sure Es_multiline is not set as this is not compatible with Es_password.
			Result := Result & (Es_multiline.bit_not)
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

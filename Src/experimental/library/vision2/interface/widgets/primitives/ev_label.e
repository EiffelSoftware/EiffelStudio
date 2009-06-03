note
	description:
		"[
			Displays a textual label.
		]"
	legal: "See notice at end of class."
	appearance:
		"[
			---------
			|  text  |
			---------
		]"
	status: "See notice at end of class."
	keywords: "label, text"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LABEL

inherit
	EV_PRIMITIVE
		redefine
			implementation,
			is_in_default_state,
			is_in_default_state_for_tabs
		end

	EV_TEXT_ALIGNABLE
		redefine
			implementation,
			is_in_default_state
		end

	EV_FONTABLE
		redefine
			implementation,
			is_in_default_state
		end

create
	default_create,
	make_with_text

feature {NONE} -- Contract support

	is_in_default_state: BOOLEAN
			-- Is `Current' in its default state?
		do
			Result := Precursor {EV_PRIMITIVE} and
				Precursor {EV_TEXT_ALIGNABLE} and
				Precursor {EV_FONTABLE} and is_center_aligned
		end

	is_in_default_state_for_tabs: BOOLEAN
		do
			Result := not is_tabable_from and not is_tabable_to
		end


--feature -- Element change
--
--	set_angle (a_angle: REAL) is
--			-- Set counter-clockwise rotation of text from horizontal plane.
--			-- `a_angle' is expressed in radians.
--		do
--			implementation.set_angle (a_angle)
--		ensure
--			angle_set: a_angle = angle
--		end
--
--feature -- Access
--
--	angle: REAL is
--			-- Amount text is rotated counter-clockwise from horizontal plane in radians.
--			-- Default is 0
--		do
--			Result := implementation.angle
--		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	implementation: EV_LABEL_I
			-- Responsible for interaction with native graphics toolkit.

feature {NONE} -- Implementation

	create_implementation
			-- See `{EV_ANY}.create_implementation'.
		do
			create {EV_LABEL_IMP} implementation.make (Current)
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




end -- class EV_LABEL


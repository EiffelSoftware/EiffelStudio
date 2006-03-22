indexing
	description:
		"Eiffel Vision label. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_LABEL_I

inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_TEXT_ALIGNABLE_I
		redefine
			interface
		end

	EV_FONTABLE_I
		redefine
			interface
		end

--feature -- Element change
--
--	set_angle (a_angle: REAL) is
--			-- Set counter-clockwise rotation of text from horizontal plane.
--			-- `a_angle' is expressed in radians.
--		deferred
--		ensure
--			angle_set: a_angle = angle
--		end
--
--feature -- Access
--
--	angle: REAL is
--			-- Amount text is rotated counter-clockwise from horizontal plane in radians.
--			-- Default is 0
--		deferred
--		end

feature {EV_ANY_I} -- implementation

	interface: EV_LABEL;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end --class EV_LABEL_I


indexing
	description:
		"Base Eiffel Vision action sequence."
	status: "See notice at end of file."
	keywords: "event, action, sequence"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ACTION_SEQUENCE [EVENT_DATA -> TUPLE create make end]

inherit
	ACTION_SEQUENCE [EVENT_DATA]

feature -- Element change

	force_extend (an_item: PROCEDURE [ANY, TUPLE]) is
			-- Extend without checking type of `an_item'.
		deferred
		end

	extend_kamikaze (an_item: like item) is
			-- Extend `an_item' and remove it again after it is called.
		do
			extend (an_item)
			prune_when_called (an_item)
		end

end -- class EV_ACTION_SEQUENCE

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license.
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------
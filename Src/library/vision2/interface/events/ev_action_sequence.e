indexing
	description:
		"Base Eiffel Vision action sequence."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "event, action, sequence"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_ACTION_SEQUENCE [EVENT_DATA -> TUPLE create default_create end]

inherit
	ACTION_SEQUENCE [EVENT_DATA]
		undefine
			new_filled_list
		end

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




end -- class EV_ACTION_SEQUENCE


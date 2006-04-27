indexing
	description: "[
					Object that to export update_for_pick_and_drop feature
					which is in implementation.
																			]"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_DRAWING_AREA

inherit
	EV_DRAWING_AREA
		redefine
			create_implementation
		end

feature {EV_ANY_I} -- Implementation

	create_implementation is
			-- See `{EV_ANY}.create_implementation'.
		do
			create {SD_DRAWING_AREA_IMP} implementation.make (Current)
		end

	update_for_pick_and_drop (a_starting: BOOLEAN; a_pebble: ANY) is
			-- Update for pick and drop.
		require
			not_void: a_starting implies a_pebble /= Void
		deferred
		end

end

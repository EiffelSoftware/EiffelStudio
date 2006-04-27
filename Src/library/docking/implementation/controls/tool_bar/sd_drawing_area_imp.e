indexing
	description:"[
 					Object that to export update_for_pick_and_drop feature
					which is in implementation.
																				]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_IMP
		redefine
			update_for_pick_and_drop,
			interface
		end

create
	make

feature {NONE} -- Implementation

	update_for_pick_and_drop (a_starting: BOOLEAN) is
			-- Redefine
		local
			l_env: EV_ENVIRONMENT
			l_app_imp: EV_APPLICATION_IMP
		do
			create l_env
			l_app_imp ?= l_env.application.implementation
			check not_void: l_app_imp /= Void end
			interface.update_for_pick_and_drop (a_starting, l_app_imp.pick_and_drop_source.pebble)
		end

	interface: SD_DRAWING_AREA
			-- Redefine

end

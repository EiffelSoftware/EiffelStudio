indexing
	description: "[
					GTK implementation for SD_DRAWING_AREA.
					Currently it do nothing. Because GTK doesn't update_for_pick_and_drop.
					Windows implementation will do update_for_pick_and_drop.
																							]"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_IMP
		export
			{SD_NOTEBOOK_TAB_DRAWER_IMP} c_object
		end

create
	make

end

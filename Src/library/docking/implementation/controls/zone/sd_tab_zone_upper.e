indexing
	description: "Objects which tab is at top side"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TAB_ZONE_UPPER

inherit
	SD_TAB_ZONE
		redefine
			make
		end
create
	make

feature {NONE} -- Initlization

	make (a_content: SD_CONTENT; a_target_zone: SD_DOCKING_ZONE) is
			-- 
		do
			Precursor {SD_TAB_ZONE} (a_content, a_target_zone)
			internal_notebook.set_tab_position ({EV_NOTEBOOK}.tab_top)
		end
		
end

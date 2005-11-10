indexing
	description: "Objects that is a zone when floating."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_FLOATING_TAB_ZONE

inherit
	SD_MULTI_CONTENT_ZONE
			
	SD_DOCKER_SOURCE
		undefine
			default_create, copy	
		end
		
	SD_RESIZE_FLOATING_WINDOW
		rename
			prune as prune_resize_window,
			count as count_resize_window,
			extend as extend_resize_window,
			make as make_resize_window,
			handle_pointer_motion as handle_pointer_motion_resize_window
		end
create
	make

feature {NONE} -- Initlization

	make is
			-- 
		do
			create internal_shared
		end
		
feature {NONE} -- Implementation
--	internal_title_bar: SD_
	
	on_focus_in is
			-- 
		do
			internal_shared.docking_manager.disable_all_zones_focus_color
		end
	
	handle_zone_focus_out is
			-- 
		do
			
		end
end

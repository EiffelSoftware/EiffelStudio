indexing
	description: "Objects that is a tool bar which support docking"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_TOOL_BAR

inherit
	SD_HOR_VER_BOX
		rename
			extend as extend_hor_ver_box	
		end

create
	make
feature {NONE} -- Initlization
	
	make (a_vertical: BOOLEAN) is
			-- 
		do
			init (a_vertical)
			internal_vertical := a_vertical
			create internal_drag_area
			internal_drag_area.set_background_color ((create {EV_STOCK_COLORS}).black)
			internal_drag_area.set_minimum_size (10, 10)
			extend_hor_ver_box (internal_drag_area)
			disable_item_expand (internal_drag_area)			
			
			if internal_vertical then
				
			else
				create internal_hor_tool_bar
				
			end
		end
	
feature --
	
	extend (a_item: EV_TOOL_BAR_ITEM) is
			-- 
		local
			l_ver_tool_bar: EV_TOOL_BAR
		do
			if internal_vertical then
				create l_ver_tool_bar
				extend_hor_ver_box (l_ver_tool_bar)
				l_ver_tool_bar.extend (a_item)
			else
				internal_hor_tool_bar.extend (a_item)
			end
		end
		
feature {NONE} -- Implementation
	internal_hor_tool_bar: EV_TOOL_BAR

	internal_vertical: BOOLEAN
	
	internal_drag_area: EV_DRAWING_AREA
	
	internal_tool_bar_buttons: ARRAYED_LIST [EV_TOOL_BAR_ITEM]

end

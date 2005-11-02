indexing
	description: "Objects that store config datas about four auto hide zones."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_AUTO_HIDE_ZONE_DATA

create
	make
	
feature {NONE} -- Initlization
	make is
			-- Creation method.
		do
			create internal_zone_bottom.make(1)
			create internal_zone_left.make (1)
			create internal_zone_right.make (1)
			create internal_zone_top.make (1)
		end
		
feature -- Properties
	zone_top: like internal_zone_top is
			-- 
		do
			Result := internal_zone_top
		end
		
	zone_bottom: like internal_zone_bottom is
			-- 
		do
			Result := internal_zone_bottom
		end
		
	zone_left: like internal_zone_left is
			-- 
		do
			Result := internal_zone_left
		end
		
	zone_right: like internal_zone_right is
			-- 
		do
			Result := internal_zone_right
		end
		
feature {NONE} -- Implementation
	internal_zone_top, internal_zone_bottom, internal_zone_left, internal_zone_right: ARRAYED_LIST [TUPLE [STRING, INTEGER]]
			-- In tuple, first argument is title of content. second is width/height of zone.
end

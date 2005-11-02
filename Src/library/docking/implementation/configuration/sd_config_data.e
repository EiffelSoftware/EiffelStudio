indexing
	description: "Objects that represent the data about inner container's structure."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CONFIG_DATA

create
	make

feature {NONE} -- Initlization
	make is
			-- Creation method.
		do
			create internal_inner_container_datas.make (1)
			create internal_auto_hide_zones_data.make
		end
		
feature -- Properties
	inner_container_datas: like internal_inner_container_datas is
			-- 
		do
			Result := internal_inner_container_datas
		end
	
	set_inner_container_datas (a_data: like internal_inner_container_datas) is
			-- 
		require
			a_data_not_void: a_data /= Void
		do
			internal_inner_container_datas := a_data
		ensure
			a_data_set: a_data = internal_inner_container_datas
		end
		
	auto_hide_zones_data: like internal_auto_hide_zones_data is
			-- 
		do
			Result := internal_auto_hide_zones_data
		end
		
--	set_inner_container_void (a_value: BOOLEAN) is
--			-- 
----		require
----			a_value_not_void: a_value /= Void
--		do
--			internal_inner_container_void := a_value
--		end
--	
--	inner_container_void: BOOLEAN is
--			-- 
--		do
--			Result := internal_inner_container_void
--		end
		
feature {NONE}  -- Implementation
	
	internal_inner_container_datas: ARRAYED_LIST [SD_INNER_CONTAINER_DATA]
	
	internal_auto_hide_zones_data: SD_AUTO_HIDE_ZONE_DATA
	
--	internal_inner_container_void: BOOLEAN
end

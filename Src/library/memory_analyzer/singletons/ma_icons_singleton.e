indexing
	description: "Objects that contain all the icons used by this memory analyzer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_ICONS_SINGLETON
	
inherit
	MA_SHARED_PIXMAP_FACTORY

feature -- Set

	set_pixmap_directory (a_dir: STRING) is
			-- Set `internal_pixmap_path'.
		local
			l_set_once: like pixmap_path
		do
			create internal_pixmap_path.make_from_string (a_dir)
			l_set_once := pixmap_path
		ensure then
			path_valid: internal_pixmap_path.is_valid
		end
		
feature {NONE} -- Implementation

	pixmap_width: INTEGER is 16
			-- The width of the icons
	
	pixmap_height: INTEGER is 16
			-- The height of the icons
	
	pixmap_path: DIRECTORY_NAME is 
			-- Path containing all of the Memory Analyzer icons
		once
			Result := internal_pixmap_path
		end
		
	internal_pixmap_path: like pixmap_path
			-- Path where have icons image.
			
	image_matrix: EV_PIXMAP is
			-- The pixmap contain all the icons
		once
			Result := pixmap_file_content ("memory_analyzer_icon_matrix")
		end
		
	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			-- 
		once
			create Result.make (25)
			Result.put ([1, 1], icon_auto_refresh)
			Result.put ([1, 2], icon_auto_refresh_speed)
			Result.put ([1, 3], icon_state_change)
			Result.put ([1, 4], icon_filter)
			Result.put ([1, 5], icon_gabage_clean_now)
			Result.put ([2, 1], icon_gabage_clean_enable)
			Result.put ([2, 2], icon_gabage_clean_disable)
			Result.put ([2, 3], icon_eiffel_pebble)
			Result.put ([2, 4], icon_object_graph)
			Result.put ([2, 5], icon_object_grid)
			Result.put ([3, 1], icon_gabage_collector_info)
			Result.put ([3, 2], icon_refresh_info)
			Result.put ([3, 3], icon_save_current_state)
			Result.put ([3, 4], icon_eiffel_pebble_X)
			Result.put ([3, 5], icon_object_grid_class)
			Result.put ([4, 1], icon_open_system_states)
			Result.put ([4, 2], icon_system_state_from)
			Result.put ([4, 3], icon_system_state_to)
			Result.put ([4, 4], icon_new_filter_class_name)
			Result.put ([4, 5], icon_object_grid_class_X)
			Result.put ([5, 1], icon_new_filter_class_name_X)
			Result.compare_objects
		end
		
		
feature -- Icons' Names

	icon_auto_refresh: STRING is "icon_auto_refresh"
			-- Icon name
	icon_auto_refresh_speed: STRING is "icon_auto_refresh_speed"
			-- Icon name
	icon_state_change: STRING is "icon_state_change"
			-- Icon name
	icon_filter: STRING is "icon_filter"
			-- Icon name						
	icon_gabage_clean_now: STRING is "icon_gabage_clean_now"
			-- Icon name			
	icon_gabage_clean_enable: STRING is "icon_gabage_clean_enable"
			-- Icon name		
	icon_gabage_clean_disable: STRING is "icon_gabage_clean_disable"
			-- Icon name
	icon_eiffel_pebble: STRING is "icon_eiffel_pebble"
			-- Icon name
	icon_object_graph: STRING is "icon_object_graph"
			-- Icon name
	icon_object_grid: STRING is "icon_object_grid"
			-- Icon name
	icon_gabage_collector_info: STRING is "icon_gabage_collector_info"
			-- Icon name
	icon_refresh_info: STRING is "icon_refresh_info"
			-- Icon name
	icon_save_current_state: STRING is "icon_save_current_state"
			-- Icon name								
	icon_eiffel_pebble_X: STRING is "icon_eiffel_pebble_X"
			-- Icon name
	icon_object_grid_class: STRING is "icon_object_grid_class"
			-- Icon name
	icon_object_grid_class_X: STRING is "icon_object_grid_class_X"
			-- Icon name
	icon_open_system_states: STRING is "icon_open_system_states"
			-- Icon name
	icon_system_state_from: STRING is "icon_system_state_from"
			-- Icon name.
	icon_system_state_to: STRING is "icon_system_state_to"
			-- Icon name
	icon_new_filter_class_name: STRING is "icon_new_filter_class_name"
			-- Icon name
	icon_new_filter_class_name_X: STRING is "icon_new_filter_class_name_X";
			-- Icon name			
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




end

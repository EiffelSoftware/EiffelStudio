note
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

	set_pixmap_directory (a_dir: STRING)
			-- Set `internal_pixmap_path'.
		local
			l_set_once: like pixmap_path
		do
			create internal_pixmap_path.make_from_string (a_dir)
			l_set_once := pixmap_path
		ensure then
			path_valid: attached internal_pixmap_path as le_path and then le_path.is_valid
		end

feature {NONE} -- Implementation

	pixmap_width: INTEGER = 16
			-- The width of the icons

	pixmap_height: INTEGER = 16
			-- The height of the icons

	pixmap_path: DIRECTORY_NAME
			-- Path containing all of the Memory Analyzer icons
		local
			l_result: like internal_pixmap_path
		do
			l_result := internal_pixmap_path
			check attached l_result end -- FIXME: Implied by ...?
			Result := l_result
		end

	internal_pixmap_path: detachable like pixmap_path
			-- Path where have icons image.

	image_matrix: EV_PIXMAP
			-- The pixmap contain all the icons
		once
			Result := pixmap_file_content ("memory_analyzer_icon_matrix")
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING]
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
			Result.put ([4, 5], icon_object_grid_class_x)
			Result.put ([5, 1], icon_new_filter_class_name_x)
			Result.put ([5, 2], icon_collect_statics)
			Result.compare_objects
		end

feature -- Icons

	auto_refresh_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_auto_refresh)
		ensure
			auto_refresh_icon_not_void: Result /= Void
		end

	auto_refresh_speed_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_auto_refresh_speed)
		ensure
			auto_refresh_speed_icon_not_void: Result /= Void
		end

	state_change_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_state_change)
		ensure
			state_change_icon_not_void: Result /= Void
		end

	filter_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_filter)
		ensure
			filter_icon_not_void: Result /= Void
		end

	gabage_clean_now_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_gabage_clean_now)
		ensure
			gabage_clean_now_icon_not_void: Result /= Void
		end

	gabage_clean_enable_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_gabage_clean_enable)
		ensure
			gabage_clean_enable_icon_not_void: Result /= Void
		end

	gabage_clean_disable_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_gabage_clean_disable)
		ensure
			gabage_clean_disable_icon_not_void: Result /= Void
		end

	eiffel_pebble_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_eiffel_pebble)
		ensure
			eiffel_pebble_icon_not_void: Result /= Void
		end

	object_graph_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_object_graph)
		ensure
			object_graph_icon_not_void: Result /= Void
		end

	object_grid_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_object_grid)
		ensure
			object_grid_icon_not_void: Result /= Void
		end

	gabage_collector_info_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_gabage_collector_info)
		ensure
			gabage_collector_info_icon_not_void: Result /= Void
		end

	refresh_info_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_refresh_info)
		ensure
			refresh_info_icon_not_void: Result /= Void
		end

	save_current_state_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_save_current_state)
		ensure
			save_current_state_icon_not_void: Result /= Void
		end

	eiffel_pebble_x_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_eiffel_pebble_x)
		ensure
			eiffel_pebble_x_icon_not_void: Result /= Void
		end

	object_grid_class_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_object_grid_class)
		ensure
			object_grid_class_icon_not_void: Result /= Void
		end

	object_grid_class_x_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_object_grid_class_x)
		ensure
			object_grid_class_x_icon_not_void: Result /= Void
		end

	open_system_states_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_open_system_states)
		ensure
			open_system_states_icon_not_void: Result /= Void
		end

	system_state_from_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_system_state_from)
		ensure
			system_state_from_icon_not_void: Result /= Void
		end

	system_state_to_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_system_state_to)
		ensure
			system_state_to_icon_not_void: Result /= Void
		end

	new_filter_class_name_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_new_filter_class_name)
		ensure
			new_filter_class_name_icon_not_void: Result /= Void
		end

	new_filter_class_name_x_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_new_filter_class_name_x)
		ensure
			new_filter_class_name_x_icon_not_void: Result /= Void
		end

	collect_statics_icon: EV_PIXMAP
		once
			Result := pixmap_file_content (icon_collect_statics)
		ensure
			collect_statics_item_not_void: Result /= Void
		end

feature {NONE} -- Icons' Names

	icon_auto_refresh: STRING = "icon_auto_refresh"
	icon_collect_statics: STRING = "icon_collect_statics"
	icon_auto_refresh_speed: STRING = "icon_auto_refresh_speed"
	icon_state_change: STRING = "icon_state_change"
	icon_filter: STRING = "icon_filter"
	icon_gabage_clean_now: STRING = "icon_gabage_clean_now"
	icon_gabage_clean_enable: STRING = "icon_gabage_clean_enable"
	icon_gabage_clean_disable: STRING = "icon_gabage_clean_disable"
	icon_eiffel_pebble: STRING = "icon_eiffel_pebble"
	icon_object_graph: STRING = "icon_object_graph"
	icon_object_grid: STRING = "icon_object_grid"
	icon_gabage_collector_info: STRING = "icon_gabage_collector_info"
	icon_refresh_info: STRING = "icon_refresh_info"
	icon_save_current_state: STRING = "icon_save_current_state"
	icon_eiffel_pebble_x: STRING = "icon_eiffel_pebble_X"
	icon_object_grid_class: STRING = "icon_object_grid_class"
	icon_object_grid_class_x: STRING = "icon_object_grid_class_X"
	icon_open_system_states: STRING = "icon_open_system_states"
	icon_system_state_from: STRING = "icon_system_state_from"
	icon_system_state_to: STRING = "icon_system_state_to"
	icon_new_filter_class_name: STRING = "icon_new_filter_class_name"
	icon_new_filter_class_name_x: STRING = "icon_new_filter_class_name_X";
			-- Icon names

note
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

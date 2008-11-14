indexing
	description: "Objects that provide access to constants loaded from files."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_CONSTANTS_IMP

feature {NONE} -- Initialization

	initialize_constants is
			-- Load all constants from file.
		local
			file: PLAIN_TEXT_FILE
		do
			if not constants_initialized then
				create file.make (file_name)
				if file.exists then
					file.open_read
					file.readstream (file.count)
					file.close
					parse_file_contents (file.laststring)
				end
				initialized_cell.put (True)
			end
		ensure
			initialized: constants_initialized
		end

feature -- Access

	lb_cpu_time_average: STRING is
			-- `Result' is STRING constant named `lb_cpu_time_average'.
		once
			Result := "Cpu Time Average"
		end

	b_filter: STRING is
			-- `Result' is STRING constant named `b_filter'.
		once
			Result := "Filter"
		end

	lb_system_time: STRING is
			-- `Result' is STRING constant named `lb_system_time'.
		once
			Result := "System Time"
		end

	padding_width: INTEGER is
			-- `Result' is INTEGER constant named padding_width.
		once
			Result := 2
		end

	lb_coalesce_period: STRING is
			-- `Result' is STRING constant named `lb_coalesce_period'.
		once
			Result := "Coalesce Period"
		end

	tb_disable_garbage_collector: STRING is
			-- `Result' is STRING constant named `tb_disable_garbage_collector'.
		once
			Result := "Disable garbage collector"
		end

	b_clear_graph_except_selected: STRING is
			-- `Result' is STRING constant named `b_clear_graph_except_selected'.
		once
			Result := "Clear Except Selected"
		end

	seperator_width: INTEGER is
			-- `Result' is INTEGER constant named seperator_width.
		once
			Result := 10
		end

	lb_cpu_interval_time_average: STRING is
			-- `Result' is STRING constant named `lb_cpu_interval_time_average'.
		once
			Result := "Cpu Interval Time Average"
		end

	b_arrange_circle: STRING is
			-- `Result' is STRING constant named `b_arrange_circle'.
		once
			Result := "Arrange Nodes in Grid"
		end

	b_find_tip_by_type: STRING is
			-- `Result' is STRING constant named `b_find_tip_by_type'.
		once
			Result := "Find the object by type name"
		end

	b_clear_graph: STRING is
			-- `Result' is STRING constant named `b_clear_graph'.
		once
			Result := "Clear Graph"
		end

	lb_real_interval_time: STRING is
			-- `Result' is STRING constant named `lb_real_interval_time'.
		once
			Result := "Real Interval Time"
		end

	lb_scavenge_zone_size: STRING is
			-- `Result' is STRING constant named `lb_scavenge_zone_size'.
		once
			Result := "Scavenge Zone Size"
		end

	lb_system_time_average: STRING is
			-- `Result' is STRING constant named `lb_system_time_average'.
		once
			Result := "System Time Average"
		end

	tb_open_system_states: STRING is
			-- `Result' is STRING constant named `tb_open_system_states'.
		once
			Result := "Open system states"
		end

	tb_filter_save: STRING is
			-- `Result' is STRING constant named `tb_filter_save'.
		once
			Result := "Save a filter file"
		end

	lb_generation_object_limit: STRING is
			-- `Result' is STRING constant named `lb_generation_object_limit'.
		once
			Result := "Generation Object Limit"
		end

	lb_largest_coalesced_block: STRING is
			-- `Result' is STRING constant named `lb_largest_coalesced_block'.
		once
			Result := "Largest Coalesced Block"
		end

	tb_save_current_datas: STRING is
			-- `Result' is STRING constant named `tb_save_current_datas'.
		once
			Result := "Save current datas"
		end

	lb_zoom: STRING is
			-- `Result' is STRING constant named `lb_zoom'.
		once
			Result := "Zoom"
		end

	lb_real_time_average: STRING is
			-- `Result' is STRING constant named `lb_real_time_average'.
		once
			Result := "Real Time Average"
		end

	main_notebook_tab_width_minimum: INTEGER is
			-- `Result' is INTEGER constant named main_notebook_tab_width_minimum.
		once
			Result := 690
		end

	dlg_max_width_speed: INTEGER is
			-- `Result' is INTEGER constant named dlg_max_width_speed.
		once
			Result := 38
		end

	nb_memory_statistics: STRING is
			-- `Result' is STRING constant named `nb_memory_statistics'.
		once
			Result := "Memory Statistics"
		end

	lb_memory_used: STRING is
			-- `Result' is STRING constant named `lb_memory_used'.
		once
			Result := "Memory Used"
		end

	nb_object_graph: STRING is
			-- `Result' is STRING constant named `nb_object_graph'.
		once
			Result := "Object Graph"
		end

	b_find_referers: STRING is
			-- `Result' is STRING constant named `b_find_referers'.
		once
			Result := "Find Referers"
		end

	b_show_object_changed: STRING is
			-- `Result' is STRING constant named `b_show_object_changed'.
		once
			Result := "Show object changed"
		end

	lb_max_memory: STRING is
			-- `Result' is STRING constant named `lb_max_memory'.
		once
			Result := "Max Memory"
		end

	lb_collected: STRING is
			-- `Result' is STRING constant named `lb_collected'.
		once
			Result := "Collected"
		end

	lb_collection_period: STRING is
			-- `Result' is STRING constant named `lb_collection_period'.
		once
			Result := "Collection Period"
		end

	lb_chunk_size: STRING is
			-- `Result' is STRING constant named `lb_chunk_size'.
		once
			Result := "Chunk Size"
		end

	tb_set_analyze_filter: STRING is
			-- `Result' is STRING constant named `tb_set_analyze_filter'.
		once
			Result := "Set analyze filter"
		end

	main_notebook_tab_height_minimum: INTEGER is
			-- `Result' is INTEGER constant named main_notebook_tab_height_minimum.
		once
			Result := 450
		end

	lb_objects_count: STRING is
			-- `Result' is STRING constant named `lb_objects_count'.
		once
			Result := "Objects Count"
		end

	tb_refresh_infomation: STRING is
			-- `Result' is STRING constant named `tb_refresh_infomation'.
		once
			Result := "Refresh infomation"
		end

	lb_memory_threshold: STRING is
			-- `Result' is STRING constant named `lb_memory_threshold'.
		once
			Result := "Memory Threshold"
		end

	lb_cycle_count: STRING is
			-- `Result' is STRING constant named `lb_cycle_count'.
		once
			Result := "Cycle Count"
		end

	lb_object_name: STRING is
			-- `Result' is STRING constant named `lb_object_name'.
		once
			Result := "Object Name:"
		end

	lb_typ_name: STRING is
			-- `Result' is STRING constant named `lb_typ_name'.
		once
			Result := "Type Name:"
		end

	nb_memory_changed: STRING is
			-- `Result' is STRING constant named `nb_memory_changed'.
		once
			Result := "Memory Changed"
		end

	lb_system_interval_time: STRING is
			-- `Result' is STRING constant named `lb_system_interval_time'.
		once
			Result := "System Iinterval Time"
		end

	dlg_max_height_speed: INTEGER is
			-- `Result' is INTEGER constant named dlg_max_height_speed.
		once
			Result := 100
		end

	tb_garbage_clean_now: STRING is
			-- `Result' is STRING constant named `tb_garbage_clean_now'.
		once
			Result := "Garbage clean now"
		end

	tb_add_new_class_name: STRING is
			-- `Result' is STRING constant named `tb_add_new_class_name'.
		once
			Result := "Add new class name"
		end

	lb_system_interval_time_average: STRING is
			-- `Result' is STRING constant named `lb_system_interval_time_average'.
		once
			Result := "System Interval Time Average"
		end

	b_add_current_state: STRING is
			-- `Result' is STRING constant named `b_add_current_state'.
		once
			Result := "Add current state"
		end

	lb_speed: STRING is
			-- `Result' is STRING constant named `lb_speed'.
		once
			Result := "Speed"
		end

	lb_collected_average: STRING is
			-- `Result' is STRING constant named `lb_collected_average'.
		once
			Result := "Collected Average"
		end

	border_width: INTEGER is
			-- `Result' is INTEGER constant named border_width.
		once
			Result := 2
		end

	lb_auto_refresh: STRING is
			-- `Result' is STRING constant named `lb_auto_refresh'.
		once
			Result := "Auto Refresh"
		end

	tb_refresh_speed_is_normal: STRING is
			-- `Result' is STRING constant named `tb_refresh_speed_is_normal'.
		once
			Result := "Refresh speed is normal"
		end

	b_find: STRING is
			-- `Result' is STRING constant named `b_find'.
		once
			Result := "Find"
		end

	nb_object_grid: STRING is
			-- `Result' is STRING constant named `nb_object_grid'.
		once
			Result := "Object Grid"
		end

	nb_search_route: STRING is
		once
			Result := "Search Route"
		end

	lb_real_interval_time_average: STRING is
			-- `Result' is STRING constant named `lb_real_interval_time_average'.
		once
			Result := "Real Interval Time Average"
		end

	lb_real_time: STRING is
			-- `Result' is STRING constant named `lb_real_time'.
		once
			Result := "Real Time"
		end

	lb_cpu_time: STRING is
			-- `Result' is STRING constant named `lb_cpu_time'.
		once
			Result := "Cpu Time"
		end

	wnd_filter_name: STRING is
			-- `Result' is STRING constant named `wnd_filter_name'.
		once
			Result := "Filter setting"
		end

	lb_tenure: STRING is
			-- `Result' is STRING constant named `lb_tenure'.
		once
			Result := "Tenure"
		end

	b_find_tip_by_instance_name: STRING is
			-- `Result' is STRING constant named `b_find_tip_by_instance_name'.
		once
			Result := "Find the object by instance name"
		end

	lb_cpu_interval_time: STRING is
			-- `Result' is STRING constant named `lb_cpu_interval_time'.
		once
			Result := "Cpu Interval Time"
		end

	wnd_memory_analyzer: STRING is
			-- `Result' is STRING constant named `wnd_memory_analyzer'.
		once
			Result := "Memory Analyzer"
		end

	tb_filter_open: STRING is
			-- `Result' is STRING constant named `tb_filter_open'.
		once
			Result := "Open a filter file"
		end

	tb_auto_refresh_enabled: STRING is
			-- `Result' is STRING constant named `tb_auto_refresh_enabled'.
		once
			Result := "Auto refresh enabled"
		end

	tb_collect_statics_enabled: STRING is
			-- `Result' is STRING constant named `tb_auto_refresh_enabled'.
		once
			Result := "Statics Collection disabled"
		end

feature -- Access

--| FIXME `constant_by_name' and `has_constant' `constants_initialized' are only required until the complete change to
--| constants is complete. They are required for the pixmaps at the moment.

	constants_initialized: BOOLEAN is
			-- Have constants been initialized from file?
		do
			Result := initialized_cell.item
		end

	string_constant_by_name (a_name: STRING): STRING is
			-- `Result' is STRING
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		do
			Result := (all_constants.item (a_name)).twin
		ensure
			Result_not_void: Result /= Void
		end

	integer_constant_by_name (a_name: STRING): INTEGER is
			-- `Result' is STRING
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
			has_constant (a_name)
		local
			l_string: STRING
		do
			l_string := (all_constants.item (a_name)).twin
			check
				is_integer: l_string.is_integer
			end

			Result := l_string.to_integer
		end

	has_constant (a_name: STRING): BOOLEAN is
			-- Does constant `a_name' exist?
		require
			initialized: constants_initialized
			name_valid: a_name /= Void and not a_name.is_empty
		do
			Result := all_constants.item (a_name) /= Void
		end

feature {NONE} -- Implementation

	initialized_cell: CELL [BOOLEAN] is
			-- A cell to hold whether the constants have been loaded.
		once
			create Result.put (False)
		end

	all_constants: HASH_TABLE [STRING, STRING] is
			-- All constants loaded from constants file.
		once
			create Result.make (4)
		end

	file_name: STRING is "constants.txt"
		-- File name from which constants must be loaded.

	String_constant: STRING is "STRING"

	Integer_constant: STRING is "INTEGER"

	parse_file_contents (content: STRING) is
			-- Parse contents of `content' into `all_constants'.
		local
			line_contents: STRING
			is_string: BOOLEAN
			is_integer: BOOLEAN
			start_quote1, end_quote1, start_quote2, end_quote2: INTEGER
			name, value: STRING
		do
			from
			until
				content.is_equal ("")
			loop
				line_contents := first_line (content)
				if line_contents.count /= 1 then
					is_string := line_contents.substring_index (String_constant, 1) /= 0
					is_integer := line_contents.substring_index (Integer_constant, 1) /= 0
					if is_string or is_integer then
						start_quote1 := line_contents.index_of ('"', 1)
						end_quote1 := line_contents.index_of ('"', start_quote1 + 1)
						start_quote2 := line_contents.index_of ('"', end_quote1 + 1)
						end_quote2 := line_contents.index_of ('"', start_quote2 + 1)
						name := line_contents.substring (start_quote1 + 1, end_quote1 - 1)
						value := line_contents.substring (start_quote2 + 1, end_quote2 - 1)
						all_constants.put (value, name)
					end
				end
			end
		end

	first_line (content: STRING): STRING is
			-- `Result' is first line of `Content',
			-- which will be stripped from `content'.
		require
			content_not_void: content /= Void
			content_not_empty: not content.is_empty
		local
			new_line_index: INTEGER
		do
			new_line_index := content.index_of ('%N', 1)
			if new_line_index /= 0 then
				Result := content.substring (1, new_line_index)
				content.keep_tail (content.count - new_line_index)
			else
				Result := content.twin
				content.keep_head (0)
			end
		ensure
			Result_not_void: Result /= Void
			no_characters_lost: old content.count = Result.count + content.count
		end

	set_with_named_file (a_pixmap: EV_PIXMAP; a_file_name: STRING) is
			-- Set image of `a_pixmap' from file, `a_file_name'.
			-- If `a_file_name' does not exist, do nothing.
		require
			a_pixmap_not_void: a_pixmap /= Void
			a_file_name /= Void
		local
			l_file: RAW_FILE
		do
			create l_file.make (a_file_name)
			if l_file.exists then
				a_pixmap.set_with_named_file (a_file_name)
			end
		end

invariant
	all_constants_not_void: all_constants /= Void

indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class MA_CONSTANTS_IMP

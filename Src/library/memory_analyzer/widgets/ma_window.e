indexing
	description: "This class is the main window of MEMORY ANALYZER.%
		%May the memory analyzer communicate with other program which can surround the target debugged application%
		% and send the MEMORY's memory map to a pipe? It should be nice, because it will only analyze the objects which%
		%we care."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_WINDOW

inherit
	MA_WINDOW_IMP
		redefine
			destroy
		end

	MA_SINGLETON_FACTORY
		export
			{NONE} all
		undefine
			copy,
			default_create
		end
create
	make

feature {NONE} -- Initialization
	make (a_dir: STRING) is
			--
		require
			a_dir_not_void: a_dir /= Void
		do
			icons.set_pixmap_directory (a_dir)
			default_create
		ensure
--			dir_set: icon
		end

	user_initialization is
			-- Called by `initialize'.
			-- Any custom user initialization that
			-- could not be performed in `initialize',
			-- (due to regeneration of implementation class)
			-- can be added here.
		do
			set_main_window (Current)
			create analyze_gc.make
			create analyze_object_gra.make_with_drawable (object_drawing)
			create analyze_object_snap.make_with_grid (object_grid)
			create analyze_route_searcher.make (analyze_object_snap, route_results_panel)
			create increase_detector.make

			create timer
			timer.actions.extend (agent timer_event)
			timer.set_interval (refresh_interval)
			main_book.drop_actions.extend (agent main_book_drop_pebble)
			main_book.drop_actions.set_veto_pebble_function (agent main_book_dropable)

			refresh_interval := refresh_interval_normal
			auto_refresh.enable_select

			filter_setting.drop_actions.extend (agent handle_filter_button_drop)

			init_icons

			show_actions.extend (agent analyze_gc.redraw_for_resize)

				-- Small hack to ensure that first time `split_incre' is shown it
				-- is shown with the right proportion as `resize_actions' are called
				-- when notebook tab shows its content.
			split_incre.resize_actions.force_extend (agent update_splitter_proportion_once (split_incre, 0.5))

			gc_graphs.resize_actions.force_extend (agent analyze_gc.redraw_for_resize)

			search_route_button.select_actions.extend (agent search_route)
		ensure then
			main_window_set: main_window_not_void
			timer_action_set: timer.actions.count > 0
			notebook_drop_action_set: main_book.drop_actions.count > 0
			update_interval_set_normal: refresh_interval = refresh_interval_normal
			auto_refresh_button_selected: auto_refresh.is_selected
		end

	init_icons is
			-- Initialize the icons in the system.
		require

			refresh_button_not_void: not refresh.is_destroyed
			gc_now_button_not_void: not gc_now.is_destroyed
			save_datas_button_not_void: not save_datas.is_destroyed
			auto_refresh_button_not_void: not auto_refresh.is_destroyed
			refresh_speed_button_not_void: not refresh_speed.is_destroyed
			gc_enable_button_not_void: not gc_enable.is_destroyed
			filter_setting_button_not_void: not filter_setting.is_destroyed
			retreive_button_not_void: not retreive.is_destroyed
		do
			main_book.item_tab (tab_garbage_collector_info).set_pixmap (icons.gabage_collector_info_icon)
			main_book.item_tab (tab_object_grid).set_pixmap (icons.object_grid_icon)
			main_book.item_tab (object_routes_panel).set_pixmap (icons.collect_statics_icon)
			main_book.item_tab (tab_object_graph).set_pixmap (icons.object_graph_icon)
			main_book.item_tab (tab_states_compare).set_pixmap (icons.state_change_icon)

			refresh.set_pixmap (icons.refresh_info_icon)
			gc_now.set_pixmap (icons.gabage_clean_now_icon)
			save_datas.set_pixmap (icons.save_current_state_icon)
			auto_refresh.set_pixmap (icons.auto_refresh_icon)
			refresh_speed.set_pixmap (icons.auto_refresh_speed_icon)
			gc_enable.set_pixmap (icons.gabage_clean_enable_icon)
			filter_setting.set_pixmap (icons.filter_icon)
			retreive.set_pixmap (icons.open_system_states_icon)
			collect_statics.set_pixmap (icons.collect_statics_icon)
		ensure
			tab_garbage_collector_info_pixmap_set: main_book.item_tab (tab_garbage_collector_info).pixmap /= Void
			tab_object_grid_pixmap_set: main_book.item_tab (tab_object_grid).pixmap /= Void
			tab_object_graph_pixmap_set: main_book.item_tab (tab_object_graph).pixmap /= Void
			tab_states_compare_pixmap_set: main_book.item_tab (tab_states_compare).pixmap /= Void
			refresh_pixmap_set: refresh.pixmap /= Void
			gc_now_pixmap_set: gc_now.pixmap /= Void
			save_datas_pixmap_set: save_datas.pixmap /= Void
			auto_refresh_pixmap_set: auto_refresh.pixmap /= Void
			refresh_speed_pixmap_set: refresh_speed.pixmap /= Void
			gc_enable_pixmap_set: gc_enable.pixmap /= Void
			filter_setting_pixmap_set: filter_setting.pixmap /= Void
			retreive_pixmap_set: retreive.pixmap /= Void
		end

feature -- Redefine

	destroy is
			-- Destroy window, clear singleton.
		do
			timer.set_interval (0)
			timer.actions.wipe_out
			timer := Void
			main_book.drop_actions.wipe_out
			filter_setting.drop_actions.wipe_out
			show_actions.wipe_out
			split_incre.resize_actions.wipe_out
			gc_graphs.resize_actions.wipe_out
			if not filter_window.is_destroyed then
				filter_window.destroy
			end
			Precursor {MA_WINDOW_IMP}
		end

feature {NONE} -- Implementation for agents

	update_splitter_proportion_once (a_splitter: EV_SPLIT_AREA; a_proportion: REAL) is
			-- Set `a_splitter' with `a_proportion'.
			-- Wipe out `a_splitter' `resize_actions' when `a_splitter' is shown.
		require
			a_splitter_not_void: a_splitter /= Void
			a_splitter_not_destroyed: not a_splitter.is_destroyed
			a_splitter_full: a_splitter.full
			a_proportion_valid: a_proportion >= 0 and a_proportion <= 1
		do
			if a_splitter.is_displayed then
				a_splitter.resize_actions.wipe_out
			end
			a_splitter.set_proportion (a_proportion)
		ensure
			a_splitter_resize_actions_empty: a_splitter.is_displayed implies a_splitter.resize_actions.is_empty
		end

	eiffel_view_frame_size_change (a_x, a_y, a_width, a_height: INTEGER) is
			-- Handle frame change.
		do

		end

	retreive_states is
			-- Retreive object states from a file.
		do
			increase_detector.states_open_from_file
		end

	save_data_clicked is
			-- Save current system datas to a file.
		do
			increase_detector.states_save_to_file
		end

	filter_clicked is
			-- When the user click the filter button.
		do
			filter_window.show
		end

	auto_refresh_enable is
			-- Enable or disable auto refresh memory graph.
		do
			if auto_refresh.is_selected then
				timer.set_interval (refresh_interval)
				auto_refresh.set_tooltip ("Auto refresh enabled")
			else
				timer.set_interval (0)
				auto_refresh.set_tooltip ("Auto refresh disabled")
			end
		ensure then
			timer_state_changed: old timer.interval /= timer.interval
			auto_refresh_tooltip_changed: old auto_refresh.tooltip /= auto_refresh.tooltip
		end

	collect_statics_enable is
			-- Enable or disable collect static memory object references.
		do
			if collect_statics.is_selected then
				collect_statics.set_tooltip ("Statics Collection enabled")
				analyze_object_snap.set_finding_route_to_once (True)
			else
				collect_statics.set_tooltip ("Statics Collection disabled")
				analyze_object_snap.set_finding_route_to_once (False)
			end
		ensure then
			timer_state_changed: old timer.interval /= timer.interval
			auto_refresh_tooltip_changed: old auto_refresh.tooltip /= auto_refresh.tooltip
		end

	auto_refresh_change_speed is
			-- Change the refresh speed.
		do
			if timer.interval /= 0 then
				inspect refresh_interval
					when refresh_interval_low then
						refresh_interval := refresh_interval_normal
						timer.set_interval (refresh_interval)
						refresh_speed.set_tooltip ("Refresh speed is normal")
					when refresh_interval_normal then
						refresh_interval := refresh_interval_hi
						timer.set_interval (refresh_interval)
						refresh_speed.set_tooltip ("Refresh speed is hi")
					when refresh_interval_hi then
						refresh_interval := refresh_interval_low
						timer.set_interval (refresh_interval)
						refresh_speed.set_tooltip ("Refresh speed is low")
				end
			end
		ensure then
			refresh_speed_toollip_changed: timer.interval /= 0 implies old refresh_speed.tooltip /= refresh_speed.tooltip
			timer_interval_changed: timer.interval /= 0 implies old timer.interval /= timer.interval
		end

	arrange_circle_clicked is
			-- Arrage the nodes in a circle.
		do
			analyze_object_gra.arrange_in_grid
		end

	main_book_drop_pebble (a_item: MA_OBJECT_STONE) is
			-- Things to do when user drop a pebble on the main_boon's tab.
		require
			a_item_not_void: a_item /= Void
		do
			analyze_object_gra.drop_a_object (a_item.object)
			main_book.select_item (tab_object_graph)
		end

	main_book_dropable (a_item: MA_OBJECT_STONE): BOOLEAN is
			-- If the tab where user pointer is at dropable?
		do
			if a_item /= Void then
				Result :=  main_book.pointed_tab_index = main_book.index_of (tab_object_graph, 1)
			end
		end

	handle_filter_button_drop (a_stone: MA_CLASS_STONE) is
			-- Handle when user drop a class item from object grid to filter button.
		require
			a_stone_not_void: a_stone /= Void
		do
			filter_window.add_class_name (a_stone.class_name)
		end

--	from_object_grid_to_object_graph (x, y: INTEGER): EV_NOTEBOOK is
--			-- Drop pebbel on object graph.
--		do
--			
--		end

	split_incre_hori_double_clicked (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- When user double click the horizontal split in the memory increase dector window.
		do
			increase_detector.adjust_split_horizontal
		end

	split_info_double_clicked (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- When user double click the split in the memory statistics window.
		do
			tab_garbage_collector_info.set_split_position (tab_garbage_collector_info.maximum_split_position)
		end

	split_area_incre_double_clicked (a_x, a_y, a_button: INTEGER; a_x_tilt, a_y_tilt, a_pressure: DOUBLE; a_screen_x, a_screen_y: INTEGER) is
			-- When user double click the vertical split in the memory increase dector window.
		do
			increase_detector.adjust_split_vertical
		end

	show_diff_in_grid is
			-- When button "show_diff_grid" clicked, to show the difference in grid.
		do
			increase_detector.show_object_count_changed
		end

	add_current_state is
			-- When button "add_current" clicked, to add current memory state.
		do
			increase_detector.add_current_state
		end

	resize_histogram (a_x, a_y, a_width, a_height: INTEGER) is
			-- Do things when the eiffel_histogram size change.
		require else
			a_height_valid: a_height >= 0 and a_height <= 800
		do
			analyze_gc.resize (a_x, a_y, a_width, a_height)
		end

	resize_history (a_x, a_y, a_width, a_height: INTEGER) is
			-- Do things when the eiffel_histogram size change.
		do
			analyze_gc.resize_history (a_x, a_y, a_width, a_height)
		end

	timer_event is
			-- The event request by the timer.
		do
			analyze_gc.update_gc_info
		end

	clear_graph_clicked is
			-- Clear the object graph.
		do
			analyze_object_gra.clear_graph
		end

	find_refers_clicked is
			-- Find the refers to current selected node (which represent a object), then put the refers to the graph.
		do
			analyze_object_gra.find_refers
		end

	zoom_changed (a_value: INTEGER) is
			-- Scale the object graph.
		do
			zoom.set_tooltip (zoom.value.out)
			analyze_object_gra.zoom_changed (a_value)
		end

	find_by_type_name is
			-- Find all the objects which belong to the same type name.
		local
			l_item: EV_LIST_ITEM
		do
			create l_item.make_with_text (type_name.text)
			analyze_object_gra.find_object_by_type_name (type_name.text)
			type_name.extend (l_item)
		ensure then
			type_name_recorded: type_name.count = old type_name.count + 1
		end

	refresh_info_clicked is
			-- Clients want to refresh all the infomation .
		do
			analyze_gc.redraw
				-- Disconnect object references.
			clear_graph_clicked
			analyze_route_searcher.reset
			analyze_object_snap.show_memory_map
		end

	gc_now_clicked is
			-- Clients want to gc now.
		do
			system_util.collect
		end

	redraw_histogram (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw histogram (left side graph) in the gc statistics notebook tab.
		do
			analyze_gc.redraw_histogram
		end

	redraw_history (a_x, a_y, a_width, a_height: INTEGER) is
			-- Redraw history (right side graph)  in the gc statistics notebook tab.
		do
			analyze_gc.redraw_history
		end

	find_object_by_instance_name is
			-- Find a object by its field name.
		local
			l_item : EV_LIST_ITEM
		do
			create l_item.make_with_text (object_name_1.text)
			object_name_1.extend (l_item)
			analyze_object_gra.find_object_by_instance_name (object_name_1.text)
		ensure then
			object_name_recorded: object_name_1.count = old object_name_1.count + 1
		end

	gc_enable_click  is
			-- Enable or disable gc.
		do
			system_util.toggle_gc (gc_enable)
		end

	search_route is
			-- Start search a route
		do
			analyze_route_searcher.build_next_route
		end

feature {NONE} -- Implementation

	increase_detector: MA_MEMORY_CHANGE_MEDIATOR
			-- The meidator response for detect, save systems states.

	analyze_gc: MA_GC_INFO_MEDIATOR
			-- The mediator response for show histogram, history.

	analyze_object_gra: MA_OBJECT_GRAPH_MEDIATOR
			-- The mediator response for show, modify object graphs.

	analyze_object_snap: MA_OBJECT_SNAPSHOT_MEDIATOR
			-- The mediator repsonse for show all the objects in the MEMORY's objects map.

	analyze_route_searcher: MA_ROUTE_TO_ONCE_SEARCHER
			-- Searcher for routes to once object.

	timer: EV_TIMEOUT
			-- The timer used for update histogram and history.

	refresh_interval: INTEGER
			-- The time of interval between refersh.

	refresh_interval_hi: INTEGER is 300
			-- The hi speed value of refresh interval.

	refresh_interval_normal: INTEGER is 2000
			-- The normal speed value of refresh interval.

	refresh_interval_low: INTEGER is 5000
			-- The low speed value of refresh interval.

invariant

	analyze_object_gra_not_void: analyze_object_gra /= Void
	increase_detector_not_void: increase_detector /= Void
	analyze_gc_not_void: analyze_gc /= Void
	analyze_object_snap_not_void: analyze_object_snap /= Void
	timer_not_void: timer /= Void
	auto_refresh_not_void: auto_refresh /= Void
	refresh_speed_not_void: refresh_speed /= Void

	main_book_not_destroyed: not main_book.is_destroyed
	main_book_has_tab_garbage_collector_info: main_book.has (tab_garbage_collector_info)
	main_book_has_tab_object_grid: main_book.has (tab_object_grid)
	main_book_has_tab_object_graph: main_book.has (tab_object_graph)
	main_book_has_tab_states_compare: main_book.has (tab_states_compare)

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




end -- class MA_WINDOW


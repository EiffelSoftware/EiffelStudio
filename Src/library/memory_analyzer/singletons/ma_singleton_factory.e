	indexing
	description: "Class that store all singletons in the system.%
				 %Class want to use the singletons it contains should inherit this class."
	date: "$Date$"
	revision: "$Revision$"

class
	MA_SINGLETON_FACTORY

feature  -- Singletons
	
	filter: MA_FILTER_SINGLETON is
			-- FILTER_SINGLETON instance
		do
			Result := internal_filter.item
		ensure
			filter_not_void: Result /= Void
		end
	
	filter_window: MA_FILTER_WINDOW is
			-- 
		do
			Result := internal_filter_window.item
		ensure
			filter_window_not_void: Result /= Void
		end
	
	grid_util: MA_GRID_UTIL_SINGLETON is
			-- GRID_UTIL_SINGLETON instance
		once
			create Result
		ensure
			grid_util_not_void: Result /= Void
		end
		
	object_finder: MA_OBJECT_FINDER_SINGLETON is
			-- OBJECT_FINDER_SINGLETON instance
		once
			create Result
		ensure
			object_finder_not_void: Result /= Void
		end
		
	system_util: MA_SYSTEM_UTIL_SINGLETON is
			-- SYSTEM_UTIL_SINGLETON instance
		once
			create Result
		ensure
			system_util_not_void: Result /= Void
		end
		
	main_window: MA_WINDOW is
			-- MEMORY_TOOL_WINDOW instance
		do
			Result := internal_main_window.item
		ensure
			result_not_void: Result /= Void
		end
		
	internal: INTERNAL is
			-- INTERNAL instance
		once
			create Result
		ensure
			internal_made: internal /= Void
		end
		
	memory: MEMORY is
			-- MEMORY singleton
		once
			create Result
		ensure
			memory_not_void: Result /= Void
		end
	
	icons: MA_ICONS_SINGLETON is
			-- ICONS_SINGLETON instance
		once
			create Result
		ensure
			icons_not_void: Result /= Void
		end

feature {MA_WINDOW} -- Access

	set_main_window (a_window: like main_window) is
			-- Set main_window instance
		require
			a_window_not_void: a_window /= Void
		do
			internal_main_window.put (a_window)
			internal_filter.put (create {MA_FILTER_SINGLETON}.make)
			internal_filter_window.put (create {MA_FILTER_WINDOW})
		ensure
			a_window_set: a_window = internal_main_window.item
		end
		
feature -- States Report
	
	main_window_not_void: BOOLEAN is
			-- Is main_windows Void ?
		do
			Result := internal_main_window /= Void
		end
		
feature -- Cursors

	accept_node: EV_CURSOR is
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.pixmap_file_content (icons.icon_eiffel_pebble), 8, 8)
		ensure
			accept_node_not_void: Result /= Void
		end
		
	deny_node: EV_CURSOR is
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.pixmap_file_content (icons.icon_eiffel_pebble_X), 8, 8)
		ensure
			deny_node_not_void: Result /= Void
		end	
	
	accept_node_class: EV_CURSOR is
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.pixmap_file_content (icons.icon_object_grid_class), 8, 8)
		ensure
			accept_node_class: Result /= Void
		end

	deny_node_class: EV_CURSOR is
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.pixmap_file_content (icons.icon_object_grid_class_X), 8, 8)
		ensure
			deny_node_class: Result /= Void
		end	
		
feature -- Colors

	increased_color: EV_COLOR is
			-- Color used when object count increased.
		once
			Result := (create {EV_STOCK_COLORS}).red
		ensure
			red_color_set: Result /= Void
		end
		
	decreased_color: EV_COLOR is
			-- Color used when obejct count decreased.
		once
			Result := (create {EV_STOCK_COLORS}).dark_green
		ensure
			green_color_set: Result /= Void
		end
		
feature {NONE} -- misc

	internal_main_window: CELL [MA_WINDOW] is
			-- MAIN_WINDOW instance's cell.
		once
			create Result
		end
		
	internal_filter: CELL [MA_FILTER_SINGLETON] is
			-- MA_FILTER_SINGLETON instance's cell.
		once
			create Result
		end
	
	internal_filter_window: CELL [MA_FILTER_WINDOW] is
			-- MA_FILTER_WINDOW instance'e cell.
		once
			create Result
		end
		
	state_file_suffix: TUPLE [STRING, STRING] is 
			-- Suffix of the States File name.
		once
			Result := ["*.ema", "Eiffel Memory Analyzer Datas (*.ema)"]
		end
	
	filter_filter_suffix: TUPLE [STRING, STRING] is	
			-- Suffix of the Filter File name.
		once
			Result := ["*.emf", "Eiffel Memory Analyzer Filter (*.emf)"]
		end
	
invariant
	internal_main_window_not_void: internal_main_window /= Void

end

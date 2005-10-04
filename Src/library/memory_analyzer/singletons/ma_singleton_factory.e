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
		once
			create Result.make
		ensure
			filter_not_void: Result /= Void
		end
	
	filter_widnow: MA_FILTER_WINDOW is
			-- 
		once
			create Result
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
		once
			Result := the_main_window
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

feature -- Access

	set_main_window (a_window: like main_window) is
			-- Set main_window instance
		require
			a_window_not_void: a_window /= Void
		local
			l_set_window: like main_window
		once
			the_main_window := a_window
			l_set_window := main_window
		ensure
			a_window_set: a_window = the_main_window
		end
		
feature -- States Report
	
	main_window_not_void: BOOLEAN is
			-- Is main_windows Void ?
		do
			Result := the_main_window /= Void
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

	the_main_window: MA_WINDOW 
			-- MAIN_WINDOW instance
	
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
	the_main_window_not_void: the_main_window /= Void

end

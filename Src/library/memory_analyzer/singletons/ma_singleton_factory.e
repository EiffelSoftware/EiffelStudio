	indexing
	description: "Class that store all singletons in the system.%
				 %Class want to use the singletons it contains should inherit this class."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	accept_node: EV_POINTER_STYLE is
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.eiffel_pebble_icon, 8, 8)
		ensure
			accept_node_not_void: Result /= Void
		end

	deny_node: EV_POINTER_STYLE is
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.eiffel_pebble_x_icon, 8, 8)
		ensure
			deny_node_not_void: Result /= Void
		end

	accept_node_class: EV_POINTER_STYLE is
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.object_grid_class_icon, 8, 8)
		ensure
			accept_node_class: Result /= Void
		end

	deny_node_class: EV_POINTER_STYLE is
			-- Icon used when picking
		local
			pix: EV_PIXMAP
		once
			create pix
			create Result.make_with_pixmap (icons.object_grid_class_x_icon, 8, 8)
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
			create Result.put (Void)
		end

	internal_filter: CELL [MA_FILTER_SINGLETON] is
			-- MA_FILTER_SINGLETON instance's cell.
		once
			create Result.put (Void)
		end

	internal_filter_window: CELL [MA_FILTER_WINDOW] is
			-- MA_FILTER_WINDOW instance'e cell.
		once
			create Result.put (Void)
		end

	state_file_suffix: TUPLE [filter: STRING; text: STRING] is
			-- Suffix of the States File name.
		once
			Result := ["*.ema", "Eiffel Memory Analyzer Datas (*.ema)"]
		end

	filter_filter_suffix: TUPLE [filter: STRING; text: STRING] is
			-- Suffix of the Filter File name.
		once
			Result := ["*.emf", "Eiffel Memory Analyzer Filter (*.emf)"]
		end

invariant
	internal_main_window_not_void: internal_main_window /= Void

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

end

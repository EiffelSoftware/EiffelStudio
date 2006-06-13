indexing
	description: "Objects that have all the icons requied in the system."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ICONS

inherit
	SHARED_PIXMAP_FACTORY

	SD_ICONS_SINGLETON

create
	make

feature {NONE} -- Initlization
	make is
			-- Creation method
		do
			init
			create internal_shared
		end

feature {NONE} -- Implementation

	pixmap_width: INTEGER is 8
			-- The width of the icons

	pixmap_height: INTEGER is 8
			-- The height of the icons

	pixmap_path: DIRECTORY_NAME is
			-- Path containing all of the Memory Analyzer icons
		once
			create Result.make_from_string ((create {EXECUTION_ENVIRONMENT}).current_working_directory)
			Result.extend ("images")
		ensure then
			path_valid: Result.is_valid
		end

	image_matrix: EV_PIXMAP is
			-- The pixmap contain all the icons
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (pixmap_path)
			l_fn.set_file_name ("smart_docking_icon_matrix_8_8.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	pixmap_lookup: HASH_TABLE [TUPLE [INTEGER, INTEGER], STRING] is
			--
		once
			create Result.make (1)
			Result.put ([1, 1], unstick_s)
			Result.put ([1, 2], stick_s)
			Result.put ([1, 3], maximize_s)
			Result.put ([1, 4], minimize_s)
			Result.put ([1, 5], close_s)
			Result.put ([2, 1], pebble_s)
			Result.put ([2, 2], default_icon_s)
			Result.put ([2, 3], hide_tab_indicator_s)
			Result.put ([2, 4], tool_bar_customize_indicator_s)
			Result.compare_objects
		end

feature -- Icons' Names

	unstick_s: STRING is "unstick"
			-- Icon name.	
	stick_s: STRING is "stick"
			-- Icon name.
	maximize_s: STRING is "maximize"
			-- Icon name.
	minimize_s: STRING is "minimize"
			-- Icon name.
	close_s: STRING is "close"
			-- Icon name.						
	default_icon_s: STRING is "default_window_icon"
			-- Icon name.
	pebble_s: STRING is "pebbel"
			-- Icon name.
	hide_tab_indicator_s: STRING is "hide_tab_indicator"
			-- Icon name.
	tool_bar_customize_indicator_s: STRING is "tool_bar_customize_indicator"
			-- Icon name.

feature -- Implementation

	sd_shared: SD_SHARED is
			--
		do
			create Result
		end

	unstick: EV_PIXMAP is
			-- Unstick icon pixmap.
		once
			Result := pixmap_file_content (unstick_s)
		end

	stick: 	EV_PIXMAP is
			-- Stick icon pixmap.
		once
			Result := pixmap_file_content (stick_s)
		end

	maximize: EV_PIXMAP is
				-- Maximize icon pixmap.
		once
			Result := pixmap_file_content (maximize_s)
		end

	normal: EV_PIXMAP is
			-- Minimize icon pixmap.
		once
			Result := pixmap_file_content (minimize_s)
		end

	close: EV_PIXMAP is
			-- close icon pixmap.
		once
			Result := pixmap_file_content (close_s)
		end

	default_icon: EV_PIXMAP is
			-- Redefine
		local
			l_icons: EV_STOCK_PIXMAPS
		once
			create l_icons
			Result := l_icons.default_window_icon
		end

	pebble: EV_PIXMAP is
			-- Redefine
		once
			Result := pixmap_file_content (pebble_s)
		end

	hide_tab_indicator (a_hide_number: INTEGER): EV_PIXMAP is
			-- Hide tab indicator.
		local
			l_box: EV_HORIZONTAL_BOX
			l_font: EV_FONT
		do
			Result := pixmap_file_content (hide_tab_indicator_s)
			create l_box
			Result.set_background_color (l_box.background_color)

			if a_hide_number < 10 then
				Result.set_size (Result.width + 8, Result.height + 3)
			elseif a_hide_number < 100 then
				Result.set_size (Result.width + 8, Result.height + 3 * 2)
			end
			Result.set_minimum_width (Result.width)
			create l_font
			l_font.set_height (8)
			Result.set_font (l_font)

			Result.draw_text_top_left (Result.width - 7, 2, a_hide_number.out)
		end

	tool_bar_indicator: EV_PIXMAP is
			-- Redefine.
		do
			Result := pixmap_file_content (hide_tab_indicator_s)
		end

	tool_bar_customize_indicator: EV_PIXMAP is
			-- Redefine.
		do
			Result := icons_8_16.customize_indicator
		end

	tool_bar_customize_indicator_horizontal: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("8_16_indicator_horizontal.png")
			create Result
			Result.set_with_named_file (l_fn)

		end
	tool_bar_customize_indicator_with_hidden_items_horizontal: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("8_16_indicator_horizontal_2.PNG")
			create Result
			Result.set_with_named_file (l_fn)
		end

	tool_bar_customize_indicator_with_hidden_items: EV_PIXMAP is
			-- Redefine.
		do
			Result := icons_8_16.customize_indicator_with_hidden_items
		end

	tool_bar_floating_customize: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("tool_bar_title_bar.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	tool_bar_floating_close: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("tool_bar_title_bar_close.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	tool_bar_customize_dialog: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			Result := (create {EV_STOCK_PIXMAPS}).Default_window_icon
		end

	big_icons: BIG_ICONS is
			-- Big icons.
		once
			create Result
		end

	icons_8_16: ICONS_8_16 is
			-- 8 * 16 icons.
		once
			create Result
		end

	drag_pointer_up: EV_CURSOR is
			-- Redefine	
		do
			create Result.make_with_pixmap (big_icons.drag_pointer_up, 0, 0)
		end

	drag_pointer_down: EV_CURSOR is
			-- Redefine		
		do
			create Result.make_with_pixmap (big_icons.drag_pointer_down, 0, 0)
		end

	drag_pointer_left: EV_CURSOR is
			-- Redefine	
		do
			create Result.make_with_pixmap (big_icons.drag_pointer_left, 0, 0)
		end

	drag_pointer_right: EV_CURSOR is
			-- Redefine
		do
			create Result.make_with_pixmap (big_icons.drag_pointer_right, 0, 0)
		end

	drag_pointer_center: EV_CURSOR is
			-- Redefine		
		do
			create Result.make_with_pixmap (big_icons.drag_pointer_center, 0, 0)
		end

	drag_pointer_float: EV_CURSOR is
			-- Redefine
		do
			create Result.make_with_pixmap (big_icons.drag_pointer_float, 0, 0)
		end

feature -- Feedback indicators

	images_path: STRING is
			-- Images path.
		do
			Result := pixmap_path
		end

	arrow_indicator_center: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("center.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_up: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("center_up_light.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_down: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("center_down_light.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_left: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("center_left.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_right: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("center_right.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_center_lightening_center: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("center_center_light.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_up: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("up.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_down: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("down.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_left: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("left.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_right: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("right.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_up_lightening: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("up_light.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_down_lightening: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("down_light.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_left_lightening: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("left_light.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

	arrow_indicator_right_lightening: EV_PIXMAP is
			-- Redefine
		local
			l_fn: FILE_NAME
		once
			create l_fn.make_from_string (images_path)
			l_fn.set_file_name ("right_light.png")
			create Result
			Result.set_with_named_file (l_fn)
		end

feature -- Right click on tabs context tool bars' icons.

	close_context_tool_bar: EV_PIXMAP  is
			-- Redefine
		do
			Result := big_icons.close_context_tool_bar
		end

	close_others: EV_PIXMAP is
			-- Redefine
		do
			Result := big_icons.close_others
		end

	close_all: EV_PIXMAP is
			-- Redefine
		do
			Result := big_icons.close_all
		end

feature {NONE}  -- Implementation

	internal_shared: SD_SHARED
			-- All singletons

invariant

	internal_shared_not_void: internal_shared /= Void

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

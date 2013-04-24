note
	description: "[
					Carbon implementation to draw native looking notebook tabs.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_DRAWER_IMP

inherit
	SD_NOTEBOOK_TAB_DRAWER_I
		redefine
			draw_pixmap_text_selected,
			draw_pixmap_text_unselected,
			expose_unselected,
			expose_selected,
			expose_hot,
			draw_focus_rect
		end

	EV_BUTTON_IMP -- Only for export
		rename
			make as make_not_use,
			pixmap as pixmap_not_use,
			set_pixmap as set_pixmap_not_use,
			text as text_not_use,
			set_text as set_text_not_use,
			height as height_not_use,
			width as width_not_use
		export
			{NONE} all
		end

create
	make

feature -- Command

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw unselected notebook tab.
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			internal_expose (a_width, internal_tab.x, False)
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw selected notebook tab.
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			internal_expose (a_width, internal_tab.x, True)
			if internal_tab.parent.has_focus then
				internal_tab.draw_focus_rect
			end
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- Draw hot notebook tab.
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			internal_expose (a_width, internal_tab.x, False)
		end

	tool_bar_drawer: SD_TOOL_BAR_DRAWER_IMP
			-- Tool bar drawer which used for drawing close button.
		once
			create Result.make
		ensure
			not_void: Result /= Void
		end

	draw_close_button (a_drawable: EV_DRAWABLE; a_close_pixmap: EV_PIXMAP)
			-- Redefine
		local
			l_vision_rect: EV_RECTANGLE
			l_imp: EV_DRAWING_AREA_IMP
		do
			if (internal_tab.is_hot or internal_tab.is_selected)and is_top_side_tab then

				l_vision_rect := close_rectangle
				l_vision_rect.move (internal_tab.x + l_vision_rect.x, l_vision_rect.y)

				-- Draw hot state background
				if internal_tab.is_pointer_in_close_area then
					l_imp ?= internal_tab.parent.implementation
					check not_void: l_imp /= Void end
					if internal_tab.is_pointer_pressed then
						tool_bar_drawer.draw_button_background (l_imp.c_object, l_vision_rect, {SD_TOOL_BAR_ITEM_STATE}.pressed)
					else
						tool_bar_drawer.draw_button_background (l_imp.c_object, l_vision_rect, {SD_TOOL_BAR_ITEM_STATE}.hot)
					end
				end

				-- We draw close button
				if internal_tab.is_pointer_pressed and internal_tab.is_pointer_in_close_area then
					a_drawable.draw_pixmap (internal_tab.x + start_x_close + 1, start_y_close, a_close_pixmap)
				else
					a_drawable.draw_pixmap (internal_tab.x + start_x_close, start_y_close, a_close_pixmap)
				end
			end
		end

	draw_pixmap_text_selected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		local
			l_font: EV_FONT
		do
			if a_pixmap.height > 0 then
				-- Draw text
				a_pixmap.set_foreground_color (internal_shared.tab_text_color)
				if a_width - start_x_text_internal >= 0 then
					l_font := a_pixmap.font
					l_font.set_weight ({EV_FONT_CONSTANTS}.weight_bold)
					a_pixmap.set_font (l_font)
					if is_top_side_tab then
						a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height + 1, text, close_clipping_width (a_width))
					else
						a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text + gap_height, text, text_clipping_width (a_width))
					end
				end
				-- Draw pixmap
				if is_draw_pixmap then
					if is_top_side_tab then
						a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position + 1, pixmap)
					else
						a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position + 1, pixmap)
					end
				end

				draw_close_button (a_pixmap, internal_shared.icons.close)
			end
		end

	draw_pixmap_text_unselected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		local
			l_font: EV_FONT
		do
			a_pixmap.set_foreground_color (internal_shared.tab_text_color)
			l_font := a_pixmap.font
			l_font.set_weight ({EV_FONT_CONSTANTS}.weight_regular)
			a_pixmap.set_font (l_font)
			if is_top_side_tab then
				-- Draw pixmap
				a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position, pixmap)
				a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, gap_height + start_y_position_text, text, close_clipping_width (a_width))
			else
				-- Draw pixmap
				a_pixmap.draw_pixmap (a_start_x + start_x_pixmap_internal, pixmap_y_position, pixmap)
				-- Draw text
				a_pixmap.draw_ellipsed_text_top_left (a_start_x + start_x_text_internal, start_y_position_text, text, text_clipping_width (a_width))
			end

			draw_close_button (a_pixmap, internal_shared.icons.close)
		end

	draw_focus_rect (a_rect: EV_RECTANGLE)
			-- Redefine
		local
			l_imp: SD_DRAWING_AREA_IMP
		do
			l_imp ?= internal_tab.parent.implementation
			check not_void: l_imp /= Void end

		end

	pixmap_y_position: INTEGER
			-- Pixmap positon relative to Current.
		do
			if pixmap /= Void then
				Result := (height / 2 - pixmap.height / 2).floor - 1
			else
				Result := start_y_position_text
			end
		end

feature {NONE}  -- Implementation	

	gap_height: INTEGER = 0
			-- Redefine

	start_y_position: INTEGER = 1
			-- Redefine

	start_y_position_text: INTEGER
			-- Redefine
		do
			Result := internal_shared.tool_bar_font.height // 3 - 2
		end

	clear (a_width, a_x: INTEGER)
			-- Clear `internal_tab''s area.
		do
			internal_tab.parent.set_foreground_color (internal_tab.parent.background_color)
			internal_tab.parent.fill_rectangle (a_x, 0, a_width, internal_tab.parent.height)
		end

	notebook_style: POINTER
			-- Default theme style from resource.
		do
		end

	style_source: POINTER
			-- Notebook for query theme style.
		once
			-- We can't use notebook for the soure of style here.
			-- Becaues it will always return white style. when using a notebook object to query the style.
		end

	internal_expose (a_width: INTEGER; a_x: INTEGER; a_is_selected: BOOLEAN)
			-- Expose implementation
		local
			l_imp: SD_DRAWING_AREA_IMP
		do
			clear (a_width, a_x)

			l_imp ?= internal_tab.parent.implementation
			check not_void: l_imp /= Void end

		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
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

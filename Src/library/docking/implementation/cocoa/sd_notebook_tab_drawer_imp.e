note
	description: "[
					Cocoa implementation to draw native looking notebook tabs.
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
			make,
			draw_pixmap_text_selected,
			draw_pixmap_text_unselected,
			expose_unselected,
			expose_selected,
			expose_hot,
			draw_focus_rect
		end

create
	make

feature {NONE} -- Initlialization

	make
			-- Creation method
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I}
		end

feature -- Command

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		local
			l_pixmap_imp: EV_PIXMAP_IMP
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			start_draw

--			l_pixmap_imp ?= buffer_pixmap.implementation
--			check not_void: l_pixmap_imp /= Void end

--			create l_wel_rect.make (0, 0, a_width, buffer_pixmap.height + 1)

--			theme_drawer.draw_theme_background (theme_data, a_bitmap_dc, 0, 0, a_rect, Void, a_brush)
--			draw_classic_tab (a_bitmap_dc, a_rect, is_top_side_tab)

			draw_pixmap_text_selected (buffer_pixmap, 0, a_width)

			end_draw

			if internal_tab.parent.has_focus then
				internal_tab.draw_focus_rect
			end
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		local
			l_pixmap_imp: EV_PIXMAP_IMP
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			start_draw

--			l_pixmap_imp ?= buffer_pixmap.implementation
--			check not_void: l_pixmap_imp /= Void end

--			create l_wel_rect.make (0, 0, a_width, buffer_pixmap.height)

--			draw_cocoa_tab (0, 0, a_width, buffer_pixmap.height)

			draw_pixmap_text_unselected (buffer_pixmap , 0, a_width)

			end_draw
		end

	draw_focus_rect (a_rect: EV_RECTANGLE)
			-- <Precursor>
		do
--			wel_draw_focus_rect (l_dc, l_rect)
		end

	draw_close_button (a_drawable: EV_DRAWABLE; a_close_pixmap: EV_PIXMAP)
			-- Redefine
		do
			a_drawable.draw_rectangle (start_x_close, start_y_close, start_x_close + 10, start_y_close + 10)
		end

	draw_pixmap_text_selected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		do
		end

	draw_pixmap_text_unselected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		do
		end

feature {NONE}  -- Implementation	

	gap_height: INTEGER = 0
			-- Redefine

	start_y_position: INTEGER = 1
			-- Redefine

	start_y_position_text: INTEGER
			-- Redefine
		do
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end

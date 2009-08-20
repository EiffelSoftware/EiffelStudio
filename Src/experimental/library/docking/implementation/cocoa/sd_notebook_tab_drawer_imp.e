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

	EV_ANY_HANDLER

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
			expose (a_width, a_tab_info)
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		local
			l_pixmap_imp: EV_PIXMAP_IMP
			l_segmented_control: NS_SEGMENTED_CONTROL
			icon: NS_IMAGE
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			expose (a_width, a_tab_info)
		end

	expose_hot (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			expose (a_width, a_tab_info)
		end

	expose (a_width: INTEGER;  a_tab_info: SD_NOTEBOOK_TAB_INFO)
		local
			l_pixmap_imp: EV_PIXMAP_IMP
			l_segmented_control: NS_SEGMENTED_CONTROL
			icon: NS_IMAGE
		do
			start_draw

			l_pixmap_imp ?= buffer_pixmap.implementation
			check not_void: l_pixmap_imp /= Void end

			l_pixmap_imp.prepare_drawing

			create l_segmented_control.make
			l_segmented_control.set_segment_count (1)
			l_segmented_control.set_segment_style ({NS_SEGMENTED_CONTROL}.segment_style_small_square)
			if is_selected then
				l_segmented_control.set_selected_segment (0)
			end
			l_segmented_control.set_label_for_segment (text, 0)
			l_segmented_control.set_enabled_for_segment (True, 0)
			l_segmented_control.set_width_for_segment (a_width-4, 0)
			if attached {EV_PIXMAP_IMP} pixmap.implementation as l_icon_imp then
				icon := l_icon_imp.image.twin
				icon.set_size (create {NS_SIZE}.make_size (20, 20))
				l_segmented_control.set_image_for_segment (icon, 0)
			end

			l_segmented_control.set_frame (create {NS_RECT}.make_rect (0, 0, a_width, buffer_pixmap.height + 1))
			l_segmented_control.draw_rect (create {NS_RECT}.make_rect (0, 0, a_width, buffer_pixmap.height + 1))

			l_pixmap_imp.finish_drawing


--			pixmap.stretch (20, 20)
--			buffer_pixmap.draw_pixmap (0, 0, pixmap)
--			draw_pixmap_text_selected (buffer_pixmap, 20, a_width)
--			draw_close_button (buffer_pixmap, pixmap)

			end_draw

			if internal_tab.parent.has_focus then
				internal_tab.draw_focus_rect
			end
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
			buffer_pixmap.draw_text (a_start_x, 0, text)
		end

	draw_pixmap_text_unselected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		do
			buffer_pixmap.draw_text (a_start_x, 0, text)
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

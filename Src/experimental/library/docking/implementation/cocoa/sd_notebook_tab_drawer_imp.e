note
	description: "Cocoa implementation to draw native looking notebook tabs."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_NOTEBOOK_TAB_DRAWER_IMP

inherit
	SD_NOTEBOOK_TAB_DRAWER_I
		redefine
			expose_unselected,
			expose_selected,
			expose_hot,
			draw_focus_rect
		end

	EV_ANY_HANDLER

create
	make

feature -- Command

	expose_unselected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
		do
			Precursor {SD_NOTEBOOK_TAB_DRAWER_I} (a_width, a_tab_info)
			expose (a_width, a_tab_info)
		end

	expose_selected (a_width: INTEGER; a_tab_info: SD_NOTEBOOK_TAB_INFO)
			-- <Precursor>
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
			l_segmented_control: NS_SEGMENTED_CONTROL
			icon: NS_IMAGE
			trans: NS_AFFINE_TRANSFORM
		do
			start_draw

			if
				attached buffer_pixmap as l_buffer_pixmap and then
				attached {EV_PIXMAP_IMP} l_buffer_pixmap.implementation as l_pixmap_imp then

				l_pixmap_imp.prepare_drawing

				create trans.make
				trans.translate_by_xy ({REAL_32}0.0, l_pixmap_imp.image.size.height.truncated_to_real)
				trans.scale_by_xy ({REAL_32}1.0, {REAL_32}-1.0)
				trans.concat

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
					--icon.set_flipped (True)
					icon.set_size (create {NS_SIZE}.make_size (20, 20))
					l_segmented_control.set_image_for_segment (icon, 0)
				end

				l_segmented_control.set_frame (create {NS_RECT}.make_rect (0, 0, a_width, l_buffer_pixmap.height + 1))
				l_segmented_control.draw_rect (create {NS_RECT}.make_rect (0, 0, a_width, l_buffer_pixmap.height + 1))

				l_pixmap_imp.finish_drawing
--				pixmap.stretch (20, 20)
--				l_buffer_pixmap.draw_pixmap (0, 0, pixmap)
--				draw_pixmap_text_selected (l_buffer_pixmap, 20, a_width)
--				draw_close_button (l_buffer_pixmap, pixmap)
			end

			end_draw

			if attached tab.parent as l_parent and then l_parent.has_focus then
				tab.draw_focus_rect
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
			if attached buffer_pixmap as l_pixmap then
				l_pixmap.draw_text (a_start_x, 0, text)
			end
		end

	draw_pixmap_text_unselected (a_pixmap: EV_DRAWABLE; a_start_x, a_width: INTEGER)
			-- Redefine
		do
			if attached buffer_pixmap as l_pixmap then
				l_pixmap.draw_text (a_start_x, 0, text)
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
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end

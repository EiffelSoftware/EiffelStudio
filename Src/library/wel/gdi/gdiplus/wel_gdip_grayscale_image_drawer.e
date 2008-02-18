indexing
	description: "[
						Drawer who can draw grayscale images base on original images.
																						]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_GDIP_GRAYSCALE_IMAGE_DRAWER

feature -- Command

	draw_grayscale_bitmap (a_image: WEL_GDIP_BITMAP; a_dest_dc: WEL_DC; a_dest_x, a_dest_y: INTEGER) is
			-- Draw grayscale version of `a_image' on `a_dest_dc' at `a_dest_x', `a_dest_y'.
		require
			not_void: a_image /= Void
			not_void: a_dest_dc /= Void
		local
			l_graphics: WEL_GDIP_GRAPHICS
			l_image_attributes: WEL_GDIP_IMAGE_ATTRIBUTES
			l_src_rect, l_dest_rect: WEL_RECT
			l_width, l_height: INTEGER
		do
			create l_image_attributes.make
			l_image_attributes.clear_color_key
			l_image_attributes.set_color_matrix (disabled_color_matrix)
			l_width := a_image.width
			l_height := a_image.height
			create l_src_rect.make (0, 0, l_width, l_height)
			create l_dest_rect.make (a_dest_x, a_dest_y, a_dest_x + l_width, a_dest_y + l_height)
			create l_graphics.make_from_dc (a_dest_dc)
			l_graphics.draw_image_with_src_rect_dest_rect_unit_attributes (a_image, l_dest_rect, l_src_rect, {WEL_GDIP_UNIT}.unitpixel, l_image_attributes)

			l_graphics.destroy_item
			l_dest_rect.dispose
			l_src_rect.dispose
			l_image_attributes.destroy_item
		end

	draw_grayscale_bitmap_or_icon_with_memory_buffer (a_bitmap: WEL_BITMAP; a_icon: WEL_ICON; a_control_dc: WEL_DC; a_dest_x, a_dest_y: INTEGER; a_background_color: WEL_COLOR_REF; a_pixmap_has_mask: BOOLEAN) is
			-- This feature will use one of `draw_grayscale_icon_with_memory_buffer' or `draw_grayscale_bitmap_with_memory_buffer' automatically.
		require
			not_void: a_bitmap /= Void and a_icon /= Void and a_control_dc /= Void and a_background_color /= Void
		local
			l_log_bitmap: WEL_LOG_BITMAP
			l_gdip_bitmap: WEL_GDIP_BITMAP
		do
			l_log_bitmap := a_bitmap.log_bitmap
			if not a_pixmap_has_mask and then l_log_bitmap.bits_pixel = 32 and then a_bitmap.ppv_bits /= default_pointer then
				create l_gdip_bitmap.make_from_bitmap_with_alpha (a_bitmap)
				draw_grayscale_bitmap_with_memory_buffer (l_gdip_bitmap, a_control_dc, a_dest_x, a_dest_y, a_background_color)
				l_gdip_bitmap.dispose
			else
				draw_grayscale_icon_with_memory_buffer (a_icon, a_control_dc, a_dest_x, a_dest_y, a_background_color)
			end
			l_log_bitmap.dispose
		end

	draw_grayscale_icon_with_memory_buffer (a_orignal_icon: WEL_ICON; a_control_dc: WEL_DC; a_dest_x, a_dest_y: INTEGER; a_background_color: WEL_COLOR_REF) is
			-- Draw grayscale version of `a_orignal_icon' on `a_control_dc'
		require
			not_void: a_orignal_icon /= Void and a_control_dc /= Void and a_background_color /= Void
		local
			l_gdip_bitmap: WEL_GDIP_BITMAP
		do
			create l_gdip_bitmap.make_from_icon (a_orignal_icon)
			draw_grayscale_bitmap_with_memory_buffer (l_gdip_bitmap, a_control_dc, a_dest_x, a_dest_y, a_background_color)
			l_gdip_bitmap.dispose
		end

	draw_grayscale_bitmap_with_memory_buffer (a_gdip_bitmap: WEL_GDIP_BITMAP; a_control_dc: WEL_DC; a_dest_x, a_dest_y: INTEGER; a_background_color: WEL_COLOR_REF) is
			-- Draw grayscale version of `a_orignal_icon' on `a_control_dc'
			-- We must draw on a buffer dc first, otherwise in Windows Remote Desktop (at least Windows Vista), the generated grayscale icon will distorted.
		require
			not_void: a_gdip_bitmap /= Void and a_control_dc /= Void and a_background_color /= Void
		local
			l_buffered_dc: WEL_DC
			l_wel_bitmap: WEL_BITMAP
			l_brush: WEL_BRUSH
			l_width, l_height: INTEGER
		do
			l_width := a_gdip_bitmap.width
			l_height := a_gdip_bitmap.height

			create {WEL_MEMORY_DC} l_buffered_dc.make_by_dc (a_control_dc)
			create l_wel_bitmap.make_compatible (a_control_dc, l_width, l_height)
			l_buffered_dc.select_bitmap (l_wel_bitmap)
			l_buffered_dc.set_background_color (a_background_color)

			-- Fill background
			create l_brush.make_solid (a_background_color)
			l_buffered_dc.fill_rect (create {WEL_RECT}.make (0, 0, l_width, l_height), l_brush)
			l_brush.delete

			-- Draw grayscale icon on memory buffer dc
			draw_grayscale_bitmap (a_gdip_bitmap, l_buffered_dc, 0, 0)
			l_wel_bitmap.dispose

			-- Finally, we copy buffer icon to target control dc.
			a_control_dc.bit_blt (a_dest_x, a_dest_y, l_width, l_height, l_buffered_dc, 0, 0, {WEL_RASTER_OPERATIONS_CONSTANTS}.srccopy)
		end

feature {NONE} -- Implementation

	disabled_color_matrix: WEL_COLOR_MATRIX is
			-- Disable color matrix.
		do
			Result := mulitply_color_matrix (disabled_color_matrix_2, disabled_color_matrix_1)
		ensure
			not_void: Result /= Void
		end

	disabled_color_matrix_1: WEL_COLOR_MATRIX is
			-- Disabled color matrix used by GDI+ DrawImage.
			-- See MSDN "A Twist in Color Space"
		do
			create Result.make
			Result.set_m_row (<<0.2125, 0.2125, 0.2125, 0, 0>>, 0) -- Grey scale R channel
			Result.set_m_row (<<0.2577, 0.2577, 0.2577, 0, 0>>, 1) -- Grey scale G channel
			Result.set_m_row (<<0.0361, 0.0361, 0.0361, 0, 0>>, 2) -- Grey scale B channel			
			Result.set_m_row (<<0, 0, 0, 1, 0>>, 3) -- Opacity
			Result.set_m_row (<<0.38, 0.38, 0.38, 0, 1>>, 4) -- Brightness
		ensure
			not_void: Result /= Void
		end

	disabled_color_matrix_2: WEL_COLOR_MATRIX is
			-- Disabled color matrix used by GDI+ DrawImage.
			-- See MSDN "A Twist in Color Space"
		do
			create Result.make
			Result.set_m_row (<<1, 0, 0, 0, 0>>, 0) -- Grey scale R channel
			Result.set_m_row (<<0, 1, 0, 0, 0>>, 1) -- Grey scale G channel
			Result.set_m_row (<<0, 0, 1, 0, 0>>, 2) -- Grey scale B channel			
			Result.set_m_row (<<0, 0, 0, 0.7, 0>>, 3) -- Opacity
			Result.set_m_row (<<0, 0, 0, 0, 0>>, 4) -- Brightness
		ensure
			not_void: Result /= Void
		end

	mulitply_color_matrix (a_matrix_1, a_matrix_2: WEL_COLOR_MATRIX): WEL_COLOR_MATRIX is
			-- Mulitply `a_matrix_1' and `a_matrix_2'
		require
			not_void: a_matrix_1 /= Void
			not_void: a_matrix_2 /= Void
		local
			l_i, l_j, l_k: INTEGER
			l_temp_array: ARRAY [REAL]
			l_sum: REAL
		do
			create Result.make
			create l_temp_array.make (0, 4)
			from
				l_j := 0
			until
				l_j > 4
			loop
				from
					l_k := 0
				until
					l_k > 4
				loop
					l_temp_array [l_k] := a_matrix_1.m (l_k, l_j)
					l_k := l_k + 1
				end
				from
					l_i := 0
				until
					l_i > 4
				loop
					l_sum := 0
					from
						l_k := 0
					until
						l_k > 4
					loop
						l_sum := l_sum + a_matrix_2.m (l_i, l_k) * l_temp_array [l_k]
						l_k := l_k + 1
					end
					Result.m (l_i, l_j) := l_sum
					l_i := l_i + 1
				end

				l_j := l_j + 1
			end
		end

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

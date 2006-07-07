indexing
	description: "Windows implementation of EV_POINTER_STYLE_I."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINTER_STYLE_IMP

inherit
	EV_POINTER_STYLE_I
		redefine
			destroy
		end

create
	make

feature {NONE} -- Initlization

	make (an_interface: EV_POINTER_STYLE) is
			-- Creation method
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize
		do
			set_is_initialized (True)
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Initialize from `a_pixel_buffer'
		do
			build_mask_bitmap (a_pixel_buffer.width, a_pixel_buffer.height)
			build_bitmap (a_pixel_buffer)
			build_native_cursor (a_pixel_buffer.width, a_pixel_buffer.height)
			wel_bitmap.delete
			wel_mask_bitmap.delete
			width := a_pixel_buffer.width
			height := a_pixel_buffer.height
		end

	init_from_cursor (a_cursor: EV_CURSOR) is
			-- Initialize from `a_cursor'
		local
			l_simple_imp: EV_PIXMAP_IMP
			l_imp: EV_PIXMAP_IMP_STATE
		do
			l_simple_imp ?= a_cursor.implementation
			l_imp ?= a_cursor.implementation

			if l_simple_imp /= Void and then l_simple_imp.private_cursor /= Void then
				-- If already have one, then we don't need to create a new gdi cursor.
				wel_cursor := l_simple_imp.private_cursor
			else
				wel_cursor ?= l_imp.build_graphical_resource (False)
				wel_cursor.enable_reference_tracking
			end
			width := a_cursor.width
			height := a_cursor.height
		ensure then
			not_void: wel_cursor /= Void
		end

feature -- Command

	destroy is
			-- Destroy
		do
			if wel_cursor /= Void and then wel_cursor.exists then
				wel_cursor.decrement_reference
				wel_cursor := Void
			end
			if wel_bitmap /= Void and then wel_bitmap.exists then
				wel_bitmap.delete
				wel_bitmap := Void
			end
			if wel_mask_bitmap /= Void and then wel_mask_bitmap.exists then
				wel_mask_bitmap.delete
				wel_mask_bitmap := Void
			end
		end

feature -- Query

	wel_cursor: WEL_CURSOR
			-- Windows native cursor

	width: INTEGER
			-- Width

	height: INTEGER
			-- Height

feature {NONE} -- Implementation

	build_native_cursor (a_width, a_height: INTEGER) is
			-- Build `wel_cursor'
		require
			valid: a_width > 0 and a_height > 0
			not_void: wel_bitmap /= Void
			not_void: wel_mask_bitmap /= Void
		local
			l_icon_info: WEL_ICON_INFO
		do
			create l_icon_info.make
			l_icon_info.set_unshared
			l_icon_info.set_is_icon (False)

			l_icon_info.set_x_hotspot (interface.x_hotspot)
			l_icon_info.set_y_hotspot (interface.y_hotspot)

			l_icon_info.set_color_bitmap (wel_bitmap)
			l_icon_info.set_mask_bitmap (wel_mask_bitmap)

			create wel_cursor.make_by_icon_info (l_icon_info)
			wel_cursor.enable_reference_tracking
			l_icon_info.delete

		ensure
			created: wel_cursor /= Void
		end

	build_bitmap (a_pixel_buffer: EV_PIXEL_BUFFER) is
			-- Build `wel_bitmap' for `wel_cursor'
		require
			not_craeted: wel_bitmap = Void
		local
			l_buffer_imp: EV_PIXEL_BUFFER_IMP
		do
			l_buffer_imp ?= a_pixel_buffer.implementation
			check not_void: l_buffer_imp /= Void end
			wel_bitmap := l_buffer_imp.gdip_bitmap.new_bitmap
		ensure
			created: wel_bitmap /= Void
		end

	build_mask_bitmap (a_width, a_height: INTEGER) is
			-- Build `wel_mask_bitmap' for `wel_cursor'
		require
			not_created: wel_mask_bitmap = Void
		local
			l_mem_dc: WEL_MEMORY_DC
		do
			create l_mem_dc.make
			create wel_mask_bitmap.make_compatible (
				l_mem_dc,
				a_width,
				a_height
				)
			l_mem_dc.select_bitmap (wel_mask_bitmap)
					-- We have no mask so make sure that all of the pixmap is visible.
			l_mem_dc.pat_blt (0, 0, a_width, a_height, {WEL_RASTER_OPERATIONS_CONSTANTS}.blackness)
			l_mem_dc.unselect_bitmap
			l_mem_dc.delete
		ensure
			created: wel_mask_bitmap /= Void
		end

	wel_bitmap: WEL_BITMAP
			-- Dib 32bits rbga bitmap.

	wel_mask_bitmap: WEL_BITMAP;
			-- Mask bitmap

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

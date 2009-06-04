note
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

feature -- Initlization

	old_make (an_interface: EV_POINTER_STYLE)
			-- Creation method
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize
		do
			build_default_icon (to_windows_constants ({EV_POINTER_STYLE_CONSTANTS}.standard_cursor))
			set_is_initialized (True)
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_x_hotspot, a_y_hotspot: INTEGER)
			-- Initialize from `a_pixel_buffer'
		do
			destroy_gdi_objects
			build_mask_bitmap (a_pixel_buffer.width, a_pixel_buffer.height)
			build_bitmap (a_pixel_buffer)
			build_native_cursor (a_pixel_buffer.width, a_pixel_buffer.height, a_x_hotspot, a_y_hotspot)
			if attached wel_bitmap as l_wel_bitmap then
				l_wel_bitmap.delete
			end
			wel_bitmap := Void
			if attached wel_mask_bitmap as l_wel_mask_bitmap then
				l_wel_mask_bitmap.delete
			end
			wel_mask_bitmap := Void
		end

	init_from_cursor (a_cursor: EV_CURSOR)
			-- Initialize from `a_cursor'
		do
			init_from_pixmap (a_cursor, a_cursor.x_hotspot, a_cursor.y_hotspot)
		end

	init_from_pixmap (a_pixmap: EV_PIXMAP; a_hotspot_x, a_hotspot_y:INTEGER)
			-- Initalize from `a_pixmap'
		local
			l_simple_imp: detachable EV_PIXMAP_IMP
			l_imp: detachable EV_PIXMAP_IMP_STATE
			l_wel_cursor: detachable like wel_cursor
		do
			destroy_gdi_objects
			l_simple_imp ?= a_pixmap.implementation
			if l_simple_imp /= Void and then attached l_simple_imp.private_cursor as l_private_cursor then
				-- If already have one, then we don't need to create a new gdi cursor.
				wel_cursor := l_private_cursor
			else
				l_imp ?= a_pixmap.implementation
				check l_imp /= Void end
				l_wel_cursor ?= l_imp.build_graphical_resource (False)
				check l_wel_cursor /= Void end
				wel_cursor := l_wel_cursor
				wel_cursor.enable_reference_tracking
			end
			set_x_hotspot (a_hotspot_x)
			set_y_hotspot (a_hotspot_y)
		ensure then
			not_void: wel_cursor /= Void
		end

	init_predefined (a_constants: INTEGER)
			-- Initialized a predefined cursor.
		do
			destroy_gdi_objects
			build_default_icon (to_windows_constants (a_constants))
		end

feature -- Command

	set_x_hotspot (a_x: INTEGER)
			-- Set `x_hotspot' to `a_x'.
		do
			set_hotspot_imp (a_x, True)
		end

	set_y_hotspot (a_y: INTEGER)
			-- Set `y_hotspot' to `a_y'.
		do
			set_hotspot_imp (a_y, False)
		end

	set_hotspot_imp (a_position: INTEGER; a_is_x: BOOLEAN)
			-- Set hotspot implementation
		local
			l_icon_info: detachable WEL_ICON_INFO
		do
			l_icon_info := wel_cursor.get_icon_info
			check l_icon_info /= Void end
			wel_cursor.decrement_reference
			if a_is_x then
				l_icon_info.set_x_hotspot (a_position)
			else
				l_icon_info.set_y_hotspot (a_position)
			end
			create wel_cursor.make_by_icon_info (l_icon_info)
			wel_cursor.enable_reference_tracking
			l_icon_info.delete
		ensure
			created: wel_cursor /= void and then wel_cursor.exists
			changed: old wel_cursor /= wel_cursor
		end

	destroy
			-- Destroy
		do
			set_is_in_destroy (True)
			destroy_gdi_objects
			set_is_destroyed (True)
		end

feature -- Query

	wel_cursor: WEL_CURSOR
			-- Windows native cursor

	width: INTEGER
			-- Width
		local
			l_icon_info: detachable WEL_ICON_INFO
		do
			l_icon_info := wel_cursor.get_icon_info
			check l_icon_info /= Void end
			Result := l_icon_info.width
			l_icon_info.delete
		end

	height: INTEGER
			-- Height
		local
			l_icon_info: detachable WEL_ICON_INFO
		do
			l_icon_info := wel_cursor.get_icon_info
			check l_icon_info /= Void end
			Result := l_icon_info.height
			l_icon_info.delete
		end

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.
		do
			Result := wel_cursor.x_hotspot
		end

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot.
		do
			Result := wel_cursor.y_hotspot
		end

	to_windows_constants (a_constants: INTEGER): POINTER
			-- Convert from EV_POINTER_STYLE_CONSTANTS to windows native constants
		require
			vaild: (create {EV_POINTER_STYLE_CONSTANTS}).is_valid (a_constants)
		do
			inspect
				a_constants
			when {EV_POINTER_STYLE_CONSTANTS}.busy_cursor then
				Result := Idc_constants.Idc_appstarting
			when {EV_POINTER_STYLE_CONSTANTS}.crosshair_cursor then
				Result := Idc_constants.Idc_cross
			when {EV_POINTER_STYLE_CONSTANTS}.help_cursor then
				Result := Idc_constants.Idc_help
			when {EV_POINTER_STYLE_CONSTANTS}.ibeam_cursor then
				Result := Idc_constants.Idc_ibeam
			when {EV_POINTER_STYLE_CONSTANTS}.no_cursor then
				Result := Idc_constants.Idc_no
			when {EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor then
				Result := Idc_constants.Idc_sizeall
			when {EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor then
				Result := Idc_constants.Idc_sizenesw
			when {EV_POINTER_STYLE_CONSTANTS}.sizens_cursor then
				Result := Idc_constants.Idc_sizens
			when {EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor then
				Result := Idc_constants.Idc_sizenwse
			when {EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor then
				Result := Idc_constants.Idc_sizewe
			when {EV_POINTER_STYLE_CONSTANTS}.standard_cursor then
				Result := Idc_constants.Idc_arrow
			when {EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor then
				Result := Idc_constants.Idc_uparrow
			when {EV_POINTER_STYLE_CONSTANTS}.wait_cursor then
				Result := Idc_constants.Idc_wait
			when {EV_POINTER_STYLE_CONSTANTS}.header_sizewe_cursor then
				Result := Idc_constants.Idc_sizewe
			when {EV_POINTER_STYLE_CONSTANTS}.hyperlink_cursor then
				Result := Idc_constants.Idc_hand
			end
		end

feature -- Duplication

	copy_from_pointer_style (a_pointer_style: like interface)
			-- Copy attributes of `a_pointer_style' to `Current.
		local
			a_pointer_style_imp: detachable like Current
		do
				-- Copy wel_cursor from `a_pointer_style'
			a_pointer_style_imp ?= a_pointer_style.implementation
			check a_pointer_style_imp /= Void end
			wel_cursor := a_pointer_style_imp.wel_cursor.twin
		end

feature {NONE} -- Implementation

	build_default_icon (a_idi_constant: POINTER)
			-- Create the pixmap corresponding to the
			-- Windows Icon constants `Idi_constant'.
		do
			create wel_cursor.make_by_predefined_id (a_idi_constant)
			wel_cursor.enable_reference_tracking
		ensure
			created: wel_cursor /= Void and then wel_cursor.exists
		end

	build_native_cursor (a_width, a_height, a_x_hotspot, a_y_hotspot: INTEGER)
			-- Build `wel_cursor'
		require
			valid: a_width > 0 and a_height > 0
			not_created: wel_cursor = Void
			not_void: wel_bitmap /= Void
			not_void: wel_mask_bitmap /= Void
		local
			l_icon_info: WEL_ICON_INFO
			l_wel_bitmap: like wel_bitmap
			l_wel_mask_bitmap: like wel_mask_bitmap
		do
			create l_icon_info.make
			l_icon_info.set_unshared
			l_icon_info.set_is_icon (False)

			l_icon_info.set_x_hotspot (a_x_hotspot)
			l_icon_info.set_y_hotspot (a_y_hotspot)

			l_wel_bitmap := wel_bitmap
			check l_wel_bitmap /= Void end
			l_wel_mask_bitmap := wel_mask_bitmap
			check l_wel_mask_bitmap /= Void end
			l_icon_info.set_color_bitmap (l_wel_bitmap)
			l_icon_info.set_mask_bitmap (l_wel_mask_bitmap)

			create wel_cursor.make_by_icon_info (l_icon_info)
			wel_cursor.enable_reference_tracking
			l_icon_info.delete
		ensure
			created: wel_cursor /= Void and then wel_cursor.exists
		end

	build_bitmap (a_pixel_buffer: EV_PIXEL_BUFFER)
			-- Build `wel_bitmap' for `wel_cursor'
		require
			not_craeted: wel_bitmap = Void
		local
			l_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
			l_pixmap: detachable EV_PIXMAP
			l_pixmap_imp: detachable EV_PIXMAP_IMP_STATE
			l_gdip_bitmap: detachable WEL_GDIP_BITMAP
		do
			l_buffer_imp ?= a_pixel_buffer.implementation
			check not_void: l_buffer_imp /= Void end
			if l_buffer_imp.is_gdi_plus_installed then
				l_gdip_bitmap ?= l_buffer_imp.gdip_bitmap
				check l_gdip_bitmap /= Void end
				wel_bitmap := l_gdip_bitmap.new_bitmap
			else
				l_pixmap ?= l_buffer_imp.pixmap
				check l_pixmap /= Void end
				l_pixmap_imp ?= l_pixmap.implementation
				check not_void: l_pixmap_imp /= Void end
				wel_bitmap := l_pixmap_imp.get_bitmap
			end

		ensure
			created: wel_bitmap /= Void
		end

	build_mask_bitmap (a_width, a_height: INTEGER)
			-- Build `wel_mask_bitmap' for `wel_cursor'
		require
			not_created: wel_mask_bitmap = Void
		local
			l_mem_dc: WEL_MEMORY_DC
			l_wel_mask_bitmap: like wel_mask_bitmap
		do
			create l_mem_dc.make
			create l_wel_mask_bitmap.make_compatible (
				l_mem_dc,
				a_width,
				a_height
				)
			l_mem_dc.select_bitmap (l_wel_mask_bitmap)
			wel_mask_bitmap := l_wel_mask_bitmap
					-- We have no mask so make sure that all of the pixmap is visible.
			l_mem_dc.pat_blt (0, 0, a_width, a_height, {WEL_RASTER_OPERATIONS_CONSTANTS}.blackness)
			l_mem_dc.unselect_bitmap
			l_mem_dc.delete
		ensure
			created: wel_mask_bitmap /= Void
		end

	destroy_gdi_objects
			-- destroy all gdi objects
		do
			if attached wel_cursor as l_wel_cursor and then l_wel_cursor.exists then
				l_wel_cursor.decrement_reference
			end
			if attached wel_bitmap as l_wel_bitmap and then l_wel_bitmap.exists then
				if l_wel_bitmap.reference_tracked then
					l_wel_bitmap.decrement_reference
				else
					l_wel_bitmap.delete
				end
			end
			if attached wel_mask_bitmap as l_wel_mask_bitmap and then l_wel_mask_bitmap.exists then
				l_wel_mask_bitmap.delete
			end
		end

	wel_bitmap: detachable WEL_BITMAP
			-- Dib 32bits rbga bitmap.

	wel_mask_bitmap: detachable WEL_BITMAP;
			-- Mask bitmap

	Idc_constants: WEL_IDC_CONSTANTS
			-- Idc constants
		once
			create Result
		end

note
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

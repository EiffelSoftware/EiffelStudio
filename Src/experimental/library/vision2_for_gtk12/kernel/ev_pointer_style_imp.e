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
		export
			{EV_ANY_HANDLER}
				interface
		redefine
			destroy
		end

	EV_ANY_HANDLER

	DISPOSABLE

create
	make

feature {NONE} -- Initlization

	make (an_interface: EV_POINTER_STYLE)
			-- Creation method
		do
			base_make (an_interface)
		end

	initialize
			-- Initialize
		do
			set_is_initialized (True)
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_x_hotspot, a_y_hotspot: INTEGER)
			-- Initialize from `a_pixel_buffer'
		local
			l_pix_buf_imp: EV_PIXEL_BUFFER_IMP
		do
			l_pix_buf_imp ?= a_pixel_buffer.implementation
			internal_pixmap := l_pix_buf_imp.internal_pixmap.twin
			set_x_hotspot (a_x_hotspot)
			set_y_hotspot (a_x_hotspot)
		end

	init_predefined (a_constant: INTEGER)
			-- Initialized a predefined cursor.
		do
			predefined_cursor_code := a_constant
		end

	init_from_cursor (a_cursor: EV_CURSOR)
			-- Initialize from `a_cursor'
		do
			internal_pixmap := a_cursor.twin
			set_x_hotspot (a_cursor.x_hotspot)
			set_y_hotspot (a_cursor.y_hotspot)
		end

	init_from_pixmap (a_pixmap: EV_PIXMAP; a_hotspot_x, a_hotspot_y: INTEGER_32)
			-- Initalize from `a_pixmap'
		do
			internal_pixmap := a_pixmap.twin
			set_x_hotspot (a_hotspot_x)
			set_y_hotspot (a_hotspot_y)
		end

feature -- Command

	set_x_hotspot (a_x: INTEGER)
			-- Set `x_hotspot' to `a_x'.
		do
			x_hotspot := a_x
		end

	set_y_hotspot (a_y: INTEGER)
			-- Set `y_hotspot' to `a_y'.
		do
			y_hotspot := a_y
		end

	destroy
			-- Destroy `Current'.
		do
			set_is_in_destroy (True)
			set_is_destroyed (True)
		end

feature -- Query

	width: INTEGER
			-- Width of pointer style.
		do
			if internal_pixmap /= Void then
				Result := internal_pixmap.width
			else
				Result := 16
			end
		end

	height: INTEGER
			-- Height of pointer style.
		do
			if internal_pixmap /= Void then
				Result := internal_pixmap.height
			else
				Result := 16
			end
		end

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot.

feature -- Implementation

	gdk_cursor_from_pointer_style: POINTER
			-- Return a GdkCursor constructed from `a_cursor'
		local
			a_image: POINTER
			l_pix_imp: EV_PIXMAP_IMP
		do
			inspect
				predefined_cursor_code
					-- Return a predefined cursor if available.
			when {EV_POINTER_STYLE_CONSTANTS}.busy_cursor then
				Result := {EV_GTK_EXTERNALS}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_watch_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.standard_cursor then
				Result := default_pointer--{EV_GTK_EXTERNALS}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_left_ptr_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.crosshair_cursor then
				Result := {EV_GTK_EXTERNALS}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_crosshair_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.ibeam_cursor then
				Result := {EV_GTK_EXTERNALS}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_xterm_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.sizeall_cursor then
				Result := {EV_GTK_EXTERNALS}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_fleur_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.sizens_cursor then
				Result := {EV_GTK_EXTERNALS}.gdk_cursor_new ({EV_GTK_ENUMS}.Gdk_size_sb_v_double_arrow_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.wait_cursor then
				Result := {EV_GTK_EXTERNALS}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_watch_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.help_cursor then
				Result := {EV_GTK_EXTERNALS}.gdk_cursor_new ({EV_GTK_ENUMS}.gdk_question_arrow_enum)
			when {EV_POINTER_STYLE_CONSTANTS}.no_cursor then
				a_image := {EV_STOCK_PIXMAPS_IMP}.no_cursor_xpm
			when {EV_POINTER_STYLE_CONSTANTS}.sizenwse_cursor then
				a_image := {EV_STOCK_PIXMAPS_IMP}.sizenwse_cursor_xpm
			when {EV_POINTER_STYLE_CONSTANTS}.sizenesw_cursor then
				a_image := {EV_STOCK_PIXMAPS_IMP}.sizenesw_cursor_xpm
			when {EV_POINTER_STYLE_CONSTANTS}.sizewe_cursor then
				a_image := {EV_STOCK_PIXMAPS_IMP}.sizewe_cursor_xpm
			when {EV_POINTER_STYLE_CONSTANTS}.uparrow_cursor then
				a_image := {EV_STOCK_PIXMAPS_IMP}.uparrow_cursor_xpm
			else
				do_nothing
			end

			if Result = default_pointer and then predefined_cursor_code /= {EV_POINTER_STYLE_CONSTANTS}.standard_cursor then
				if a_image /= default_pointer then
					internal_pixmap := create {EV_CURSOR}
					l_pix_imp ?= internal_pixmap.implementation
					l_pix_imp.set_from_xpm_data (a_image)
					Result := l_pix_imp.app_implementation.gdk_cursor_from_pixmap (internal_pixmap, x_hotspot, y_hotspot)
				else
					if internal_pixmap /= Void then
						l_pix_imp ?= internal_pixmap.implementation
						Result := l_pix_imp.app_implementation.gdk_cursor_from_pixmap (internal_pixmap, x_hotspot, y_hotspot)
					end
				end
			end
		end

	internal_pixmap: EV_PIXMAP
		-- EV_PIXMAP used for pointer style implementation.

feature {EV_ANY_HANDLER, EV_ANY_I} -- Implementation

	predefined_cursor_code: INTEGER;
		-- Predefined cursor code used for selecting platform cursors.

feature {NONE} -- Implementation

	dispose
			-- Clean up `Current'.
		do
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

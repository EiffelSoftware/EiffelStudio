note
	description: "Cocoa implementation of EV_POINTER_STYLE_I."
	author: "Daniel Furrer"
	keywords: "mouse, pointer, cursor, arrow"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POINTER_STYLE_IMP

inherit
	EV_POINTER_STYLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initlization

	make
			-- Initialize
		do
			create cursor.make
			cursor := cursor.arrow_cursor
			set_is_initialized (True)
		end

	init_from_pixel_buffer (a_pixel_buffer: EV_PIXEL_BUFFER; a_hotspot_x, a_hotspot_y: INTEGER)
			-- Initialize from `a_pixel_buffer'
		local
			l_pixel_buffer_imp: detachable EV_PIXEL_BUFFER_IMP
		do
			l_pixel_buffer_imp ?= a_pixel_buffer.implementation
			check l_pixel_buffer_imp /= Void end
			create cursor.make_with_image (l_pixel_buffer_imp.image, create {NS_POINT}.make_point (a_hotspot_x, a_hotspot_y))
		end

	init_predefined (a_constant: INTEGER)
			-- Initialized a predefined cursor.
		do
			create cursor.make
			if a_constant = {EV_POINTER_STYLE_CONSTANTS}.Busy_cursor then
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Standard_cursor then
				cursor := cursor.arrow_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Crosshair_cursor then
				cursor := cursor.crosshair_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Help_cursor then
				cursor := cursor.ibeam_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Ibeam_cursor then
				cursor := cursor.ibeam_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.No_cursor then
				cursor := cursor.closed_hand_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Sizeall_cursor then
				cursor := cursor.resize_up_down_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Sizens_cursor then
				cursor := cursor.resize_up_down_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Sizenwse_cursor then
				cursor := cursor.resize_up_down_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Sizenesw_cursor then
				cursor := cursor.resize_up_down_cursor
			elseif a_constant = {EV_POINTER_STYLE_CONSTANTS}.Hyperlink_cursor then
				cursor := cursor.pointing_hand_cursor
			else
				cursor := cursor.arrow_cursor
			end
		end

	init_from_cursor (a_cursor: EV_CURSOR)
			-- Initialize from `a_cursor'
		local
			l_pixmap_imp: detachable EV_PIXMAP_IMP
		do
			l_pixmap_imp ?= a_cursor.implementation
			check l_pixmap_imp /= Void end
			create cursor.make_with_image (l_pixmap_imp.image, create {NS_POINT}.make_point (a_cursor.x_hotspot, a_cursor.y_hotspot))
		end

	init_from_pixmap (a_pixmap: EV_PIXMAP; a_hotspot_x, a_hotspot_y: INTEGER_32)
			-- Initalize from `a_pixmap'
		local
			l_pixmap_imp: detachable EV_PIXMAP_IMP
		do
			l_pixmap_imp ?= a_pixmap.implementation
			check l_pixmap_imp /= Void end
			create cursor.make_with_image (l_pixmap_imp.image, create {NS_POINT}.make_point (a_hotspot_x, a_hotspot_y))
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
		end

feature -- Query

	width: INTEGER
			-- Width of pointer style.
		do
		end

	height: INTEGER
			-- Height of pointer style.
		do
		end

	x_hotspot: INTEGER
			-- Specifies the x-coordinate of a cursor's hot spot.

	y_hotspot: INTEGER
			-- Specifies the y-coordinate of a cursor's hot spot.

feature -- Duplication

	copy_from_pointer_style (a_pointer_style: like interface)
			-- Copy attributes of `a_pointer_style' to `Current.
		do
		end

feature {EV_ANY_HANDLER, EV_ANY_I} -- Implementation

	predefined_cursor_code: INTEGER;
		-- Predefined cursor code used for selecting platform cursors.

	cursor: NS_CURSOR

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_POINTER_STYLE note option: stable attribute end;
			-- Interface

end

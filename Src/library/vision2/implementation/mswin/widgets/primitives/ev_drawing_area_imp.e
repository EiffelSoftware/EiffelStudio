indexing
	description: "EiffelVision drawing area. Implementation interface."
	note: "The dc we use is actually a private dc (See notice on display%
		% device context. It doesn't need to be released each time."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DRAWING_AREA_IMP

inherit
	EV_DRAWING_AREA_I

	EV_DRAWABLE_IMP
		undefine
			background_color,
			foreground_color
		redefine
			foreground_color_imp,
			set_background_color,
			set_foreground_color		
		end

	EV_PIXMAPABLE_IMP
		redefine
			set_pixmap,
			unset_pixmap
		end

	EV_PRIMITIVE_IMP
		undefine
			set_default_options
		redefine
			on_key_down,
			foreground_color_imp,
			background_color_imp,
			set_background_color,
			set_foreground_color
		end

	WEL_CONTROL_WINDOW
		rename
			make as wel_make,
			parent as wel_parent,
			set_parent as wel_set_parent,
			destroy as wel_destroy,
			destroy_item as wel_destroy_item
		undefine
			set_width,
			set_height,
			remove_command,
			background_brush,
			on_left_button_down,
			on_mouse_move,
			on_left_button_up,
			on_right_button_down,
			on_right_button_up,
			on_left_button_double_click,
			on_right_button_double_click,
			on_key_up,
			on_kill_focus,
			on_set_focus,
			on_set_cursor,
			on_accelerator_command
		redefine
			on_size,
			on_key_down,
			on_paint,
			on_wm_erase_background,
			background_brush,
			default_style
		end

	WEL_CS_CONSTANTS
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make is
			-- Create an empty drawing area.
		do
			!! foreground_color_imp.make_system (color_windowtext)
			!! background_color_imp.make_system (color_window)
			wel_make (default_parent.item, "Drawing area")
			!! dc.make (Current)
			dc.get

			-- We set some default_values
			dc.set_background_opaque
			set_logical_mode (3)
			dc.select_brush (background_brush)
			dc.select_pen (background_pen)
			set_line_width (1)
			set_line_style (ps_solid)
		end

feature -- Access

	dc: WEL_CLIENT_DC
			-- A dc to paint on it.

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
		do
--			{EV_PIXMAPABLE_IMP} Precursor (pix)
			pixmap_imp ?= pix.implementation
			pixmap_imp.set_free_status (False)
			set_minimum_size (pixmap_imp.width, pixmap_imp.height)
		end

	unset_pixmap is
			-- Remove the pixmap from the container
		do
--			{EV_PIXMAPABLE_IMP} Precursor
			pixmap_imp.set_free_status (True)
			pixmap_imp := Void
			set_minimum_size (0, 0)
		end

feature -- Event - command association

	add_resize_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of action to be executed when
			-- current area is resized.
			-- `arg' will be passed to `cmd' whenever it is
			-- invoked as a callback.
		do
			add_command (Cmd_size, cmd, arg)
		end

	add_paint_command (cmd: EV_COMMAND; arg: EV_ARGUMENT) is
			-- Add `cmd' to the list of commands to be executed
			-- when the widget has to be redrawn.
		do
			add_command (Cmd_paint, cmd, arg)
		end

feature -- Event - command removal

	remove_resize_commands is
			-- Remove the list of commands to be executed when
			-- current area is resized.
		do
			remove_command (Cmd_size)
		end

	remove_paint_commands is
			-- Empty the list of commands to be executed when
			-- the widget has to be redrawn.
		do
			remove_command (Cmd_paint)
		end

feature {NONE} -- Implementation

	foreground_color_imp: EV_COLOR_IMP
			-- Color used for the foreground of the drawable,
			-- used for the text and the drawings.

	background_color_imp: EV_COLOR_IMP
			-- Current background color

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			{EV_PRIMITIVE_IMP} Precursor (color)
			{EV_DRAWABLE_IMP} Precursor (color)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			{EV_PRIMITIVE_IMP} Precursor (color)
			{EV_DRAWABLE_IMP} Precursor (color)
		end

feature {NONE} -- WEL Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Executed when a key is pressed.
			-- We verify that there is indeed a command to avoid
			-- the creation of an object for nothing.
		local
			data: EV_KEY_EVENT_DATA
		do
			if has_command (Cmd_key_press) then
				data := get_key_data (virtual_key, key_data)
				execute_command (Cmd_key_press, data)
			end
		end

	on_size (size_type, a_width, a_height: INTEGER) is
			-- Called when the drawing area is resized.
		do
			execute_command (Cmd_size, Void)
		end

	on_paint (paint_dc: WEL_PAINT_DC; invalid_rect: WEL_RECT) is
			-- Wm_paint message.
			-- May be redefined to paint something on
			-- the `paint_dc'. `invalid_rect' defines
			-- the invalid rectangle of the client area that
			-- needs to be repainted.
		local
			clip: EV_CLIP
			pt: EV_COORDINATES
			expose_event_data: EV_EXPOSE_EVENT_DATA
		do
			-- If a pixmap is linked to the area, we draw it
			if pixmap_imp /= Void then
				dc.copy_dc (pixmap_imp.internal_dc, client_rect)
			end

			-- arguments for the paint event.
			!! pt.set (invalid_rect.left, invalid_rect.top)
			!! clip.set (pt, invalid_rect.width, invalid_rect.height)
			!! expose_event_data.make
			expose_event_data.implementation.set_clip_region (clip)
			execute_command (Cmd_paint, expose_event_data)
		end

	on_wm_erase_background (wparam: INTEGER) is
	  			-- Wm_erasebkgnd message.
				-- Need to do nothing
		do
			disable_default_processing
		end

	default_style: INTEGER is
			-- Default style that memories the drawings.
		do
			Result := Ws_child + Ws_visible + Cs_owndc
		end

feature {NONE} -- Inapplicable

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		do
			check
				Inapplicable: False
			end
		end

end -- class EV_DRAWING_AREA_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

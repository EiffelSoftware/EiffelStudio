indexing
	description: "This class represents a MS_WINDOWS Ownerdraw button";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	PICT_COLOR_BUTTON_WINDOWS

inherit
	OWNER_DRAW_BUTTON_WINDOWS
		rename
			realize as draw_realize
		redefine
			on_draw,
			set_default_size,
			set_background_pixmap
		end

	OWNER_DRAW_BUTTON_WINDOWS
		redefine
			on_draw,
			set_default_size,
			set_background_pixmap,
			realize
		select
			realize
		end
		
	PICT_COL_B_I

	WEL_DIB_COLORS_CONSTANTS
		export
			{NONE} all
		end
	
creation
	make

feature -- Initialization

	make (a_picture_color_button: PICT_COLOR_B; oui_parent: COMPOSITE; man: BOOLEAN) is
			-- Create the pict color b
		do
			!! private_attributes
			parent ?= oui_parent.implementation
			managed := True
			a_picture_color_button.set_font_imp (Current)
			managed := man
		end

feature -- Access

	pixmap: PIXMAP
			-- Pixmap to be drawn on button

	is_pressed: BOOLEAN
			-- Is the button pressed?

feature -- Status setting

	set_pressed (b: boolean) is
			-- Set `is_pressed' to `b'. 
		do 
			is_pressed := b;
			if exists then
				invalidate
			end
		end

	set_pixmap, set_background_pixmap (a_pixmap: PIXMAP) is
			-- Set the pixmap for the button
		do
			pixmap := a_pixmap
			if (fixed_size_flag and (pixmap.height + off_set > height or pixmap.width + off_set > width)) or not fixed_size_flag then
				set_form_width ((pixmap.width + off_set).min (maximal_width))
				set_form_height ((pixmap.height + off_set).min (maximal_height))
			end
			if exists then
				invalidate
			end
		end

	set_default_size is
			-- Set default of button
		do
			if pixmap /= Void then
				set_form_width (pixmap.width + off_set)
				set_form_height (pixmap.height + off_set)
			end
		end

feature -- Element change 

	add_draw_item_action (a_command: COMMAND; arg: ANY) is
			-- Action for a draw item.
		do
			draw_item_actions.add (Current, a_command, arg)
		end

	realize is
		do
			draw_realize;
			invalidate
		end

feature -- Removal

	remove_draw_item_action (a_command: COMMAND; arg: ANY) is
			-- Remove actions for draw_item event
		do
			draw_item_actions.remove (Current, a_command, arg)
		end

feature {NONE} -- Implementation

	on_draw (a_draw_item_struct: WEL_DRAW_ITEM_STRUCT) is
			-- Respond to a draw_item message.
		local
			dc: WEL_DC
			brush: WEL_BRUSH
		do
			dc := a_draw_item_struct.dc
			!! brush.make_solid (wel_background_color)
			dc.select_brush (brush)
			dc.rectangle (0, 0, width, height)
			dc.unselect_brush
			if is_pressed then
				draw_all_selected (dc)
			else
				if flag_set (a_draw_item_struct.item_state, Ods_selected) then
					draw_all_selected (dc)	
				else
					draw_all_unselected (dc)
				end
			end	
		end

	draw_selected (a_dc: WEL_DC) is
		local
			bitmap: WEL_BITMAP
			pixmap_w: PIXMAP_WINDOWS
			dib: WEL_DIB
			pixmap_x, pixmap_y : INTEGER
		do
			if pixmap /= Void then
				pixmap_w ?= pixmap.implementation
				dib := pixmap_w.dib
				check
					dib_exists: dib /= Void
				end
				!! bitmap.make_by_dib (a_dc, dib, dib_rgb_colors)
				if alignment_type = center_alignment_type and then False then
					pixmap_x := (4 + ((internal_width - bitmap.width) // 2)).max (4)
					pixmap_y := (4 + ((internal_height - bitmap.height) // 2)).max (4)
					a_dc.draw_bitmap (bitmap, pixmap_x, pixmap_y, internal_width, internal_height)
				else
					a_dc.draw_bitmap (bitmap, 2, 2, internal_width, internal_height)
				end
			end
		end

	draw_unselected (a_dc: WEL_DC) is
		local
			bitmap: WEL_BITMAP
			pixmap_w: PIXMAP_WINDOWS
			dib: WEL_DIB
			pixmap_x, pixmap_y : INTEGER
		do
			if pixmap /= Void then
				pixmap_w ?= pixmap.implementation
				dib := pixmap_w.dib
				check
					dib_exists: dib /= Void
				end
				!! bitmap.make_by_dib (a_dc, dib, dib_rgb_colors)
				if alignment_type = center_alignment_type and False then
					pixmap_x := (2 + ((internal_width - bitmap.width) // 2)).max (2)
					pixmap_y := (2 + ((internal_height - bitmap.height) // 2)).max (2)
					a_dc.draw_bitmap (bitmap, pixmap_x, pixmap_y, internal_width, internal_height)
				else
					a_dc.draw_bitmap (bitmap, 2, 2, internal_width, internal_height)
				end
			end
		end

	internal_width: INTEGER is
		require
			exists: exists
		do
			Result := (width - off_set).max (0)
		ensure
			positive_result: Result >= 0
		end

	internal_height: INTEGER is
		require
			exists: exists
		do
			Result := (height - off_set).max (0)
		ensure
			positive_result: Result >= 0
		end

	off_set: INTEGER is 4

end -- class PICT_COLOR_BUTTON_WINDOWS

--|---------------------------------------------------------------- 
--| EiffelVision: library of reusable components for ISE Eiffel 3. 
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc. 
--| All rights reserved. Duplication and distribution prohibited. 
--| 
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA 
--| Telephone 805-685-1006 
--| Fax 805-685-6869 
--| Electronic mail <info@eiffel.com> 
--| Customer support e-mail <support@eiffel.com> 
--|---------------------------------------------------------------- 

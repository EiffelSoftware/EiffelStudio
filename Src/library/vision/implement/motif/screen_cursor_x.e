indexing

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class SCREEN_CURSOR_X 

inherit

	RESOURCES_X [ANY]
		rename
			make as resources_x_make
		export
			{ANY} objects
		end;

	SCREEN_CURSOR_I;
		
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end


creation

	make

	
feature {NONE}

	dispose is
			-- Called when garbaged.
		local
			null_pointer: POINTER;
		do
			if type = User_defined_pixmap then
				if arx_pixmap /= null_pointer then
					c_free_pixmap (arx_pixmap);
					arx_pixmap := null_pointer;
				end;
				if arx_mask /= null_pointer then
					c_free_pixmap (arx_mask);
					arx_mask := null_pointer;
				end;
			end
		end; 
	
feature 

	make (a_cursor: SCREEN_CURSOR) is
			-- Create a cursor implementation and set current type
			-- to `X_cursor' by default.
		do
			resources_x_make;
			type := X_cursor
		end; 

	cursor_id (a_screen: SCREEN_I): POINTER is
			-- Cursor id for `a_screen_object'
		require
			a_screen_exists: not (a_screen = Void)
		
		local
			a_resource: RESOURCE_X
		do
			a_resource := find_same_screen (a_screen);
			if (a_resource = Void) then
				if type = User_defined_pixmap then
					Result := c_create_pixmap_cursor (a_screen.screen_object, arx_pixmap, arx_mask)
				else
					Result := x_create_font_cursor (a_screen.screen_object, type*2)
				end;
				!CURSOR_RES_X! a_resource.make (a_screen, Result, true);
				put_front (a_resource)
			else
				Result := a_resource.identifier
			end
		end; 
	
feature {NONE}

	free_resources is
			-- Free all cursor resources.
		do
			from
				start
			until
				off
			loop
				if item.is_allocated then
					x_free_cursor (item.screen.screen_object, item.identifier);
					item.set_allocated (False);
				end;
				forth
			end;
			wipe_out;
			dispose
		end; 

	is_used_by (a_widget: WIDGET): BOOLEAN is
			-- Is `a_widget' using this resource ?
		require else
			a_widget_exists: not (a_widget = Void)
		do
			Result := (a_widget.cursor /= Void) and then 
					(a_widget.cursor.implementation = Current)
		ensure then
			(number_of_uses = 0) implies (not Result)
		end; 
	
feature 

	set_type (new_type: INTEGER) is
			-- Set type of current cursor to `new_type'.
			-- Thie new type must be a predefined one.
		require else
			type_ok: (X_cursor <= new_type) and (new_type < Cursor_undefined)
		do
			free_resources;
			type := new_type;
			update_widgets
		ensure then
			type = new_type
		end; 

	set_pixmap (pixmap: PIXMAP; mask: PIXMAP) is
			-- Set `pixmap' as the new shape of the cursor.
			-- `mask' is the pixel of pixmap that are to be displayed.
			-- If `mask' is void, a suitable mask is drawn from `pixmap'.
			-- Note that `pixmap' and `mask' are not kept by the cursor,
			-- they may be disposed, and if they change, cursor will be
			-- altered.
		require else
			pixmap_exists: not (pixmap = Void);
			pixmap_is_valid: pixmap.is_valid;
			mask_is_valid_if_exists: (not (mask = Void)) implies mask.is_valid
		local
			pixmap_implementation: PIXMAP_X;
			mask_implementation: PIXMAP_X
		do
			free_resources;
			type := User_defined_pixmap;
			pixmap_implementation ?= pixmap.implementation;
			arx_pixmap := c_arx_duplicate (pixmap_implementation.arx_pixmap);
			if not (mask = Void) then
				mask_implementation ?= mask.implementation;
				arx_mask := c_arx_duplicate (mask_implementation.arx_pixmap)
			else
				arx_mask := c_arx_mask (arx_pixmap)
			end;
			update_widgets
		ensure then
			type = User_defined_pixmap
		end;

	
feature {NONE}

	arx_pixmap: POINTER;
			-- ArXpixmap giving the shape of the cursor

	arx_mask: POINTER;
			-- ArXpixmap giving the pixels of arx_pixmap drawn.

	
feature 

	type: INTEGER;
			-- Predefined type of current cursor

	
feature {NONE}

	update_widgets is
			-- Update widgets.
		
		local
			widgets_to_update: LIST [WIDGET_X]
		do
			from
				widgets_to_update ?= objects;
				widgets_to_update.start
			until
				widgets_to_update.off
			loop
				widgets_to_update.item.update_cursor;
				widgets_to_update.forth
			end
		end

feature {NONE} -- External features

	x_create_font_cursor (scr_obj: POINTER; val: INTEGER): POINTER is
		external
			"C"
		end; 

	c_arx_mask (pix: POINTER): POINTER is
		external
			"C"
		end; 

	c_arx_duplicate (pix: POINTER): POINTER is
		external
			"C"
		end; 

	c_free_pixmap (mask: POINTER) is
		external
			"C"
		end; 

	x_free_cursor (scr_obj: POINTER; ident: POINTER) is
		external
			"C"
		end; 

	c_create_pixmap_cursor (scr_obj, pix, mask: POINTER): POINTER is
		external
			"C"
		end;

invariant

	((type >= X_cursor) and (type < Cursor_undefined)) or (type = User_defined_pixmap)

end 


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
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

indexing

	description: 
		"EiffelVision implementation of a Screen cursor.";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class 
	SCREEN_CURSOR_IMP 

inherit

	RESOURCE_X
		undefine
			is_equal
		end;

	SCREEN_CURSOR_I
		undefine
			is_equal
		end;

	G_ANY_I
		undefine
			is_equal
		end;

	MEL_SCREEN_CURSOR
		undefine
			has_valid_display
		redefine
			display, dispose
		end
		
creation
	make,
	make_for_screen

feature {NONE} -- Initialization

	make (a_cursor: SCREEN_CURSOR) is
			-- Create a cursor implementation and set current type
			-- to `X_cursor' by default.
		require
			last_open_display_not_null: last_open_display /= Void
		do
			type := X_cursor;
			display := last_open_display
		end; 

	make_for_screen (a_cursor: SCREEN_CURSOR; a_screen: SCREEN) is
			-- Create a font.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		local
			mel_display: MEL_DISPLAY
		do
			type := X_cursor;
			display ?= a_screen.implementation;
			check
				valid_display: display /= Void
			end
		end;

feature -- Access

	display: MEL_DISPLAY;
			-- Display where resource is allocated

	type: INTEGER;
			-- Predefined type of current cursor

	source_pixmap: PIXMAP_IMP;
			-- Pixmap giving the shape of the cursor
			-- (Reset to Void after allocation)

	cursor_mask: PIXMAP_IMP;
			-- Pixmap giving the pixels of cursor drawn
			-- (Reset to Void after allocation)

feature -- Status setting

	set_type (new_type: INTEGER) is
			-- Set type of current cursor to `new_type'.
			-- Thie new type must be a predefined one.
		do
			dispose;
			type := new_type;
			update_widgets
		end; 

	set_pixmap (pixmap: PIXMAP; mask: PIXMAP) is
			-- Set `pixmap' as the new shape of the cursor.
			-- `mask' is the pixel of pixmap that are to be displayed.
			-- If `mask' is void, a suitable mask is drawn from `pixmap'.
			-- Note that `pixmap' and `mask' are not kept by the cursor,
			-- they may be disposed, and if they change, cursor will be
			-- altered.
		local
			pixmap_implementation: PIXMAP_IMP;
			mask_implementation: PIXMAP_IMP
		do
			dispose;
			type := User_defined_pixmap;
			source_pixmap ?= pixmap.implementation;
			source_pixmap.allocate_bitmap;
			if mask = Void then
				cursor_mask ?= pixmap.implementation;
			else
				cursor_mask ?= mask.implementation;
			end;
			cursor_mask.allocate_bitmap
			update_widgets
		end;

feature -- Element change

	allocate_cursor is
			-- Allocate the screen cursor.
		require
			set_up: (type = User_defined_pixmap and then 
				not is_allocated) implies (source_pixmap /= Void and then
					cursor_mask /= Void)
		do
			if not is_allocated then
				if type = User_defined_pixmap then 
					make_from_pixmap (
						source_pixmap.bitmap, cursor_mask.bitmap, 
						source_pixmap.hot_x, source_pixmap.hot_y)
						-- Let the GC call dispose on the pixmaps in
						-- order to free them if no other object is using them.
					cursor_mask := Void;
					source_pixmap := Void;
				else
					make_from_type (display, type*2)
				end;
				is_allocated := True
			end
		end;

	dispose is
			-- Called when garbaged collected.
		do
			if not is_destroyed then
				destroy
			end;
			is_allocated := False;
		end; 

	update_widget_resource (widget_m: WIDGET_IMP) is
			-- Update resource for `widget_m'.
		local
			c: SCREEN_CURSOR
		do
			c := widget_m.cursor;	
			if (c /= Void) and then (c.implementation = Current) then
				number_of_users := number_of_users + 1;
				widget_m.update_cursor
			end
		end; 

end -- class SCREEN_CURSOR_IMP


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


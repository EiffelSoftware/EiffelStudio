indexing
	
	description: "Cursor displayable on the screen";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	SCREEN_CURSOR 

inherit

	CURSOR_TYPE;

	G_ANY
		export
			{NONE} all
		end

creation

	make,
	make_for_screen

feature {NONE} -- Initialization

	make is
			-- Create a cursor.
		do
			!SCREEN_CURSOR_IMP!implementation.make (current)
		end;

	make_for_screen (a_screen: SCREEN) is
			-- Create a cursor for `a_screen'.
		require
			valid_screen: a_screen /= Void and then a_screen.is_valid
		do
			!SCREEN_CURSOR_IMP!implementation.make_for_screen (Current, a_screen)
		end;

feature -- Access

	type: INTEGER is
			-- Predefined type of current cursor
		do
			Result := implementation.type
		end

feature -- Element change

	set_pixmap (pixmap: PIXMAP; mask: PIXMAP) is
			-- Set `pixmap' as the new shape of the cursor.
			-- `mask' is the pixel of pixmap that are to be displayed.
			-- If `mask' is void, a suitable mask is drawn from `pixmap'.
			-- Note that `pixmap' and `mask' are not kept by the cursor,
			-- they may be disposed, and if they change, cursor will be
			-- altered.
		require
			pixmap_exists: pixmap /= Void
			pixmap_is_valid: pixmap.is_valid;
			mask_is_valid_if_exists: (mask /= Void) implies mask.is_valid
		do
			implementation.set_pixmap (pixmap, mask)
		ensure
			user_pixmap_type: type = User_defined_pixmap
		end;

	set_type (new_type: INTEGER) is
			-- Set type of current cursor to `new_type'.
		require
			--type_ok: (X_cursor <= new_type) and (new_type < Cursor_undefined)
		do
			implementation.set_type (new_type)
		ensure
			type_set: type = new_type
		end;

feature {G_ANY, G_ANY_I, WIDGET_I, TOOLKIT} -- Implementation

	implementation: SCREEN_CURSOR_I;
			-- Implementation of current cursor

invariant

	valid_type: ((type >= X_cursor) and (type < Cursor_undefined)) or (type = User_defined_pixmap)

end -- class SCREEN_CURSOR



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


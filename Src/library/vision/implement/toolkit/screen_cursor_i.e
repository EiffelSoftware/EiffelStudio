
indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

deferred class SCREEN_CURSOR_I 

inherit

	CURSOR_TYPE
		
feature 

	set_pixmap (pixmap: PIXMAP; mask: PIXMAP) is
			-- Set `pixmap' as the new shape of the cursor.
			-- `mask' is the pixel of pixmap that are to be displayed.
			-- If `mask' is void, a suitable mask is drawn from `pixmap'.
			-- Note that `pixmap' and `mask' are not kept by the cursor,
            -- they may be disposed, and if they change, cursor will be
            -- altered.
		require
			pixmap_exists: not (pixmap = Void);
			pixmap_is_valid: pixmap.is_valid;
			mask_is_valid_if_exists: (not (mask = Void)) implies mask.is_valid
		deferred
		ensure
			type = User_defined_pixmap
		end; -- set_pixmap

	set_type (new_type: INTEGER) is
			-- Set type of current cursor to `new_type'.
			-- This new type must be a predefined one.
		require
			type_ok: (X_cursor <= new_type) and (new_type < Cursor_undefined)
		deferred
		ensure
			type = new_type
		end; -- set_type

	type: INTEGER is
			-- Predefined type of current cursor
		deferred
		end -- type

invariant

	((type >= X_cursor) and (type < Cursor_undefined)) or (type = User_defined_pixmap)

end


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

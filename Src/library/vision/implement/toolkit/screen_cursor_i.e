--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.      --
--|    270 Storke Road, Suite 7 Goleta, California 93117        --
--|                   (805) 685-1006                            --
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

indexing

	date: "$Date$";
	revision: "$Revision$"

deferred class SCREEN_CURSOR_I 

inherit

	CURSOR_TYPE
		export
			{NONE} all
		end

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

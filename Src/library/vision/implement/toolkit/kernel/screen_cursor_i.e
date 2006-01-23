indexing

	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class

	SCREEN_CURSOR_I 

inherit

	CURSOR_TYPE
		
feature -- Access

	type: INTEGER is
			-- Predefined type of current cursor
		deferred
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
		deferred
		ensure
			set: type = User_defined_pixmap
		end;

	set_type (new_type: INTEGER) is
			-- Set type of current cursor to `new_type'.
			-- This new type must be a predefined one.
		require
			type_ok: (X_cursor <= new_type) and (new_type < Cursor_undefined)
		deferred
		ensure
			set: type = new_type
		end;

invariant

	valid: ((type >= X_cursor) and (type < Cursor_undefined)) or (type = User_defined_pixmap)

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class SCREEN_CURSOR_I


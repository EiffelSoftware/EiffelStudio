indexing

	description: 
		"EiffelVision pixmap container, implementation interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_PIXMAP_CONTAINER_I
	
feature {EV_PIXMAP} -- status settings
	
	add_pixmap (pixmap: EV_PIXMAP) is
			-- Add a pixmap in the container
		require
			pixmap_not_void: pixmap /= Void
			pixmap_size_ok: pixmap_size_ok (pixmap)
		deferred
		end

	pixmap_size_ok (pixmap: EV_PIXMAP): BOOLEAN is
			-- Check if the size of the pixmap is ok for
			-- the container.
		do
			Result := True
		end

end -- class EV_PIXMAP_CONTAINER_I

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

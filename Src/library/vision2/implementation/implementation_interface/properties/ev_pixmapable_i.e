indexing
	description: 
		"Eiffel Vision pixmapable. Implementation interface."
	status: "See notice at end of class"
	keywords: "pixmap, bitmap, icon, graphic, image"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class 
	EV_PIXMAPABLE_I

inherit
	EV_ANY_I
		redefine
			interface
		end
	
feature -- Access

	pixmap: EV_PIXMAP is
			-- Image displayed on `Current'.
		deferred
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		require
			pixmap_not_void: a_pixmap /= Void
		deferred
		end

	remove_pixmap is
			-- Make `pixmap' `Void'.
		deferred
		ensure
			pixmap_removed: pixmap = Void
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'.

end -- class EV_PIXMAPABLE_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


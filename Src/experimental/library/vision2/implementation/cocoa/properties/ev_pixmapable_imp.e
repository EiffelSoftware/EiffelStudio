note
	description: "Eiffel Vision pixmapable. Cocoa implementation."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAPABLE_IMP

inherit
	EV_PIXMAPABLE_I

feature -- Initialization

	pixmapable_imp_initialize
		do
		end

feature -- Access

	pixmap: detachable EV_PIXMAP
			-- Pixmap shown in `Current'

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		do
			pixmap := a_pixmap
		end

	remove_pixmap
			-- Assign Void to `pixmap'.
		do
			pixmap := void
		end

end -- EV_PIXMAPABLE_IMP


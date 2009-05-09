note
	description:
		"Eiffel Vision pixmapable. Cocoa implementation."

deferred class
	EV_PIXMAPABLE_IMP

inherit
	EV_PIXMAPABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			destroy
		redefine
			interface
		end

feature -- Initialization

	pixmapable_imp_initialize
		do
		end

feature -- Access

	pixmap: EV_PIXMAP
			-- Pixmap shown in `Current'
		do
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP)
			-- Assign `a_pixmap' to `pixmap'.
		do
		end

	remove_pixmap
			-- Assign Void to `pixmap'.
		do
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE;

note
	copyright:	"Copyright (c) 2009, Daniel Furrer"
end -- EV_PIXMAPABLE_IMP


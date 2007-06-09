indexing
	description:
		"Eiffel Vision pixmapable. Carbon implementation."

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

	pixmapable_imp_initialize is
		do
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Pixmap shown in `Current'
		do
			if internal_pixmap /= Void then
				Result := internal_pixmap.interface.twin
			end
		end

feature -- Element change

	set_pixmap (a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to `pixmap'.
		do
			internal_pixmap ?= a_pixmap.implementation
			internal_set_pixmap (internal_pixmap, internal_pixmap.width, internal_pixmap.height)
		end

	remove_pixmap is
			-- Assign Void to `pixmap'.
		do
			internal_pixmap := void
			internal_remove_pixmap
		end

feature {EV_ITEM_PIXMAP_SCALER_I} -- Implementation

	internal_set_pixmap (a_pixmap_imp: EV_PIXMAP_IMP; a_width, a_height: INTEGER) is
			--
		do
		end

	internal_remove_pixmap is
			-- Remove pixmap from Current
		do
		end

	internal_pixmap: EV_PIXMAP_IMP
			-- Internal stored pixmap.		

feature {EV_ANY_I} -- Implementation

	interface: EV_PIXMAPABLE;

indexing
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- EV_PIXMAPABLE_IMP


indexing
	description: "EiffelVision pixmap container. %
				% Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAPABLE_IMP

inherit
	EV_PIXMAPABLE_I

	WEL_RASTER_OPERATIONS_CONSTANTS
		export
			{NONE} all
		end

	WEL_DT_CONSTANTS
		export
			{NONE} all
		end

	WEL_ODS_CONSTANTS
		export
			{NONE} all
		end

	WEL_ODA_CONSTANTS
		export
			{NONE} all
		end

	WEL_DRAWING_ROUTINES
		rename
			draw_edge as routine_draw_edge
		export
			{NONE} all
		end

feature -- Access

	pixmap: EV_PIXMAP is
			-- Current pixmap
		do
			Result := pixmap_imp.interface
		end

	pixmap_imp: EV_PIXMAP_IMP
			-- Implementation of the pixmap contained 

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of the widget.
		do
			pixmap_imp ?= pix.implementation
		end

	unset_pixmap is
			-- Remove the pixmap from the container
		do
			pixmap_imp ?= Void
		end

feature {EV_PIXMAP_IMP} -- Implementation

	wel_window: WEL_WINDOW is
			-- Window used to create the pixmap.
		deferred
		end

	interface: EV_ANY is
		deferred
		end

feature {EV_CONTAINER_IMP} -- Implementation

	on_draw (struct: WEL_DRAW_ITEM_STRUCT) is
		deferred
		end

end -- class EV_PIXMAPABLE_IMP

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

note
	description: "EiffelVision pixmap container. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAPABLE_IMP

inherit
	EV_PIXMAPABLE_I

feature -- Access

	pixmap: EV_PIXMAP
			-- Give a copy of pixmap used by `Current'.
		do
			if private_pixmap /= Void then
				create Result
				Result.copy (private_pixmap)
			end
		end

	pixmap_imp: EV_PIXMAP_IMP_STATE
			-- Implementation of pixmap in `Current'.
		do
			if private_pixmap /= Void then
				Result ?= private_pixmap.implementation
			end
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP)
			-- Make `pix' the new pixmap of `Current'.
		do
			private_pixmap := pix.twin
		end

	remove_pixmap
			-- Remove the pixmap from `Current'.
		do
			private_pixmap := Void
		end

feature {NONE} -- Implementation

	private_pixmap: EV_PIXMAP;
			-- Pixmap of `Current'.

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PIXMAPABLE_IMP


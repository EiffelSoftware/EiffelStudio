indexing
	description: "EiffelVision pixmap container. Mswindows implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_PIXMAPABLE_IMP

inherit
	EV_PIXMAPABLE_I

feature -- Access

	pixmap: EV_PIXMAP is
			-- Give a copy of pixmap used by `Current'.
		do
			if private_pixmap /= Void then
				create Result
				Result.copy (private_pixmap)
			end
		end

	pixmap_imp: EV_PIXMAP_IMP_STATE is
			-- Implementation of pixmap in `Current'.
		do
			if private_pixmap /= Void then
				Result ?= private_pixmap.implementation
			end
		end

feature -- Element change

	set_pixmap (pix: EV_PIXMAP) is
			-- Make `pix' the new pixmap of `Current'.
		do
			private_pixmap := pix
		end

	remove_pixmap is
			-- Remove the pixmap from `Current'.
		do
			private_pixmap := Void
		end

feature {NONE} -- Implementation

	private_pixmap: EV_PIXMAP
			-- Pixmap of `Current'.

end -- class EV_PIXMAPABLE_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description	: "EiffelVision pixmap. Common attributes between%
				  %all different EV_PIXMAP Windows implementation"
	status		: "See notice at end of class"
	date		: "$Date$"
	revision	: "$Revision$"
	author		: "Arnaud PICHERY [ aranud@mail.dotcom.fr ]"

deferred class
	EV_PIXMAP_IMP_STATE

feature -- Access

	bitmap: WEL_BITMAP is
			-- Current bitmap used. Void if not initialized, not
			-- Void otherwise (see Invariant at the end of class).
		deferred
		end

	icon: WEL_ICON
		-- Current icon used. Void if none.

	has_mask: BOOLEAN is
			-- Has the current pixmap a mask?
		deferred
		end

	mask_bitmap: WEL_BITMAP is
		-- Monochrome bitmap used as mask. Void if none.
		require
			mask_in_use: has_mask
		deferred
		end

	palette: WEL_PALETTE is
		-- Current palette used. Void if none.
		deferred
		end

	transparent_color: EV_COLOR is
			-- Color used as transparent (Void by default).
		deferred
		end

feature -- Misc.

	build_icon: WEL_ICON is
			-- Build a WEL_ICON from `bitmap' and `mask_bitmap'.
		local
			icon_info: WEL_ICON_INFO
		do
			create icon_info.make
			icon_info.set_fIcon (True)
			icon_info.set_color_bitmap (bitmap)
			if mask_bitmap /= Void then
				icon_info.set_mask_bitmap (mask_bitmap)
			end
			create Result.make_by_icon_info (icon_info)
		end

feature -- Measurement

	width: INTEGER is
			-- Width of the pixmap.
		deferred
		end

	height: INTEGER is
			-- Height of the pixmap.
		deferred
		end

end -- class EV_PIXMAP_IMP_STATE

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

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2000/05/03 00:37:00  pichery
--| Added feature `build_icon' + Refactoring.
--|
--| Revision 1.3  2000/04/25 01:25:12  pichery
--| Added `icon' attribute for polymorphism
--|
--| Revision 1.2  2000/04/13 18:33:12  pichery
--| Added access to width & height
--|
--| Revision 1.1  2000/04/12 01:34:56  pichery
--| New pixmap implementation.
--| Use 3 differents states depending on
--| what the user is doing with the pixmap.
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

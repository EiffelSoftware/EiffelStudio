indexing
	description: "List of default pens used by the system. %
		%Mswindows implementation. Make sure you call `delete' on WEL_PEN%
		%object when we are done with them to save GDI objects."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_SYSTEM_PEN_IMP

inherit
	WEL_PS_CONSTANTS
		export
			{NONE} all
		end

	WEL_COLOR_CONSTANTS
		export
			{NONE} all
		end

	WEL_STANDARD_PENS
		export
			{NONE} all
		end

feature {NONE} -- Access

	window_frame_pen: WEL_PEN is
			-- `Result' is a pen with the window frame color.
		local
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_windowframe)
			create Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
		end

	face_pen: WEL_PEN is
			-- `Result' is a pen with the face color.
		local
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_btnface)
			create Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end
	
	shadow_pen: WEL_PEN is
			-- `Result' is a pen with the shadow color.
		local
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_btnshadow)
			create Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

	highlight_pen: WEL_PEN is
			-- `Result' is a pen with the highlight color.
		local
			color: WEL_COLOR_REF
		do
			create color.make_system (Color_btnhighlight)
			create Result.make (ps_solid, 1, color)
		ensure
			result_not_void: Result /= Void
			result_exists: Result.exists
		end

end -- class EV_SYSTEM_PEN_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.8.5  2000/11/27 19:03:00  rogers
--| Replaced all bang bang's with create.
--|
--| Revision 1.1.8.4  2000/11/02 05:02:09  manus
--| Updated comment on EV_SYSTEM_PEN_IMP to show that after using one of these WEL_PEN
--| object the Vision2 implementor needs to call `delete' on them to free the allocated
--| GDI object. Updated code of classes which was not doing it.
--|
--| Revision 1.1.8.3  2000/10/27 02:09:00  manus
--| `Pen' cannot be constants anymore, since they need to reflect any changes made by the
--| user through the Appearance control panel.
--|
--| Revision 1.1.8.2  2000/08/11 20:02:42  rogers
--| removed fixme NOT_REVIEWED. Comments. Fixed copyright clause.
--|
--| Revision 1.1.8.1  2000/05/03 19:09:18  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/02/19 05:45:00  oconnor
--| released
--|
--| Revision 1.2  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.1.10.2  2000/01/27 19:30:16  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.1.10.1  1999/11/24 17:30:23  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.1.6.2  1999/11/02 17:20:08  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

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


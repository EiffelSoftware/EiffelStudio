indexing
	description: "General notion of a cursor manager"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	CURSOR_WIDGET_MANAGER

inherit
	W_MAN_GEN

feature -- Access

	cursor_widget: WIDGET_IMP is
			-- widget at mouse position, Void if none
		do
			Result := cursor_widget_implementation.item
		end;

feature {NONE} --Implementation

	cursor_widget_implementation: CELL [WIDGET_IMP] is
			-- Implementation for cursor_widget
		once
			!! Result.put (Void)
		ensure
			result_exists: Result /= Void
		end;

	set_cursor_widget (c: like cursor_widget) is
			-- replace `cursor_widget' by `c'
		do
			cursor_widget_implementation.replace (c)
		ensure
			cursor_widget_set: cursor_widget = c
		end;

	widget_pointed: WIDGET is
			-- Widget pointed, void if none
		local
			a_point: WEL_POINT
			a_window: WEL_WINDOW
		do
			!! a_point.make (0, 0)
			a_point.set_cursor_position
			a_window := a_point.window_at
			if a_window /= Void then
				Result := widget_manager.screen_object_to_oui (a_window.item)
			end
		end

end -- class CURSOR_WIDGET_MANAGER



--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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


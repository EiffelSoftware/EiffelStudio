indexing
	description: "General notion of a cursor manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			create Result.put (Void)
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
			create a_point.make (0, 0)
			a_point.set_cursor_position
			a_window := a_point.window_at
			if a_window /= Void then
				Result := widget_manager.screen_object_to_oui (a_window.item)
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class CURSOR_WIDGET_MANAGER


indexing

	description:
			"A MEL_TEXT as a child of a MEL_SCROLLED_WINDOW.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLLED_TEXT

inherit

	MEL_TEXT
		redefine
			make, clean_up
		end;

	MEL_SCROLLED_TEXT_RESOURCES

creation 
	make,
	make_detailed

feature {NONE} -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled text.
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_text (a_parent.screen_object, $widget_name, default_pointer, 0);
			Mel_widgets.put (Current, screen_object);
			text_widget := Current;
			!! scrolled_window.make_from_existing (xt_parent (screen_object));
			set_default;
			if do_manage then
				manage
			end
		end;

	make_detailed (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN;
							scroll_hor, scroll_vert, scroll_top, scroll_left: BOOLEAN) is
			-- Create a motif scrolled text with the eventual appearing horizontal
			-- scroll bar at the top or bottom, eventual appearing vertical scroll bar
			-- at the left or right.
		require
			a_name_exists: a_name /= Void;
			a_parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			parent := a_parent;
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_text_detailed (a_parent.screen_object,
								$widget_name, scroll_hor, scroll_vert, scroll_top, scroll_left);
			Mel_widgets.put (Current, screen_object);
			text_widget := Current;
			!! scrolled_window.make_from_existing (xt_parent (screen_object));
			set_default;
		   	if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			scroll_horizontal_set: is_scroll_horizontal = scroll_hor;
			scroll_vertical_set: is_scroll_vertical = scroll_vert;
			scroll_top_side_set: is_scroll_top_side = scroll_top;
			scroll_left_side_set: is_scroll_left_side = scroll_left
		end;

feature -- Access

	text_widget: MEL_TEXT;
			-- Text widget

	scrolled_window: MEL_SCROLLED_WINDOW;
			-- Scrolled window

feature -- Status report

	is_scroll_horizontal: BOOLEAN is
			-- Is a horizontal scrollbar added?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNscrollHorizontal)
		end;

	 is_scroll_vertical: BOOLEAN is
			-- Is a vertical scrollbar added?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNscrollVertical)
		end;

	is_scroll_top_side: BOOLEAN is
			-- Is the scrollbar displayed above the text window?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNscrollTopSide)
		end;

	is_scroll_left_side: BOOLEAN is
			-- Is the scrollbar displayed to the left of the text window?
		require
			exists: not is_destroyed
		do
			Result := get_xt_boolean (screen_object, XmNscrollLeftSide)
		end;

feature -- Removal

	clean_up is
			-- Destroy the widget.
		do
			object_clean_up;
			scrolled_window.object_clean_up
		end;

feature {NONE} -- Implementation

	xm_create_scrolled_text (a_parent, a_name, arglist: POINTER; argcount: INTEGER): POINTER is
		external
			"C [macro <Xm/Text.h>] (Widget, String, ArgList, Cardinal): EIF_POINTER"
		alias
			"XmCreateScrolledText"
		end;

	xm_create_scrolled_text_detailed (a_parent, a_name: POINTER; scroll_hor, scroll_vert, scroll_top, scroll_left: BOOLEAN): POINTER is
		external
			"C"
		end;
	
end -- class MEL_SCROLLED_TEXT

--|-----------------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1996, Interactive Software Engineering, Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Information e-mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|-----------------------------------------------------------------------

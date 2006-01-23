indexing

	description:
			"A MEL_TEXT as a child of a MEL_SCROLLED_WINDOW."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_SCROLLED_TEXT

inherit

	MEL_SCROLLED_TEXT_RESOURCES
		export
			{NONE} all
		end;

	MEL_TEXT
		rename
			make as text_make,
			make_from_existing as text_make_from_existing
		export
			{NONE} text_make, text_make_from_existing
		redefine
			parent, clean_up
		end;

create 
	make,
	make_detailed

feature -- Initialization

	make (a_name: STRING; a_parent: MEL_COMPOSITE; do_manage: BOOLEAN) is
			-- Create a motif scrolled text.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			screen_object := xm_create_scrolled_text 
				(a_parent.screen_object, $widget_name);
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default;

			if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name);
		end;

	make_detailed (a_name: STRING; a_parent: MEL_COMPOSITE; 
		       do_manage: BOOLEAN;
		       scroll_hor, scroll_vert, 
		       scroll_top, scroll_left: BOOLEAN) is
			-- Create a motif scrolled text with the
			-- eventual appearing horizontal scroll bar at
			-- the top or bottom, eventual appearing
			-- vertical scroll bar at the left or right.
		require
			name_exists: a_name /= Void;
			parent_exists: a_parent /= Void and then not a_parent.is_destroyed
		local
			widget_name: ANY
		do
			widget_name := a_name.to_c;
			screen_object := 
				xm_create_scrolled_text_detailed (a_parent.screen_object,
								  $widget_name, 
								  scroll_hor, 
								  scroll_vert, 
								  scroll_top, 
								  scroll_left);
			create parent.make_from_existing (xt_parent (screen_object), a_parent);
			Mel_widgets.add (Current);
			set_default;
		   	if do_manage then
				manage
			end
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent;
			name_set: name.is_equal (a_name);
			scroll_horizontal_set: is_scroll_horizontal = scroll_hor;
			scroll_vertical_set: is_scroll_vertical = scroll_vert;
			scroll_top_side_set: is_scroll_top_side = scroll_top;
			scroll_left_side_set: is_scroll_left_side = scroll_left
		end;

	make_from_existing (a_screen_object: POINTER; a_parent: MEL_COMPOSITE) is
			-- Create a motif widget from an existing widget.
		require
			valid_a_screen_object: a_screen_object /= default_pointer;
			valid_parent: a_parent /= Void
		do
			create parent.make_from_existing (xt_parent (a_screen_object),
				a_parent);
			screen_object := a_screen_object;
			Mel_widgets.add (Current);
		ensure
			exists: not is_destroyed;
			parent_set: parent.parent = a_parent
		end

feature -- Access

	parent: MEL_SCROLLED_WINDOW;
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

feature {NONE} -- Implementation

	clean_up is
			-- Clean up the object.
		do
			parent.clean_up;
		end;

feature {NONE} -- Implementation

	xm_create_scrolled_text (a_parent, a_name: POINTER): POINTER is
		external
			"C"
		end;

	xm_create_scrolled_text_detailed (a_parent, a_name: POINTER; scroll_hor, scroll_vert, scroll_top, scroll_left: BOOLEAN): POINTER is
		external
			"C"
		end;
	
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




end -- class MEL_SCROLLED_TEXT



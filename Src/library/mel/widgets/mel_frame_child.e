indexing

	description:
		"Child of a MEL_FRAME widget.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FRAME_CHILD

inherit

	MEL_FRAME_CHILD_RESOURCES
		export
			{NONE} all
		end;

	MEL_OBJECT

feature -- Access

	is_child_title: BOOLEAN is
			-- Is Current widget child type a title?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildType) = XmFRAME_TITLE_CHILD
		end;

	is_child_workarea: BOOLEAN is
			-- Is Current widget child type a work area?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildType) = XmFRAME_WORKAREA_CHILD
		end;

	is_child_generic: BOOLEAN is
			-- Is Current widget child type ignored?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildType) = XmFRAME_GENERIC_CHILD
		end;

	is_child_horizontal_alignment_beginning: BOOLEAN is
			-- Is widget horizontally aligned with the beginning?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildHorizontalAlignment) = XmCHILD_ALIGNMENT_BEGINNING
		end;

	is_child_horizontal_alignment_center: BOOLEAN is
			-- Is widget horizontally aligned with the center?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildHorizontalAlignment) = XmCHILD_ALIGNMENT_CENTER
		end;

	is_child_horizontal_alignment_end: BOOLEAN is
			-- Is widget horizontally aligned with the end?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildHorizontalAlignment) = XmCHILD_ALIGNMENT_END
		end;

	child_horizontal_spacing: INTEGER is
			-- Minimun distance between the title text and Current's shadow
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			Result := get_xt_dimension (screen_object, XmNchildHorizontalSpacing)
		ensure
			horizontal_spacing_large_enough: Result >= 0
		end;

	is_child_vertical_alignment_baseline_bottom: BOOLEAN is
			-- Is baseline aligned to the bottom of `parent'?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment) = XmCHILD_ALIGNMENT_BASELINE_BOTTOM
		end;

	is_child_vertical_alignment_baseline_top: BOOLEAN is
			-- Is baseline of aligned to the top of Current?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment) = XmCHILD_ALIGNMENT_BASELINE_TOP
		end;

	is_child_vertical_alignment_widget_top: BOOLEAN is
			-- Is widget aligned to the top of Current?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment) = XmCHILD_ALIGNMENT_WIDGET_TOP
		end;

	is_child_vertical_alignment_center: BOOLEAN is
			-- Is center line of widget aligned to the top line of Current?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment) = XmCHILD_ALIGNMENT_CENTER
		end;

	is_child_vertical_alignment_widget_bottom: BOOLEAN is
			-- Is widget aligned to the bottom of Current?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment) = XmCHILD_ALIGNMENT_WIDGET_BOTTOM
		end;

feature -- Status setting

	set_child_as_title is
			-- Set widget as the title.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			set_xt_unsigned_char 
					(screen_object, XmNchildType, XmFRAME_TITLE_CHILD)
		ensure
			child_is_now_the_title: is_child_title 
		end;

	set_child_as_workarea is
			-- Use widget as the work area.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildType, XmFRAME_WORKAREA_CHILD)
		ensure
			child_is_now_the_work_area: is_child_workarea 
		end;

	set_child_generic is
			-- Ignore widget as child type.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			set_xt_unsigned_char 
					(screen_object, XmNchildType, XmFRAME_GENERIC_CHILD)
		ensure
			child_is_now_ignored: is_child_generic 
		end;

	set_child_horizontal_alignment_beginning is
			-- Align widget with the beginning.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildHorizontalAlignment, XmCHILD_ALIGNMENT_BEGINNING)
		ensure
			alignment_set: is_child_horizontal_alignment_beginning 
		end;

	set_child_horizontal_alignment_center is
			-- Align widget with the center.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildHorizontalAlignment, XmCHILD_ALIGNMENT_CENTER)
		ensure
			alignment_set: is_child_horizontal_alignment_center 
		end;

	set_child_horizontal_alignment_end is
			-- Align widget with the end.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildHorizontalAlignment, XmCHILD_ALIGNMENT_END)
		ensure
			alignment_set: is_child_horizontal_alignment_end 
		end;

	set_child_horizontal_spacing (a_spacing: INTEGER) is
			-- Set `child_horizontal_spacing' to `a_spacing'.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title;
			a_spacing_large_enough: a_spacing >= 0
		do
			set_xt_dimension (screen_object, XmNchildHorizontalSpacing, a_spacing)
		ensure
			horizontal_spacing_set: child_horizontal_spacing = a_spacing
		end;

	set_child_vertical_alignment_baseline_bottom is
			-- Align baseline of widget to the bottom of Current.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment, XmCHILD_ALIGNMENT_BASELINE_BOTTOM)
		ensure
			placement_set: is_child_vertical_alignment_baseline_bottom 
		end;

	set_child_vertical_alignment_baseline_top is
			-- Align baseline of widget to the top of Current.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment, XmCHILD_ALIGNMENT_BASELINE_TOP)
		ensure
			placement_set: is_child_vertical_alignment_baseline_top 
		end;

	set_child_vertical_alignment_widget_top is
			-- Align widget to the top of Current?
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment, XmCHILD_ALIGNMENT_WIDGET_TOP)
		ensure
			placement_set: is_child_vertical_alignment_widget_top 
		end;

	set_child_vertical_alignment_center is
			-- Align center line of widget to the top line of Current.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment, XmCHILD_ALIGNMENT_CENTER)
		ensure
			placement_set: is_child_vertical_alignment_center 
		end;

	set_child_vertical_alignment_widget_bottom is
			-- Align widget to the bottom of Current.
		require
			exists: not is_destroyed;
			parent_is_frame: parent.is_frame;
			widget_is_the_title: is_child_title 
		do
			set_xt_unsigned_char 
				(screen_object, XmNchildVerticalAlignment, XmCHILD_ALIGNMENT_WIDGET_BOTTOM)
		ensure
			placement_set: is_child_vertical_alignment_widget_bottom 
		end;

end -- class MEL_FRAME_CHILD


--|----------------------------------------------------------------
--| Motif Eiffel Library: library of reusable components for ISE Eiffel.
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


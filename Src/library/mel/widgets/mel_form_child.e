indexing

	description:
		"Widget that has a form parent.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_FORM_CHILD

inherit

	MEL_FORM_CHILD_RESOURCES
		export
			{NONE} all
		end;

	MEL_OBJECT

feature -- Form child access

	form_parent: MEL_FORM is
			-- Form parent
		require
			has_form_parent: parent.is_form
		do	
			Result ?= parent
		ensure
			non_void_result: Result /= Void
		end;

feature -- Form child status report

	child_resizable: BOOLEAN is
			-- Is widget resizable?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			Result := get_xt_boolean (screen_object, XmNresizable)
		end;

	top_widget: MEL_RECT_OBJ is
			-- Widget that serves as the attachment point for 
			-- top of Current widget
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result ?= get_xt_widget (screen_object, XmNtopWidget)
		end;

	bottom_widget: MEL_RECT_OBJ is
			-- Widget that serves as the attachment point for 
			-- bottom of Current widget
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result ?= get_xt_widget (screen_object, XmNbottomWidget)
		end;

	left_widget: MEL_RECT_OBJ is
			-- Widget that serves as the attachment point for 
			-- left of Current widget
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result ?= get_xt_widget (screen_object, XmNleftWidget)
		end;

	right_widget: MEL_RECT_OBJ is
			-- Widget that serves as the attachment point for 
			-- right of Current widget
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result ?= get_xt_widget (screen_object, XmNrightWidget)
		end;

	is_top_attached: BOOLEAN is
			-- Is the top side of widget attached to the 
			-- top side of the form? 
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNtopAttachment) = XmATTACH_FORM
		end;

	is_bottom_attached: BOOLEAN is
			-- Is the bottom side of widget attached to 
			-- the bottom side of form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNbottomAttachment) = XmATTACH_FORM
		end;

	is_left_attached: BOOLEAN is
			-- Is the left side of widget attached to the 
			-- left side of form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNleftAttachment) = XmATTACH_FORM
		end;

	is_right_attached: BOOLEAN is
			-- Is the right side of widget attached to 
			-- the right side of form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNrightAttachment) = XmATTACH_FORM
		end;

	is_top_attached_to_opposite: BOOLEAN is
			-- Is the top side of widget attached to 
			-- the bottom side of form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNtopAttachment) = XmATTACH_OPPOSITE_FORM
		end;

	is_bottom_attached_to_opposite: BOOLEAN is
			-- Is the bottom side of widget attached to 
			-- the top side of form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNbottomAttachment) = XmATTACH_OPPOSITE_FORM
		end;

	is_left_attached_to_opposite: BOOLEAN is
			-- Is the left side of widget attached to 
			-- the right side of form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNleftAttachment) = XmATTACH_OPPOSITE_FORM
		end;

	is_right_attached_to_opposite: BOOLEAN is
			-- Is the right side of widget attached to 
			-- the left side of form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNrightAttachment) = XmATTACH_OPPOSITE_FORM
		end;

	is_top_not_attached: BOOLEAN is
			-- Is the top side of widget not attached?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNtopAttachment) = XmATTACH_NONE
		end;

	is_bottom_not_attached: BOOLEAN is
			-- Is the bottom side of widget not attached?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNbottomAttachment) = XmATTACH_NONE
		end;

	is_left_not_attached: BOOLEAN is
			-- Is the left side of widget not attached?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNleftAttachment) = XmATTACH_NONE
		end;

	is_right_not_attached: BOOLEAN is
			-- Is the right side of widget not attached?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNrightAttachment) = XmATTACH_NONE
		end;

	is_top_attached_to_widget: BOOLEAN is
			-- Is the top side of widget attached to the 
			-- bottom side of a widget?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNtopAttachment) = XmATTACH_WIDGET
		end;

	is_bottom_attached_to_widget: BOOLEAN is
			-- Is the bottom side of Current widget attached to 
			-- the top side of a widget?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNbottomAttachment) = XmATTACH_WIDGET
		end;

	is_left_attached_to_widget: BOOLEAN is
			-- Is the left side of Current widget attached to 
			-- the right side of a widget?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNleftAttachment) = XmATTACH_WIDGET
		end;

	is_right_attached_to_widget: BOOLEAN is
			-- Is the right side of Current widget attached to 
			-- the left side of a widget?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char (screen_object, XmNrightAttachment) = XmATTACH_WIDGET
		end;

	is_top_attached_to_opposite_widget: BOOLEAN is
			-- Is the top side of Current widget attached to 
			-- the opposite side of a widget?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNtopAttachment) = XmATTACH_OPPOSITE_WIDGET
		end;

	is_bottom_attached_to_opposite_widget: BOOLEAN is
			-- Is the bottom side of Current widget attached to 
			-- the bottom side of a widget?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNbottomAttachment) = XmATTACH_OPPOSITE_WIDGET
		end;

	is_left_attached_to_opposite_widget: BOOLEAN is
			-- Is the left side of Current widget attached to 
			-- the left side of a widget?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNleftAttachment) = XmATTACH_OPPOSITE_WIDGET
		end;

	is_right_attached_to_opposite_widget: BOOLEAN is
			-- Is the right side of Current widget attached to 
			-- the right side of a widget?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNrightAttachment) = XmATTACH_OPPOSITE_WIDGET
		end;

	is_top_attached_to_itself: BOOLEAN is
			-- Is the top side of widget attached to itself?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNtopAttachment) = XmATTACH_SELF
		end;

	is_bottom_attached_to_itself: BOOLEAN is
			-- Is the bottom side of widget attached to itself?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNbottomAttachment) = XmATTACH_SELF
		end;

	is_left_attached_to_itself: BOOLEAN is
			-- Is the left side of widget attached to itself?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
				(screen_object, XmNleftAttachment) = XmATTACH_SELF
		end;

	is_right_attached_to_itself: BOOLEAN is
			-- Is the right side of widget attached to itself?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNrightAttachment) = XmATTACH_SELF
		end;

	is_top_attached_to_position: BOOLEAN is
			-- Is the top side of widget attached to a position in form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 	
					(screen_object, XmNtopAttachment) = XmATTACH_POSITION
		end;

	is_bottom_attached_to_position: BOOLEAN is
			-- Is the bottom side of widget attached to a position in form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNbottomAttachment) = XmATTACH_POSITION
		end;

	is_left_attached_to_position: BOOLEAN is
			-- Is the left side of widget attached to a position in form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNleftAttachment) = XmATTACH_POSITION
		end;

	is_right_attached_to_position: BOOLEAN is
			-- Is the right side of widget attached to a position in form?
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_unsigned_char 
					(screen_object, XmNrightAttachment) = XmATTACH_POSITION
		end;

	top_offset: INTEGER is
			-- Distance between widget its top side and the object it is
			-- attached to
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_int (screen_object, XmNtopOffset)
		end;

	bottom_offset: INTEGER is
			-- Distance between widget its bottom side and the object it is
			-- attached to
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_int (screen_object, XmNbottomOffset)
		end;

	left_offset: INTEGER is
			-- Distance between widget its left side and the object it is
			-- attached to
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_int (screen_object, XmNleftOffset)
		end;

	right_offset: INTEGER is
			-- Distance between widget its right side and the object it is
			-- attached to
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_int (screen_object, XmNrightOffset)
		end;

	widget_top_position: INTEGER is
			-- Used in conjunction with `fraction' to calculate the position of
			-- the top of widget
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_int (screen_object, XmNtopPosition)
		ensure
			top_position_large_enough: Result >= 0;
			top_position_small_enough: Result <= form_parent.fraction_base
		end;

	widget_bottom_position: INTEGER is
			-- Used in conjunction with parent's `fraction_base' to calculate the position
			-- of the bottom of a child
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_int (screen_object, XmNbottomPosition)
		ensure
			bottom_position_large_enough: Result >= 0;
			bottom_position_small_enough: Result <= form_parent.fraction_base
		end;

	widget_left_position: INTEGER is
			-- Used in conjunction with `fraction' to calculate the position of
			-- the left side of widget
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_int (screen_object, XmNleftPosition)
		ensure
			left_position_large_enough: Result >= 0;
			left_position_small_enough: Result <= form_parent.fraction_base
		end;

	widget_right_position: INTEGER is
			-- Used in conjunction with `fraction' to calculate the position of
			-- the right side of widget
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			Result := get_xt_int (screen_object, XmNrightPosition)
		ensure
			right_position_large_enough: Result >= 0;
			right_position_small_enough: Result <= form_parent.fraction_base
		end;

feature -- Form child status setting

	enable_resize_requests is
			-- Enable the acceptance of resize requests from widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_boolean (screen_object, XmNresizable, True)
		ensure
			child_allowed_to_resize: child_resizable
		end;

	disable_resize_requests is
			-- Disable the acceptance of resize requests from widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_boolean (screen_object, XmNresizable, False)
		ensure
			child_not_allowed_to_resize: not child_resizable
		end;

	set_top_offset (an_offset: INTEGER) is
			-- Set `an_offset' distance between the top side of widget to the
			-- attached object.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			set_xt_int (screen_object, XmNtopOffset, an_offset)
		ensure
			top_offset_set: top_offset = an_offset
		end;

	set_bottom_offset (an_offset: INTEGER) is
			-- Set `an_offset' distance between the bottom side of widget to the
			-- attached object.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			set_xt_int (screen_object, XmNbottomOffset, an_offset)
		ensure
			bottom_offset_set: bottom_offset = an_offset
		end;

	set_left_offset (an_offset: INTEGER) is
			-- Set `an_offset' distance between the left side of widget to the
			-- attached object.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			set_xt_int (screen_object, XmNleftOffset, an_offset)
		ensure
			left_offset_set: left_offset = an_offset
		end;

	set_right_offset (an_offset: INTEGER) is
			-- Set `an_offset' distance between the right side of widget to the
			-- attached object.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			set_xt_int (screen_object, XmNrightOffset, an_offset)
		ensure
			right_offset_set: right_offset = an_offset
		end;

	set_widget_top_position (a_position: INTEGER) is
			-- Set the position of the top of widget to `a_position'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= form_parent.fraction_base
		do
			set_xt_int (screen_object, XmNtopPosition, a_position)
		ensure
			widget_top_position_is_set: widget_top_position = a_position
		end;

	set_widget_bottom_position (a_position: INTEGER) is
			-- Set the position of the bottom of _widget to `a_position'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= form_parent.fraction_base
		do
			set_xt_int (screen_object, XmNbottomPosition, a_position)
		ensure
			widget_bottom_position_is_set: widget_bottom_position = a_position
		end;

	set_widget_left_position (a_position: INTEGER) is
			-- Set the position of the left of widget to `a_position'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= form_parent.fraction_base
		do
			set_xt_int (screen_object, XmNleftPosition, a_position)
		ensure
			widget_left_position_is_set: widget_left_position = a_position
		end;

	set_widget_right_position (a_position: INTEGER) is
			-- Set the position of the right of widget to `a_position'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= form_parent.fraction_base
		do
			set_xt_int (screen_object, XmNrightPosition, a_position)
		ensure
			widget_right_position_is_set: widget_right_position = a_position
		end;

	attach_top is
			-- Attach the top side of _widget to the top side of the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNtopAttachment, XmATTACH_FORM)
		ensure
			widget_top_is_attached_to_form: is_top_attached 
		end;

	attach_top_to_opposite is
			-- Attach the top side of widget to the bottom side of the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNtopAttachment, XmATTACH_OPPOSITE_FORM)
		ensure
			widget_top_is_attached_to_opposite_form: is_top_attached_to_opposite 
		end;

	attach_top_to_widget (a_target: MEL_RECT_OBJ) is
			-- Attach the top side of widget to to bottom of `a_target'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_target_is_sibbling: a_target /= Void and then
									a_target.parent = parent
		do
			set_xt_unsigned_char (screen_object, XmNtopAttachment, XmATTACH_WIDGET);
			set_xt_widget (screen_object, XmNtopWidget, a_target.screen_object)
		ensure
			widget_top_is_attached_to_widget: is_top_attached_to_widget;
			target_set: top_widget = a_target
		end;

	attach_top_to_opposite_widget (a_target: MEL_RECT_OBJ) is
			-- Attach the top side of widget to the opposite side of `a_target'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_target_is_sibbling: a_target /= Void and then
									a_target.parent = parent
		do
			set_xt_unsigned_char (screen_object, XmNtopAttachment, XmATTACH_OPPOSITE_WIDGET);
			set_xt_widget (screen_object, XmNtopWidget, a_target.screen_object)
		ensure
			widget_top_is_attached_to_opposite_widget: is_top_attached_to_opposite_widget;
			target_set: top_widget = a_target
		end;

	attach_top_to_itself is
			-- Attach the top side of widget to itself.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNtopAttachment, XmATTACH_SELF)
		ensure
			widget_top_is_attached_to_itself: is_top_attached_to_itself
		end;

	attach_top_to_position (a_position: INTEGER) is
			-- Attach the top side of widget to a position in the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= form_parent.fraction_base
		do
			set_xt_unsigned_char (screen_object, XmNtopAttachment, XmATTACH_POSITION);
			set_xt_int (screen_object, XmNtopPosition, a_position)
		ensure
			widget_top_is_attached_to_position: is_top_attached_to_position;
			widget_top_position_is_set: widget_top_position = a_position
		end;

	attach_bottom is
			-- Attach the bottom side of widget to the bottom side of the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNbottomAttachment, XmATTACH_FORM)
		ensure
			widget_bottom_is_attached_to_form: is_bottom_attached 
		end;

	attach_bottom_to_opposite is
			-- Attach the bottom side of widget to the top side of the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNbottomAttachment, XmATTACH_OPPOSITE_FORM)
		ensure
			widget_bottom_is_attached_to_opposite_form: is_bottom_attached_to_opposite 
		end;

	attach_bottom_to_widget (a_target: MEL_RECT_OBJ) is
			-- Attach the bottom side of widget; to the top side `a_target'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_target_is_sibbling: a_target /= Void and then
									a_target.parent = parent
		do
			set_xt_unsigned_char (screen_object, XmNbottomAttachment, XmATTACH_WIDGET);
			set_xt_widget (screen_object, XmNbottomWidget, a_target.screen_object)
		ensure
			widget_bottom_is_attached_to_widget: is_bottom_attached_to_widget;
			target_set: bottom_widget =  a_target
		end;

	attach_bottom_to_opposite_widget (a_target: MEL_RECT_OBJ) is
			-- Attach the bottom side of `a_target' to the bottom side of widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_target_is_sibbling: a_target /= Void and then
									a_target.parent = parent
		do
			set_xt_unsigned_char (screen_object, XmNbottomAttachment, XmATTACH_OPPOSITE_WIDGET);
			set_xt_widget (screen_object, XmNbottomWidget, a_target.screen_object)
		ensure
			widget_bottom_is_attached_to_opposite_widget: is_bottom_attached_to_opposite_widget;
			target_set: bottom_widget = a_target
		end;

	attach_bottom_to_itself is
			-- Attach the bottom side of widget to itself.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNbottomAttachment, XmATTACH_SELF)
		ensure
			widget_bottom_is_attached_to_itself: is_bottom_attached_to_itself 
		end;

	attach_bottom_to_position (a_position: INTEGER) is
			-- Attach the bottom side of widget to `a_position' in the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= form_parent.fraction_base
		do
			set_xt_unsigned_char (screen_object, XmNbottomAttachment, XmATTACH_POSITION);
			set_xt_int (screen_object, XmNbottomPosition, a_position)
		ensure
			widget_bottom_is_attached_to_position: is_bottom_attached_to_position;
			widget_bottom_position_is_set: widget_bottom_position = a_position
		end;

	attach_left is
			-- Attach the left side of widget to the left side of the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNleftAttachment, XmATTACH_FORM)
		ensure
			widget_left_is_attached_to_form: is_left_attached 
		end;

	attach_left_to_opposite is
			-- Attach the left side of widget to the left side of the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNleftAttachment, XmATTACH_OPPOSITE_FORM)
		ensure
			widget_left_is_attached_to_opposite_form: is_left_attached_to_opposite 
		end;

	attach_left_to_widget (a_target: MEL_RECT_OBJ) is
			-- Attach the left side of widget to the right side of `a_target'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_target_is_sibbling: a_target /= Void and then
									a_target.parent = parent
		do
			set_xt_unsigned_char (screen_object, XmNleftAttachment, XmATTACH_WIDGET);
			set_xt_widget (screen_object, XmNleftWidget, a_target.screen_object)
		ensure
			widget_left_is_attached_to_widget: is_left_attached_to_widget;
			target_set: left_widget = a_target
		end;

	attach_left_to_opposite_widget (a_target: MEL_RECT_OBJ) is
			-- Attach the left side of `a_target' to the left side of widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			target_is_sibbling: a_target /= Void and then
									a_target.parent = parent
		do
			set_xt_unsigned_char (screen_object, XmNleftAttachment, XmATTACH_OPPOSITE_WIDGET);
			set_xt_widget (screen_object, XmNleftWidget, a_target.screen_object)
		ensure
			widget_left_is_attached_to_opposite_widget: is_left_attached_to_opposite_widget;
			target_set: left_widget = a_target
		end;

	attach_left_to_itself is
			-- Attach the left side of widget to itself.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNleftAttachment, XmATTACH_SELF)
		ensure
			widget_left_is_attached_to_itself: is_left_attached_to_itself
		end;

	attach_left_to_position (a_position: INTEGER) is
			-- Attach the left side of widget to `a_position' in the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= form_parent.fraction_base
		do
			set_xt_unsigned_char (screen_object, XmNleftAttachment, XmATTACH_POSITION);
			set_xt_int (screen_object, XmNleftPosition, a_position)
		ensure
			widget_left_is_attached_to_position: is_left_attached_to_position;
			widget_left_position_is_set: widget_left_position = a_position
		end;

	attach_right is
			-- Attach the right side of widget to the right side of the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNrightAttachment, XmATTACH_FORM)
		ensure
			widget_right_is_attached_to_form: is_right_attached 
		end;

	attach_right_to_opposite is
			-- Attach the right side of widget to the right side of the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNrightAttachment, XmATTACH_OPPOSITE_FORM)
		ensure
			widget_right_is_attached_to_opposite_form: is_right_attached_to_opposite 
		end;

	attach_right_to_widget (a_target: MEL_RECT_OBJ) is
			-- Attach the right side of widget to the left side of `a_target'.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			target_is_sibbling: a_target /= Void and then
									a_target.parent = parent
		do
			set_xt_unsigned_char (screen_object, XmNrightAttachment, XmATTACH_WIDGET);
			set_xt_widget (screen_object, XmNrightWidget, a_target.screen_object)
		ensure
			widget_right_is_attached_to_widget: is_right_attached_to_widget;
			target_set: right_widget =  a_target
		end;

	attach_right_to_opposite_widget (a_target: MEL_RECT_OBJ) is
			-- Attach the right side of `a_target' to the right side of widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNrightAttachment, XmATTACH_OPPOSITE_WIDGET);
			set_xt_widget (screen_object, XmNrightWidget, a_target.screen_object)
		ensure
			widget_right_is_attached_to_opposite_widget: is_right_attached_to_opposite_widget;
			target_set: right_widget = a_target
		end;

	attach_right_to_itself is
			-- Attach the right side of widget to itself.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNrightAttachment, XmATTACH_SELF)
		ensure
			widget_right_is_attached_to_itself: is_right_attached_to_itself 
		end;

	attach_right_to_position (a_position: INTEGER) is
			-- Attach the right side of idget to `a_position' in the form.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
			a_position_large_enough: a_position >= 0;
			a_position_small_enough: a_position <= form_parent.fraction_base
		do
			set_xt_unsigned_char (screen_object, XmNrightAttachment, XmATTACH_POSITION);
			set_xt_int (screen_object, XmNrightPosition, a_position)
		ensure
			widget_right_is_attached_to_position: is_right_attached_to_position;
			widget_right_position_is_set: widget_right_position = a_position
		end;

	detach_right is
			-- Detach the right side of widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form
		do
			set_xt_unsigned_char (screen_object, XmNrightAttachment, XmATTACH_NONE)
		ensure
			right_is_detached: is_right_not_attached 
		end;

	detach_top is
			-- Detach the top side of widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNtopAttachment, XmATTACH_NONE)
		ensure
			top_is_detached: is_top_not_attached 
		end;

	detach_bottom is
			-- Detach the bottom side of widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNbottomAttachment, XmATTACH_NONE)
		ensure
			bottom_is_detached: is_bottom_not_attached 
		end;

	detach_left is
			-- Detach the left side of widget.
		require
			exists: not is_destroyed;
			has_form_parent: parent.is_form;
		do
			set_xt_unsigned_char (screen_object, XmNleftAttachment, XmATTACH_NONE)
		ensure
			left_is_detached: is_left_not_attached 
		end;

end -- class MEL_FORM_CHILD


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


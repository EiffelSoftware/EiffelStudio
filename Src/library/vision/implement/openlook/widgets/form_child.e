indexing

	description: "Widget with its attachments in a form";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FORM_CHILD

inherit

	DIRECTION_DEF
		export
			{NONE} all
		end

creation

	make
	
feature 

	widget: WIDGET_I;
			-- Widget which is a child of a form

	left: ATTACHMENT;
			-- Left attachment of `widget'

	right: ATTACHMENT;
			-- Right attachment of `widget'

	top: ATTACHMENT;
			-- Top attachment of `widget'

	bottom: ATTACHMENT;
			-- Bottom attachment of `widget'

	
feature {NONE}

	wait: ATTACH_WAIT is
			-- Attachment which is not fixed
		once
			!!Result
		end;

	ok: ATTACH_OK is
			-- Attachment which is fixed
		once
			!!Result
		end;
	
feature 

	make (a_widget: WIDGET_I) is
			-- Create a form_child for `a_widget'
		do
			widget := a_widget
		end;

	attach_form (offset: INTEGER; a_side: INTEGER) is
			-- Attach `a_side' of `widget' to the form with `offset'
		require
			offset_non_negative: offset >= 0
		LOcal
			attachment: ATTACH_FORM
		do
			!!attachment.make (offset);
			attach (attachment, a_side)
		end;

	attach_position (position: INTEGER; a_side: INTEGER) is
			-- Attach `a_side' of `widget' to the form at `position'
		require
			position_non_negative: position >= 0
		local
			attachment: ATTACH_POSIT
		do
			!!attachment.make (position);			
			attach (attachment, a_side)
		end;

	attach_widget (a_widget: WIDGET_I; offset: INTEGER; a_side: INTEGER) is
			-- Attach `a_side' of `widget' to `a_widget' with `offset'
		require
			not_widget_void: not (a_widget = Void) ; 
			offset_non_negative: offset >= 0
		local
			attachment: ATTACH_WIDGET
		do
			!!attachment.make (a_widget, offset);			
			attach (attachment, a_side)
		end;

	detach (a_side: INTEGER) is
			-- Detach `a_side' of `widget'
		require
		
		do
			inspect a_side
				when bottom_side then
					bottom := Void;
					c_detach_bottom (widget.screen_object)
				when top_side then
					top := Void;
					c_detach_top (widget.screen_object)
				when right_side then
					right := Void;
					c_detach_right (widget.screen_object)
				when left_side then
					left := Void;
					c_detach_left (widget.screen_object)
			end;
		end;

feature {NONE}

	attach (an_attachment: ATTACHMENT; a_side: INTEGER) is
			-- Store `an_attachment' for `a_side' of `widget'
		require
			not_attachment_void: not (an_attachment = Void) 
		
		do
			inspect a_side
				when bottom_side then
					bottom := an_attachment;
					if (top = Void) then 
						set_y_fix (widget.screen_object)
					else
						set_y_resizable (widget.screen_object)
					end
				when top_side then
					top := an_attachment;
					if (bottom = Void) then 
						set_y_fix (widget.screen_object)
					else
						set_y_resizable (widget.screen_object)
					end
				when right_side then
					right := an_attachment;
					if (left = Void) then 
						set_x_fix (widget.screen_object)
					else
						set_x_resizable (widget.screen_object)
					end
				when left_side then
					left := an_attachment;
					if (right = Void) then 
						set_x_fix (widget.screen_object)
					else
						set_x_resizable (widget.screen_object)
					end
			end;
		end;

feature 

	update_form_position (width, height, fraction_base: INTEGER): BOOLEAN is
			-- Update the form and the position attachments of `widget'.
			-- True if `widget' has no widget attachment
		local
			wid_attach: ATTACH_WIDGET
		do
			Result := true;
			if not (left = Void) then
				wid_attach ?= left;
				if (wid_attach = Void) then
					left.perform_attach (widget, 
								width, 
								fraction_base,
								left_side)
				else
					Result := false
				end
			end;
			if not (right = Void) then
				wid_attach ?= right;
				if (wid_attach = Void) then
					right.perform_attach (widget, 
								width,
								fraction_base, 
								right_side)
				elseif Result then
					Result := false
				end
			end;
			if not (top = Void) then
				wid_attach ?= top;
				if (wid_attach = Void) then
					top.perform_attach (widget, 
								height,
								fraction_base, 
								top_side)
				elseif Result then
					Result := false
				end
			end;
			if not (bottom = Void) then
				wid_attach ?= bottom;
				if (wid_attach = Void) then
					bottom.perform_attach (widget, 
								height,
								fraction_base, 
								bottom_side)
				elseif Result then
					Result := false
				end
			end
		end; 

	widgets_only: FORM_CHILD is
			-- Copy of `widget' with only the widget attachments.
			-- Each form or position attachment is replaced by
			-- an ok attachment.
			-- Each void attachment is replaced by
			-- an ok or wait attachment.
		local
			attachments: FORM_CHILD;
		do
			!!attachments.make (widget);

			if (left = Void) then 
				if (right = Void) or else right.is_form_or_posit then 
					attachments.set_ok (left_side)
				else 
					attachments.set_wait (left_side)
				end
			elseif left.is_form_or_posit then
				attachments.set_ok (left_side)
			else
				attachments.set_widget_attach (left_side, left)
			end;

			if (right = Void) then 
				if (left = Void) or else left.is_form_or_posit then 
					attachments.set_ok (right_side)
				else 
					attachments.set_wait (right_side)
				end
			elseif right.is_form_or_posit then
				attachments.set_ok (right_side)
			else
				attachments.set_widget_attach (right_side, right)
			end;

			if (top = Void) then 
				if (bottom = Void) or else bottom.is_form_or_posit then 
					attachments.set_ok (top_side)
				else 
					attachments.set_wait (top_side)
				end
			elseif top.is_form_or_posit then
				attachments.set_ok (top_side)
			else
				attachments.set_widget_attach (top_side, top)
			end;

			if (bottom = Void) then 
				if (top = Void) or else top.is_form_or_posit then 
					attachments.set_ok (bottom_side)
				else 
					attachments.set_wait (bottom_side)
				end
			elseif bottom.is_form_or_posit then
				attachments.set_ok (bottom_side)
			else
				attachments.set_widget_attach (bottom_side, bottom)
			end;

			Result := attachments
		end;

	is_ok (a_side: INTEGER): BOOLEAN is
			-- Is `a_side' of `widget' an ok attachment ?
		do
			inspect a_side
				when bottom_side then
					Result := bottom = ok
				when top_side then
					Result := top = ok
				when right_side then
					Result := right = ok
				when left_side then
					Result := left = ok
			end;
		end;

	is_wait (a_side: INTEGER): BOOLEAN is
			-- Is `a_side' of `widget' a wait attachment ?
		do
			inspect a_side
				when bottom_side then
					Result := bottom = wait
				when top_side then
					Result := top = wait
				when right_side then
					Result := right = wait
				when left_side then
					Result := left = wait
			end;
		end;

	is_widget (a_side: INTEGER): BOOLEAN is
			-- Is `a_side' of `widget' a widget attachment ?
		local
			the_attach: ATTACH_WIDGET
		do
			inspect a_side
				when bottom_side then
					the_attach ?= bottom
				when top_side then
					the_attach ?= top
				when right_side then
					the_attach ?= right
				when left_side then
					the_attach ?= left
			end;
			Result := not (the_attach = Void)
		end;

	set_ok (a_side: INTEGER) is
			-- Set `a_side' of `widget' to an ok attachment.
		do
			inspect a_side
				when bottom_side then
					bottom := ok
				when top_side then
					top := ok
				when right_side then
					right := ok
				when left_side then
					left := ok
			end;
		end;

	set_wait (a_side: INTEGER) is
			-- Set `a_side' of `widget' to a wait attachment.
		do
			inspect a_side
				when bottom_side then
					bottom := wait
				when top_side then
					top := wait
				when right_side then
					right := wait
				when left_side then
					left := wait
			end;
		end;

	set_widget_attach (a_side: INTEGER; a_widget_attach: ATTACHMENT) is
			-- Set `a_side' of `widget' to `a_widget_attach'. 
		do
			inspect a_side
				when bottom_side then
					bottom := a_widget_attach
				when top_side then
					top := a_widget_attach
				when right_side then
					right := a_widget_attach
				when left_side then
					left := a_widget_attach
			end;
		end;

feature {NONE} -- External features

	set_y_fix (scr_obj: POINTER) is
		external
			"C"
		end;

	set_x_fix (scr_obj: POINTER) is
		external
			"C"
		end;

	set_y_resizable (scr_obj: POINTER) is
		external
			"C"
		end;

	set_x_resizable (scr_obj: POINTER) is
		external
			"C"
		end;

	c_detach_bottom (scr_obj: POINTER) is
		external
			"C"
		end; 

	c_detach_left (scr_obj: POINTER) is
		external
			"C"
		end; 

	c_detach_right (scr_obj: POINTER) is
		external
			"C"
		end; 

	c_detach_top (scr_obj: POINTER) is
		external
			"C"
		end; 

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

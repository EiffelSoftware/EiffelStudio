
-- FORM_O: implementation of form.

indexing

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class FORM_O 

inherit
	
	FORM_I
		export
			{NONE} all
		end;

	BASIC_ROUTINES
		export
			{NONE} all
		end;

	BULLETIN_O
		rename
			hide as bulletin_hide,
			show as bulletin_show,
			set_managed as bulletin_set_managed
		undefine
			make
		end;

	BULLETIN_O
		undefine
			make
		redefine
			hide, show, set_managed
		select
			hide, show, set_managed
		end;

	COMMAND
		export
			{NONE} all
		end;

	DIRECTION_DEF
		export
			{NONE} all
		end;

creation

	make

feature 

	make (a_form: FORM) is
			-- Create an openlook form.
		
		local
			ext_name: ANY;
		do
			ext_name := a_form.identifier.to_c;
			screen_object := create_form ($ext_name,
							a_form.parent.implementation.screen_object);
			initialize (a_form)
		end;

	attach_bottom (a_child: WIDGET_I; bottom_offset: INTEGER) is
			-- Attach bottom side of `a_child' to the bottom side of current form
			-- with `bottom_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void) ; 
			offset_non_negative: bottom_offset >= 0
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_form (bottom_offset, bottom_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_bottom_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach bottom side of `a_child' to a position that is
			-- relative to bottom side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_position (a_position, bottom_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_bottom_widget (a_widget: WIDGET_I; a_child: WIDGET_I; bottom_offset: INTEGER)  is
			-- Attach bottom side of `a_child' to the top side of
			-- `a_widget' with `bottom_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void) ; 
			not_widget_void: not (a_widget = Void) ; 
			offset_non_negative: bottom_offset >= 0
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_widget (a_widget, bottom_offset, bottom_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_left (a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the left side of current form
			-- with `left_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void) ; 
			offset_non_negative: left_offset >= 0
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_form (left_offset, left_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_left_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach left side of `a_child' to a position that is
			-- relative to left side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_position (a_position, left_side);
			if realized then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_left_widget (a_widget: WIDGET_I; a_child: WIDGET_I; left_offset: INTEGER) is
			-- Attach left side of `a_child' to the right side of
			-- `a_widget' with `left_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void) ; 
			not_widget_void: not (a_widget = Void) ; 
			offset_non_negative: left_offset >= 0
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_widget (a_widget, left_offset, left_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_right (a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of current form
			-- with `right_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void) ; 
			offset_non_negative: right_offset >= 0
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_form (right_offset, right_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_right_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach right side of `a_child' to a position that is
			-- relative to right side of current form and is a fraction
			-- of the width of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_position (a_position, right_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_right_widget (a_widget: WIDGET_I; a_child: WIDGET_I; right_offset: INTEGER) is
			-- Attach right side of `a_child' to the left side of
			-- `a_widget' with `right_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void) ; 
			not_widget_void: not (a_widget = Void) ; 
			offset_non_negative: right_offset >= 0
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_widget (a_widget, right_offset, right_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_top (a_child: WIDGET_I; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of current form
			-- with `top_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void) ; 
			offset_non_negative: top_offset >= 0
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_form (top_offset, top_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_top_position (a_child: WIDGET_I; a_position: INTEGER) is
			-- Attach top side of `a_child' to a position that is
			-- relative to top side of current form and is a fraction
			-- of the height of current form. This fraction is the value
			-- of `a_position' divided by the value of `fraction_base'.
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_position (a_position, top_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	attach_top_widget (a_widget: WIDGET_I; a_child: WIDGET_I; top_offset: INTEGER) is
			-- Attach top side of `a_child' to the bottom side of
			-- `a_widget' with `top_offset' spaces between each other.
		require else
			not_child_void: not (a_child = Void) ; 
			not_widget_void: not (a_widget = Void) ; 
			offset_non_negative: top_offset >= 0
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.find (a_child);
			child_attachments.attach_widget (a_widget, top_offset, top_side);
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

feature {NONE}

	form_child_list: FORM_CHILD_L;
	
feature 

	detach_right (a_child: WIDGET_I) is
			-- Detach right side of `a_child'.
		require else
			not_child_void: not (a_child = Void) 
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.search (a_child);
			if not (child_attachments = Void) then
				child_attachments.detach (right_side);
			end;
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	detach_left (a_child: WIDGET_I) is
			-- Detach left side of `a_child'.
		require else
			not_child_void: not (a_child = Void) 
		local
			child_attachments: FORM_CHILD;
		do
			child_attachments := form_child_list.search (a_child);
			if not (child_attachments = Void) then
				child_attachments.detach (left_side);
			end;
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	detach_bottom (a_child: WIDGET_I) is
			-- Detach bottom side of `a_child'.
		require else
			not_child_void: not (a_child = Void) 
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.search (a_child);
			if not (child_attachments = Void) then
				child_attachments.detach (bottom_side);
			end;
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

	detach_top (a_child: WIDGET_I) is
			-- Detach top side of `a_child'.
		require else
			not_child_void: not (a_child = Void) 
		local
			child_attachments: FORM_CHILD
		do
			child_attachments := form_child_list.search (a_child);
			if not (child_attachments = Void) then
				child_attachments.detach (top_side);
			end;
			if realized and then shown then 
				update_attach_modif
			else
				update_all
			end
		end;

feature {NONE}

	width_aux: INTEGER;

	height_aux: INTEGER;	

	execute (action: ANY) is
			-- Recompute the attachments of the childs
			-- when a resize event occurs.
		do
			if width /= width_aux or height /= height_aux then
				bulletin_set_managed (false);
				update_all;
				bulletin_set_managed (true);
				if not is_shown and realized then 
					bulletin_hide;
				end;
			end;
		end;

	fraction_base: INTEGER;
			-- Value used to compute child position with
			-- position attachment

      	resize_actions: SIZE_HAND_X;
                      	-- actions to execute when the form is resized

 	initialize (a_form: FORM) is
			-- Initialize the current form
              	local
                      	arg: ANY
 		do
			fraction_base := 1;
			!!form_child_list.make;
            !!arg;
            !!resize_actions.make (screen_object, a_form);
            resize_actions.add (Current, arg);
			is_shown := true;
 		end;
	
feature {NONE}

	attach_widget (attachments: FORM_CHILD; side: INTEGER) is
			-- Perform the Openlook `side' attachment 
			-- of `attachments'.
		 
		local
			wid_attach: ATTACH_WIDGET;
		do
			save_size;
			inspect side 
				when bottom_side then
					wid_attach ?= attachments.bottom;
					attach_widget_bottom (wid_attach.extremity.screen_object, 
				       			attachments.widget.screen_object,
							wid_attach.offset,
							height_aux);
				when top_side then
					wid_attach ?= attachments.top;
					attach_widget_top (wid_attach.extremity.screen_object, 
				       			attachments.widget.screen_object,
							wid_attach.offset);
				when right_side then
					wid_attach ?= attachments.right;
					attach_widget_right (wid_attach.extremity.screen_object, 
				       			attachments.widget.screen_object,
							wid_attach.offset,
							width_aux);
				when left_side then
					wid_attach ?= attachments.left;
					attach_widget_left (wid_attach.extremity.screen_object, 
				       			attachments.widget.screen_object,
							wid_attach.offset);
			end;
			update_child_if_form (attachments.widget);
			restore_size;
		end;

feature 

	set_fraction_base (a_value: INTEGER) is
			-- Set fraction_base to `a_value'.
			-- Unsecure to set it after any position attachment,
			-- contradictory constraints could occur.
		do
			fraction_base := a_value
		end;

	set_managed (flag: BOOLEAN) is
			-- Enable geometry managment on screen widget implementation,
			-- by window manager of parent widget if `flag', disable it
			-- otherwise.
		local
			attach_widget_list:  FORM_CHILD_L;
		do
			if flag then
				update_all;
			end;
			bulletin_set_managed (flag);
		end;

	is_shown: BOOLEAN;

	show is
		do
			bulletin_show;
			is_shown := true;
		end;

	hide is
		do
			bulletin_hide;
			is_shown := false;
		end;

	update_attach_modif is
			-- Update all the attachments when an attachment
			-- is added or deleted.
		local
			attach_widget_list:  FORM_CHILD_L;
			visible: BOOLEAN;
		do
			bulletin_set_managed (false);
			update_all;
			bulletin_set_managed (true);
			if not is_shown and realized then 
				bulletin_hide;
			end;
		end;

	update_all is
			-- Update all the attachments.
		local
			attach_widget_list:  FORM_CHILD_L;
			visible: BOOLEAN;
		do
			attach_widget_list := update_form_position;
			if not (attach_widget_list = Void) then
				update_attach_widget (attach_widget_list)
			end;
		end;

	update_attach_widget (list: FORM_CHILD_L) is
			-- Update all the widget attachments of `list'.
		local
			ok: BOOLEAN;
			attachments: FORM_CHILD;
			left_attachment: ATTACH_WIDGET;
			right_attachment: ATTACH_WIDGET;
			top_attachment: ATTACH_WIDGET;
			bottom_attachment: ATTACH_WIDGET;
			extremity: WIDGET_I;
			nb_loop: INTEGER;
		do
			from
				ok := false;
			until
				ok or nb_loop > 500
			loop
				nb_loop := nb_loop+1;
				ok := true;
				from
					list.start
				variant
					list.count - list.index + 1
				until
					list.after
				loop
					attachments := list.item;
					if attachments.is_widget (left_side) then
						left_attachment ?= attachments.left;
						extremity := left_attachment.extremity;
						if list.is_side_ok (extremity, right_side) 
						   and then list.is_side_ok (extremity, left_side) then
							attach_widget (attachments, left_side);
							attachments.set_ok (left_side);
							if attachments.is_wait (right_side) then 
								attachments.set_ok (right_side)
							end
						else
							ok := false
						end;
					end;	
					if attachments.is_widget (right_side) then
						right_attachment ?= attachments.right;
						extremity := right_attachment.extremity;
						if list.is_side_ok (extremity, left_side) then
							attach_widget (attachments, right_side);
							attachments.set_ok (right_side);
							if attachments.is_wait (left_side) then 
								attachments.set_ok (left_side)
							end
						else
							ok := false
						end;
					end;	
					if attachments.is_widget (top_side) then
						top_attachment ?= attachments.top;
						extremity := top_attachment.extremity;
						if list.is_side_ok (extremity, bottom_side) 
						   and then list.is_side_ok (extremity, top_side) then
							attach_widget (attachments, top_side);
							attachments.set_ok (top_side);
							if attachments.is_wait (bottom_side) then 
								attachments.set_ok (bottom_side)
							end
						else
							ok := false
						end;
					end;	
					if attachments.is_widget (bottom_side) then
						bottom_attachment ?= attachments.bottom;
						extremity := bottom_attachment.extremity;
						if list.is_side_ok (extremity, top_side) then
							attach_widget (attachments, bottom_side);
							attachments.set_ok (bottom_side);
							if attachments.is_wait (top_side) then 
								attachments.set_ok (top_side)
							end
						else
							ok := false
						end;
					end;

					list.forth
				end
			end;
			if nb_loop >= 500 then 
				io.putstring ("circular dependency : cannot perform all the form attachments%N");
			end;
		end;

	update_form_position:  FORM_CHILD_L is
			-- Update all the form and position attachments.
			-- Return a list with only the widget attachments
		local
			attach_widget_list:  FORM_CHILD_L;
			child_attachments: FORM_CHILD;
		do
			save_size;
			width_aux := width;
			height_aux := height;
			from
				form_child_list.start
			variant
				form_child_list.count - form_child_list.index + 1
			until
				form_child_list.after
			loop
				child_attachments := form_child_list.item;
				if not child_attachments.update_form_position (width_aux, 
										height_aux,
										fraction_base) then
					if (attach_widget_list = Void) then
						!!attach_widget_list.make
					end;
					attach_widget_list.add_right (child_attachments.widgets_only);
				end;
				update_child_if_form (child_attachments.widget);
				form_child_list.forth
			end;
			restore_size;
			Result := attach_widget_list
		end;

	update_child_if_form (a_child: WIDGET_I) is
		local
			child_form: FORM_O
		do
			child_form ?= a_child;
			if not (child_form = void) then
				child_form.update_attach_modif;
			end;
		end;

	restore_size is
		do
			if width /= width_aux or else height /= height_aux then
				set_size (width_aux, height_aux);
			end;
		end;

	save_size is
		do
			width_aux := width;
			height_aux := height;
		end;


feature {NONE} -- External features

	attach_widget_top (ext, wid: POINTER; offs: INTEGER) is
		external
			"C"
		end;

	attach_widget_right (ext, wid: POINTER; offs, wdth: INTEGER) is
		external
			"C"
		end;

	attach_widget_left (ext, wid: POINTER; offs: INTEGER) is
		external
			"C"
		end;

	attach_widget_bottom (ext, wid: POINTER; offs, hght: INTEGER) is
		external
			"C"
		end;

	create_form (name: ANY; parent: POINTER): POINTER is
		external
			"C"
		end; 

end 


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

indexing

	description:
			"Fundamental widget that can have children.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	MEL_COMPOSITE

inherit

	MEL_COMPOSITE_RESOURCES
		export
			{NONE} all
		end;

	MEL_WIDGET
		rename
			object_clean_up as old_object_clean_up,
			destroy as obj_destroy
		export
			{NONE} old_object_clean_up, obj_destroy
		redefine	
			clean_up
		end

	MEL_WIDGET
		redefine	
			clean_up, object_clean_up, destroy
		select
			object_clean_up, destroy
		end

creation

	make_from_existing

creation {MEL_COMPOSITE}

	make_for_descendants

feature -- Access

	mel_popup_children: ARRAYED_LIST [MEL_SHELL];
			-- List of popup children
			--| `xt_destroy' automatically destroys all children including popups.
			--| A list was need since `children' doesn't record popup children
			--| and MEL needs all the children for proper cleanup in the 
			--| widget manager and callback structures.

	is_form: BOOLEAN is
			-- Is Current a form?
		do
		end;

	is_frame: BOOLEAN is
			-- Is Current a fame?
		do
		end;

	is_paned_window: BOOLEAN is
			-- Is Current a paned window?
		do
		end;

	children: FIXED_LIST [POINTER] is
			-- List of the children widgets `screen_object'
			-- (Does not include popup children)
		require
			exists: not is_destroyed
		local
			c_list: POINTER;
			c_count: INTEGER;
			i: INTEGER
		do
			c_list := c_get_children (screen_object, XmNchildren);
			c_count := children_count;
			!! Result.make_filled (c_count);
			from
				i := 1
			until
				i > c_count
			loop
				Result.put_i_th (c_get_i_th_widget_child (c_list.item, i), i)
				i := i + 1
			end;
		ensure
			valid_result: Result /= Void and then Result.count = children.count
		end;

	mel_children: ARRAYED_LIST [MEL_OBJECT] is
			-- List of children widgets recorded in MEL
			-- (This list may vary from `children' since a widget
			-- may have been created in C without being recorded in MEL.)
			-- (Does not include popup children)
		require
			exists: not is_destroyed
		local
			a_screen_object: POINTER;
			c_list: FIXED_LIST [POINTER]
			an_object: MEL_OBJECT;
			temp: INTEGER
		do
			c_list := children;
			temp := c_list.count;
			!! Result.make (temp);
			if temp > 0 then
				from
					c_list.start
				until
					c_list.after
				loop
					a_screen_object := c_list.item;
					an_object := Mel_widgets.item (a_screen_object);
					if an_object /= Void then
						Result.extend (an_object)
					end
					c_list.forth
				end
			end;
		ensure
			children_list_not_void: Result /= Void
		end;

	descendants: ARRAYED_LIST [POINTER] is
			-- List of all descendants of current composite
			-- (Does not include popup children)
		do
			!! Result.make (20);
			descendants_of (Current, Result)
		end;

	mel_descendants: ARRAYED_LIST [MEL_OBJECT] is
			-- List of descendants of current composite recorded in MEL
			-- (This list may vary from `children' since a widget
			-- may have been created in C without being recorded in MEL.
			-- Does not include popup children)
		require
			exists: not is_destroyed
		local
			a_screen_object: POINTER;
			mel_object: MEL_OBJECT;
			temp: INTEGER;
			c_list: ARRAYED_LIST [POINTER]
		do
			c_list := descendants;
			temp := c_list.count;
			!! Result.make (temp);
			if temp > 0 then
				from
					c_list.start
				until
					c_list.after
				loop
					a_screen_object := c_list.item;
					mel_object := Mel_widgets.item (a_screen_object);
					if mel_object /= Void then
						Result.extend (mel_object)
					end
					c_list.forth
				end
			end
		ensure
			descendants_list_not_void: Result /= Void
		end;

feature -- Measurement

	mel_children_count: INTEGER is
			-- Count of the composite's MEL children
			-- (This count may vary from `children_count' since a widget
			-- may have been created in C without being recorded in MEL.)
		require
			exists: not is_destroyed
		do
			Result := children.count
		ensure
			mel_children_count_large_enough: Result >= 0
		end;

	children_count: INTEGER is
			-- Count of the widget's children
		require
			exists: not is_destroyed
		do
			Result := get_xt_cardinal (screen_object, XmNnumChildren)
		ensure
			children_count_large_enough: Result >= 0
		end;

feature -- Removal

    destroy is
            -- Destroy the associated screen object and all its
			-- children including popups.
		local
			ds: MEL_DIALOG_SHELL
		do
			if created_dialog_automatically then
				ds ?= parent;
				ds.remove_from_popup_list
			end;
			obj_destroy;
		end

feature {NONE} -- Implementation

	created_dialog_automatically: BOOLEAN is
			-- Was the dialog shell created automatically?
		do
		end;

	make_for_descendants (a_screen_object: POINTER) is
			-- Make a composite for calculating descendants
		require
			not_null: a_screen_object /= default_pointer;
			is_composite: xt_is_composite (a_screen_object)
		do
			screen_object := a_screen_object
		end;

	all_children_destroyed (list: ARRAYED_LIST [POINTER]): BOOLEAN is
			-- Are all the children destroyed?
		local
			mel_object: MEL_OBJECT
		do
			from
				Result := screen_object = default_pointer;
				list.start
			until
				list.after or else not Result
			loop
				mel_object := Mel_widgets.item (list.item);
				Result := mel_object = Void;
				list.forth
			end
		end

	descendants_of (a_comp: MEL_COMPOSITE; list: ARRAYED_LIST [POINTER]) is
			-- List of all descendants of current composite
		require
			valid_comp: a_comp /= Void;
			valid_list: list /= Void
		local
			c_list: like children;
			w: POINTER;
			mel_comp: MEL_COMPOSITE
		do
			c_list := a_comp.children;
			from
				c_list.start
			until
				c_list.after
			loop
				w := c_list.item;
				list.extend (w);
				if xt_is_composite (w) then
					!! mel_comp.make_for_descendants (w)
					descendants_of (mel_comp, list)
				end
				c_list.forth
			end;
		end;

feature {MEL_OBJECT}

	frozen clean_up is
			-- Clean up the is_destroyed widget's data structure
			-- and its children.
		local
			children_list: ARRAYED_LIST [MEL_OBJECT];
			a_child: MEL_OBJECT;
			old_descendants: ARRAYED_LIST [POINTER]
		do
			debug ("MEL")
				old_descendants := descendants
			end;
			children_list := mel_descendants;
			from
				children_list.start
			until
				children_list.after
			loop
				a_child := children_list.item;
				a_child.object_clean_up;
				check
					child_cleaned: a_child.is_destroyed 
				end
				children_list.forth
			end
			if created_dialog_automatically then
				check
					parent_exists: parent /= Void
				end
				parent.object_clean_up
				check
					parent_cleaned: parent.is_destroyed 
				end
			end;
			if not is_destroyed then
					-- This check is needed in cases for recursive clean_up of children
					-- in the one of the children is a MEL_SCROLLED_TEXT or
					-- MEL_SCROLLED_LIST.
				object_clean_up;
			end
			debug ("MEL")
				if all_children_destroyed (old_descendants) then
					io.error.putstring ("Object cleanned up properly")
				else
					io.error.putstring ("**** Object NOT cleanned up properly")
				end
				io.error.new_line
			end;
		end;

	object_clean_up is
			-- Clean up object widget data structures.
		do	
			old_object_clean_up;
			if mel_popup_children /= Void then	
				from
					mel_popup_children.start
				until
					mel_popup_children.after
				loop
					mel_popup_children.item.clean_up;
					mel_popup_children.forth
				end
				mel_popup_children := Void
			end;
		end

feature {MEL_WIDGET_MANAGER, MEL_SHELL}

	add_popup_child (a_popup: MEL_SHELL) is
			-- Add `a_popup' shell to `mel_popup_children'
		require
			not_has_popup: mel_popup_children = Void or else 
					not mel_popup_children.has (a_popup)
		do
			if mel_popup_children = Void then
				!! mel_popup_children.make (1);
			end;
			mel_popup_children.extend (a_popup)
		ensure
			has_popup: mel_popup_children.has (a_popup)
		end;

	remove_popup_child (a_popup: MEL_SHELL) is
			-- Remove `a_popup' shell from `mel_popup_children'
		require
			has_popup: mel_popup_children /= Void and then
					mel_popup_children.has (a_popup)
		do
			mel_popup_children.start;
			mel_popup_children.prune (a_popup);
			if mel_popup_children.is_empty then
				mel_popup_children := Void
			end;
		ensure
			not_has_popup: mel_popup_children = Void or else 
					not mel_popup_children.has (a_popup)
		end;

feature {NONE} -- External features

	c_get_i_th_widget_child (a_scr_obj: POINTER; index: INTEGER): POINTER is
		external
			"C"
		end;

	c_get_children (a_scr_obj: POINTER; resource: POINTER): POINTER is
		external
			"C"
		end;

	x_circulate_up (display_ptr: POINTER; a_window: POINTER) is
		external
			"C (Display *, Window) | <X11/Xlib.h>"
		alias
			"XCirculateSubwindowsUp"
		end;

	x_circulate_down (display_ptr: POINTER; a_window: POINTER) is
		external
			"C (Display *, Window) | <X11/Xlib.h>"
		alias
			"XCirculateSubwindowsDown"
		end;

	x_restack_windows (display_ptr: POINTER; w_list: POINTER; n: INTEGER) is
		external
			"C (Display *, Window *, int) | <X11/Xlib.h>"
		alias
			"XRestackWindows"
		end;

end -- class MEL_COMPOSITE


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


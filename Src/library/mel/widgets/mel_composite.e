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
		redefine
			clean_up
		end

feature -- Access

	children: ARRAYED_LIST [MEL_OBJECT] is
			-- The list of the widgets used by MEL.
		require
			exists: not is_destroyed
		local
			a_screen_object: POINTER;
			an_object: MEL_OBJECT;
			i, temp: INTEGER
		do
			temp := children_count;
			!! Result.make (temp);
			if temp > 0 then
				from
					i := 0
				until
					i = temp
				loop
					i := i + 1;
					a_screen_object := get_i_th_widget_child (screen_object, i);
					an_object := Mel_widgets.item (a_screen_object);
					if an_object /= Void then
						Result.extend (an_object)
					end
				end
			end
		ensure
			children_list_not_void: Result /= Void
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

feature {NONE} -- Implementation

	clean_up is
			-- Clean up the is_destroyed widget's data structure.
		local
			children_list: ARRAYED_LIST [MEL_OBJECT];
		do
			children_list := children;
			if not children_list.empty then
				from
					children_list.start
				until
					children_list.after
				loop
					children_list.item.clean_up;
					children_list.forth
				end
			end;
			object_clean_up
		end;

feature {NONE} -- External features

	get_i_th_widget_child (a_scr_obj: POINTER; index: INTEGER): POINTER is
		external
			"C"
		end;

end -- class MEL_COMPOSITE

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

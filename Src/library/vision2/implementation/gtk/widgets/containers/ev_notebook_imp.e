indexing
	description: 
		"Eiffel Vision notebook. GTK implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_NOTEBOOK_IMP
	
inherit
	EV_NOTEBOOK_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface,
			replace
		end
		
	EV_WIDGET_LIST_IMP
		redefine
			interface,
			on_new_item,
			replace,
			initialize,
--			set_foreground_color,
--			set_background_color,
			remove_i_th
		end
	  
	EV_NOTEBOOK_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create a fixed widget. 
		do
			base_make (an_interface)
			set_c_object (C.gtk_notebook_new ())
			real_signal_connect (c_object, "switch-page", ~page_switch, ~page_switch_translate)
		end

	initialize is
			-- Initialize the notebook.
		do
			Precursor {EV_WIDGET_LIST_IMP}
			selected_item_index := 1
		end

feature -- Access

	item_text (an_item: like item): STRING is
			-- Label of `an_item'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			check
                		an_item_has_implementation: item_imp /= Void
			end
			create Result.make_from_c (C.gtk_label_struct_label (
				C.gtk_notebook_get_tab_label (
					c_object,
					item_imp.c_object
				)
			))
		end

feature -- Status report

	selected_item: like item is
			-- Page displayed topmost.
		local
			p: POINTER
			pn: INTEGER
			imp: EV_WIDGET_IMP
		do
			pn := selected_item_index - 1
			p := C.gtk_notebook_get_nth_page (
				c_object,
				pn
			)
			check
				p_not_void: p /= NULL
			end
			imp ?= eif_object_from_c (p)
			check
				p_has_eif_object: imp /= Void
			end

			Result ?= imp.interface

			check
				imp_has_interface: Result /= Void
			end
		end

	selected_item_index: INTEGER
			-- Index `selected_item'


	tab_position: INTEGER is
			-- Position of tabs.
 		local
 			gtk_pos: INTEGER
 		do
 			gtk_pos := C.gtk_notebook_struct_tab_pos (c_object)
 			inspect
 				gtk_pos
 			when 0 then
 				Result := interface.Tab_left
 			when 1 then
 				Result := interface.Tab_right
 			when 2 then
 				Result := interface.Tab_top
 			when 3 then
 				Result := interface.Tab_bottom
			end
		end

feature -- Status setting
	
	set_tab_position (a_tab_position: INTEGER) is
			-- Display tabs at `a_position'.
		local
			gtk_pos: INTEGER
		do
			if a_tab_position = interface.Tab_left then
				gtk_pos := 0
			elseif a_tab_position = interface.Tab_right then
				gtk_pos := 1
			elseif a_tab_position = interface.Tab_top then
				gtk_pos := 2
			elseif a_tab_position = interface.Tab_bottom then
				gtk_pos := 3
			end
			C.gtk_notebook_set_tab_pos (c_object, gtk_pos)
		end

	select_item (an_item: like item) is
			-- Display `an_item' above all others.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			check
				an_item_has_implementation: item_imp /= Void
			end
			C.gtk_notebook_set_page (
				c_object,
				C.gtk_notebook_page_num (c_object, item_imp.c_object)
			)
		end	
	
feature -- Element change

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		do
			Precursor {EV_WIDGET_LIST_IMP} (i)
			selected_item_index := C.gtk_notebook_get_current_page (c_object) + 1
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		local
			i: INTEGER
		do
			i := C.gtk_notebook_get_current_page (c_object)
			remove_i_th (index)
			insert_i_th (v, index)
			C.gtk_notebook_set_page (c_object, i)
		end


	set_item_text (an_item: like item; a_text: STRING) is
			-- Assign `a_text' to the label for `an_item'.
		local
			item_imp: EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			check
				an_item_has_implementation: item_imp /= Void
			end
			C.gtk_notebook_set_tab_label_text (
				c_object,
				item_imp.c_object,
				eiffel_to_c (a_text)
			)
		end
	
-- FIXME reimplement if needed. sam
--	set_background_color (color: EV_COLOR) is
--			-- Make `color' the new `background_color'.
--			-- Redefine because EV_NOTEBOOK are made of GtkNotebook
--			-- and GtkLabel.
--		local
--			list: LINKED_LIST [POINTER]
--		do
--			{EV_CONTAINER_IMP} Precursor (color)
--
--			list := labels_list
--			from
--				list.start
--			until
--				list.after
--			loop
----C.c_gtk_widget_set_bg_color (list.item, color.red, color.green, color.blue)
--				list.forth
--			end
--		end

-- FIXME reimplement if needed. sam
--	set_foreground_color (color: EV_COLOR) is
--			-- Make `color' the new `foreground_color'
--			-- Redefine because EV_NOTEBOOK are made of GtkNotebook
--			-- and GtkLabel.
--		local
--			list: LINKED_LIST [POINTER]
--		do
--			{EV_CONTAINER_IMP} Precursor (color)
--
--			list := labels_list
--			from
--				list.start
--			until
--				list.after
--			loop
----C.c_gtk_widget_set_fg_color (list.item, color.red, color.green, color.blue)
--				list.forth
--			end
--		end

feature {EV_ANY_I} -- Implementation

	page_switch (a_page: TUPLE [POINTER]) is
			-- Called when the page is switched.
		local
			temp_ptr_ref: POINTER_REF
			temp_ptr: POINTER
		do
			if not is_destroyed then
			temp_ptr_ref ?= a_page.item (1)
			temp_ptr := temp_ptr_ref.item
			selected_item_index := C.gtk_notebook_page_num (
				c_object,
				C.gtk_notebook_page_struct_child (temp_ptr)
			) + 1
			if selection_actions_internal /= Void then
				selection_actions_internal.call ([])
			end
			end
		end

	page_switch_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Retrieve index of switched page.
		do
			Result := [gtk_value_pointer (p)]
		end

	on_new_item (an_item: EV_WIDGET) is
			-- Set `an_item's text empty.
		do
			set_item_text (an_item, "")
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_notebook_reorder_child (a_container, a_child, a_position)
		end

	interface: EV_NOTEBOOK
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_NOTEBOOK_IMP

--|-----------------------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|-----------------------------------------------------------------------------

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.26  2001/07/14 12:46:23  manus
--| Replace --! by --|
--|
--| Revision 1.25  2001/07/14 12:16:27  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.24  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.17.4.13  2001/04/26 19:03:08  king
--| Put in temporary hack to preventgtk warning on gtk deg fault in Studio
--|
--| Revision 1.17.4.12  2000/12/20 00:38:07  etienne
--| Redefining remove_i_th to correctly set selected_item_index
--|
--| Revision 1.17.4.11  2000/10/27 16:54:42  manus
--| Removed undefinition of `set_default_colors' since now the one from EV_COLORIZABLE_IMP is
--| deferred.
--| However, there might be a problem with the definition of `set_default_colors' in the following
--| classes:
--| - EV_TITLED_WINDOW_IMP
--| - EV_WINDOW_IMP
--| - EV_TEXT_COMPONENT_IMP
--| - EV_LIST_ITEM_LIST_IMP
--| - EV_SPIN_BUTTON_IMP
--|
--| Revision 1.17.4.10  2000/10/12 16:22:47  king
--| Fixed selection_actions
--|
--| Revision 1.17.4.9  2000/10/10 22:04:31  king
--| Made compilable with AS correction
--|
--| Revision 1.17.4.8  2000/10/09 17:55:25  king
--| Made compilable
--|
--| Revision 1.17.4.7  2000/09/18 18:06:43  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.17.4.6  2000/08/30 16:19:53  oconnor
--| fixed replace
--|
--| Revision 1.17.4.5  2000/08/08 00:03:14  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.17.4.4  2000/08/04 19:19:28  oconnor
--| Optimised radio button management by using a polymorphic call
--| instaed of using agents.
--|
--| Revision 1.17.4.3  2000/07/24 21:36:08  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.17.4.2  2000/06/01 00:03:35  king
--| Implemented external in Eiffel
--|
--| Revision 1.17.4.1  2000/05/03 19:08:48  oconnor
--| mergred from HEAD
--|
--| Revision 1.22  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.21  2000/04/20 18:07:40  oconnor
--| Removed default_translate where not needed in sognal connect calls.
--|
--| Revision 1.20  2000/04/04 20:51:57  oconnor
--| updated signal connection for new marshaling scheme
--|
--| Revision 1.19  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.18  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.17.6.12  2000/02/04 04:25:38  oconnor
--| released
--|
--| Revision 1.17.6.11  2000/02/02 20:19:00  oconnor
--| added agent to set new page texts to empty
--|
--| Revision 1.17.6.10  2000/01/27 19:29:43  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.17.6.9  2000/01/19 08:04:40  oconnor
--| fixed off by one error in selected_item_index
--|
--| Revision 1.17.6.8  2000/01/18 23:19:50  king
--| Altered item to return ev_widget
--|
--| Revision 1.17.6.7  2000/01/18 17:53:35  oconnor
--| Added EV_WIDGET_LIST.gtk_reorder_child deferred.
--| Defined in ev_notebook_imp.e and ev_box_imp.e.
--| GTK is missing a GtkMultiContainer class so there is no way
--| to polymorphicaly call gtk_box_reorder_child and gtk_notebook_reorder_child.
--|
--| Revision 1.17.6.6  2000/01/18 06:53:15  oconnor
--| missing create keyword
--|
--| Revision 1.17.6.5  2000/01/18 01:38:10  oconnor
--| Complete revision.
--| Commenting, formatting.
--| Renamed features to refer to item not page.
--| Now inherits widget list.
--|
--| Revision 1.17.6.4  2000/01/13 23:57:31  king
--| Implemented set_title_for_page
--|
--| Revision 1.17.6.3  2000/01/13 22:24:05  king
--| Connected switch action sequence, corrected wipe_out, now incremeteing ref
--| count of widgets, removed switch command
--|
--| Revision 1.17.6.2  2000/01/13 01:15:47  king
--| Implemented to fit in with new structure, colors still need doing.
--|
--| Revision 1.17.6.1  1999/11/24 17:29:54  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.17.2.3  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.17.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

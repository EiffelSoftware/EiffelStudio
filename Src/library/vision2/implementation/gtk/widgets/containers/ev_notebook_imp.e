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
		redefine
			interface
		end
		
	EV_WIDGET_LIST_IMP
		redefine
			interface,
			initialize
--			set_foreground_color,
--			set_background_color,
		end
	  
create
	make

feature {NONE} -- Initialization
	
	make (an_interface: like interface) is
			-- Create a fixed widget. 
		do
			base_make (an_interface)
			set_c_object (C.gtk_notebook_new ())
		end	

	initialize is
			-- Set up the action sequence connection.
		do
			Precursor
			connect_signal_to_actions ("switch-page", interface.selection_actions)
			new_item_actions.extend (~set_item_text (?, ""))
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
			pn := C.gtk_notebook_get_current_page (c_object)
			p := C.gtk_notebook_get_nth_page (
				c_object,
				C.gtk_notebook_get_current_page (c_object)
			)
			check
				p_not_void: p /= default_pointer
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

	selected_item_index: INTEGER is
			-- Index `selected_item'.
		do
			Result := C.gtk_notebook_get_current_page (c_object) + 1
		end

	tab_position: INTEGER is
			-- Position of tabs.
 		local
 			gtk_pos: INTEGER
 		do
 			gtk_pos := C.c_gtk_notebook_tab_position (c_object)
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
--				--C.c_gtk_widget_set_bg_color (list.item, color.red, color.green, color.blue)
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
--				--C.c_gtk_widget_set_fg_color (list.item, color.red, color.green, color.blue)
--				list.forth
--			end
--		end

feature {EV_ANY_I} -- Implementation

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_notebook_reorder_child (a_container, a_child, a_position)
		end

	interface: EV_NOTEBOOK
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_NOTEBOOK_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-1999 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
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
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

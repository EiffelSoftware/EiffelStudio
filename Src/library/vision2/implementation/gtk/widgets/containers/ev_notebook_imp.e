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
			remove_i_th,
			needs_event_box
		end
		
	EV_FONTABLE_IMP
		undefine
			destroy
		redefine
			interface
		end
	  
	EV_NOTEBOOK_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is True
	
	make (an_interface: like interface) is
			-- Create a fixed widget. 
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_notebook_new ())
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_tab_border (visual_widget, 1)
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_show_border (visual_widget, False)
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_tab_hborder (visual_widget, 0)
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_tab_vborder (visual_widget, 0)
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_scrollable (visual_widget, True)
			real_signal_connect (visual_widget, "switch-page", agent (App_implementation.gtk_marshal).on_notebook_page_switch_intermediary (c_object, ?), agent (App_implementation.gtk_marshal).page_switch_translate)
		end

	initialize is
			-- Initialize the notebook.
		do
			Precursor {EV_WIDGET_LIST_IMP}
			selected_item_index_internal := 0
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
			create Result.make_from_c (feature {EV_GTK_EXTERNALS}.gtk_label_struct_label (
				feature {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (
					visual_widget,
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
			if count > 0 then
				pn := selected_item_index_internal - 1
				p := feature {EV_GTK_EXTERNALS}.gtk_notebook_get_nth_page (
					visual_widget,
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
		end
			
	selected_item_index: INTEGER is
			-- 
		do
			if count > 0 then
				Result := selected_item_index_internal
			end
		end

	tab_position: INTEGER is
			-- Position of tabs.
 		local
 			gtk_pos: INTEGER
 		do
 			gtk_pos := feature {EV_GTK_EXTERNALS}.gtk_notebook_struct_tab_pos (visual_widget)
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
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_tab_pos (visual_widget, gtk_pos)
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
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_page (
				visual_widget,
				feature {EV_GTK_EXTERNALS}.gtk_notebook_page_num (visual_widget, item_imp.c_object)
			)
		end	
	
feature -- Element change

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		do
			Precursor {EV_WIDGET_LIST_IMP} (i)
			if count > 0 then
				selected_item_index_internal := feature {EV_GTK_EXTERNALS}.gtk_notebook_get_current_page (visual_widget) + 1
			else
				selected_item_index_internal := 0
			end
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		local
			i: INTEGER
		do
			i := feature {EV_GTK_EXTERNALS}.gtk_notebook_get_current_page (visual_widget)
			remove_i_th (index)
			insert_i_th (v, index)
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_page (visual_widget, i)
		end

	set_item_text (an_item: like item; a_text: STRING) is
			-- Assign `a_text' to the label for `an_item'.
		local
			item_imp: EV_WIDGET_IMP
			a_cs: EV_GTK_C_STRING
		do
			item_imp ?= an_item.implementation
			check
				an_item_has_implementation: item_imp /= Void
			end
			create a_cs.make (a_text)
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_tab_label_text (
				visual_widget,
				item_imp.c_object,
				a_cs.item
			)
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	page_switch (a_page: TUPLE [INTEGER]) is
			-- Called when the page is switched.
		local
			temp_int_ref: INTEGER_REF
		do
			if not is_destroyed then
				temp_int_ref ?= a_page.item (1)
				selected_item_index_internal := temp_int_ref.item + 1
				if selection_actions_internal /= Void and count > 0 then
					selection_actions_internal.call ((App_implementation.gtk_marshal).empty_tuple)
				end
			end
		end
		
feature {EV_ANY_I} -- Implementation

	selected_item_index_internal: INTEGER
			-- Index `selected_item'

	on_new_item (an_item_imp: EV_WIDGET_IMP) is
			-- Set `an_item's text empty.
		do
			Precursor (an_item_imp)
			set_item_text (an_item_imp.interface, "      ")
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			feature {EV_GTK_EXTERNALS}.gtk_notebook_reorder_child (a_container, a_child, a_position)
		end

	interface: EV_NOTEBOOK
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_NOTEBOOK_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
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


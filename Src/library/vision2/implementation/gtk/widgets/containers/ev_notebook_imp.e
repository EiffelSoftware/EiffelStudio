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
			initialize_pixmaps
		end

feature -- Access

	pointed_tab_index: INTEGER is
			-- index of tab currently under mouse pointer, or 0 if none.
		do
			--| FIXME IEK Implement this
		end

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement this
		end

	item_tab (an_item: EV_WIDGET): EV_NOTEBOOK_TAB is
			-- Tab associated with `an_item'.
		do
			create Result.make_with_widgets (interface, an_item)
		end

	item_text (an_item: like item): STRING is
			-- Label of `an_item'.
		local
			item_imp: EV_WIDGET_IMP
			a_list, a_label: POINTER
		do
			item_imp ?= an_item.implementation

			a_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (feature {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object))
			if feature {EV_GTK_EXTERNALS}.g_list_length (a_list) = 1 then
				-- We only have a label stored
				a_label := feature {EV_GTK_EXTERNALS}.g_list_nth_data (a_list, 0)
			else
				-- We have both a pixmap and a label
				a_label := feature {EV_GTK_EXTERNALS}.g_list_nth_data (a_list, 1)
			end

			create Result.make_from_c (feature {EV_GTK_EXTERNALS}.gtk_label_struct_label (
				a_label
			))
			feature {EV_GTK_EXTERNALS}.g_list_free (a_list)
		end

	item_pixmap (an_item: like item): EV_PIXMAP is
			-- 
		local
			item_imp: EV_WIDGET_IMP
			a_tab_label, a_list: POINTER
		do
			item_imp ?= an_item.implementation
			a_tab_label := feature {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			a_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (a_tab_label)
			if feature {EV_GTK_EXTERNALS}.g_list_length (a_list) = 2 then
				-- Our pixmap is set
				create Result
			end
			feature {EV_GTK_EXTERNALS}.g_list_free (a_list)
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
			-- Page index of selected item
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
			a_hbox, a_label: POINTER
		do
			item_imp ?= an_item.implementation
			create a_cs.make (a_text)
			
			a_hbox := feature {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			a_label := feature {EV_GTK_EXTERNALS}.gtk_label_new (a_cs.item)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (a_label)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (a_hbox)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (a_hbox, a_label)
			feature {EV_GTK_EXTERNALS}.gtk_notebook_set_tab_label (visual_widget, item_imp.c_object, a_hbox)
		end

	set_item_pixmap (an_item: like item; a_pixmap: EV_PIXMAP) is
			-- 
		local
			item_imp: EV_WIDGET_IMP
			a_hbox, a_list, a_pix: POINTER
			a_pix_imp: EV_PIXMAP_IMP
		do
			item_imp ?= an_item.implementation
			a_hbox := feature {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			a_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (a_hbox)
			if  feature {EV_GTK_EXTERNALS}.g_list_length (a_list) = 2 then
				-- We already have a pixmap present so we remove it
				feature {EV_GTK_EXTERNALS}.gtk_container_remove (a_hbox, feature {EV_GTK_EXTERNALS}.g_list_nth_data (a_list, 0))
			end
			a_pix_imp ?= a_pixmap.implementation
			a_pix := feature {EV_GTK_EXTERNALS}.gtk_image_new_from_pixbuf (a_pix_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height))
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (a_pix)
			feature {EV_GTK_EXTERNALS}.gtk_box_pack_start (a_hbox, a_pix, False, False, 0)
			feature {EV_GTK_EXTERNALS}.gtk_box_reorder_child (a_hbox, a_pix, 0)
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
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------


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
			real_signal_connect (c_object, "switch-page", agent page_switch, agent page_switch_translate)
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
			a_gs: GEL_STRING
		do
			item_imp ?= an_item.implementation
			check
				an_item_has_implementation: item_imp /= Void
			end
			create a_gs.make (a_text)
			C.gtk_notebook_set_tab_label_text (
				c_object,
				item_imp.c_object,
				a_gs.item
			)
		end

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
				selection_actions_internal.call (empty_tuple)
			end
			end
		end

	page_switch_translate (n: INTEGER; p: POINTER): TUPLE is
			-- Retrieve index of switched page.
		do
			Result := [gtk_marshal.gtk_value_pointer (p)]
		end

	on_new_item (an_item: EV_WIDGET) is
			-- Set `an_item's text empty.
		do
			Precursor (an_item)
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


note
	description:
		"Eiffel Vision notebook. GTK implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			replace,
			make,
			remove_i_th,
			needs_event_box
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	old_make (an_interface: attached like interface)
			-- Create a fixed widget.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize the notebook.
		do
			set_c_object ({GTK}.gtk_notebook_new ())
			{GTK}.gtk_notebook_set_show_border (visual_widget, True)
			{GTK}.gtk_notebook_set_scrollable (visual_widget, True)
			real_signal_connect (visual_widget, {EV_GTK_EVENT_STRINGS}.switch_page_event_name,
						agent (App_implementation.gtk_marshal).on_notebook_page_switch_event (c_object, ?),
						Void
					)
			Precursor {EV_WIDGET_LIST_IMP}
			selected_item_index_internal := 0
			initialize_pixmaps
		end

feature -- Access

	pointed_tab_index: INTEGER
			-- index of tab currently under mouse pointer, or 0 if none.
		local
			i: INTEGER
			gdkwin, mouse_ptr_wid, tab_label: POINTER
			a_wid: detachable EV_WIDGET_IMP
			l_x, l_y: INTEGER
		do
			from
				i := 1
				gdkwin := {GDK_HELPERS}.window_at ($l_x, $l_y)
				if gdkwin /= default_pointer then
					{GTK}.gdk_window_get_user_data (gdkwin, $mouse_ptr_wid)
					a_wid ?= eif_object_from_c (mouse_ptr_wid)
				end
			until
				Result > 0 or else i > count or else mouse_ptr_wid = default_pointer
			loop
				a_wid ?= i_th (i).implementation
				check a_wid /= Void then end
				tab_label := {GTK}.gtk_notebook_get_tab_label (visual_widget, a_wid.c_object)
				if mouse_ptr_wid = tab_label or else mouse_ptr_wid = {GTK}.gtk_widget_get_parent (mouse_ptr_wid) then
					Result := i
				end
				i := i + 1
			end
		end

	pixmaps_size_changed
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement this
		end

feature {EV_NOTEBOOK, EV_NOTEBOOK_TAB_IMP} -- Access

	item_tab (an_item: EV_WIDGET): EV_NOTEBOOK_TAB
			-- Tab associated with `an_item'.
		do
			create Result.make_with_widgets (attached_interface, an_item)
		end

	item_text (an_item: like item): STRING_32
			-- Label of `an_item'.
		local
			item_imp: detachable EV_WIDGET_IMP
			a_event_box, a_hbox, a_list, a_label: POINTER
			a_cs: EV_GTK_C_STRING
		do
			item_imp ?= an_item.implementation
			check item_imp /= Void then end
			a_event_box := {GTK}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			if a_event_box /= default_pointer then
				a_hbox := {GTK}.gtk_bin_get_child (a_event_box)
				a_list := {GTK}.gtk_container_get_children (a_hbox)
				a_label := {GTK}.g_list_nth_data (a_list, 1)
				{GTK}.g_list_free (a_list)
			end

			if a_label /= default_pointer then
				create a_cs.share_from_pointer ({GTK}.gtk_label_get_label (
					a_label
				))
				Result := a_cs.string
			else
				Result := ""
			end
		end

	item_pixmap (an_item: attached like item): detachable EV_PIXMAP
			-- Pixmap of `an_item'.
		local
			item_imp: detachable EV_WIDGET_IMP
			a_event_box, a_hbox, a_list, a_image, a_pixbuf: POINTER
			pix_imp: detachable EV_PIXMAP_IMP
		do
			item_imp ?= an_item.implementation
			check item_imp /= Void then end
			a_event_box := {GTK}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			if a_event_box /= default_pointer then
				a_hbox := {GTK}.gtk_bin_get_child (a_event_box)
				a_list := {GTK}.gtk_container_get_children (a_hbox)
				a_image := {GTK}.g_list_nth_data (a_list, 0)
				{GTK}.g_list_free (a_list)
				a_pixbuf := {GTK2}.gtk_image_get_pixbuf (a_image)
				if a_pixbuf /= default_pointer then
					create Result
					pix_imp ?= Result.implementation
					check pix_imp /= Void then end
					pix_imp.set_pixmap_from_pixbuf (a_pixbuf)
				end
			end
		end

feature -- Status report

	selected_item: detachable like item
			-- Page displayed topmost.
		local
			p: POINTER
			pn: INTEGER
		do
			if count > 0 then
				pn := selected_item_index_internal - 1
				p := {GTK}.gtk_notebook_get_nth_page (visual_widget, pn)
				if attached {EV_WIDGET_I} eif_object_from_c (p) as imp then
					Result := imp.interface
				end
			end
		end

	selected_item_index: INTEGER
			-- Page index of selected item
		do
			if count > 0 then
				Result := selected_item_index_internal
			end
		end

	tab_position: INTEGER
			-- Position of tabs.
 		local
 			gtk_pos: INTEGER
 		do
 			gtk_pos := {GTK}.gtk_notebook_get_tab_pos (visual_widget)
 			inspect
 				gtk_pos
 			when 0 then
 				Result := attached_interface.Tab_left
 			when 1 then
 				Result := attached_interface.Tab_right
 			when 2 then
 				Result := attached_interface.Tab_top
 			when 3 then
 				Result := attached_interface.Tab_bottom
			end
		end

feature {EV_NOTEBOOK} -- Status setting

	set_tab_position (a_tab_position: INTEGER)
			-- Display tabs at `a_position'.
		local
			gtk_pos: INTEGER
		do
			if a_tab_position = attached_interface.Tab_left then
				gtk_pos := 0
			elseif a_tab_position = attached_interface.Tab_right then
				gtk_pos := 1
			elseif a_tab_position = attached_interface.Tab_top then
				gtk_pos := 2
			elseif a_tab_position = attached_interface.Tab_bottom then
				gtk_pos := 3
			end
			{GTK}.gtk_notebook_set_tab_pos (visual_widget, gtk_pos)
		end

	select_item (an_item: like item)
			-- Display `an_item' above all others.
		local
			item_imp: detachable EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			check
				an_item_has_implementation: item_imp /= Void then
			end
			{GTK}.gtk_notebook_set_current_page (
				visual_widget,
				{GTK}.gtk_notebook_page_num (visual_widget, item_imp.c_object)
			)
		end

feature -- Element change

	remove_i_th (i: INTEGER)
			-- Remove item at `i'-th position.
		do
			Precursor {EV_WIDGET_LIST_IMP} (i)
			if count > 0 then
				selected_item_index_internal := {GTK}.gtk_notebook_get_current_page (visual_widget) + 1
			else
				selected_item_index_internal := 0
			end
		end

	replace (v: attached like item)
			-- Replace current item by `v'.
		local
			i: INTEGER
		do
			i := {GTK}.gtk_notebook_get_current_page (visual_widget)
			remove_i_th (index)
			insert_i_th (v, index)
			{GTK}.gtk_notebook_set_current_page (visual_widget, i)
		end

feature {EV_NOTEBOOK, EV_NOTEBOOK_TAB_IMP} -- Element change

	ensure_tab_label (tab_widget: POINTER)
			-- Ensure the is a tab label widget for `tab_widget'.
		local
			a_event_box, a_hbox, a_image, a_label: POINTER
		do
			if {GTK}.gtk_notebook_get_tab_label (visual_widget, tab_widget) = default_pointer then
				a_event_box := {GTK}.gtk_event_box_new
				{GTK2}.gtk_event_box_set_visible_window (a_event_box, False)
				{GTK}.gtk_widget_show (a_event_box)
				a_hbox := {GTK}.gtk_box_new ({GTK_ORIENTATION}.gtk_orientation_horizontal, default_tab_label_spacing)
				{GTK}.gtk_container_add (a_event_box, a_hbox)
				{GTK}.gtk_widget_show (a_hbox)
				a_image := {GTK2}.gtk_image_new
				{GTK}.gtk_widget_show (a_image)
				{GTK}.gtk_container_add (a_hbox, a_image)
				a_label := {GTK}.gtk_label_new (default_pointer)
				{GTK}.gtk_widget_show (a_label)
				{GTK}.gtk_container_add (a_hbox, a_label)
				{GTK}.gtk_notebook_set_tab_label (visual_widget, tab_widget, a_event_box)
			end
		end

	default_tab_label_spacing: INTEGER = 2
		-- Space between pixmap and text in the tab label.

	set_item_text (an_item: like item; a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to the label for `an_item'.
		local
			item_imp: detachable EV_WIDGET_IMP
			a_cs: EV_GTK_C_STRING
			a_event_box, a_hbox, a_list, a_label: POINTER
		do
			item_imp ?= an_item.implementation
			check item_imp /= Void then end
			a_cs := a_text
			ensure_tab_label (item_imp.c_object)
			a_event_box := {GTK}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			a_hbox := {GTK}.gtk_bin_get_child (a_event_box)
			a_list := {GTK}.gtk_container_get_children (a_hbox)
			a_label := {GTK}.g_list_nth_data (a_list, 1)
			{GTK}.gtk_label_set_text (a_label, a_cs.item)
			{GTK}.g_list_free (a_list)
		end

	set_item_pixmap (an_item: attached like item; a_pixmap: detachable EV_PIXMAP)
			-- Assign `a_pixmap' to the tab for `an_item'.
		local
			item_imp: detachable EV_WIDGET_IMP
			a_event_box, a_hbox, a_image, a_list, a_pixbuf: POINTER
			a_pix_imp: detachable EV_PIXMAP_IMP
		do
			item_imp ?= an_item.implementation
			check item_imp /= Void then end
			ensure_tab_label (item_imp.c_object)
			a_event_box := {GTK}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			a_hbox := {GTK}.gtk_bin_get_child (a_event_box)

			a_list := {GTK}.gtk_container_get_children (a_hbox)
			a_image := {GTK}.g_list_nth_data (a_list, 0)
			{GTK}.g_list_free (a_list)

			if a_pixmap /= Void then
				a_pix_imp ?= a_pixmap.implementation
				check a_pix_imp /= Void then end
				a_pixbuf := a_pix_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height)
				{GTK2}.gtk_image_set_from_pixbuf (a_image, a_pixbuf)
			else
				{GTK2}.gtk_image_set_from_pixbuf (a_image, default_pointer)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	page_switch (a_page: INTEGER)
			-- Called when the page is switched.
		do
			if not is_destroyed then
				selected_item_index_internal := a_page + 1
				if selection_actions_internal /= Void and count > 0 then
					selection_actions_internal.call (Void)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	selected_item_index_internal: INTEGER
			-- Index `selected_item'

	gtk_insert_i_th (a_container, a_child: POINTER; a_position: INTEGER)
			-- Move `a_child' to `a_position' in `a_container'.
		do
			{GTK}.gtk_container_add (a_container, a_child)
			if a_position < count then
				{GTK}.gtk_notebook_reorder_child (a_container, a_child, a_position)
			end
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: detachable EV_NOTEBOOK note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_NOTEBOOK_IMP












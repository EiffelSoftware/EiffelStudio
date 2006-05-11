indexing
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
			set_c_object ({EV_GTK_EXTERNALS}.gtk_notebook_new ())
			{EV_GTK_EXTERNALS}.gtk_notebook_set_show_border (visual_widget, True)
			{EV_GTK_EXTERNALS}.gtk_notebook_set_scrollable (visual_widget, True)
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
		local
			i: INTEGER
			gdkwin, mouse_ptr_wid, tab_label: POINTER
			a_wid: EV_WIDGET_IMP
		do
			from
				i := 1
				gdkwin := {EV_GTK_EXTERNALS}.gdk_window_at_pointer (default_pointer, default_pointer)
				if gdkwin /= default_pointer then
					{EV_GTK_EXTERNALS}.gdk_window_get_user_data (gdkwin, $mouse_ptr_wid)
					a_wid ?= eif_object_from_c (mouse_ptr_wid)
				end
			until
				Result > 0 or else i > count or else mouse_ptr_wid = default_pointer
			loop
				a_wid ?= i_th (i).implementation
				tab_label := {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, a_wid.c_object)
				if mouse_ptr_wid = tab_label or else mouse_ptr_wid = {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (mouse_ptr_wid) then
					Result := i
				end
				i := i + 1
			end
		end

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement this
		end

feature {EV_NOTEBOOK, EV_NOTEBOOK_TAB_IMP} -- Access

	item_tab (an_item: EV_WIDGET): EV_NOTEBOOK_TAB is
			-- Tab associated with `an_item'.
		do
			create Result.make_with_widgets (interface, an_item)
		end

	item_text (an_item: like item): STRING_32 is
			-- Label of `an_item'.
		local
			item_imp: EV_WIDGET_IMP
			a_event_box, a_hbox, a_list, a_label: POINTER
			a_cs: EV_GTK_C_STRING
		do
			item_imp ?= an_item.implementation
			a_event_box := {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			if a_event_box /= default_pointer then
				a_hbox := {EV_GTK_EXTERNALS}.gtk_bin_struct_child (a_event_box)
				a_list := {EV_GTK_EXTERNALS}.gtk_container_children (a_hbox)
				a_label := {EV_GTK_EXTERNALS}.g_list_nth_data (a_list, 1)
				{EV_GTK_EXTERNALS}.g_list_free (a_list)
			end

			if a_label /= default_pointer then
				create a_cs.share_from_pointer ({EV_GTK_EXTERNALS}.gtk_label_struct_label (
					a_label
				))
				Result := a_cs.string
			else
				Result := ""
			end
		end

	item_pixmap (an_item: like item): EV_PIXMAP is
			-- Pixmap of `an_item'.
		local
			item_imp: EV_WIDGET_IMP
			a_event_box, a_hbox, a_list, a_image, a_pixbuf: POINTER
			pix_imp: EV_PIXMAP_IMP
		do
			item_imp ?= an_item.implementation
			a_event_box := {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			if a_event_box /= default_pointer then
				a_hbox := {EV_GTK_EXTERNALS}.gtk_bin_struct_child (a_event_box)
				a_list := {EV_GTK_EXTERNALS}.gtk_container_children (a_hbox)
				a_image := {EV_GTK_EXTERNALS}.g_list_nth_data (a_list, 0)
				{EV_GTK_EXTERNALS}.g_list_free (a_list)
				a_pixbuf := {EV_GTK_EXTERNALS}.gtk_image_get_pixbuf (a_image)
				if a_pixbuf /= default_pointer then
					create Result
					pix_imp ?= Result.implementation
					pix_imp.set_pixmap_from_pixbuf (a_pixbuf)
				end
			end
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
				p := {EV_GTK_EXTERNALS}.gtk_notebook_get_nth_page (
					visual_widget,
					pn
				)
				imp ?= eif_object_from_c (p)
				Result ?= imp.interface
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
 			gtk_pos := {EV_GTK_EXTERNALS}.gtk_notebook_struct_tab_pos (visual_widget)
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

feature {EV_NOTEBOOK} -- Status setting

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
			{EV_GTK_EXTERNALS}.gtk_notebook_set_tab_pos (visual_widget, gtk_pos)
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
			{EV_GTK_EXTERNALS}.gtk_notebook_set_page (
				visual_widget,
				{EV_GTK_EXTERNALS}.gtk_notebook_page_num (visual_widget, item_imp.c_object)
			)
		end

feature -- Element change

	remove_i_th (i: INTEGER) is
			-- Remove item at `i'-th position.
		do
			Precursor {EV_WIDGET_LIST_IMP} (i)
			if count > 0 then
				selected_item_index_internal := {EV_GTK_EXTERNALS}.gtk_notebook_get_current_page (visual_widget) + 1
			else
				selected_item_index_internal := 0
			end
		end

	replace (v: like item) is
			-- Replace current item by `v'.
		local
			i: INTEGER
		do
			i := {EV_GTK_EXTERNALS}.gtk_notebook_get_current_page (visual_widget)
			remove_i_th (index)
			insert_i_th (v, index)
			{EV_GTK_EXTERNALS}.gtk_notebook_set_page (visual_widget, i)
		end

feature {EV_NOTEBOOK, EV_NOTEBOOK_TAB_IMP} -- Element change

	ensure_tab_label (tab_widget: POINTER) is
			-- Ensure the is a tab label widget for `tab_widget'.
		local
			a_event_box, a_hbox, a_image, a_label: POINTER
		do
			if {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, tab_widget) = default_pointer then
				a_event_box := {EV_GTK_EXTERNALS}.gtk_event_box_new
				{EV_GTK_EXTERNALS}.gtk_event_box_set_visible_window (a_event_box, False)
				{EV_GTK_EXTERNALS}.gtk_widget_show (a_event_box)
				a_hbox := {EV_GTK_EXTERNALS}.gtk_hbox_new (False, default_tab_label_spacing)
				{EV_GTK_EXTERNALS}.gtk_container_add (a_event_box, a_hbox)
				{EV_GTK_EXTERNALS}.gtk_widget_show (a_hbox)
				a_image := {EV_GTK_EXTERNALS}.gtk_image_new
				{EV_GTK_EXTERNALS}.gtk_widget_show (a_image)
				{EV_GTK_EXTERNALS}.gtk_container_add (a_hbox, a_image)
				a_label := {EV_GTK_EXTERNALS}.gtk_label_new (default_pointer)
				{EV_GTK_EXTERNALS}.gtk_widget_show (a_label)
				{EV_GTK_EXTERNALS}.gtk_container_add (a_hbox, a_label)
				{EV_GTK_EXTERNALS}.gtk_notebook_set_tab_label (visual_widget, tab_widget, a_event_box)
			end
		end

	default_tab_label_spacing: INTEGER is 3
		-- Space between pixmap and text in the tab label.

	set_item_text (an_item: like item; a_text: STRING_GENERAL) is
			-- Assign `a_text' to the label for `an_item'.
		local
			item_imp: EV_WIDGET_IMP
			a_cs: EV_GTK_C_STRING
			a_event_box, a_hbox, a_list, a_label: POINTER
		do
			item_imp ?= an_item.implementation
			a_cs := a_text
			ensure_tab_label (item_imp.c_object)
			a_event_box := {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			a_hbox := {EV_GTK_EXTERNALS}.gtk_bin_struct_child (a_event_box)
			a_list := {EV_GTK_EXTERNALS}.gtk_container_children (a_hbox)
			a_label := {EV_GTK_EXTERNALS}.g_list_nth_data (a_list, 1)
			{EV_GTK_EXTERNALS}.gtk_label_set_text (a_label, a_cs.item)
			{EV_GTK_EXTERNALS}.g_list_free (a_list)
		end

	set_item_pixmap (an_item: like item; a_pixmap: EV_PIXMAP) is
			-- Assign `a_pixmap' to the tab for `an_item'.
		local
			item_imp: EV_WIDGET_IMP
			a_event_box, a_hbox, a_image, a_list, a_pixbuf: POINTER
			a_pix_imp: EV_PIXMAP_IMP
		do
			item_imp ?= an_item.implementation
			ensure_tab_label (item_imp.c_object)
			a_event_box := {EV_GTK_EXTERNALS}.gtk_notebook_get_tab_label (visual_widget, item_imp.c_object)
			a_hbox := {EV_GTK_EXTERNALS}.gtk_bin_struct_child (a_event_box)

			a_list := {EV_GTK_EXTERNALS}.gtk_container_children (a_hbox)
			a_image := {EV_GTK_EXTERNALS}.g_list_nth_data (a_list, 0)
			{EV_GTK_EXTERNALS}.g_list_free (a_list)

			if a_pixmap /= Void then
				a_pix_imp ?= a_pixmap.implementation
				a_pixbuf := a_pix_imp.pixbuf_from_drawable_with_size (pixmaps_width, pixmaps_height)
				{EV_GTK_EXTERNALS}.gtk_image_set_from_pixbuf (a_image, a_pixbuf)
			else
				{EV_GTK_EXTERNALS}.gtk_image_set_from_pixbuf (a_image, default_pointer)
			end
		end

feature {EV_INTERMEDIARY_ROUTINES} -- Implementation

	page_switch (a_page: INTEGER) is
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

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			{EV_GTK_EXTERNALS}.gtk_notebook_reorder_child (a_container, a_child, a_position)
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: EV_NOTEBOOK;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_NOTEBOOK_IMP


indexing
	description: 
		"Eiffel Vision container, GTK+ implementation."
	status: "See notice at end of class"
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_CONTAINER_IMP
	
inherit
	EV_CONTAINER_I
		redefine
			interface,
			propagate_foreground_color,
			propagate_background_color
		end

	EV_WIDGET_IMP
		redefine
			interface,
			initialize,
			destroy,
			set_parent_imp
		end
	
	EV_CONTAINER_ACTION_SEQUENCES_IMP

feature {NONE} -- Initialization

	initialize is
			-- Create `shared_pointer' for radio groups.
		do
			Precursor
			create shared_pointer
		end

feature -- Access

	container_widget: POINTER is
		do
			Result := visual_widget
		end
	
	client_width: INTEGER is
			-- Width of the client area of container.
			-- Redefined in children.
		do
			Result := width
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
			-- Redefined in children.
		do
			Result := height
		end

	background_pixmap: EV_PIXMAP
			-- the background pixmap
	
feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			w: EV_WIDGET_IMP
		do
			if not interface.is_empty then
				on_removed_item (interface.item)
				w ?= interface.item.implementation
				feature {EV_GTK_DEPENDENT_EXTERNALS}.object_ref (w.c_object)
				feature {EV_GTK_EXTERNALS}.gtk_container_remove (container_widget, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				feature {EV_GTK_EXTERNALS}.gtk_container_add (container_widget, w.c_object)
				on_new_item (w)
			end
		end		
	
feature {EV_RADIO_BUTTON_IMP, EV_CONTAINER_IMP} -- Access

	shared_pointer: POINTER_REF
			-- Reference to `radio_group'. Used to share the
			-- pointer `radio_group' with merged containers even when
			-- its value is still `NULL'.

	set_shared_pointer (p: POINTER_REF) is
			-- Assign `p' to `shared_pointer'.
		do
			shared_pointer := p
		end

	set_radio_group (p: POINTER) is
			-- Assign `p' to `radio_group'.
		do
			shared_pointer.set_item (p)
		end

	radio_group: POINTER is
			-- GSList with all radio items of this container.
			-- `Current' Shares reference with merged containers.
		do
			Result := shared_pointer.item
		end

feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER) is
			-- Join radio grouping of `a_container' to `Current'.
		local
			l: ARRAYED_LIST [POINTER]
			peer: EV_CONTAINER_IMP
		do
			peer ?= a_container.implementation
			if peer = Void then
				-- It's a widget that inherits from EV_CONTAINER,
				-- but has implementation renamed.
				-- If this is the case, on `a_container' this feature
				-- had to be redefined.
				a_container.merge_radio_button_groups (interface)
			else
				if shared_pointer /= peer.shared_pointer then
					l := gslist_to_eiffel (peer.radio_group)
					from
						l.start
					until
						l.off
					loop
						feature {EV_GTK_EXTERNALS}.gtk_radio_button_set_group (l.item, radio_group)
						set_radio_group (feature {EV_GTK_EXTERNALS}.gtk_radio_button_group (l.item))
						feature {EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (l.item, False)
						l.forth
					end
					peer.set_shared_pointer (shared_pointer)
				end
			end
		end

	unconnect_radio_grouping (a_container: EV_CONTAINER) is
			-- Remove Join of `a_container' to radio grouping of `Current'.
		local
			l: ARRAYED_LIST [POINTER]
			peer: EV_CONTAINER_IMP
			a_child_list: POINTER
			rad_but_imp: EV_RADIO_BUTTON_IMP
			selected_rad_but: EV_RADIO_BUTTON_IMP
		do
			peer ?= a_container.implementation
			if peer = Void then
				-- It's a widget that inherits from EV_CONTAINER,
				-- but has implementation renamed.
				-- If this is the case, on `a_container' this feature
				-- had to be redefined.
				a_container.unmerge_radio_button_groups (interface)
			else
				if shared_pointer = peer.shared_pointer then
						-- They share the same radio grouping.
					a_child_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (peer.container_widget)
					l := glist_to_eiffel (a_child_list)
							-- Wipe out peers radio grouping
					if l /= Void then
						from
							l.start
							if l.first /= NULL then
								rad_but_imp ?= eif_object_from_c (l.first)
							end
							peer.set_shared_pointer (NULL)
							peer.set_radio_group (NULL)
						until
							l.off
						loop
							if l.item /= NULL then
								rad_but_imp ?= eif_object_from_c (l.item)
									-- The c_object of the radio button is its parent (event box)
								if rad_but_imp /= Void then
									feature {EV_GTK_EXTERNALS}.gtk_radio_button_set_group (rad_but_imp.visual_widget, peer.radio_group)
									peer.set_radio_group (rad_but_imp.radio_group)
								end
							end
							l.forth
						end
					end
					if a_child_list /= NULL then
						feature {EV_GTK_EXTERNALS}.g_list_free (a_child_list)
					end
					a_child_list := feature {EV_GTK_EXTERNALS}.gtk_container_children (container_widget)
					l := glist_to_eiffel (a_child_list)
					from
						l.start
						rad_but_imp := Void
						selected_rad_but := Void
					until
						l.off
					loop
							if l.item /= NULL then
								rad_but_imp ?= eif_object_from_c (l.item)
								if rad_but_imp /= Void then
									set_radio_group (rad_but_imp.radio_group)
									if rad_but_imp.is_selected then
										selected_rad_but := rad_but_imp
									end
								end
							end
							l.forth
					end
					if selected_rad_but = Void and not l.is_empty then
						rad_but_imp ?= eif_object_from_c (l.first)
						rad_but_imp.enable_select
					end
					if a_child_list /= NULL then
						feature {EV_GTK_EXTERNALS}.g_list_free (a_child_list)
					end
				end
			end
		end

	add_radio_button (w: EV_WIDGET) is
			-- Called every time a widget is added to the container.
		require
			w_not_void: w /= Void
		local
			r: EV_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				if radio_group /= NULL then
					feature {EV_GTK_EXTERNALS}.gtk_radio_button_set_group (r.visual_widget, radio_group)
				else
					feature {EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (r.visual_widget, False)
				end
				set_radio_group (feature {EV_GTK_EXTERNALS}.gtk_radio_button_group (r.visual_widget))
			end
		end

	remove_radio_button (w: EV_WIDGET) is
			-- Called every time a widget is removed from the container.
		require
			w_not_void: w /= Void
		local
			r: EV_RADIO_BUTTON_IMP
			a_max_index: INTEGER
			a_item_index: INTEGER
			a_item_pointer: POINTER
			an_item_imp: EV_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				a_max_index := feature {EV_GTK_EXTERNALS}.g_slist_length (radio_group) - 1
				a_item_index := feature {EV_GTK_EXTERNALS}.g_slist_index (radio_group, r.visual_widget)
				
				if a_max_index - a_item_index > 0 then
					a_item_pointer := feature {EV_GTK_EXTERNALS}.g_slist_nth_data (
								radio_group,
								a_max_index
							)
				elseif a_max_index > 0 then
					a_item_pointer := feature {EV_GTK_EXTERNALS}.g_slist_nth_data (
								radio_group,
								a_max_index - 1
							)
				end				
				
				feature {EV_GTK_EXTERNALS}.gtk_radio_button_set_group (r.visual_widget, NULL)

				if a_item_pointer /= NULL then
					an_item_imp ?= eif_object_from_c (
						feature {EV_GTK_EXTERNALS}.gtk_widget_struct_parent (a_item_pointer)
					)
					check an_item_imp_not_void: an_item_imp /= Void end
					set_radio_group (an_item_imp.radio_group)
				else
					set_radio_group (NULL)
				end

				if r.is_selected then
					if radio_group /= NULL then
						feature {EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (
							feature {EV_GTK_EXTERNALS}.gslist_struct_data (radio_group),
							True
						)
					end
				else
					feature {EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (r.visual_widget, True)
				end
			end
		end

	internal_set_background_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set the container background pixmap to `pixmap'.
		local
			a_style: POINTER
			pix_imp: EV_PIXMAP_IMP
			mem_ptr, pix_ptr: POINTER
			i: INTEGER
		do	
			pix_imp ?= background_pixmap.implementation
			a_style := feature {EV_GTK_EXTERNALS}.gtk_style_copy (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (visual_widget))
			pix_ptr := feature {EV_GTK_EXTERNALS}.gdk_pixmap_ref (pix_imp.drawable)
			from
				i := 0
			until
				i = 12
			loop
				-- We need to ref the pixmap twice for each state to prevent GdkPixmap deletion.
				pix_ptr := feature {EV_GTK_EXTERNALS}.gdk_pixmap_ref (pix_imp.drawable)	
				i := i + 1
			end
			from
				i := 0
			until
				i = 5
			loop
				-- 4 = size of pointer in bytes.
				mem_ptr := bg_pixmap (a_style) + (i * 4)
				mem_ptr.memory_copy ($pix_ptr, 4)
				i := i + 1
			end
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_style (visual_widget, a_style)
			feature {EV_GTK_EXTERNALS}.gtk_style_unref (a_style)
		end
		
	set_background_pixmap (a_pixmap: EV_PIXMAP) is
			-- Set the container background pixmap to `pixmap'. 
		do
			background_pixmap := clone (a_pixmap)
			internal_set_background_pixmap (a_pixmap)
		end
		
	bg_pixmap (p: POINTER): POINTER is
		external
			"C [struct <gtk/gtk.h>] (GtkStyle): POINTER"
		alias
			"&bg_pixmap"
		end

	remove_background_pixmap is
			-- Make background pixmap Void.
		local
			a_style, mem_ptr: POINTER
			i: INTEGER
		do
			a_style := feature {EV_GTK_EXTERNALS}.gtk_style_copy (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (visual_widget))
			from
				i := 0
			until
				i = 5
			loop
				-- 4 = size of pointer in bytes.
				mem_ptr := bg_pixmap (a_style) + (i * 4)
				mem_ptr.memory_set (0, 4)
				i := i + 1
			end
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_style (visual_widget, a_style)
			background_pixmap := Void
		end

feature -- Basic operations

	propagate_foreground_color is
			-- Propagate the current foreground color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
			propagate_foreground_color_internal (foreground_color, c_object)
		end

	propagate_background_color is
			-- Propagate the current background color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
			propagate_background_color_internal (background_color, c_object)
		end

feature -- Command
	
	destroy is
			-- Detatch children.
			-- Destroy `c_object'.
			-- Render `Current' unusable.
			--| We remove all children before destroying
			--| the `c_object'. This prevents them from
			--| being destroyed when the container is destroyed.
		do
			if not is_destroyed then
				interface.wipe_out
				Precursor {EV_WIDGET_IMP}				
			end
		end

feature -- Event handling

	on_new_item (an_item_imp: EV_WIDGET_IMP) is
			-- Called after `an_item' is added.
		do
			an_item_imp.set_parent_imp (Current)
			add_radio_button (an_item_imp.interface)
--			if new_item_actions_internal /= Void then
--				new_item_actions_internal.call ([an_item])
--			end
		end

	on_removed_item (an_item: EV_WIDGET) is
			-- Called just before `an_item' is removed.
		local
			a_widget_imp: EV_WIDGET_IMP
		do
			a_widget_imp ?= an_item.implementation
			a_widget_imp.set_parent_imp (Void)
			remove_radio_button (an_item)
		end
		
feature {EV_WIDGET_IMP} -- Implementation

	child_has_resized (a_widget_imp: EV_WIDGET_IMP) is
			-- 
		do
			-- By default do nothing
		end
		
	set_parent_imp (a_parent_imp: EV_CONTAINER_IMP) is
			-- 
		do
			Precursor {EV_WIDGET_IMP} (a_parent_imp)
			if background_pixmap /= Void and parent_imp = Void then
				-- We need to reref the background pixmap as gtk doesn't handle it properly
				-- on removal from parent of Current.
				internal_set_background_pixmap (background_pixmap)
			end
		end

feature {NONE} -- Externals
	
	gslist_to_eiffel (gslist: POINTER): ARRAYED_LIST [POINTER] is
			-- Convert `gslist' to Eiffel structure.
		local
			cur: POINTER
		do
			create Result.make (10)
			from
				cur := gslist
			until
				cur = NULL
			loop
				Result.extend (feature {EV_GTK_EXTERNALS}.gslist_struct_data (cur))
				cur := feature {EV_GTK_EXTERNALS}.gslist_struct_next (cur)
			end
		ensure
		--	same_size: Result.count = g_slist_length (gslist)
		end
		
	glist_to_eiffel (gslist: POINTER): ARRAYED_LIST [POINTER] is
			-- Convert `gslist' to Eiffel structure.
		local
			cur: POINTER
		do
			create Result.make (10)
			from
				cur := gslist
			until
				cur = NULL
			loop
				Result.extend (feature {EV_GTK_EXTERNALS}.glist_struct_data (cur))
				cur := feature {EV_GTK_EXTERNALS}.glist_struct_next (cur)
			end
		ensure
		--	same_size: Result.count = g_slist_length (gslist)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_CONTAINER_IMP

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


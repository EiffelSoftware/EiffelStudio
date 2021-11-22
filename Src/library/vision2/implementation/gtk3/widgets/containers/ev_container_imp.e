note
	description:
		"Eiffel Vision container, GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_CONTAINER_IMP

inherit
	EV_CONTAINER_I
		undefine
			interface_item
		redefine
			interface,
			propagate_foreground_color,
			propagate_background_color
		end

	EV_WIDGET_IMP
		redefine
			interface,
			make,
			destroy,
			set_parent_imp
		end

	PLATFORM

feature {NONE} -- Initialization

	make
			-- Create `shared_pointer' for radio groups.
		do
			Precursor {EV_WIDGET_IMP}
			create shared_pointer

			real_set_default_background_color (visual_widget)
		end

feature -- Access

	container_widget: POINTER
		do
			Result := visual_widget
		end

	client_width: INTEGER
			-- Width of the client area of container.
			-- Redefined in children.
		do
			Result := width
		end

	client_height: INTEGER
			-- Height of the client area of container
			-- Redefined in children.
		do
			Result := height
		end

	background_pixmap: detachable EV_PIXMAP
			-- the background pixmap

feature -- Element change

	replace (v: like item)
			-- Replace `item' with `v'.
		local
			w: detachable EV_WIDGET_IMP
		do
			if attached item as l_item then
				w ?= l_item.implementation
				check w /= Void end
				if w /= Void then
					on_removed_item (w)
					gtk_container_remove (container_widget, w.c_object)
				end
			end
			if v /= Void then
				w ?= v.implementation
				check w /= Void end
				if w /= Void then
					gtk_insert_i_th (container_widget, w.c_object, 1)
					on_new_item (w)
				end
			end
		end

feature {EV_RADIO_BUTTON_IMP, EV_CONTAINER_IMP} -- Access

	shared_pointer: POINTER_REF
			-- Reference to `radio_group'. Used to share the
			-- pointer `radio_group' with merged containers even when
			-- its value is still `default_pointer'.

	set_shared_pointer (p: POINTER_REF)
			-- Assign `p' to `shared_pointer'.
		do
			shared_pointer := p
		end

	set_radio_group (p: POINTER)
			-- Assign `p' to `radio_group'.
		do
			shared_pointer.set_item (p)
		end

	radio_group: POINTER
			-- GSList with all radio items of this container.
			-- `Current' Shares reference with merged containers.
		do
			Result := shared_pointer.item
		end

feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER)
			-- Join radio grouping of `a_container' to `Current'.
		local
			l: ARRAYED_LIST [POINTER]
			peer: detachable EV_CONTAINER_IMP
		do
			peer ?= a_container.implementation
			if peer = Void then
				-- It's a widget that inherits from EV_CONTAINER,
				-- but has implementation renamed.
				-- If this is the case, on `a_container' this feature
				-- had to be redefined.
				a_container.merge_radio_button_groups (attached_interface)
			else
				if shared_pointer /= peer.shared_pointer then
					l := gslist_to_eiffel (peer.radio_group)
					from
						l.start
					until
						l.off
					loop
						{GTK}.gtk_radio_button_set_group (l.item, radio_group)
						set_radio_group ({GTK}.gtk_radio_button_get_group (l.item))
						{GTK}.gtk_toggle_button_set_active (l.item, False)
						l.forth
					end
					peer.set_shared_pointer (shared_pointer)
				end
			end
		end

	unconnect_radio_grouping (a_container: EV_CONTAINER)
			-- Remove Join of `a_container' to radio grouping of `Current'.
		local
			l: ARRAYED_LIST [POINTER]
			peer: detachable EV_CONTAINER_IMP
			a_child_list: POINTER
			rad_but_imp: detachable EV_RADIO_BUTTON_IMP
			selected_rad_but: detachable EV_RADIO_BUTTON_IMP
		do
			peer ?= a_container.implementation
			if peer = Void then
				-- It's a widget that inherits from EV_CONTAINER,
				-- but has implementation renamed.
				-- If this is the case, on `a_container' this feature
				-- had to be redefined.
				a_container.unmerge_radio_button_groups (attached_interface)
			else
				if shared_pointer = peer.shared_pointer then
						-- They share the same radio grouping.
					a_child_list := {GTK}.gtk_container_get_children (peer.container_widget)
					l := glist_to_eiffel (a_child_list)
							-- Wipe out peers radio grouping
					if l /= Void then
						from
							l.start
							if not l.first.is_default_pointer then
								rad_but_imp ?= eif_object_from_c (l.first)
							end
							peer.set_shared_pointer (default_pointer)
							peer.set_radio_group (default_pointer)
						until
							l.off
						loop
							if l.item /= default_pointer then
								rad_but_imp ?= eif_object_from_c (l.item)
									-- The c_object of the radio button is its parent (event box)
								if rad_but_imp /= Void then
									{GTK}.gtk_radio_button_set_group (rad_but_imp.visual_widget, peer.radio_group)
									peer.set_radio_group (rad_but_imp.radio_group)
								end
							end
							l.forth
						end
					end
					if a_child_list /= default_pointer then
						{GTK}.g_list_free (a_child_list)
					end
					a_child_list := {GTK}.gtk_container_get_children (container_widget)
					l := glist_to_eiffel (a_child_list)
					from
						l.start
						rad_but_imp := Void
						selected_rad_but := Void
					until
						l.off
					loop
							if l.item /= default_pointer then
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
						if rad_but_imp /= Void then
							rad_but_imp.enable_select
						end
					end
					if a_child_list /= default_pointer then
						{GTK}.g_list_free (a_child_list)
					end
				end
			end
		end

	add_radio_button (a_widget_imp: EV_WIDGET_IMP)
			-- Called every time a widget is added to the container.
		require
			a_widget_imp_not_void: a_widget_imp /= Void
		local
			r: detachable EV_RADIO_BUTTON_IMP
		do
			r ?= a_widget_imp
			if r /= Void then
				if radio_group /= default_pointer then
					{GTK}.gtk_radio_button_set_group (r.visual_widget, radio_group)
				else
					{GTK}.gtk_toggle_button_set_active (r.visual_widget, False)
				end
				set_radio_group ({GTK}.gtk_radio_button_get_group (r.visual_widget))
			end
		end

	remove_radio_button (a_widget_imp: EV_WIDGET_IMP)
			-- Called every time a widget is removed from the container.
		require
			a_widget_imp_not_void: a_widget_imp /= Void
		local
			r: detachable EV_RADIO_BUTTON_IMP
			a_max_index: INTEGER
			a_item_index: INTEGER
			a_item_pointer: POINTER
			an_item_imp: detachable EV_RADIO_BUTTON_IMP
		do
			r ?= a_widget_imp
			if r /= Void then
				a_max_index := {GTK}.g_slist_length (radio_group) - 1
				a_item_index := {GTK}.g_slist_index (radio_group, r.visual_widget)

				if a_max_index - a_item_index > 0 then
					a_item_pointer := {GTK}.g_slist_nth_data (
								radio_group,
								a_max_index
							)
				elseif a_max_index > 0 then
					a_item_pointer := {GTK}.g_slist_nth_data (
								radio_group,
								a_max_index - 1
							)
				end

				{GTK}.gtk_radio_button_set_group (r.visual_widget, default_pointer)

				if not a_item_pointer.is_default_pointer then
					an_item_imp ?= eif_object_from_c (
						{GTK}.gtk_widget_get_parent (a_item_pointer)
					)
					check an_item_imp_not_void: an_item_imp /= Void then end
					set_radio_group (an_item_imp.radio_group)
				else
					set_radio_group (default_pointer)
				end

				if r.is_selected then
					if not radio_group.is_default_pointer then
						{GTK}.gtk_toggle_button_set_active (
							{GTK}.gslist_struct_data (radio_group),
							True
						)
					end
				else
					{GTK}.gtk_toggle_button_set_active (r.visual_widget, True)
				end
			end
		end

	internal_set_background_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the container background pixmap to `pixmap'.
		local
			pix_imp: detachable EV_PIXMAP_IMP
			l_image: POINTER
			  -- Pointer to a GTK image.
		do
			debug ("refactor_fixme")
				{REFACTORING_HELPER}.to_implement ("implement container background")
			end

			real_set_background_color (c_object, (create {EV_STOCK_COLORS}).gray)
			if
				attached visual_widget as vw and then
				not vw.is_default_pointer and then
			 	vw /= c_object
			then
				real_set_background_color (vw, (create {EV_STOCK_COLORS}).gray)
			end

			if attached background_pixmap as l_background_pixmap then
				pix_imp ?= l_background_pixmap.implementation
			end
			if pix_imp /= Void then
				l_image := {GTK2}.gtk_image_new_from_pixbuf (pix_imp.pixbuf)
				{GTK}.gtk_widget_show (l_image)
				{GTK}.gtk_container_add (visual_widget, l_image)
			else
				check has_implementation: False end
			end
		end

	set_background_pixmap (a_pixmap: EV_PIXMAP)
			-- Set the container background pixmap to `pixmap'.
		do
			background_pixmap := a_pixmap.twin
			internal_set_background_pixmap (a_pixmap)
		end

--	bg_pixmap (p: POINTER): POINTER
--		external
--			"C [struct <ev_gtk.h>] (GtkStyle): POINTER"
--		alias
--			"&bg_pixmap"
--		end

	remove_background_pixmap
			-- Make background pixmap Void.
		local
--			a_style, mem_ptr: POINTER
			i: INTEGER
		do
			real_set_background_color (c_object, Void)
			if
				attached visual_widget as vw and then
				not vw.is_default_pointer and then
			 	vw /= c_object
			then
				real_set_background_color (vw, Void)
			end

--			a_style := {GTK}.gtk_style_copy ({GTK}.gtk_widget_struct_style (visual_widget))
			from
				i := 0
			until
				i = 5
			loop
				-- 4 = size of pointer in bytes.
				--| FIXME IEK bg_pixmap deprecated.
--				mem_ptr := bg_pixmap (a_style) + (i * 4)
--				mem_ptr.memory_set (0, 4)
				i := i + 1
			end
--			{GTK}.gtk_widget_set_style (visual_widget, a_style)
			background_pixmap := Void
		end

feature -- Basic operations

	propagate_foreground_color
			-- Propagate the current foreground color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
			propagate_foreground_color_internal (foreground_color, c_object)
			if
				attached visual_widget as vw and then
				not vw.is_default_pointer and then
			 	vw /= c_object
			then
				propagate_foreground_color_internal (foreground_color, vw)
			end
		end

	propagate_background_color
			-- Propagate the current background color of the
			-- container to the children.
		do
			Precursor {EV_CONTAINER_I}
			propagate_background_color_internal (background_color, c_object)
		end

feature -- Command

	destroy
			-- Render `Current' unusable.
		do
			if attached_interface.prunable then
				attached_interface.wipe_out
			end
			Precursor {EV_WIDGET_IMP}
		end

feature -- Event handling

	on_new_item (an_item_imp: EV_WIDGET_IMP)
			-- Called after `an_item' is added.
		do
			add_radio_button (an_item_imp)
			an_item_imp.set_parent_imp (Current)
--			if new_item_actions_internal /= Void then
--				new_item_actions_internal.call ([an_item])
--			end
		end

	on_removed_item (an_item_imp: EV_WIDGET_IMP)
			-- Called just before `an_item' is removed.
		do
			an_item_imp.set_parent_imp (Void)
			remove_radio_button (an_item_imp)
		end

feature {EV_WIDGET_IMP} -- Implementation

	child_has_resized (a_widget_imp: EV_WIDGET_IMP)
			--
		do
			-- By default do nothing
		end

	set_parent_imp (a_parent_imp: detachable EV_CONTAINER_IMP)
			--
		do
			Precursor {EV_WIDGET_IMP} (a_parent_imp)
			if attached background_pixmap as l_background_pixmap and parent_imp = Void then
				-- We need to reref the background pixmap as gtk doesn't handle it properly
				-- on removal from parent of Current.
				internal_set_background_pixmap (l_background_pixmap)
			end
		end

feature {NONE} -- Implementation

	gtk_insert_i_th (a_container, a_widget: POINTER; i: INTEGER)
			-- Insert `a_widget' in to `a_container' at position `i'.
		do
			{GTK}.gtk_container_add (a_container, a_widget)
		end

	gtk_container_remove (a_container, a_child: POINTER)
			-- Remove `a_child' from `a_container'.
		do
			{GTK}.gtk_container_remove (a_container, a_child)
		end

feature {NONE} -- Externals

	gslist_to_eiffel (gslist: POINTER): ARRAYED_LIST [POINTER]
			-- Convert `gslist' to Eiffel structure.
		local
			cur: POINTER
		do
			create Result.make (10)
			from
				cur := gslist
			until
				cur.is_default_pointer
			loop
				Result.extend ({GTK}.gslist_struct_data (cur))
				cur := {GTK}.gslist_struct_next (cur)
			end
		ensure
		--	same_size: Result.count = g_slist_length (gslist)
		end

	glist_to_eiffel (gslist: POINTER): ARRAYED_LIST [POINTER]
			-- Convert `gslist' to Eiffel structure.
		local
			cur: POINTER
		do
			create Result.make (10)
			from
				cur := gslist
			until
				cur.is_default_pointer
			loop
				Result.extend ({GTK}.glist_struct_data (cur))
				cur := {GTK}.glist_struct_next (cur)
			end
		ensure
		--	same_size: Result.count = g_slist_length (gslist)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CONTAINER note option: stable attribute end;
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

end -- class EV_CONTAINER_IMP

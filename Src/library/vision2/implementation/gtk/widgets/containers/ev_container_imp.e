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
			destroy
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
			Result := c_object
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
				C.gtk_container_remove (container_widget, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				C.gtk_container_add (container_widget, w.c_object)
				on_new_item (v)
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
			l: LINKED_LIST [POINTER]
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
						C.gtk_radio_button_set_group (l.item, radio_group)
						set_radio_group (C.gtk_radio_button_group (l.item))
						C.gtk_toggle_button_set_active (l.item, False)
						l.forth
					end
					peer.set_shared_pointer (shared_pointer)
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
					C.gtk_radio_button_set_group (r.button_widget, radio_group)
				else
					C.gtk_toggle_button_set_active (r.button_widget, False)
				end
				set_radio_group (C.gtk_radio_button_group (r.button_widget))
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
				a_max_index := C.g_slist_length (radio_group) - 1
				a_item_index := C.g_slist_index (radio_group, r.button_widget)
				
				if a_max_index - a_item_index > 0 then
					a_item_pointer := C.g_slist_nth_data (
								radio_group,
								a_max_index
							)
				elseif a_max_index > 0 then
					a_item_pointer := C.g_slist_nth_data (
								radio_group,
								a_max_index - 1
							)
				end				
				
				C.gtk_radio_button_set_group (r.button_widget, NULL)

				if a_item_pointer /= NULL then
					an_item_imp ?= eif_object_from_c (
						C.gtk_widget_struct_parent (a_item_pointer)
						-- c_object for radio button is event box.
					)
					check an_item_imp_not_void: an_item_imp /= Void end
					set_radio_group (an_item_imp.radio_group)
				else
					set_radio_group (NULL)
				end

				if r.is_selected then
					if radio_group /= NULL then
						C.gtk_toggle_button_set_active (
							C.gslist_struct_data (radio_group),
							True
						)
					end
				else
					C.gtk_toggle_button_set_active (r.button_widget, True)
				end
			end
		end

	set_background_pixmap (pixmap: EV_PIXMAP) is
			-- Set the container background pixmap to `pixmap'.
		local
			pix_imp: EV_PIXMAP_IMP
		do
			pix_imp ?= pixmap.implementation

--|FIXME			C.c_gtk_container_set_bg_pixmap (container_widget, pix_imp.c_object)
--|FIXME			C.gtk_widget_show (pix_imp.c_object)

			background_pixmap := pixmap
		end
			-- FIXME NPC

feature -- Basic operations

	propagate_foreground_color is
			-- Propagate the current foreground color of the
			-- container to the children.
		do
			propagate_foreground_color_internal (foreground_color, c_object)
		end

	propagate_background_color is
			-- Propagate the current background color of the
			-- container to the children.
		do
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
			interface.wipe_out
			Precursor
		end

feature -- Event handling

	on_new_item (an_item: EV_WIDGET) is
			-- Called after `an_item' is added.
		do
			add_radio_button (an_item)
			if new_item_actions_internal /= Void then
				new_item_actions_internal.call ([an_item])
			end
		end

	on_removed_item (an_item: EV_WIDGET) is
			-- Called just before `an_item' is removed.
		do
			remove_radio_button (an_item)
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_CONTAINER_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
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
--| Revision 1.36  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.20.2.15  2001/05/18 18:15:14  king
--| Moved color propagation up
--|
--| Revision 1.20.2.14  2000/12/15 19:40:02  king
--| Changed .empty to .is_empty
--|
--| Revision 1.20.2.13  2000/10/27 16:54:41  manus
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
--| Revision 1.20.2.12  2000/09/18 18:06:42  oconnor
--| reimplemented propogate_[fore|back]ground_color for speeeeed
--|
--| Revision 1.20.2.11  2000/09/06 23:42:17  oconnor
--| added new_item_actions to ev_container
--|
--| Revision 1.20.2.10  2000/08/30 16:21:35  oconnor
--| Redefined destroy to remove children before destroying.
--|
--| Revision 1.20.2.9  2000/08/08 00:03:13  oconnor
--| Redefined set_default_colors to do nothing in EV_COLORIZABLE_IMP.
--|
--| Revision 1.20.2.8  2000/08/04 19:19:28  oconnor
--| Optimised radio button management by using a polymorphic call
--| instaed of using agents.
--|
--| Revision 1.20.2.7  2000/07/24 21:36:08  oconnor
--| inherit action sequences _IMP class
--|
--| Revision 1.20.2.6  2000/06/30 23:51:46  king
--| Corrected implemented remove_radio_button
--|
--| Revision 1.20.2.5  2000/06/15 19:05:45  king
--| Converted radio grouping to use button_widget instead of c_object radio button events
--|
--| Revision 1.20.2.4  2000/06/14 23:15:24  king
--| Removed event masking code
--|
--| Revision 1.20.2.3  2000/06/14 00:00:48  king
--| Corrected event handling with introduction of a container_widget
--|
--| Revision 1.20.2.2  2000/05/03 19:08:47  oconnor
--| mergred from HEAD
--|
--| Revision 1.35  2000/05/02 18:55:28  oconnor
--| Use NULL instread of Defualt_pointer in C code.
--| Use eiffel_to_c (a) instead of a.to_c.
--|
--| Revision 1.34  2000/04/26 17:04:50  oconnor
--| put GtkPixmap in an event box
--|
--| Revision 1.33  2000/04/21 18:07:05  king
--| Made client dimensions return widget dimensions
--|
--| Revision 1.32  2000/04/18 18:44:23  oconnor
--| removed reference to obsolete C external in set_bg_pixmap
--|
--| Revision 1.31  2000/04/06 01:55:00  brendel
--| Removed gs_list_to_eiffel.
--|
--| Revision 1.30  2000/03/15 01:19:40  brendel
--| Fixed bug in removal of radio button.
--|
--| Revision 1.29  2000/03/03 21:24:00  brendel
--| Fixed bug in connect_radio_groups. When implementation of `a_container' is
--| Void, target and argument of call are reversed, because on that class,
--| this feature had to be redefined anyway.
--|
--| Revision 1.28  2000/02/29 23:18:11  brendel
--| Fully implemented radio group merging by sharing the radio_group pointer
--| using POINTER_REF.
--|
--| Revision 1.27  2000/02/29 02:22:20  brendel
--| Finished first imp of radio group merging.
--|
--| Revision 1.26  2000/02/28 23:21:22  brendel
--| Started first imp of merging containers as radio groups.
--|
--| Revision 1.25  2000/02/26 02:20:04  brendel
--| Removed annoying put_string.
--|
--| Revision 1.24  2000/02/26 01:28:06  brendel
--| Implemented radio button add/remove functions.
--| Added new_item_actions and remove_item_actions.
--| Radio add/remove functions are added to the action sequences.
--|
--| Revision 1.23  2000/02/25 22:35:51  brendel
--| Revised already existent radio grouping features.
--|
--| Revision 1.22  2000/02/22 18:39:38  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.21  2000/02/14 11:40:31  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.20.2.1.2.14  2000/02/08 09:32:09  oconnor
--| replaced put with replace
--|
--| Revision 1.20.2.1.2.13  2000/02/04 04:25:37  oconnor
--| released
--|
--| Revision 1.20.2.1.2.12  2000/01/28 17:42:22  oconnor
--| removed obsolete features
--|
--| Revision 1.20.2.1.2.11  2000/01/27 19:29:42  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.20.2.1.2.10  2000/01/14 20:30:19  oconnor
--| added comments
--|
--| Revision 1.20.2.1.2.9  2000/01/14 20:22:25  oconnor
--| removed color propogation feature, now in _I
--|
--| Revision 1.20.2.1.2.8  1999/12/15 23:47:43  oconnor
--| improved safety of put
--|
--| Revision 1.20.2.1.2.7  1999/12/15 20:17:28  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.20.2.1.2.6  1999/12/15 17:38:46  oconnor
--| formatting
--|
--| Revision 1.20.2.1.2.5  1999/12/04 18:59:18  oconnor
--| moved externals into EV_C_EXTERNALS, accessed through EV_ANY_IMP.C
--|
--| Revision 1.20.2.1.2.4  1999/12/01 17:37:12  oconnor
--| migrating to new externals
--|
--| Revision 1.20.2.1.2.3  1999/12/01 01:02:33  brendel
--| Rearranged externals to GEL or EV_C_GTK. Modified some features that relied
--| on specific things like return value BOOLEAN instead of INTEGER.
--|
--| Revision 1.20.2.1.2.2  1999/11/30 23:15:47  oconnor
--| redefine interface to be of more refined type
--|
--| Revision 1.20.2.1.2.1  1999/11/24 17:29:53  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.19.2.4  1999/11/17 01:53:03  oconnor
--| removed "child packing" hacks and obsolete _ref _unref wrappers
--|
--| Revision 1.19.2.3  1999/11/09 16:53:15  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.19.2.2  1999/11/02 17:20:04  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

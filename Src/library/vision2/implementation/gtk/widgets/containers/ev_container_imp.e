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
			interface
		end

	EV_WIDGET_IMP
		redefine
			interface,
			initialize
		end

feature {NONE} -- Initialization

	initialize is
			-- Precusor and create new_item_actions.
		do
			Precursor
			create new_item_actions.make ("new_item", <<"widget">>)
			new_item_actions.extend (~add_radio_button)
			create remove_item_actions.make ("remove_item", <<"widget">>)
			remove_item_actions.extend (~remove_radio_button)
		end

feature -- Access
	
	client_width: INTEGER is
			-- Width of the client area of container.
			-- Redefined in children.
		do
			-- FIXME why does this return 0
			-- if it is indeed redefined by children it should be deffered.
			Result := 0
		end
	
	client_height: INTEGER is
			-- Height of the client area of container
			-- Redefined in children.
		do
			-- FIXME why does this return 0
			-- if it is indeed redefined by children it should be deffered.
			Result := 0
		end

	background_pixmap: EV_PIXMAP
			-- the background pixmap
	
feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			w: EV_WIDGET_IMP
		do
			if not interface.empty then
				remove_item_actions.call ([interface.item])
				w ?= interface.item.implementation
				C.gtk_container_remove (c_object, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				C.gtk_container_add (c_object, w.c_object)
				new_item_actions.call ([v])
			end
		end
	
feature {EV_RADIO_BUTTON_IMP, EV_CONTAINER_IMP} -- Access
	
	radio_group: POINTER
			-- GSList with all radio items of this container.

	radio_dummy: BOOLEAN
			-- Is this container merged with another?

	enable_radio_dummy is
			-- Make this container a dummy.
		require
			not_yet_a_dummy: not radio_dummy
		do
			radio_dummy := True
		ensure
			radio_dummy: radio_dummy
		end

feature -- Status setting

	gslist_to_eiffel (gslist: POINTER): LINKED_LIST [POINTER] is
			-- List of all radio items in the group `Current' is in.
		local
			cur: POINTER
		do
			create Result.make
			from
				cur := gslist
			until
				cur = Default_pointer
			loop
				Result.extend (C.gslist_struct_data (cur))
				cur := C.gslist_struct_next (cur)
			end
		ensure
			same_size: Result.count = C.g_slist_length (gslist)
		end

	connect_radio_grouping (a_container: EV_CONTAINER) is
			-- Join radio grouping of `a_container' to Current.
		local
			l: LINKED_LIST [POINTER]
			peer: EV_CONTAINER_IMP
			rbi: EV_RADIO_BUTTON_IMP
		do
			peer ?= a_container.implementation
			peer.enable_radio_dummy

			from
				l := gslist_to_eiffel (peer.radio_group)
				l.start
			until
				l.off
			loop
				C.gtk_radio_button_set_group (l.item, radio_group)
				radio_group := C.gtk_radio_button_group (l.item)
				C.gtk_toggle_button_set_active (l.item, False)
				l.forth
			end

			--| FIXME to be verified:
			peer.new_item_actions.prune (peer~add_radio_button)
			peer.new_item_actions.extend (~add_radio_button)
			peer.remove_item_actions.prune (peer~remove_radio_button)
			peer.remove_item_actions.extend (~remove_radio_button)
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
				if radio_group /= Default_pointer then
					C.gtk_radio_button_set_group (r.c_object, radio_group)
				else
					C.gtk_toggle_button_set_active (r.c_object, False)
				end
				radio_group := C.gtk_radio_button_group (r.c_object)
			end
		end

	remove_radio_button (w: EV_WIDGET) is
			-- Called every time a widget is removed from the container.
		require
			w_not_void: w /= Void
		local
			r: EV_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				radio_group := C.g_slist_remove (radio_group, r.c_object)
				if r.is_selected then
					if radio_group /= Default_pointer then
						C.gtk_toggle_button_set_active (C.gslist_struct_data (radio_group), True)
					end
				else
					C.gtk_toggle_button_set_active (r.c_object, True)
				end
			end
		end

	set_background_pixmap (pixmap: EV_PIXMAP) is
			-- Set the container background pixmap to `pixmap'.
		local
			pix_imp: EV_PIXMAP_IMP
		do
			pix_imp ?= pixmap.implementation

			C.c_gtk_container_set_bg_pixmap (c_object, pix_imp.c_object)
			C.gtk_widget_show (pix_imp.c_object)

			background_pixmap := pixmap
		end
			-- FIXME NPC

feature -- Event handling

	new_item_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed after an item is added.

	remove_item_actions: ACTION_SEQUENCE [TUPLE [EV_WIDGET]]
			-- Actions to be performed before an item is removed.

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

invariant
	new_item_actions_not_void: is_useable implies new_item_actions /= Void
	remove_item_actions_not_void: is_useable implies remove_item_actions /= Void

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

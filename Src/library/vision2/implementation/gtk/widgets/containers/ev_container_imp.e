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
			interface
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
	
feature {EV_RADIO_BUTTON_IMP} -- Access --| FIXME apparently not.
	
	radio_button_group: POINTER is
			-- Gtk radio button group for this container. 
			-- If no radio buttons are added inside this 
			-- container, return Default_pointer
		do
			if rbg_pointer = Void then
				Result := Default_pointer
			else
				Result := rbg_pointer
			end
		end
	
	set_rbg_pointer (new_rbg_pointer: POINTER) is
			-- FIXME What's this?
		do
			rbg_pointer := new_rbg_pointer
		end
	
feature -- Element change

	replace (v: like item) is
			-- Replace `item' with `v'.
		local
			w: EV_WIDGET_IMP
		do
			if not interface.empty then
				w ?= interface.item.implementation
				C.gtk_container_remove (c_object, w.c_object)
			end
			if v /= Void then
				w ?= v.implementation
				C.gtk_container_add (c_object, w.c_object)
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

feature {NONE} -- Implementation
	
	rbg_pointer: POINTER

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_CONTAINER_IMP

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

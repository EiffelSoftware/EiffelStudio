indexing
	description	: "Eiffel Vision container. Implementation interface."
	status		: "See notice at end of class"
	keywords	: "container"
	date		: "$Date$"
	revision	: "$Revision$"
	
deferred class
	EV_CONTAINER_I
	
inherit
	EV_WIDGET_I
		redefine
			interface
		end
	
	EV_CONTAINER_ACTION_SEQUENCES_I

feature -- Access

	item: EV_WIDGET is
			-- Current item.
		deferred
		end

	client_width: INTEGER is
			-- Width of the client area of container.
		deferred
		ensure
			positive: Result >= 0
		end
	
	client_height: INTEGER is
			-- Height of the client area of container.
		deferred
		ensure
			positive: Result >= 0
		end

feature -- Element change

	extend (v: like item) is
			-- Ensure that structure includes `v'.
		require
			v_not_void: v /= Void
		deferred
		end

	replace (v: like item) is
			-- Replace `item' with `v'.
		deferred
		end

feature -- Status setting

	connect_radio_grouping (a_container: EV_CONTAINER) is
			-- Join radio grouping of `a_container' to Current.
		require
			a_container_not_void: a_container /= Void
		deferred
		end

feature -- Basic operations
			
	propagate_foreground_color is
			-- Propagate the current foreground color of the
			-- container to the children.
		local
			l: LINEAR [EV_WIDGET]
			c: EV_CONTAINER
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			cur: CURSOR
			fg: EV_COLOR
		do
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
				fg := foreground_color
			until
				l.after
			loop
				l.item.set_foreground_color (fg)
				c ?= l.item
				if c /= Void then
					c.propagate_foreground_color
				end
				l.forth
			end
			if cs /= Void then
				cs.go_to (cur)
			end
		ensure
			foreground_color_propagated: interface.foreground_color_propagated
		end

	propagate_background_color is
			-- Propagate the current background color of the
			-- container to the children.
		local
			l: LINEAR [EV_WIDGET]
			c: EV_CONTAINER
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			cur: CURSOR
			bg: EV_COLOR
		do
			l := interface.linear_representation
			cs ?= l
			if cs /= Void then
				cur := cs.cursor
			end
			from
				l.start
				bg := background_color
			until
				l.after
			loop
				l.item.set_background_color (bg)
				c ?= l.item
				if c /= Void then
					c.propagate_background_color
				end
				l.forth
			end
			if cs /= Void then
				cs.go_to (cur)
			end
		ensure
			background_color_propagated: interface.background_color_propagated
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_CONTAINER

feature {NONE} -- Implementation

	Key_constants: EV_KEY_CONSTANTS is
		once
			create Result
		end

end -- class EV_CONTAINER_I

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

--|----------------------------------------------------------------
--| CVS log
--|----------------------------------------------------------------
--|
--| $Log$
--| Revision 1.15  2001/07/14 12:16:28  manus
--| Cosmetics, replace the long:
--| --|-----------------------------------------------------------------------------
--| by the short version which is standard among all ISE libraries
--| --|----------------------------------------------------------------
--|
--| Revision 1.14  2001/06/07 23:08:10  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.8.4.4  2000/09/18 18:13:15  oconnor
--| Optimized color propogation to grab the color once instead of many times.
--|
--| Revision 1.8.4.3  2000/09/06 23:42:18  oconnor
--| added new_item_actions to ev_container
--|
--| Revision 1.8.4.2  2000/09/04 18:19:15  oconnor
--| added cursor safety to iteration features
--|
--| Revision 1.8.4.1  2000/05/03 19:09:04  oconnor
--| mergred from HEAD
--|
--| Revision 1.13  2000/04/29 03:07:42  pichery
--| Cosmetics
--|
--| Revision 1.12  2000/02/28 23:19:42  brendel
--| Declared `connect_radio_groups' as deferred.
--|
--| Revision 1.11  2000/02/22 18:39:43  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.10  2000/02/16 23:38:47  king
--| Added connect_radio_grouping
--|
--| Revision 1.9  2000/02/14 11:40:37  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.8.6.13  2000/02/10 21:54:23  oconnor
--| removed precondition require v_not_void from replace, need to replace (Void) to remove internaly)
--|
--| Revision 1.8.6.12  2000/02/08 09:31:06  oconnor
--| added extend and replace deferred
--|
--| Revision 1.8.6.11  2000/02/04 04:09:08  oconnor
--| released
--|
--| Revision 1.8.6.10  2000/01/29 01:05:01  brendel
--| Tweaked inheritance clause.
--|
--| Revision 1.8.6.9  2000/01/28 17:43:06  oconnor
--| removed obsolete features
--|
--| Revision 1.8.6.8  2000/01/27 19:30:01  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.8.6.7  2000/01/18 00:03:32  brendel
--| Propogated -> propagated.
--|
--| Revision 1.8.6.6  2000/01/14 21:17:07  oconnor
--| formatting
--|
--| Revision 1.8.6.5  2000/01/14 20:22:43  oconnor
--| implemented color propogation features
--|
--| Revision 1.8.6.4  1999/12/17 18:37:30  rogers
--| Removed put. It has now been placed in EV_CELL_I.
--|
--| Revision 1.8.6.3  1999/12/15 17:38:46  oconnor
--| formatting
--|
--| Revision 1.8.6.2  1999/11/30 22:48:42  oconnor
--| Redefined interface to more refined type
--|
--| Revision 1.8.6.1  1999/11/24 17:30:09  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.8.2.5  1999/11/17 01:57:32  oconnor
--| obsoleted remove_child, added put
--|
--| Revision 1.8.2.4  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.8.2.3  1999/11/04 23:10:41  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.8.2.2  1999/11/02 17:20:06  oconnor
--| Added CVS log, redoing creation sequence
--|
--|----------------------------------------------------------------
--| End of CVS log
--|----------------------------------------------------------------

indexing
	description: 
		"Eiffel Vision container. Holds other widgets.%N%
		%Base class for all containers."
	status: "See notice at end of class"
	keywords: "container"
	date: "$Date$"
	revision: "$Revision$"

deferred class 
	EV_CONTAINER

inherit
	EV_WIDGET
		redefine
			implementation
		end

	BOX [EV_WIDGET]
		undefine
			default_create
		redefine
			changeable_comparison_criterion
		end

	COLLECTION [EV_WIDGET]
		rename
			extend as cl_extend,
			put as cl_put
		undefine
			default_create
		redefine
			changeable_comparison_criterion
		end

feature -- Access

	item: EV_WIDGET is
			-- Current item
		do
			Result := implementation.item
		ensure
			bridge_ok: Result = implementation.item
		end

	has_recursive (an_item: like item): BOOLEAN is
			-- Does structure include `an_item' or
			-- does any structure recursivly included by structure,
			-- include `an_item'.
		local
			l: LINEAR [EV_WIDGET]
			cs: CURSOR_STRUCTURE [EV_WIDGET]
			c: CURSOR
			ct: EV_CONTAINER
		do
			Result := has (an_item)
			l := linear_representation
			cs ?= l
			if cs /= Void then
				c := cs.cursor
			end
			from
				l.start
			until
				l.after or Result
			loop
				ct ?= l.item
				if l.item /= Void then
					Result := ct.has_recursive (an_item)
				end
				l.forth
			end
			if cs /= Void then
				cs.go_to (c)
			end
		end

feature -- Status setting

	merge_radio_button_groups (other: like Current) is
			-- Merge `Current' radio button group with that of `other'.
		require
			other_not_void: other /= Void
		do
			implementation.connect_radio_grouping (other)
		end

feature -- Status report

	writable: BOOLEAN is
			-- Is there a current item that may be modified?
		deferred
		end

feature -- Element change

	extend (v: like item) is
			-- Ensure that structure includes `v'.
		require
			extendible: extendible
			v_not_void: v /= Void
			not_has_v: not has (v)
			not_v_is_parent_recursive: not v.is_parent_recursive (Current)
		do
			implementation.extend (v)
		ensure
			has_v: has (v)
		end

	put, replace (v: like item) is
			-- Replace `item' with `v'.
		require
			writable: writable
			v_not_void: v /= Void
			not_has_v: not has (v)
			not_v_is_parent_recursive: not v.is_parent_recursive (Current)
		do
			implementation.replace (v)
		ensure
			has_v: has (v)
		end

feature -- Measurement

	client_width: INTEGER is
			-- Width of the area available to children in pixels. 
		require
		do
			Result := implementation.client_width
		ensure
			bridge_ok: Result = implementation.client_width
			positive: Result >= 0
		end
	
	client_height: INTEGER is
			-- Height of the area available to children in pixels. 
		require
		do
			Result := implementation.client_height
		ensure
			bridge_ok: Result = implementation.client_height
			positive: Result >= 0	
		end
		
feature -- Basic operations

	propagate_foreground_color is
			-- Propagate `foreground_color' to all children.
		do
			implementation.propagate_foreground_color
		ensure
			foreground_color_propagated: foreground_color_propagated
		end

	propagate_background_color is
			-- Propagate `background_color' to all children.
		do
			implementation.propagate_background_color
		ensure
			background_color_propagated: background_color_propagated
		end

feature -- Implementation

	changeable_comparison_criterion: BOOLEAN is False
			-- May `object_comparison' be changed?
			-- (Answer: no by default.)

	implementation: EV_CONTAINER_I
			-- Responsible for interaction with the underlying native graphics
			-- toolkit.

feature -- Contract support

	foreground_color_propagated: BOOLEAN is
			-- Do all children have same foreground color as `Current'?
		local
			l: LINEAR [EV_WIDGET]
			c: EV_CONTAINER
		do
			Result := True
			l := linear_representation
			from
				l.start
			until	
				l.after or not Result
			loop
				c ?= l.item
				if not foreground_color.is_equal (l.item.foreground_color) then
					Result := False
				elseif c /= Void and then not c.foreground_color_propagated then
					Result := False
				end
				l.forth
			end
		end

	background_color_propagated: BOOLEAN is
			-- Do all children have same background color as `Current'?
		local
			l: LINEAR [EV_WIDGET]
			c: EV_CONTAINER
		do
			Result := True
			l := linear_representation
			from
				l.start
			until	
				l.after or not Result
			loop
				c ?= l.item
				if not background_color.is_equal (l.item.background_color) then
					Result := False
				elseif c /= Void and then not c.background_color_propagated then
					Result := False
				end
				l.forth
			end
		end

feature -- Contract support

	all_radio_buttons_connected: BOOLEAN is
			-- Are all radio buttons in this container connected?
		local
			l: LINEAR [EV_WIDGET]
			peer: EV_RADIO_PEER
			peers: LINKED_LIST [EV_RADIO_PEER]
		do
			l := linear_representation
			from
				l.start
			until
				l.off or else not Result
			loop
				peer ?= item
				if peer /= Void then
					if peers = Void then
						peers := peer.peers
					else
						Result := peers.has (peer)
					end
				end
				l.forth
			end
			if peers = Void then
				Result := True
			end
		end

feature {NONE} -- Inapplicable

	cl_put (v: like item) is
			-- Replace `item' with `v'.
		do
			put (v)
		end

	cl_extend (v: like item) is
			-- Ensure that structure includes `v'.
		do
			extend (v)
		end

invariant
	all_radio_buttons_connected: all_radio_buttons_connected

end -- class EV_CONTAINER

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
--! Customer support include-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.18  2000/02/25 22:45:15  brendel
--| Fixed compiler errors in all_radio_buttons_connected.
--|
--| Revision 1.17  2000/02/25 22:34:51  brendel
--| Added invariant all_radio_buttons_connected.
--| No actions have been taken to satisfy it yet!
--|
--| Revision 1.16  2000/02/22 18:39:50  oconnor
--| updated copyright date and formatting
--|
--| Revision 1.15  2000/02/17 02:11:03  oconnor
--| re: meeting of thismorning, changed radio grouping name
--|
--| Revision 1.14  2000/02/16 23:38:52  king
--| Added connect_radio_grouping
--|
--| Revision 1.13  2000/02/14 11:40:51  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.12.6.12  2000/02/08 09:29:18  oconnor
--| added has_recursive
--| added deferred writable
--| added extend, put and replace with stronger preconditions
--|
--| Revision 1.12.6.11  2000/01/28 20:00:13  oconnor
--| released
--|
--| Revision 1.12.6.10  2000/01/27 19:30:51  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.12.6.9  2000/01/18 17:54:25  oconnor
--| removed useless ensure then
--|
--| Revision 1.12.6.8  2000/01/18 00:03:32  brendel
--| Propogated -> propagated.
--|
--| Revision 1.12.6.7  2000/01/14 20:25:51  oconnor
--| made propogation checks recursive
--|
--| Revision 1.12.6.6  2000/01/14 19:28:48  oconnor
--| added contract support features for color propogation
--|
--| Revision 1.12.6.5  1999/12/15 23:49:26  oconnor
--| removed inheritance of TRAVERSABLE
--|
--| Revision 1.12.6.4  1999/12/15 20:17:30  oconnor
--| reworking box formatting, contracts and names
--|
--| Revision 1.12.6.3  1999/12/15 17:38:46  oconnor
--| formatting
--|
--| Revision 1.12.6.2  1999/11/24 22:40:58  oconnor
--| added review notes
--|
--| Revision 1.12.6.1  1999/11/24 00:15:04  oconnor
--| merged from REVIEW_BRANCH_19991006, now inherits from base lib stuff
--|
--| Revision 1.12.2.6  1999/11/17 01:59:49  oconnor
--| moved single child stuff to EV_CELL
--|
--| Revision 1.12.2.5  1999/11/09 16:53:16  oconnor
--| reworking dead object cleanup
--|
--| Revision 1.12.2.4  1999/11/04 23:10:54  oconnor
--| updates for new color model, removed exists: not destroyed
--|
--| Revision 1.12.2.3  1999/11/02 17:20:12  oconnor
--| Added CVS log, redoing creation sequence
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------

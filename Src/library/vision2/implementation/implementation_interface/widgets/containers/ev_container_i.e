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
		
	EV_PIXMAPABLE_I
		rename
			set_pixmap as set_background_pixmap,
			remove_pixmap as remove_background_pixmap,
			pixmap as background_pixmap
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


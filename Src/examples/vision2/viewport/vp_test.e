indexing
	description: "Viewport example."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel", "brendel@eiffel.com"
	date: "$Date$"
	revision: "$Revision$"

class
	VP_TEST

inherit
	EV_APPLICATION

create
	make_and_launch

feature -- Initialization

	sb_x, sb_y: EV_SPIN_BUTTON
			-- Gauges that control offset of `vp'.

	vp: EV_VIEWPORT
			-- Example object.

	prepare is
			-- Pack `first_window'.
		local
			vb: EV_VERTICAL_BOX
			sa: EV_SCROLLABLE_AREA
			hb: EV_HORIZONTAL_BOX
		do
			create vb
			first_window.extend (vb)

			create hb
			hb.set_minimum_size (350, 20)
			hb.extend (create {EV_LABEL}.make_with_text ("EV_VIEWPORT"))
			create sb_x
			sb_x.change_actions.extend (agent on_sb_x_changed)
			hb.extend (create {EV_LABEL}.make_with_text ("x_offset:"))
			hb.extend (sb_x)
			create sb_y
			sb_y.change_actions.extend (agent on_sb_y_changed)
			hb.extend (create {EV_LABEL}.make_with_text ("y_offset:"))
			hb.extend (sb_y)
			vb.extend (hb)
			vb.disable_item_expand (vb.last)

			create vp.make_for_test
			vb.extend (vp)
			vb.extend (create {EV_LABEL}.make_with_text ("EV_SCROLLABLE_AREA"))
			vb.disable_item_expand (vb.last)
			create sa.make_for_test
			vb.extend (sa)
			first_window.resize_actions.extend (agent on_geometry)
		end

	on_geometry (x, y, w, h: INTEGER) is
			-- Window resized.
		do
			sb_x.set_value (0)
			sb_x.set_maximum ((vp.item_width - vp.client_width).max (0))
			sb_y.set_value (0)
			sb_y.set_maximum ((vp.item_height - vp.client_height).max (0))
		end

	on_sb_x_changed is
			-- Horizontal value changed.
		do
			vp.set_x_offset (sb_x.value)
		end

	on_sb_y_changed is
			-- Vertical value changed.
		do
			vp.set_y_offset (sb_y.value)
		end

	first_window: EV_TITLED_WINDOW is
			-- Window containing viewport and scrollable area.
		once
			create Result.make_with_title ("Viewport example")
		end

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


end -- class VP_TEST


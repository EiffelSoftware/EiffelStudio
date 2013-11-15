note
	description: "EiffelVision box. Cocoa implementation."
	author: "Daniel Furrer"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_BOX_IMP

inherit
	EV_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			client_width,
			client_height,
			set_background_color,
			make
		end

feature -- Initialization

	make
			-- Initialize `Current'
		do
			create box.make
			cocoa_view := box
			Precursor {EV_WIDGET_LIST_IMP}
			box.set_box_type ({NS_BOX}.box_custom)
			box.set_title_position ({NS_BOX}.no_title)
			box.set_border_type ({NS_BOX}.no_border)
			box.set_content_view_margins (0, 0)

			is_homogeneous := Default_homogeneous
			padding := Default_spacing
			border_width := Default_border_width

			set_is_initialized (True)
		end

feature -- Access

	client_width: INTEGER
			-- Width of the client area of `Current'.
		do
			Result := (box.content_view.frame.size.width.rounded - 2 * border_width).max (0)
		end

	client_height: INTEGER
			-- Height of the client area of `Current'.
		do
			Result := (box.content_view.frame.size.height.rounded  - 2 * border_width).max (0)
		end

	total_spacing: INTEGER
			-- Total spacing. One spacing between two consecutive children.
		do
			Result := padding * ((childvisible_nb - 1).max (0))
		end

	childvisible_nb: INTEGER
			-- Number of visible children.

	compute_childexpand_nb
			-- Compute number of visible children which are expanded
			-- and assign to `child_expand_number'.
		local
			i: INTEGER
		do
			from
				i := 1
				childexpand_nb := 0
			until
				i > ev_children.count
			loop
				if attached ev_children.i_th (i) as w then
					if w.is_show_requested and w.is_expandable then
						childexpand_nb := childexpand_nb + 1
					end
				end
				i := i + 1
			end
		end

	childexpand_nb: INTEGER
			-- Number of visible children which are expanded.

feature {EV_ANY, EV_ANY_I} -- expandable

	is_item_expanded (child: EV_WIDGET): BOOLEAN
			-- Is the `child' expandable. ie: does it
			-- allow the parent to resize or move it.
		do
			if attached {EV_WIDGET_IMP} child.implementation as w then
				Result := w.is_expandable
			end
		end

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN)
			-- Make `child' expandable if `flag',
			-- not expandable otherwise.
		do
			if attached {EV_WIDGET_IMP} child.implementation as w then
				w.set_expandable (flag)
				notify_change (Nc_minsize, Current)
			end
		end

feature {NONE} -- Basic operation

	rest (total_rest: INTEGER): INTEGER
				-- `Result' is rest we must add to the current child of
				-- `ev_children' when the size of the parent is not a
				-- multiple of the number of children.
				-- Dependent on `total_rest'.
		do
			if total_rest > 0 then
				Result := 1
			elseif total_rest < 0 then
				Result := -1
			else
				Result := 0
			end
		end

feature -- Access

	is_homogeneous: BOOLEAN
			-- Are all children restricted to be the same size?

	border_width: INTEGER
			-- Width of border around container in pixels.

	padding: INTEGER
			-- Space between children in pixels.	

feature {EV_ANY, EV_ANY_I} -- Status settings

	set_homogeneous (flag: BOOLEAN)
			-- Set whether every child is the same size.
		do
			is_homogeneous := flag
			notify_change (Nc_minheight, Current)
		end

	set_border_width (value: INTEGER)
			 -- Assign `value' to `border_width'.
		do
			border_width := value
			notify_change (Nc_minheight, Current)
		end

	set_padding (value: INTEGER)
			-- Assign `value' to `padding'.
		do
			padding := value
			notify_change (Nc_minheight, Current)
		end

feature -- Color

	set_background_color (a_color: EV_COLOR)
			-- Assign `a_color' to `background_color'
		local
			color: NS_COLOR
		do
			Precursor {EV_WIDGET_LIST_IMP} (a_color)
			create color.color_with_calibrated_red_green_blue_alpha (a_color.red, a_color.green, a_color.blue, (1.0).truncated_to_real)
			box.set_fill_color (color);
		end

feature {EV_ANY_I}

	box: NS_BOX
			-- Convenience function

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: detachable EV_BOX note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end -- class EV_BOX_IMP

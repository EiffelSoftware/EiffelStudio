note
	description: "[
		The Cell is similar to EV_GRID_LABEL_ITEM, except it has extra pixmaps on the right
		See description of EV_GRID_LABEL_ITEM for more details
	 	Implementation Interface.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM_I

inherit
	EV_GRID_LABEL_ITEM_I
		redefine
			interface,
			required_width,
			draw_additional
		end

create
	make

feature {EV_GRID_LABEL_ITEM} -- Status Report

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
		do
			Result := Precursor + pixmaps_on_right_width
		end

	pixmaps_on_right_width: INTEGER
		local
			i: INTEGER
			l_spacing: INTEGER
		do
			if attached pixmaps_on_right as pixs and then not pixs.is_empty then
				from
					i := pixs.lower
					if attached interface as l_interface then
						l_spacing := l_interface.spacing
					end
					Result := l_spacing
				until
					i > pixs.upper
				loop
					if attached pixs[i] as p then
						Result := Result + l_spacing + p.width
					end
					i := i + 1
				end
			end
		end

	pixmaps_on_right_height: INTEGER
		local
			i: INTEGER
		do
			if attached pixmaps_on_right as pixs and then not pixs.is_empty then
				from
					i := pixs.lower
				until
					i > pixs.upper
				loop
					if attached pixs[i] as p then
						Result := Result.max (p.height)
					end
					i := i + 1
				end
			end
		end

feature {EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM} -- Properties

	pixmaps_on_right: detachable ARRAY [detachable EV_PIXMAP]

feature {EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM} -- change

	set_pixmaps_on_right_count (c: INTEGER)
		do
			if attached pixmaps_on_right as l_pixmaps then
				l_pixmaps.conservative_resize_with_default (Void, 1, c)
			else
				create pixmaps_on_right.make_filled (Void, 1, c)
			end
		end

	put_pixmap_on_right (p: EV_PIXMAP; i: INTEGER)
		require
			pixmaps_on_right_not_void: attached pixmaps_on_right as l_pixmaps
			valid_index: l_pixmaps.valid_index (i)
		local
			l_pix: like pixmaps_on_right
		do
			l_pix := pixmaps_on_right
			check l_pix_attached: l_pix /= Void then end
			l_pix.put (p, i)
			if is_parented and not is_destroyed then
				redraw
			end
		end

feature {NONE} -- Implementation

	draw_additional (a_drawable: EV_DRAWABLE; a_layout: EV_GRID_LABEL_ITEM_LAYOUT; an_indent: INTEGER_32)
			-- Draw additional pixmaps on the right of label.
		local
			l_start_center_y, l_start_x: INTEGER
			l_spacing: INTEGER
			i: INTEGER
		do
			if
				attached interface as l_interface and
				attached pixmaps_on_right as pixs and then not pixs.is_empty
			then
				from
					l_spacing := l_interface.spacing
						-- By default we start displaying pixmaps after the end of the
						-- space allotted for `text'.
					l_start_x := a_layout.text_x + a_layout.available_text_width + l_spacing + an_indent
						-- We calculate the middle of the text.
					l_start_center_y := a_layout.text_y + internal_text_height // 2
					i := pixs.lower
				until
					i > pixs.upper
				loop
					if attached pixs[i] as p then
							-- All images are drawn relative to the middle of the text.
						a_drawable.draw_pixmap (l_start_x, l_start_center_y - (p.height // 2), p)
						l_start_x := l_start_x + p.width + l_spacing
					end
					i := i + 1
				end
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID_PIXMAPS_ON_RIGHT_LABEL_ITEM note option: stable attribute end
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

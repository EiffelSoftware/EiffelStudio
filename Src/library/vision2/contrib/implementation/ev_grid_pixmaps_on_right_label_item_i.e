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
			perform_redraw
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
			pixs: like pixmaps_on_right
			p: detachable EV_PIXMAP
			l_interface: like attached_interface
		do
			pixs := pixmaps_on_right
			if pixs /= Void and then not pixs.is_empty then
				from
					i := pixs.lower
					l_interface := attached_interface
				until
					i > pixs.upper
				loop
					p := pixs[i]
					if p /= Void then
						Result := Result + l_interface.spacing + p.width
					end
					i := i + 1
				end
			end
		end

	pixmaps_on_right_height: INTEGER
		local
			i: INTEGER
			pixs: like pixmaps_on_right
			p: detachable EV_PIXMAP
		do
			pixs := pixmaps_on_right
			if pixs /= Void and then not pixs.is_empty then
				from
					i := pixs.lower
				until
					i > pixs.upper
				loop
					p := pixs[i]
					if p /= Void then
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
			check l_pix_attached: l_pix /= Void end
			l_pix.put (p, i)
			if is_parented and not is_destroyed then
				redraw
			end
		end

feature {EV_GRID_DRAWER_I} -- Implementation

	perform_redraw (an_x, a_y, a_width, a_height, an_indent: INTEGER; drawable: EV_PIXMAP)
			-- Redraw `Current'.
		local
			l_interface: like interface
			back_color: EV_COLOR
			l_pixmap: detachable EV_PIXMAP
			pixmap_width: INTEGER
			pixmap_height: INTEGER
			left_border, right_border, top_border, bottom_border, spacing_used: INTEGER
			space_remaining_for_text, space_remaining_for_text_vertical: INTEGER
			text_offset_into_available_space, vertical_text_offset_into_available_space: INTEGER
			client_x, client_y, client_width, client_height: INTEGER
			text_x, text_y: INTEGER
			pixmap_x, pixmap_y: INTEGER
			l_pixmaps_on_right_width, l_pixmaps_on_right_height: INTEGER
			pixmaps_on_right_x, pixmaps_on_right_y: INTEGER
			selection_x, selection_y, selection_width, selection_height: INTEGER
			focused: BOOLEAN
			l_clip_width, l_clip_height: INTEGER
		do
			recompute_text_dimensions
				-- Update the dimensions of the text if required.

				-- Retrieve properties from interface
			l_interface := attached_interface
			focused := attached_parent_i.drawables_have_focus
			left_border := l_interface.left_border
			right_border := l_interface.right_border
			top_border := l_interface.top_border
			bottom_border := l_interface.bottom_border

				-- Retrieve properties from interface.
			l_pixmap := l_interface.pixmap

				-- Now calculate the area to be used for displaying the text and pixmap
				-- by subtracting the borders from the complete area.
			client_x := an_x + left_border
			client_y := a_y + top_border
			client_width := a_width - left_border - right_border
			client_height := a_height - top_border - bottom_border

			if l_pixmap /= Void then
				pixmap_width := l_pixmap.width
				pixmap_height := l_pixmap.height
				spacing_used := l_interface.spacing
			end
			l_pixmaps_on_right_width := pixmaps_on_right_width
			l_pixmaps_on_right_height := pixmaps_on_right_height

			space_remaining_for_text := client_width - pixmap_width - spacing_used - l_pixmaps_on_right_width
			space_remaining_for_text_vertical := client_height

				-- Note in the following text positioning calculations, we subtract 1 from
				-- the calculation as this accounts for the 0-based drawing positions.
			if l_interface.text /= Void and space_remaining_for_text > 0 then
				if l_interface.is_left_aligned then
					text_offset_into_available_space := 0
				elseif l_interface.is_right_aligned then
					text_offset_into_available_space := space_remaining_for_text - internal_text_width - 1
				else
					text_offset_into_available_space := space_remaining_for_text - internal_text_width - 1
					if text_offset_into_available_space /= 0 then
						text_offset_into_available_space := text_offset_into_available_space // 2
					end
				end
					-- Ensure that the text always respect the edge of the pixmap + the spacing in all alignment modes
					-- when the width of the column is not enough to display all of the contents
				text_offset_into_available_space := text_offset_into_available_space.max (0)

				if l_interface.is_top_aligned then
					vertical_text_offset_into_available_space := 0
				elseif l_interface.is_bottom_aligned then
					vertical_text_offset_into_available_space := space_remaining_for_text_vertical - internal_text_height - 1
				else
					vertical_text_offset_into_available_space := space_remaining_for_text_vertical - internal_text_height - 1
					if vertical_text_offset_into_available_space /= 0 then
						vertical_text_offset_into_available_space := vertical_text_offset_into_available_space // 2
					end
				end

					-- Ensure that the text always respects the top edge of the row in all alignment modes
					-- when the height of the row is not enough to display the text fully.
				vertical_text_offset_into_available_space := vertical_text_offset_into_available_space.max (0)
			end
			pixmap_x := left_border
			pixmap_y := top_border + (client_height - pixmap_height) // 2

			text_x := pixmap_x + pixmap_width + spacing_used + text_offset_into_available_space
			text_y := top_border + vertical_text_offset_into_available_space

			pixmaps_on_right_x := client_width - l_pixmaps_on_right_width - right_border
			pixmaps_on_right_y := top_border + (client_height - l_pixmaps_on_right_height) // 2

			if attached l_interface.layout_procedure as l_layout_procedure then
				grid_label_item_layout.set_pixmap_x (pixmap_x)
				grid_label_item_layout.set_pixmap_y (pixmap_y)
				grid_label_item_layout.set_text_x (text_x)
				grid_label_item_layout.set_text_y (text_y)
				grid_label_item_layout.set_grid_label_item (l_interface)
				grid_label_item_layout.set_has_text_pixmap_overlapping (True)
				l_layout_procedure.call ([l_interface, grid_label_item_layout])
				text_x := grid_label_item_layout.text_x
				text_y := grid_label_item_layout.text_y
				pixmap_x := grid_label_item_layout.pixmap_x
				pixmap_y := grid_label_item_layout.pixmap_y

				if pixmap_x > text_x and not grid_label_item_layout.has_text_pixmap_overlapping then
					space_remaining_for_text := pixmap_x - text_x
				else
					space_remaining_for_text := l_interface.width - text_x
				end
				space_remaining_for_text_vertical := l_interface.height - text_y
			end

			drawable.set_copy_mode
			back_color := displayed_background_color
			drawable.set_foreground_color (back_color)
			if is_selected then
				if focused then
					drawable.set_foreground_color (attached_parent_i.focused_selection_color)
				else
					drawable.set_foreground_color (attached_parent_i.non_focused_selection_color)
				end

					-- Calculate the area that must be selected in `Current'.
				if l_interface.is_full_select_enabled then
					selection_x := 0
					selection_width := a_width
					selection_y := 0
					selection_height := a_height
				else
					selection_x := text_x
					selection_width := text_width + 2
					selection_y := text_y
					selection_height := text_height
				end

				drawable.fill_rectangle (selection_x + an_indent, selection_y, selection_width, selection_height)
				if focused then
					drawable.set_foreground_color (attached_parent_i.focused_selection_text_color)
				else
					drawable.set_foreground_color (attached_parent_i.non_focused_selection_text_color)
				end
				drawable.set_copy_mode
			else
				drawable.set_foreground_color (displayed_foreground_color)
			end
				-- Now assign a clip area based on the borders of the item before we draw the text and the pixmap as they
				-- may be clipped based on the amount of space available to them based on the border settings.

			l_clip_width := attached_column_i.width - right_border
			l_clip_height := height - bottom_border

			if l_clip_width > 0 and then l_clip_height > 0 then
					-- Only draw if the clipping area is not empty
				internal_rectangle.move_and_resize (left_border, top_border, attached_column_i.width - right_border, height - bottom_border)
				drawable.set_clip_area (internal_rectangle)

				draw_pixmaps_on_right (drawable, 1 + pixmaps_on_right_x + an_indent, pixmaps_on_right_y, l_interface.spacing)

				if l_pixmap /= Void then
						-- Now blit the pixmap
					drawable.draw_pixmap (pixmap_x + an_indent, pixmap_y, l_pixmap)
				end

				if attached l_interface.font as l_font then
					drawable.set_font (l_font)
				else
					drawable.set_font (internal_default_font)
				end

				if l_interface.text /= Void and space_remaining_for_text > 0 and space_remaining_for_text < internal_text_width then
					drawable.draw_ellipsed_text_top_left (text_x + an_indent, text_y, l_interface.text, space_remaining_for_text)
				else
					drawable.draw_text_top_left (text_x + an_indent, text_y, l_interface.text)
				end
				drawable.remove_clip_area
				drawable.set_copy_mode
			end
		end

feature {NONE} -- Implementation

	draw_pixmaps_on_right (a_drawable: EV_DRAWABLE; a_start_x, a_start_y: INTEGER; a_spacing: INTEGER)
			-- Draw check box on `a_drawable'
		local
			l_start_x: INTEGER
			i: INTEGER
			pixs: like pixmaps_on_right
			p: detachable EV_PIXMAP
		do
			pixs := pixmaps_on_right
			if pixs /= Void and then not pixs.is_empty then
				from
					l_start_x := a_start_x
					i := pixs.lower
				until
					i > pixs.upper
				loop
					p := pixs[i]
					if p /= Void then
						a_drawable.draw_pixmap (l_start_x, a_start_y, p)
						l_start_x := l_start_x + p.width + a_spacing
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
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end

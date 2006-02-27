indexing
	description: "Cell consisting of only of a text label. Implementation Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_LABEL_ITEM_I

inherit
	EV_GRID_ITEM_I
		redefine
			interface,
			perform_redraw,
			initialize
		end

create
	make

feature {EV_ANY} -- Initialization

	initialize is
			-- Initialize `Current'.
		do
			must_recompute_text_dimensions := True
			Precursor {EV_GRID_ITEM_I}
		end

feature {EV_GRID_LABEL_ITEM} -- Status Report

	text_width: INTEGER is
			-- `Result' is width required to fully display `text' in `pixels'.
			-- This function is optimized internally by `Current' and is therefore
			-- faster than querying `font.string_size' directly.
		do
			recompute_text_dimensions
			Result := internal_text_width
		ensure
			result_non_negative: result >= 0
		end

	text_height: INTEGER is
			-- `Result' is height required to fully display `text' in `pixels'.
			-- This function is optimized internally by `Current' and is therefore
			-- faster than querying `font.string_size' directly.
		do
			recompute_text_dimensions
			Result := internal_text_height
		ensure
			result_non_negative: result >= 0
		end

feature {EV_GRID_LABEL_ITEM} -- Implementation

	string_size_changed is
			-- Respond to the changing of an `interface' property which
			-- affects the size of `text'
		do
			must_recompute_text_dimensions := True
		ensure
			must_recompute_text_dimensions: must_recompute_text_dimensions
		end

feature {EV_GRID_DRAWER_I} -- Implementation

	internal_default_font: EV_FONT is
			-- Default font used for `Current'.
		once
			create Result
		end

	internal_text_width: INTEGER
		-- Last computed width of `text' within `interface'.

	internal_text_height: INTEGER
		-- Last computed height of `text' within `interface'.

	must_recompute_text_dimensions: BOOLEAN
		-- Must the dimensions of `interface.text' be re-computed
		-- before drawing.

	recompute_text_dimensions is
			-- Recompute `internal_text_width' and `internal_text_height'.
		do
			if must_recompute_text_dimensions then
				if interface.font /= Void then
					parent_i.string_size (interface.text, interface.font, text_dimensions)
				else
					parent_i.string_size (interface.text, internal_default_font, text_dimensions)
				end
				internal_text_width := text_dimensions.integer_item (1)
				internal_text_height := text_dimensions.integer_item (2)
			end
			must_recompute_text_dimensions := False
		ensure
			dimensions_recomputed: must_recompute_text_dimensions = False
		end

	text_dimensions: TUPLE [INTEGER, INTEGER] is
			-- A once tuple for use within `recompute_text_dimensions' to
			-- prevent the need for always creating new tuples.
		once
			create Result
		ensure
			result_not_void: Result /= Void
		end

	perform_redraw (an_x, a_y, a_width, a_height, an_indent: INTEGER; drawable: EV_PIXMAP) is
			-- Redraw `Current'.
		local
			back_color: EV_COLOR
			l_pixmap: EV_PIXMAP
			pixmap_width: INTEGER
			pixmap_height: INTEGER
			left_border, right_border, top_border, bottom_border, spacing_used: INTEGER
			space_remaining_for_text, space_remaining_for_text_vertical: INTEGER
			text_offset_into_available_space, vertical_text_offset_into_available_space: INTEGER
			client_x, client_y, client_width, client_height: INTEGER
			text_x, text_y: INTEGER
			pixmap_x, pixmap_y: INTEGER
			selection_x, selection_y, selection_width, selection_height: INTEGER
			focused: BOOLEAN
			l_clip_width, l_clip_height: INTEGER
		do
			recompute_text_dimensions
				-- Update the dimensions of the text if required.

				-- Retrieve properties from interface
			focused := parent_i.drawables_have_focus
			left_border := interface.left_border
			right_border := interface.right_border
			top_border := interface.top_border
			bottom_border := interface.bottom_border

			if interface.layout_procedure /= Void then
				grid_label_item_layout.set_pixmap_x (0)
				grid_label_item_layout.set_pixmap_y (0)
				grid_label_item_layout.set_text_x (0)
				grid_label_item_layout.set_text_y (0)
				grid_label_item_layout.set_grid_label_item (interface)
				l_pixmap := interface.pixmap
				if l_pixmap /= Void then
					pixmap_width := l_pixmap.width
					pixmap_height := l_pixmap.height
				end
				interface.layout_procedure.call ([interface, grid_label_item_layout])
				text_x := grid_label_item_layout.text_x
				text_y := grid_label_item_layout.text_y
				pixmap_x := grid_label_item_layout.pixmap_x
				pixmap_y := grid_label_item_layout.pixmap_y

				space_remaining_for_text := grid_label_item_layout.grid_label_item.width - text_x
				space_remaining_for_text_vertical := grid_label_item_layout.grid_label_item.height - text_y
			else
					-- Retrieve properties from interface.
				l_pixmap := interface.pixmap
				spacing_used := interface.spacing

					-- Now calculate the area to be used for displaying the text and pixmap
					-- by subtracting the borders from the complete area.
				client_x := an_x + left_border
				client_y := a_y + top_border
				client_width := a_width - left_border - right_border
				client_height := a_height - top_border - bottom_border

				if l_pixmap /= Void then
					pixmap_width := l_pixmap.width
					pixmap_height := l_pixmap.height
				else
					spacing_used := 0
				end

				space_remaining_for_text := client_width - pixmap_width - spacing_used
				space_remaining_for_text_vertical := client_height

					-- Note in the following text positioning calculations, we subtract 1 from
					-- the calculation as this accounts for the 0-based drawing positions.
				if interface.text /= Void and space_remaining_for_text > 0 then
					if interface.is_left_aligned then
						text_offset_into_available_space := 0
					elseif interface.is_right_aligned then
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

					if interface.is_top_aligned then
						vertical_text_offset_into_available_space := 0
					elseif interface.is_bottom_aligned then
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
				text_x := left_border + pixmap_width + spacing_used + text_offset_into_available_space
				text_y := top_border + vertical_text_offset_into_available_space
				pixmap_x := left_border
				pixmap_y := top_border + (client_height - pixmap_height) // 2
			end

			drawable.set_copy_mode
			back_color := displayed_background_color
			drawable.set_foreground_color (back_color)
			if is_selected then
				if focused then
					drawable.set_foreground_color (parent_i.focused_selection_color)
				else
					drawable.set_foreground_color (parent_i.non_focused_selection_color)
				end

					-- Calculate the area that must be selected in `Current'.
				if interface.is_full_select_enabled then
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
					drawable.set_foreground_color (parent_i.focused_selection_text_color)
				else
					drawable.set_foreground_color (parent_i.non_focused_selection_text_color)
				end
				drawable.set_copy_mode
			else
				drawable.set_foreground_color (displayed_foreground_color)
			end
				-- Now assign a clip area based on the borders of the item before we draw the text and the pixmap as they
				-- may be clipped based on the amount of space available to them based on the border settings.

			l_clip_width := column_i.width - right_border
			l_clip_height := height - bottom_border

			if l_clip_width > 0 and then l_clip_height > 0 then
					-- Only draw if the clipping area is not empty
				internal_rectangle.move_and_resize (left_border, top_border, column_i.width - right_border, height - bottom_border)
				drawable.set_clip_area (internal_rectangle)
				if l_pixmap /= Void then
						-- Now blit the pixmap
					drawable.draw_pixmap (pixmap_x + an_indent, pixmap_y, l_pixmap)
				end

				if interface.font /= Void then
					drawable.set_font (interface.font)
				else
					drawable.set_font (internal_default_font)
				end

				if interface.text /= Void and space_remaining_for_text > 0 and space_remaining_for_text < internal_text_width then
					drawable.draw_ellipsed_text_top_left (text_x + an_indent, text_y, interface.text, space_remaining_for_text)
				else
					drawable.draw_text_top_left (text_x + an_indent, text_y, interface.text)
				end
				drawable.remove_clip_area
				drawable.set_copy_mode
			end
		end

	grid_label_item_layout: EV_GRID_LABEL_ITEM_LAYOUT is
			-- Once access to a layout structure used by `layout_procedure'.
		once
			create Result
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_GRID_LABEL_ITEM;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end


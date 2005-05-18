indexing
	description: "Cell consisting of only of a text label. Implementation Interface."
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
	
feature {NONE} -- Initialization

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
		local
			dimensions: TUPLE [INTEGER, INTEGER, INTEGER, INTEGER]
		do
			if must_recompute_text_dimensions then
				if interface.font /= Void then
					dimensions := interface.font.string_size (interface.text)
				else
					dimensions := internal_default_font.string_size (interface.text)
				end
				internal_text_width := dimensions.integer_item (1) - dimensions.integer_item (3) + dimensions.integer_item (4)
				internal_text_height := dimensions.integer_item (2)
			end
			must_recompute_text_dimensions := False
		ensure	
			dimensions_recomputed: must_recompute_text_dimensions = False
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
			content_left_edge, content_right_edge, content_top_edge, content_bottom_edge: INTEGER
			selection_x, selection_y, selection_width, selection_height: INTEGER
			focused: BOOLEAN
		do
			recompute_text_dimensions
				-- Update the dimensions of the text if required.

				-- Retrieve properties from interface
			focused := parent_i.drawable.has_focus
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
			drawable.fill_rectangle (an_indent, 0, a_width, a_height)
			if is_selected then
				if focused then
					drawable.set_foreground_color (parent_i.focused_selection_color)
				else
					drawable.set_foreground_color (parent_i.non_focused_selection_color)
				end
				fixme ("EV_GRID_LABEL_ITEM.perform_redraw - For now, perform no inversion of selection.")
--				drawable.set_and_mode

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
					
			if l_pixmap /= Void then
					-- Now blit the pixmap
				drawable.draw_pixmap (pixmap_x + an_indent, pixmap_y, l_pixmap)
			end

			if interface.font /= Void then
				drawable.set_font (interface.font)
			else
				drawable.set_font (internal_default_font)
			end

			if interface.text /= Void and space_remaining_for_text > 0 then
				drawable.draw_ellipsed_text_top_left (text_x + an_indent, text_y, interface.text, space_remaining_for_text)
			end

				-- Now handle the border clipping. We simply draw the border back over the top of the
				-- text and pixmap. First we calculate the area occupied by the contents and only perform
				-- the overdraw if it intersects with this.

			content_left_edge := text_x.min (pixmap_x)
			content_right_edge := (text_x + text_width + 2).max (pixmap_x + pixmap_width)
			content_top_edge := text_y.min (pixmap_y)
			content_bottom_edge := (text_y + text_height).max (pixmap_y + pixmap_height)

				-- First draw the border in the standard background color
			drawable.set_foreground_color (back_color)
			if bottom_border > a_height - content_bottom_edge then
				drawable.fill_rectangle (content_left_edge + an_indent, (a_height - bottom_border).max (content_top_edge), content_right_edge - content_left_edge, content_bottom_edge - ((a_height - bottom_border).max (content_top_edge)))
			end
			if top_border > content_top_edge then
				drawable.fill_rectangle (content_left_edge + an_indent, content_top_edge, content_right_edge - content_left_edge, top_border.min (content_bottom_edge) - content_top_edge)
			end
			if left_border > content_left_edge then
				drawable.fill_rectangle (content_left_edge + an_indent, content_top_edge, left_border.min (content_right_edge) - content_left_edge, content_bottom_edge - content_top_edge)
			end
			if right_border > a_width - content_right_edge then
				drawable.fill_rectangle ((a_width - right_border).max (content_left_edge) + an_indent, content_top_edge, content_right_edge - ((a_width - right_border).max (content_left_edge)), content_bottom_edge - content_top_edge)
			end
			if is_selected then
					-- Now, if `Current' is selected, highlight the border.
					-- We must take into account whether `interface.is_full_select_enabled' and only re-draw
					-- the correct area if so.

				if interface.is_full_select_enabled then
					
						-- If we are not in `full_select_mode', there is nothing to do here
						-- as the selection is clipped with the text. In `full_select_mode', the selection
						-- always occupies the complete client area of `Current' so we must draw it in.
					
					if focused then
						drawable.set_foreground_color (parent_i.focused_selection_color)
					else
						drawable.set_foreground_color (parent_i.non_focused_selection_color)
					end
					drawable.set_and_mode

					if bottom_border > a_height - content_bottom_edge then
						drawable.fill_rectangle (content_left_edge + an_indent, (a_height - bottom_border).max (content_top_edge), content_right_edge - content_left_edge, content_bottom_edge - ((a_height - bottom_border).max (content_top_edge)))
					end
					if top_border > content_top_edge then
						drawable.fill_rectangle (content_left_edge + an_indent, content_top_edge, content_right_edge - content_left_edge, top_border.min (content_bottom_edge) - content_top_edge)
					end
					if left_border > content_left_edge then
						drawable.fill_rectangle (content_left_edge + an_indent, content_top_edge, left_border.min (content_right_edge) - content_left_edge, content_bottom_edge - content_top_edge)
					end
					if right_border > a_width - content_right_edge then
						drawable.fill_rectangle ((a_width - right_border).max (content_left_edge) + an_indent, content_top_edge, content_right_edge - ((a_width - right_border).max (content_left_edge)), content_bottom_edge - content_top_edge)
					end
				end
			end
			drawable.set_copy_mode
		end

	grid_label_item_layout: EV_GRID_LABEL_ITEM_LAYOUT is
			-- Once access to a layout structure used by `layout_procedure'.
		once
			create Result
		end
		
feature {EV_ANY_I} -- Implementation

	interface: EV_GRID_LABEL_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

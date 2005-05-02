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
			redraw,
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

feature {EV_GRID_DRAWER_I} -- Implementation

	internal_default_font: EV_FONT is
			-- Default font used for `Current'.
		once
			create Result
		end

	internal_text_width: INTEGER

	internal_text_height: INTEGER

	must_recompute_text_dimensions: BOOLEAN
		-- Must the dimensions of `interface.text' be re-computed
		-- before drawing.

	recompute_text_dimensions is
			--
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
		
		
	redraw (an_x, a_y, a_width, a_height: INTEGER; drawable: EV_DRAWABLE) is
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
		do
			fixme ("Correctly handle selection colors and inversion")
			recompute_text_dimensions
				-- Update the dimensions of the text if required.

			if buffer_pixmap.width < a_width or buffer_pixmap.height < a_height then
				buffer_pixmap.set_size (a_width, a_height)
			end

				-- Retrieve properties from interface
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

			buffer_pixmap.set_copy_mode
			back_color := internal_background_color
			if back_color = Void then
				back_color := parent_i.background_color
			end
			buffer_pixmap.set_foreground_color (back_color)
			buffer_pixmap.fill_rectangle (0, 0, a_width, a_height)
			if is_selected then
				buffer_pixmap.set_foreground_color (parent_i.selection_color)
				buffer_pixmap.set_and_mode
				buffer_pixmap.fill_rectangle (0, 0, a_width, a_height)
				buffer_pixmap.set_foreground_color ((create {EV_STOCK_COLORS}).white)
				buffer_pixmap.set_copy_mode
			else
				buffer_pixmap.set_foreground_color (foreground_color)
			end
					
			if l_pixmap /= Void then
					-- Now blit the pixmap
				buffer_pixmap.draw_pixmap (pixmap_x, pixmap_y, l_pixmap)
			end

			if interface.font /= Void then
				buffer_pixmap.set_font (interface.font)
			else
				buffer_pixmap.set_font (internal_default_font)
			end

			if interface.text /= Void and space_remaining_for_text > 0 then
				buffer_pixmap.draw_ellipsed_text_top_left (text_x, text_y, interface.text, space_remaining_for_text)
			end

				-- Now handle the border clipping.

				-- First draw the border in the standard background color
			buffer_pixmap.set_foreground_color (back_color)
			if bottom_border > 0 then
				buffer_pixmap.fill_rectangle (0, a_height - bottom_border, a_width, a_height)
			end
			if top_border > 0 then
				buffer_pixmap.fill_rectangle (0, 0, a_width, top_border)
			end
			if left_border > 0 then
				buffer_pixmap.fill_rectangle (0, 0, left_border, a_height)
			end
			if right_border > 0 then
				buffer_pixmap.fill_rectangle (a_width - right_border, 0, a_width, a_height)
			end

			if is_selected then
					-- Now, if `Current' is selected, highlight the border.
				buffer_pixmap.set_foreground_color (parent_i.selection_color)
				buffer_pixmap.set_and_mode
				if bottom_border > 0 then
					buffer_pixmap.fill_rectangle (0, a_height - bottom_border, a_width, a_height)
				end
				if top_border > 0 then
					buffer_pixmap.fill_rectangle (0, 0, a_width, top_border)
				end
				if left_border > 0 then
					buffer_pixmap.fill_rectangle (0, 0, left_border, a_height)
				end
				if right_border > 0 then
					buffer_pixmap.fill_rectangle (a_width - right_border, 0, a_width, a_height)
				end	
			end

			drawable.draw_sub_pixmap (an_x, a_y, buffer_pixmap, create {EV_RECTANGLE}.make (0, 0, a_width, a_height))
		end

	buffer_pixmap: EV_PIXMAP is
			--
		once
			create Result
			Result.set_size (100, 16)
		end

	grid_label_item_layout: EV_GRID_LABEL_ITEM_LAYOUT is
			--
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

note
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
			make,
			required_width
		end

create
	make

feature {EV_ANY} -- Initialization

	make
			-- Initialize `Current'.
		do
			must_recompute_text_dimensions := True
			Precursor {EV_GRID_ITEM_I}
		end

feature {EV_GRID_LABEL_ITEM} -- Status Report

	required_width: INTEGER
			-- Width in pixels required to fully display contents, based
			-- on current settings.
		do
			if attached interface as l_interface then
				Result := l_interface.left_border + text_width + l_interface.right_border
				if attached l_interface.pixmap as l_pixmap then
					Result := Result + l_pixmap.width + l_interface.spacing
				end
			end
		end

	text_width: INTEGER
			-- `Result' is width required to fully display `text' in `pixels'.
			-- This function is optimized internally by `Current' and is therefore
			-- faster than querying `font.string_size' directly.
		do
			recompute_text_dimensions
			Result := internal_text_width
		ensure
			result_non_negative: Result >= 0
		end

	text_height: INTEGER
			-- `Result' is height required to fully display `text' in `pixels'.
			-- This function is optimized internally by `Current' and is therefore
			-- faster than querying `font.string_size' directly.
		do
			recompute_text_dimensions
			Result := internal_text_height
		ensure
			result_non_negative: Result >= 0
		end

feature {EV_GRID_LABEL_ITEM} -- Implementation

	string_size_changed
			-- Respond to the changing of an `interface' property which
			-- affects the size of `text'
		do
			must_recompute_text_dimensions := True
		ensure
			must_recompute_text_dimensions: must_recompute_text_dimensions
		end

feature {EV_GRID_DRAWER_I} -- Implementation

	internal_default_font: EV_FONT
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

	recompute_text_dimensions
			-- Recompute `internal_text_width' and `internal_text_height'.
		local
			l_text_dimensions: TUPLE [w: INTEGER; h: INTEGER]
			l_text: detachable STRING_32
			l_font: detachable EV_FONT
			l_empty: BOOLEAN
		do
			if must_recompute_text_dimensions then
				if attached interface as l_interface then
					l_text := l_interface.text
					if l_text.is_empty then
						l_empty := True
						l_text:= {STRING_32} " "
					end
					l_font := l_interface.font
					if l_font = Void then
						l_font := internal_default_font
					end
					if attached parent_i as l_parent_i then
						l_text_dimensions := text_dimensions
						l_parent_i.string_size (l_text, l_font, l_text_dimensions)
					else
							-- Item is not parented so we use the slower font implementation directly.
						l_text_dimensions := l_font.string_size (l_text)
					end
					if l_empty then
						internal_text_width := 0
					else
						internal_text_width := l_text_dimensions.w
					end
					internal_text_height := l_text_dimensions.h
				end
			end
			must_recompute_text_dimensions := False
		ensure
			dimensions_recomputed: must_recompute_text_dimensions = False
		end

	text_dimensions: TUPLE [INTEGER, INTEGER]
			-- A once tuple for use within `recompute_text_dimensions' to
			-- prevent the need for always creating new tuples.
		once
			Result := [0, 0]
		ensure
			result_not_void: Result /= Void
		end

	perform_redraw (an_x, a_y, a_width, a_height, an_indent: INTEGER; drawable: EV_PIXMAP)
			-- Redraw `Current'.
		local
			back_color: EV_COLOR
			l_pixmap: detachable EV_PIXMAP
			left_border, right_border, top_border, bottom_border: INTEGER
			text_x, text_y: INTEGER
			pixmap_x, pixmap_y: INTEGER
			selection_x, selection_y, selection_width, selection_height: INTEGER
			focused, activated: BOOLEAN
			l_clip_width, l_clip_height: INTEGER
			l_layout: EV_GRID_LABEL_ITEM_LAYOUT
		do
				-- Retrieve properties from interface
			check
				attached interface as l_interface and
				attached parent_i as l_parent_i and
				attached column_i as l_column_i
			then
				drawable.start_drawing_session
					-- Update the dimensions of the text if required.
				recompute_text_dimensions

				focused := l_parent_i.drawables_have_focus
				if l_parent_i.currently_active_item = l_interface and then attached l_parent_i.activate_window as l_act_window then
					activated := l_act_window.has_focus
				end

				l_layout := l_interface.computed_initial_grid_label_item_layout (a_width, a_height)
				if attached l_interface.layout_procedure as l_layout_procedure then
					l_layout_procedure.call ([l_interface, l_layout])
				end
				text_x := l_layout.text_x
				text_y := l_layout.text_y
				pixmap_x := l_layout.pixmap_x
				pixmap_y := l_layout.pixmap_y

				left_border := l_interface.left_border
				right_border := l_interface.right_border
				top_border := l_interface.top_border
				bottom_border := l_interface.bottom_border

					-- Retrieve properties from interface.
				l_pixmap := l_interface.pixmap

				drawable.set_copy_mode
				back_color := displayed_background_color
				drawable.set_foreground_color (back_color)
				if is_selected and then not activated then
					if focused then
						drawable.set_foreground_color (l_parent_i.focused_selection_color)
					else
						drawable.set_foreground_color (l_parent_i.non_focused_selection_color)
					end

						-- Calculate the area that must be selected in `Current'.
					if l_interface.is_full_select_enabled then
						selection_x := 0
						selection_width := a_width
						selection_y := 0
						selection_height := a_height
					else
						selection_x := text_x
						selection_width := internal_text_width + 2
						selection_y := text_y
						selection_height := internal_text_height
					end

					drawable.fill_rectangle (selection_x + an_indent, selection_y, selection_width, selection_height)
					if focused then
						drawable.set_foreground_color (l_parent_i.focused_selection_text_color)
					else
						drawable.set_foreground_color (l_parent_i.non_focused_selection_text_color)
					end
					drawable.set_copy_mode
				else
					drawable.set_foreground_color (displayed_foreground_color)
				end
					-- Now assign a clip area based on the borders of the item before we draw the text and the pixmap as they
					-- may be clipped based on the amount of space available to them based on the border settings.

				l_clip_width := l_column_i.width - right_border
				l_clip_height := height - bottom_border

				if l_clip_width > 0 and then l_clip_height > 0 then
						-- Only draw if the clipping area is not empty
					internal_rectangle.move_and_resize (left_border, top_border, l_column_i.width - right_border, height - bottom_border)
					drawable.set_clip_area (internal_rectangle)

					draw_additional (drawable, l_layout, an_indent)

					if l_pixmap /= Void then
							-- Now blit the pixmap
						drawable.draw_pixmap (pixmap_x + an_indent, pixmap_y, l_pixmap)
					end

					draw_text (l_interface.text, drawable, l_layout, an_indent)

					drawable.remove_clip_area
					drawable.set_copy_mode
				end

				drawable.end_drawing_session
			end
		end

	draw_additional (a_drawable: EV_DRAWABLE; a_layout: EV_GRID_LABEL_ITEM_LAYOUT; an_indent: INTEGER)
			-- Draw additional items if any to Current.
		do
		end

	draw_text (a_text: STRING_32; a_drawable: EV_DRAWABLE; a_layout: EV_GRID_LABEL_ITEM_LAYOUT; an_indent: INTEGER)
			-- Draw text to Current.
		do
			if attached interface as l_interface and then attached l_interface.font as l_font then
				a_drawable.set_font (l_font)
			else
				a_drawable.set_font (internal_default_font)
			end

			if a_layout.available_text_width < internal_text_width then
					-- Clipping width argument have to be at least 1 to have some effect.
				a_drawable.draw_ellipsed_text_top_left (a_layout.text_x + an_indent,
					a_layout.text_y, a_text, a_layout.available_text_width.max (1))
			else
				a_drawable.draw_text_top_left (a_layout.text_x + an_indent, a_layout.text_y, a_text)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_GRID_LABEL_ITEM note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end











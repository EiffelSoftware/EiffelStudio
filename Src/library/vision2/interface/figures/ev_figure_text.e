indexing
	description:
		"`text's in a `font' displayed on `point'."
	status: "See notice at end of class"
	keywords: "figure, text, string"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_TEXT

inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create,
			bounding_box
		end

	EV_FONT_CONSTANTS
		export
			{NONE} all
			{ANY} valid_family, valid_weight, valid_shape
		undefine
			default_create,
			out
		end

	EV_SINGLE_POINTED_FIGURE
		undefine
			default_create
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	default_create is
			-- Create in (0, 0)
		do
			create text.make (0)
			font := default_font
			is_default_font_used := True
			Precursor {EV_ATOMIC_FIGURE}
		end

	make_with_text (a_text: STRING) is
			-- Create with `a_text'.
		require
			a_text_not_void: a_text /= Void
		do
			default_create
			set_text (a_text)
		end

feature -- Access

	text: STRING
			-- Text that is displayed.

	font: EV_FONT
			-- Typeface `text' is displayed in.

feature -- Status report

	width: INTEGER
			-- Horizontal dimension.

	height: INTEGER
			-- Vertical dimension.

	is_default_font_used: BOOLEAN
			-- Is `Current' using a default font?

feature -- Status setting

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		require
			a_font_not_void: a_font /= Void
		do
			font := a_font
			is_default_font_used := False
			update_dimensions
			invalidate
		ensure
			font_assigned: font = a_font
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		require
			a_text_not_void: a_text /= Void
		do
			text := a_text
			update_dimensions
			invalidate
		ensure
			text_assigned: text = a_text
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is (`x', `y') on this figure?
		do
			update_dimensions
			Result := point_on_rectangle (x, y, point.x_abs, point.y_abs,
				point.x_abs + width, point.y_abs + height)
		end
		
feature {NONE} -- Implementation

	update_dimensions is
			-- Reassign `width' and `height'.
		local
			t: TUPLE [INTEGER, INTEGER]
		do
			t := font.string_size (text)
			width := t.integer_item (1)
			height := t.integer_item (2)
		end

	bounding_box: EV_RECTANGLE is
			-- Smallest orthogonal rectangle `Current' fits in.
		do
			update_dimensions
			create Result.make (point.x_abs, point.y_abs, width, height)
		end

	Default_font: EV_FONT is
			-- Font set by `default_create'.
		once
			create Result
		end

invariant
	text_exists: text /= Void
	font_exists: font /= Void

end -- class EV_FIGURE_TEXT

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


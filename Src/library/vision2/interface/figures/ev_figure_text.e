indexing
	description: "EiffelVision2 text figure. A text is defined by one point, its%
		% top-left corner, and by a text and font attribute."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FIGURE_TEXT


inherit
	EV_ATOMIC_FIGURE
		redefine
			default_create
		end

create
	default_create,
	make_with_point_and_text

feature -- Initialization

	default_create is
			-- Create in (0, 0)
		do
			Precursor
			text := ""
			create font
		end

	make_with_point_and_text (p: EV_RELATIVE_POINT; txt: STRING) is
			-- Create with `txt' on `p'.
		require
			p_exists: p /= Void
			p_not_in_figure: p.figure = Void
		do
			default_create
			set_point (p)
			set_text (txt)
		end

feature -- Access

	text: STRING
			-- The text that is displayed.

	font: EV_FONT
			-- The font the text is displayed in.

	point_count: INTEGER is
			-- A text-figure consists of only one point.
		once
			Result := 1
		end

	point: EV_RELATIVE_POINT is
			-- The position of this pixel or dot.
		do
			Result := get_point_by_index (1)
		end

feature -- Status report

	width: INTEGER is
			-- Calculate the width of the text with the specified font.
		do
			Result := font.string_width (text)
		ensure
			Result_assigned: Result = font.string_width (text)
		end

	height: INTEGER is
			-- Calculate the height of the text-figure by taking the height
			-- of the font.
		do
			Result := font.height
		ensure
			Result_assigned: Result = font.height
		end

feature -- Status setting

	set_point (pos: EV_RELATIVE_POINT) is
			-- Change the reference of `point' with `pos'.
		require
			pos_exists: pos /= Void
		do
			set_point_by_index (1, pos)
		ensure
			point_assigned: point = pos
		end

	set_font (fnt: EV_FONT) is
			-- Set the font to `fnt'.
		require
			fnt_exists: fnt /= Void
		do
			font := fnt
		ensure
			font_assigned: font = fnt
		end

	set_text (txt: STRING) is
			-- Set the text to `txt'.
		require
			txt_exists: txt /= Void
		do
			text := txt
		ensure
			text_assigned: text = txt
		end

feature -- Events

	position_on_figure (x, y: INTEGER): BOOLEAN is
			-- Is the point on (`x', `y') on this figure?
		do
			--| FIXME Rotation and scaling!
			Result := point_on_rectangle (x, y, point.x_abs, point.y_abs,
				point.x_abs + width, point.y_abs + height)
		end

invariant
	text_exists: text /= Void
	font_exists: font /= Void

end -- class EV_FIGURE_TEXT

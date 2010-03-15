note
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CARBON_DRAWING

feature -- Access

	internal_line: BOOLEAN
	internal_rectangle: BOOLEAN
	internal_draw_arc: BOOLEAN
	internal_elipse: BOOLEAN
	internal_text: BOOLEAN
	internal_dashed_line_style: BOOLEAN
	internal_filled: BOOLEAN

	internal_color: EV_COLOR
	internal_font: EV_FONT
	internal_string: C_STRING

	internal_x1, internal_x2, internal_y1, internal_y2: INTEGER
	internal_draw_width, internal_draw_height: INTEGER
	internal_start_angle, internal_aperture: REAL
	pix_to_draw: EV_PIXMAP_IMP

	internal_line_width: INTEGER


feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

set_rectangle (a_x, a_y, a_height, a_width, a_line: INTEGER; a_filled, a_dashed: BOOLEAN; a_col: EV_COLOR)
	do
		internal_rectangle := true
		internal_dashed_line_style := a_dashed
		internal_x1 := a_x
		internal_y1 := a_y

		internal_draw_width := a_width
		internal_draw_height := a_height

		internal_filled := a_filled

		internal_line_width := a_line
		internal_color := a_col

	end

set_line (a_x, a_y, a_x2, a_y2, a_line: INTEGER; a_filled, a_dashed: BOOLEAN; a_col: EV_COLOR)
	do
		internal_line := true
		internal_dashed_line_style := a_dashed

		internal_x1 := a_x
		internal_y1 := a_y

		internal_x2 := a_x2
		internal_y2 := a_y2

		internal_line_width := a_line

		internal_color := a_col

	end

set_elipse (a_x, a_y, a_height, a_width, a_line: INTEGER; a_filled, a_dashed: BOOLEAN; a_col: EV_COLOR)
	do
		internal_elipse := true
		internal_dashed_line_style := a_dashed

		internal_x1 := a_x
		internal_y1 := a_y

		internal_draw_height := a_height
		internal_draw_width := a_width

		internal_line_width := a_line

		internal_color := a_col

		internal_filled := a_filled

	end

set_text (a_x, a_y: INTEGER; a_filled: BOOLEAN; a_col: EV_COLOR; a_font: EV_FONT; an_angle: REAL; a_string: STRING_GENERAL)
	do
		internal_text := true

		internal_x1 := a_x
		internal_y1 := a_y


		internal_color := a_col

		internal_filled := a_filled

		internal_font := a_font
		internal_start_angle := an_angle
		create internal_string.make (a_string)
	end

set_pixmap (a_x, a_y: INTEGER; a_pix: EV_PIXMAP_IMP)
	do
		pix_to_draw := a_pix

		internal_x1 := a_x
		internal_y1 := a_y
	end


feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	invariant_clause: True -- Your invariant here

end

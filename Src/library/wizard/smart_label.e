indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SMART_LABEL

inherit
	EV_PIXMAP
		redefine
			initialize
		end
		
feature -- Initialization

	initialize is
			-- Initialization
		do
			Precursor
			resize_actions.extend (~on_resize)
			create our_font
			set_font (our_font)
		end

feature -- Process

	text: STRING
			-- Current displayed text

	set_text (s: STRING) is
		do
				-- Set the text
			text:= s
				
				-- Compute the coordinates of the text.
			recompute_align_text_coordinates

				-- Draw the text.
			draw_text (align_text_x, align_text_y, text)
		end

--	nice_style is
--		do
--			our_font.set_family (font_constants.ev_font_family_modern)
--			our_font.set_family (4)
--		end

	enable_bold is
		do
			our_font.set_weight (font_constants.ev_font_weight_bold)
			set_font (our_font)
		end

	disable_bold is
		do
			our_font.set_weight (font_constants.ev_font_weight_regular)
			set_font (our_font)
		end

	align_text_vertical_center is
		do
			vertical_center := TRUE
			recompute_align_text_coordinates
		end

	align_text_center is
		do
			alignment := Alignment_center
			recompute_align_text_coordinates
		end

	align_text_left is
		do
			alignment := Alignment_left
			recompute_align_text_coordinates
		end

	apply is
		do
			recompute_align_text_coordinates
		end

	our_font: EV_FONT
			-- Current font used to draw the text

feature {NONE} -- Implementation

	align_text_x: INTEGER
			-- x-coordinate of the first letter of the text.
	
	align_text_y: INTEGER
			-- y-coordinate of the first letter of the text.

	alignment: INTEGER
			-- current alignment (left, center, ...)
			-- See `Alignment_xxxx' for possible values

	recompute_align_text_coordinates is
			-- Recompute the coordinate of the text.
		local
			text_width: INTEGER
			text_height: INTEGER
		do
			inspect alignment
			when Alignment_left then
				align_text_x := 0
			when Alignment_center then
				if text /= Void then
					text_width := our_font.string_width (text)
				else
					text_width := 0
				end
				align_text_x := (width - text_width) // 2
			
			end
			if vertical_center then
				if text /= Void then
					text_height := our_font.height
				else
					text_height := 0
				end
				align_text_y := (height - text_height) // 2
			end
		end

feature {NONE} -- Vision2 event

	on_resize (a_x, a_y, a_width, a_height: INTEGER) is
			-- Resize action
		do
				-- resize the pixmap
			set_size (a_width.max(1), a_height.max(1))

				-- erase the content
			clear

				-- redraw the text
			if text /= Void then
				set_text (text)			
			end
		end

feature {NONE} -- Private constants

	Alignment_left: INTEGER is 0 -- Default
			-- Text is left aligned

	Alignment_center: INTEGER is 1
			-- Text is center aligned

	vertical_center: BOOLEAN
			-- Text is center aligned

	font_constants: EV_FONT_CONSTANTS is
		once
			create Result
		end

	

end -- class SMART_LABEL

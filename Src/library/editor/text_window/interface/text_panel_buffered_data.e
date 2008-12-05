indexing
	description: "[
					Buffered data for text panel instances. Used for userset properties on single text panel instance.
					 Differs from editor preferences that are for system wide editor property settings.
					]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PANEL_BUFFERED_DATA

inherit
	SHARED_EDITOR_DATA

feature -- Access

	fonts: SPECIAL [EV_FONT] assign set_fonts
			-- Fonts

	font_offset: INTEGER assign set_font_offset
			-- Font offset

	line_height: INTEGER assign set_line_height
			-- Line height

	font_width: INTEGER
			-- Fixed width of the first font in `fonts'.

	is_font_fixed: BOOLEAN
			-- Is the first font in `fonts' fixed.
		require
			is_font_fixed_set: is_font_fixed_set
		do
			Result := is_font_fixed_intenal
		end

feature -- Status report

	is_font_fixed_set: BOOLEAN
			-- Is `is_font_fixed' set?

feature {TEXT_PANEL} -- Settings

	set_fonts (a_fonts: like fonts)
			-- Set `fonts' with `a_fonts'.
		local
			l_font: EV_FONT
			i, upper: INTEGER
			l_width: INTEGER
			l_fixed, l_stop: BOOLEAN
		do
			fonts := a_fonts
			if a_fonts /= Void then
				l_font := a_fonts.item (editor_preferences.editor_font_id)
				if l_font /= Void then
					l_width := l_font.width
					from
						i := a_fonts.lower
					until
						i > upper and then l_stop
					loop
						l_font := a_fonts [i]
						if l_font /= Void then
							l_fixed := not l_font.is_proportional and not l_font.is_proportional and then l_width = l_font.width
							l_stop := not l_fixed
						end
						i := i + 1
					end
					if l_fixed then
						font_width := l_width
					else
						font_width := 0
					end
					is_font_fixed_intenal := l_fixed
					is_font_fixed_set := True
				else
					font_width := 0
					is_font_fixed_intenal := False
					is_font_fixed_set := False
				end
			else
				font_width := 0
				is_font_fixed_intenal := False
				is_font_fixed_set := False
			end
		ensure
			fonts_set: fonts = a_fonts
		end

	set_font_offset (a_offset: like font_offset)
			-- Set `font_offset' with `a_offset'.
		do
			font_offset := a_offset
		ensure
			font_offset = a_offset
		end

	set_line_height (a_height: like line_height)
			-- Set `height' with `a_height'.
		do
			line_height := a_height
		ensure
			line_height_set: line_height = a_height
		end

feature {NONE} -- Implementation

	is_font_fixed_intenal: like is_font_fixed
			-- Value of `is_font_fixed'

invariant
	font_width_positive_implies_is_font_fixed: font_width > 0 implies is_font_fixed

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

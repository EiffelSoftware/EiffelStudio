indexing
	description: "A part of topic-text with same attributes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"

class
	E_TEXT_PART

creation
	make_empty,
	make_from_other

feature -- Initialization

	make_empty is
			-- Create as standard text.
		do
		end

	make_from_other(other:E_TEXT_PART) is
			-- Copy.
		require
			not_void: other /= Void
		do
			text := other.text
			bold := other.bold
			italic := other.italic
			underline := other.underline
			font_name := other.font_name
			font_size := other.font_size
			font_color := other.font_color
			list_depth := other.list_depth
			line_break := other.line_break
			bullet := other.bullet
			hyperlink := other.hyperlink
			important := other.important
		end

feature -- Display

	display(area: E_TOPIC_DISPLAY) is
			-- Output marked-up text on 'area'.
		require
			area /= Void
		local
			cf: EV_CHARACTER_FORMAT
			font: EV_FONT
		do
			cf := area.text_format
			cf.set_bold(bold)
			cf.set_italic(italic)
		--	-- Underline is not supported by EV_RICH_TEXT.
		--	cf.set_underline(underline)

		--	if font_name /= Void or else font_size > 0 then
		--		font := cf.font
		--		if font_name /= Void then
		--			font.set_name(font_name)
		--		end
		--		if font_size > 0 then
		--			font.set_height(font_size)
		--		end
		--		cf.set_font(font)
		--	end
			if font_color /= Void then
				cf.set_color(font_color)
			end
			area.set_character_format(cf)
			if line_break then
				area.line_break(list_depth)
			end
			if bullet then
				area.bullet_list_item
			end
			if text /= Void and then not text.empty then
				if hyperlink /= Void then
					area.append_hyperlinked_text(text, hyperlink)
				else
					area.append_text(text)
				end
			end
			area.reset_text_format
		end

	get_character_format: EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result.set_bold(bold)
			Result.set_italic(italic)
		--	-- Underline is not supported by EV_RICH_TEXT.
		--	Result.set_underline(underline)

		--	if font_name /= Void or else font_size > 0 then
		--		font := Result.font
		--		if font_name /= Void then
		--			font.set_name(font_name)
		--		end
		--		if font_size > 0 then
		--			font.set_height(font_size)
		--		end
		--		Result.set_font(font)
		--	end
			if font_color /= Void then
				Result.set_color(font_color)
			end
		end

	needs_character_format: BOOLEAN is
		do
			Result := bold or else italic or else underline or else
				font_name /= Void or else font_size > 0 or else
				font_color /= Void
		end

feature -- Element change

	set_text(txt:STRING) is
		do
			text := txt
		end

	set_bold(b:BOOLEAN) is
		do
			bold := b
		end

	set_italic(b:BOOLEAN) is
		do
			italic := b
		end

	set_underline(b:BOOLEAN) is
		do
			underline := b
		end

	set_font_name(s: STRING) is
		do
			font_name := s
		end

	set_font_size(i: INTEGER) is
		do
			font_size := i
		end

	set_font_color(c: EV_COLOR) is
		do
			font_color := c
		end

	set_font_color_rgb(r,g,b:INTEGER) is
		do
			create font_color.make_rgb(r,g,b)
		end

	set_font_color_by_string(s:STRING) is
		do
			if s.is_equal("red") then
				create font_color.make_rgb(255,0,0)
			elseif s.is_equal("green") then
				create font_color.make_rgb(0,255,0)
			elseif s.is_equal("blue") then
				create font_color.make_rgb(0,0,255)
			elseif s.is_equal("magenta") then
				create font_color.make_rgb(255,0,255)
			elseif s.is_equal("cyan") then
				create font_color.make_rgb(0,255,255)
			elseif s.is_equal("white") then
				create font_color.make_rgb(255,255,255)
			elseif s.is_equal("link") then
				create font_color.make_rgb(0,255,0)
			else
				create font_color.make_rgb(0,0,0)
			end
		end

	set_list_depth(i:INTEGER) is
		do
			list_depth := i
		end

	set_line_break(b:BOOLEAN) is
		do
			line_break := b
		end

	set_bullet(b:BOOLEAN) is
		do
			bullet := b
		end

	set_hyperlink(s:STRING) is
		do
			hyperlink := s
		end

	set_important(b:BOOLEAN) is
		do
			important := b
		end

feature -- Access

	text: STRING
		-- Will soon be replaced by a reference.

	bold, italic, underline: BOOLEAN
		-- Basic attributes

	font_name: STRING
		-- Name of the font used. Void means use default.

	font_size: INTEGER
		-- Size of the font used. 0 means default.

	font_color: EV_COLOR
		-- Color of the text. Void means use default.

	list_depth: INTEGER
		-- Number of indents (tabs) before this text.

	line_break: BOOLEAN
		-- Put a line-break before this text?

	bullet: BOOLEAN
		-- Display a bullet? (list item)

	hyperlink: STRING
		-- Where is this text linked to? (Void if none)

	important: BOOLEAN
		-- Should this text-part be included in the search-index?
		-- Has no effect on display.

invariant
	valid_list_depth: list_depth >= 0
	valid_font_size: font_size >= 0
	hyperlink_not_empty: hyperlink /= Void implies not hyperlink.empty

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class E_TEXT_PART

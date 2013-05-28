note
	description: "Summary description for {CSS_STYLE}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=CSS reference", "protocol=URI", "src=http://www.w3schools.com/cssref/"

class
	CSS_STYLE

inherit
	ITERABLE [READABLE_STRING_8]

create
	make,
	make_with_string,
	make_with_items

convert
	make_with_string ({READABLE_STRING_8, STRING_8, IMMUTABLE_STRING_8})

feature {NONE} -- Initialization

	make
		do
			make_with_items (create {like items}.make (3))
		end

	make_with_string (s: READABLE_STRING_8)
		do
			make_with_items (s.split (';'))
		end

	make_with_items (lst: ITERABLE [READABLE_STRING_8])
		do
			create items.make (5)
			across
				lst as c
			loop
				if attached {IMMUTABLE_STRING_8} c.item as imm then
					items.force (imm)
				else
					items.force (create {IMMUTABLE_STRING_8}.make_from_string (c.item))
				end
			end
		end

	items: ARRAYED_LIST [IMMUTABLE_STRING_8]

feature -- Access

	count: INTEGER
			-- Count of style entities.

	new_cursor: ITERATION_CURSOR [READABLE_STRING_8]
		do
			Result := items.new_cursor
		end

feature -- Element change

	plus alias "+" (a_other: CSS_STYLE): like Current
			-- <Precursor>
		local
			lst: ARRAYED_LIST [READABLE_STRING_8]
		do
			create lst.make (count + a_other.count)
			lst.append (items)
			across
				a_other as c
			loop
				lst.force (c.item)
			end
			create Result.make_with_items (lst)
		end

	append (a_other: CSS_STYLE)
			-- Append style from `a_other' into Current
		do
			across
				a_other as c
			loop
				items.force (c.item)
			end
		end

feature -- Change

	put_key_value (k,v: READABLE_STRING_8)
		do
			items.force (k + ": " + v)
		end

feature -- Property: colors		

	put_color (v: READABLE_STRING_8)
		do
			put_key_value ("color", v)
		end

	put_background (v: READABLE_STRING_8)
			--| ex: #00ff00 url('smiley.gif') no-repeat fixed center;
		do
			put_key_value ("background", v)
		end

	put_background_color (v: READABLE_STRING_8)
		do
			put_key_value ("background-color", v)
		end

feature -- Property: fonts	

	put_font (v: READABLE_STRING_8)
		do
			put_key_value ("font", v)
		end

	put_font_family (v: READABLE_STRING_8)
		do
			put_key_value ("font-family", v)
		end

	put_font_size (v: READABLE_STRING_8)
		do
			put_key_value ("font-size", v)
		end

	put_font_style (v: READABLE_STRING_8)
		do
			put_key_value ("font-style", v)
		end

	put_font_weight (v: READABLE_STRING_8)
		do
			put_key_value ("font-weight", v)
		end

	put_font_bold
		do
			put_font_weight ("bold")
		end

	put_font_italic
		do
			put_font_style ("italic")
		end

	put_text_decoration (v: READABLE_STRING_8)
		do
			put_key_value ("text-decoration", v)
		end

	put_text_decoration_none
		do
			put_text_decoration ("none")
		end

	put_text_decoration_underline
		do
			put_text_decoration ("underline")
		end

	put_text_decoration_strike
		do
			put_text_decoration ("strike")
		end

	put_text_align (v: READABLE_STRING_8)
		do
			put_key_value ("text-align", v)
		end

	put_white_space (v: READABLE_STRING_8)
			--| normal 	Sequences of whitespace will collapse into a single whitespace. Text will wrap when necessary. This is default
			--| nowrap 	Sequences of whitespace will collapse into a single whitespace. Text will never wrap to the next line. The text continues on the same line until a <br /> tag is encountered
			--| pre 	Whitespace is preserved by the browser. Text will only wrap on line breaks Acts like the <pre> tag in HTML
			--| pre-line 	Sequences of whitespace will collapse into a single whitespace. Text will wrap when necessary, and on line breaks
			--| pre-wrap 	Whitespace is preserved by the browser. Text will wrap when necessary, and on line breaks
			--| inherit 	Specifies that the value of the white-space property should be inherited from the parent element			
		do
			put_key_value ("white-space", v)
		end

	put_white_space_nowrap
		do
			put_white_space ("nowrap")
		end

	put_white_space_pre
		do
			put_white_space ("pre")
		end


feature -- Property: margin		

	put_margin (a_top, a_right, a_bottom, a_left: detachable READABLE_STRING_8)
		local
			v: STRING
		do
			create v.make (10)
			if a_left /= Void then
				v.append (a_left)
			end
			if not v.is_empty then
				v.prepend_character (' ')
			end
			if a_bottom /= Void then
				v.prepend (a_bottom)
			else
				v.prepend_character ('0')
			end
			if not v.is_empty then
				v.prepend_character (' ')
			end
			if a_right /= Void then
				v.prepend (a_right)
			else
				v.prepend_character ('0')
			end
			if not v.is_empty then
				v.prepend_character (' ')
			end
			if a_top /= Void then
				v.prepend (a_top)
			else
				v.prepend_character ('0')
			end
			put_key_value ("margin", v)
		end

	put_margin_top (v: READABLE_STRING_8)
		do
			put_key_value ("margin-top", v)
		end

	put_margin_right (v: READABLE_STRING_8)
		do
			put_key_value ("margin-right", v)
		end

	put_margin_bottom (v: READABLE_STRING_8)
		do
			put_key_value ("margin-bottom", v)
		end

	put_margin_left (v: READABLE_STRING_8)
		do
			put_key_value ("margin-left", v)
		end

feature -- Property: padding		

	put_padding (a_top, a_right, a_bottom, a_left: detachable READABLE_STRING_8)
		local
			v: STRING
		do
			create v.make (10)
			if a_left /= Void then
				v.append (a_left)
			end
			if not v.is_empty then
				v.prepend_character (' ')
			end
			if a_bottom /= Void then
				v.prepend (a_bottom)
			else
				v.prepend_character ('0')
			end
			if not v.is_empty then
				v.prepend_character (' ')
			end
			if a_right /= Void then
				v.prepend (a_right)
			else
				v.prepend_character ('0')
			end
			if not v.is_empty then
				v.prepend_character (' ')
			end
			if a_top /= Void then
				v.prepend (a_top)
			else
				v.prepend_character ('0')
			end
			put_key_value ("padding", v)
		end

	put_padding_top (v: READABLE_STRING_8)
		do
			put_key_value ("padding-top", v)
		end

	put_padding_right (v: READABLE_STRING_8)
		do
			put_key_value ("padding-right", v)
		end

	put_padding_bottom (v: READABLE_STRING_8)
		do
			put_key_value ("padding-bottom", v)
		end

	put_padding_left (v: READABLE_STRING_8)
		do
			put_key_value ("padding-left", v)
		end

feature -- Properties: layout		

	put_width (v: READABLE_STRING_8)
		do
			put_key_value ("width", v)
		end

	put_height (v: READABLE_STRING_8)
		do
			put_key_value ("height", v)
		end

	put_z_index (v: READABLE_STRING_8)
		do
			put_key_value ("z-index", v)
		end

feature -- Property: border

	put_border (a_border: detachable READABLE_STRING_8; a_style: READABLE_STRING_8; a_size: READABLE_STRING_8; a_color: READABLE_STRING_8)
			-- "solid 1px color"
		require
			a_border /= Void implies (a_border.same_string ("top") or a_border.same_string ("right") or a_border.same_string ("bottom") or a_border.same_string ("left"))
		local
			k: STRING
		do
			k := "border"
			if a_border /= Void then
				k.append_character ('-')
				k.append (a_border)
			end
			put_key_value (k, a_style + " " + a_size + " " + a_color)
		end

	put_border_style (a_style: READABLE_STRING_8)
			-- "solid 1px color"
		do
			put_key_value ("border-style", a_style)
		end

	put_border_style_none (a_style: READABLE_STRING_8)
			-- "solid 1px color"
		do
			put_border_style ("none")
		end

feature -- Property: display		

	put_display (v: READABLE_STRING_8)
		do
			put_key_value ("display", v)
		end

	put_display_none
		do
			put_display ("none")
		end

	put_display_block
		do
			put_display ("block")
		end

	put_display_inline
		do
			put_display ("inline")
		end

	put_display_inline_block
		do
			put_display ("inline-block")
		end

	put_list_style (v: READABLE_STRING_8)
			--| ex: list-style:square url("sqpurple.gif");
		do
			put_key_value ("list-style", v)
		end

	put_list_style_type (v: READABLE_STRING_8)
			--circle 	The marker is a circle
			--decimal 	The marker is a number. This is default for <ol>
			--decimal-leading-zero 	The marker is a number with leading zeros (01, 02, 03, etc.)
			--disc 	The marker is a filled circle. This is default for <ul>
			--lower-alpha 	The marker is lower-alpha (a, b, c, d, e, etc.)
			--lower-greek 	The marker is lower-greek
			--lower-latin 	The marker is lower-latin (a, b, c, d, e, etc.)
			--lower-roman 	The marker is lower-roman (i, ii, iii, iv, v, etc.)
			--none 	No marker is shown
			--square 	The marker is a square
			--upper-alpha 	The marker is upper-alpha (A, B, C, D, E, etc.)
			--upper-latin 	The marker is upper-latin (A, B, C, D, E, etc.)
			--upper-roman 	The marker is upper-roman (I, II, III, IV, V, etc.)
		do
			put_key_value ("list-style-type", v)
		end

feature -- Property: float ...

	put_float (v: READABLE_STRING_8)
		do
			put_key_value ("float", v)
		end

	put_clear (v: READABLE_STRING_8)
		do
			put_key_value ("clear", v)
		end

feature -- Conversion

	append_inline_to (s: STRING_8)
		do
			append_to (s, False)
		end

	append_text_to (s: STRING_8)
		do
			append_to (s, True)
		end

	append_to (s: STRING_8; a_multiline: BOOLEAN)
		local
			n: INTEGER
		do
			n := 0
			across
				items as c
			loop
				if n > 0 then
					if a_multiline then
						s.append_character ('%N')
					else
						s.append_character (' ')
					end
				end
				s.append (c.item)
				s.append_character (';')
				n := n + 1
			end
		end

end

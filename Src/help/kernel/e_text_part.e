indexing
	description: "Part of topic-text with attributes"
	author: "Vincent Brendel"

class
	E_TEXT_PART

creation
	make,
	make_old

feature -- Initialization

	make(txt:STRING; cf:EV_CHARACTER_FORMAT) is
		do
			text := txt
			char_format := cf
		end

	make_old(new_text:STRING; attribs:LINKED_LIST[E_ATTRIBUTE]) is
			-- Initialize
		require
			new_text_not_void: new_text /= Void
			attribs_not_void: attribs /= Void
		do
			text := new_text
			from
				!! attributes.make
				attribs.start
			until
				attribs.after
			loop
				attributes.extend(attribs.item)
				attribs.forth
			end
		ensure
			text_set: text = new_text
			attributes_set: attributes.count = attribs.count
		end

	display(area: E_TOPIC_DISPLAY) is
			-- Output marked-up text on 'area'.
		local
			cf: EV_CHARACTER_FORMAT
			color: EV_COLOR
			tag: STRING
			link, recognized: BOOLEAN
			topic_id: STRING
		do
			cf := area.text_format
			cf.set_bold(bold)
			cf.set_italic(italic)
			--cf.set_underline(underline)
			if font_name /= Void then
				cf.font.set_name(font_name)
			end
			if font_size > 0 then
				cf.font.set_height(font_size)
			end
			if font_color /= Void then
				cf.set_color(font_size)
			end
			if line_break then
				area.line_break
				if list_depth > 0 then
					area.append_text("__")
				end
			end
			if bullet then
				area.append_text("> ")
			end
			if link /= Void then
				area.append_hyperlinked_text(text,link)
			end
			area.reset_text_format
		end

	set_list_depth(i:INTEGER) is
		do
			list_depth := i
		ensure
			list_depth = i
		end

	set_line_break(b:BOOLEAN) is
		do
			line_break := b
		ensure
			line_break = b
		end

	set_bullet(b:BOOLEAN) is
		do
			bullet := b
		ensure
			bullet = b
		end

	set_link(s:STRING) is
		do
			link := s
		ensure
			link = s
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

	link: STRING
		-- Where is this text linked to? (Void if none)

invariant
	valid_list_depth: list_depth >= 0
	valid_font_size: font_size >= 0
	link_not_empty: (link = Void) or else (not link.empty)

end -- class E_TEXT_PART

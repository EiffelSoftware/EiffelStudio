indexing
	description: "Display for help-topics"
	author: "Vincent Brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	E_TOPIC_DISPLAY

	-- Replace ANY below by the name of parent class if any (adding more parents
	-- if necessary); otherwise you can remove inheritance clause altogether.
inherit
	EV_RICH_TEXT
		rename
			make as make_rich
		end

creation
	make

feature -- Initialization

	make(par:EV_CONTAINER) is
			-- Initialize
		do
			make_rich(par)
--			set_editable(false)
			init_head_format
			create text_format.make
			reset_text_format
			create hyperlinks.make
		end

	init_head_format is
		local
			font: EV_FONT
			color: EV_COLOR
		do
			create head_format.make
			create font.make_by_name("Arial")
			font.set_height(16)
			create color.make_rgb(0,0,0)
			head_format.set_font(font)
			head_format.set_color(color)
			head_format.set_bold(true)
			head_format.set_italic(false)
		end

	reset_text_format is
		local
			font: EV_FONT
			color: EV_COLOR
		do
			create font.make_by_name("Times New Roman")
			font.set_height(12)
			text_format.set_font(font)
			text_format.set_bold(false)
			text_format.set_italic(false)
			create color.make_rgb(0,0,0)
			text_format.set_color(color)
		end

	set_head_format is
		do
			set_character_format(head_format)
		end

	deep_clone_text_format:EV_CHARACTER_FORMAT is
		do
			create Result.make
			Result := deep_clone(text_format)
		end

	append_hyperlinked_text(txt, link:STRING) is
		local
			new_link:E_TOPIC_LINK
			first: INTEGER
		do
			first := text_length
			append_text(txt)
			create new_link.make(first, text_length, link)
			hyperlinks.extend(new_link)
		end

	remove_all_hyperlinks is
		do
			hyperlinks.wipe_out
		end

	get_link_from_position(ax, ay: INTEGER): E_TOPIC_LINK is
		local
			charpos: INTEGER
			found: BOOLEAN
		do
			charpos := index_from_position(ax, ay)
			from
				hyperlinks.start
			until
				found or else hyperlinks.after
			loop
				if hyperlinks.item.is_in_region(charpos) then
					Result := hyperlinks.item
					found := true
				end
				hyperlinks.forth
			end
		end

	clear is
		do
			set_text("")
			remove_all_hyperlinks
		end

	bulleted_list is
			-- Insert margin (4 spaces).
		do
			append_text("    ")
		end

	bullet_list_item is
		do
			line_break
			append_text("> ")
		end

	line_break is
		do
			set_position(text_length+1)
			put_new_line
		end

	head_format: EV_CHARACTER_FORMAT

	text_format: EV_CHARACTER_FORMAT

	hyperlinks: LINKED_LIST[E_TOPIC_LINK]

invariant
	head_format_exists: head_format /= Void

end -- class E_TOPIC_DISPLAY

indexing
	description: "Display for help-topics. Based on EV_RICH_TEXT."
	author: "Vincent Brendel"

class
	E_TOPIC_DISPLAY

inherit
	EV_RICH_TEXT
		rename
			make as make_rich
		end

	FACILITIES

creation
	make

feature -- Initialization

	make(par:EV_CONTAINER; vw:VIEWER_WINDOW) is
			-- Initialize
		local
			com: EV_ROUTINE_COMMAND
		do
			make_rich(par)
			viewer := vw
			init_head_format
			create text_format.make
			reset_text_format
			create hyperlinks.make
			create com.make(~link_clicked)
			add_button_press_command(1, com, Void)
		end

	init_head_format is
			-- Initialize the font attributes for topic titles.
		local
			font: EV_FONT
			color: EV_COLOR
		do
			create head_format.make
			--create font.make_by_name("Arial")
			--font.set_height(16)
			create color.make_rgb(0,0,0)
			--head_format.set_font(font)
			head_format.set_color(color)
			head_format.set_bold(true)
			head_format.set_italic(false)
		end

feature -- Actions

	link_clicked(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Check if there is a link on this position.
		require
			link_clicked: data /= Void
		local
			md: EV_BUTTON_EVENT_DATA
			link: E_TOPIC_LINK
		do
			md ?= data
			link := get_link_from_position(md.x, md.y)
			if link /= Void then
				viewer.set_selected_topic_by_id(link.topic_id)
			end
		end

feature -- Status setting

	reset_text_format is
			-- Initialize the font attributes for the body of the text.
		local
			font: EV_FONT
			color: EV_COLOR
		do
			--create font.make_by_name("Times New Roman")
			--font.set_height(12)
			--text_format.set_font(font)
			text_format.set_bold(false)
			text_format.set_italic(false)
			create color.make_rgb(0,0,0)
			text_format.set_color(color)
		end

	append_hyperlinked_text(txt, link:STRING) is
			-- Append Hyperlink.
		require
			not_void: txt /= Void and link /= Void
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
			-- remove the hyperlinks.
		do
			hyperlinks.wipe_out
		end

feature -- Implementation

	get_link_from_position(ax, ay: INTEGER): E_TOPIC_LINK is
		require
			possible: ax >=0 and ay >=0
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

feature -- Display

	set_head_format is
			-- Set head format.
		do
			set_character_format(head_format)
		end

	clear is
		do
			set_text("")
			remove_all_hyperlinks
		end

	bullet_list_item is
		do
			append_text("· ")
		end

	line_break(indent:INTEGER) is
			-- Insert a Carriage Return.
		require
			possible: indent >=0
		local
			i: INTEGER
		do
			append_text ("%R%N")
			from
				i := indent
			until
				i <= 0
			loop
				append_text("    ")
				i := i - 1
			end
		end

feature -- Access

	head_format: EV_CHARACTER_FORMAT
			-- The character format used for displaying topic titles.

	text_format: EV_CHARACTER_FORMAT
			-- The character format for topic body text.

feature -- Implementation

	hyperlinks: LINKED_LIST[E_TOPIC_LINK]
			-- The list of all hyperlinks on the current page.

	viewer: VIEWER_WINDOW
			-- The main window.

invariant
	E_TOPIC_DISPLAY_not_void: hyperlinks /= Void and viewer /= Void and text_format /= Void and head_format /= VOid

end -- class E_TOPIC_DISPLAY

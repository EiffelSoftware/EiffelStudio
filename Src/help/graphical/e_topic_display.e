indexing
	description: "Display for help-topics. Based on EV_RICH_TEXT."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Vincent Brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	E_TOPIC_DISPLAY

inherit
	EV_RICH_TEXT
		rename
			make as make_rich
		end

	FACILITIES

create
	make

feature -- Initialization

	make (par: EV_CONTAINER) is
			-- Initialize.
		local
			com: EV_ROUTINE_COMMAND
		do
			make_rich(par)
			init_head_format
			create text_format.make
			reset_text_format
			create hyperlinks.make
			create com.make(agent link_clicked)
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
			--create color.make_rgb(0,0,0)
			--head_format.set_font(font)
			--head_format.set_color(color)
			head_format.set_bold(true)
			--head_format.set_italic(false)
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
				main_window.set_selected_topic_by_id(link.topic_id)
			end
		end

feature -- Status setting

	reset_text_format is
			-- Reset the font attributes for the body of the text.
		local
			font: EV_FONT
			color: EV_COLOR
		do
			--create font.make_by_name("Times New Roman")
			--font.set_height(12)
			--text_format.set_font(font)
			--text_format.set_bold(false)
			--text_format.set_italic(false)
			--create color.make_rgb(0,0,0)
			--text_format.set_color(color)
		end

	add_hyperlink (first, last: INTEGER; link: STRING) is
			-- Set a new hyperlink.
		require
			valid_first: first >= 0
			valid_last: last >= first
			link_exists: link /= Void
		local
			new_link:E_TOPIC_LINK
		do
			create new_link.make (first, last, link)
			hyperlinks.extend (new_link)
		end

	remove_all_hyperlinks is
			-- Remove the hyperlinks.
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

	get_bullet_list_item_str: STRING is
		do
			Result := "- "
		end

	get_line_break_str (indent: INTEGER): STRING is
			-- Get string with line-break and spaces.
		require
			valid_indent: indent >= 0
		local
			i: INTEGER
		do
			Result := "%R%N"
			from
				i := indent
			until
				i <= 0
			loop
				Result.append ("    ")
				i := i - 1
			end
		end

	display_topic (topic: E_TOPIC) is
			-- Displays a topic using a buffer.
			-- Try to make this a bit faster please.
		require
			topic_exists: topic /= Void
		local
			buffer: STRING
			etext: E_TEXT
			part: E_TEXT_PART
			attribs: LINKED_LIST [RICH_TEXT_ATTR]
			tmp_attr: RICH_TEXT_ATTR
			sp, ep: INTEGER
			cf: EV_CHARACTER_FORMAT
			counter: INTEGER
		do
			-- Reset character
			create cf.make
			set_character_format (cf)

			-- Init
			create buffer.make (0)
			create attribs.make
			remove_all_hyperlinks

			-- Display head
			create tmp_attr.make (1, topic.head.count)
			tmp_attr.set_format (head_format)
			attribs.extend (tmp_attr)
			buffer.append (topic.head + "%R%N%R%N")

			if topic.contains_text then
				from
					topic.paragraphs.start
				until
					topic.paragraphs.after
				loop
					from
						etext := topic.paragraphs.item
						etext.text_parts.start
					until
						etext.text_parts.after
					loop
						part := etext.text_parts.item
						sp := buffer.count
						buffer.append (part.text)
						ep := buffer.count

						if part.needs_character_format then
							create tmp_attr.make (sp + 1, ep)
							tmp_attr.set_format (part.get_character_format)
							attribs.extend (tmp_attr)
						end

						if part.line_break then
							buffer.append (get_line_break_str (part.list_depth))
						end
						if part.bullet then
							buffer.append (get_bullet_list_item_str)
						end
						if part.hyperlink /= Void then
							add_hyperlink (sp, ep, part.hyperlink)
						end

						etext.text_parts.forth
					end
					topic.paragraphs.forth
					buffer.append ("%R%N")
				end
			elseif topic.contains_subtopics then
				from
					topic.subtopics.start
					counter := 1
				until
					topic.subtopics.after
				loop
					buffer.append ("  " + counter.out + ": ")
					counter := counter + 1

					sp := buffer.count
					buffer.append (topic.subtopics.item.head)
					ep := buffer.count

					--create tmp_attr.make (sp + 1, ep)
					--tmp_attr.set_format (cf)
					--attribs.extend (tmp_attr)
					buffer.append ("%R%N")

					add_hyperlink (sp + 1, ep, topic.subtopics.item.id)

					topic.subtopics.forth
				end
			end
			set_text (buffer)
			from
				attribs.start
			until
				attribs.after
			loop
				attribs.item.apply (Current)
				attribs.forth
			end
		end

feature -- Not used

--! These features are not used anymore. The display speed was too slow.

	append_hyperlinked_text(txt, link:STRING) is
			-- Append Hyperlink.
		require
			not_void: txt /= Void and link /= Void
		local
			first: INTEGER
		do
			first := text_length
			append_text(txt)
			add_hyperlink (first, text_length, link)

		end

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
			append_text(get_bullet_list_item_str)
		end

	line_break(indent:INTEGER) is
			-- Insert a Carriage Return.
		require
			possible: indent >=0

		do
			append_text (get_line_break_str (indent))
		end

feature -- Access

	head_format: EV_CHARACTER_FORMAT
			-- The character format used for displaying topic titles.

	text_format: EV_CHARACTER_FORMAT
			-- The character format for topic body text.

feature -- Implementation

	hyperlinks: LINKED_LIST [E_TOPIC_LINK]
			-- The list of all hyperlinks on the current page.

invariant
	E_TOPIC_DISPLAY_not_void: hyperlinks /= Void and text_format /= Void and head_format /= VOid

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
end -- class E_TOPIC_DISPLAY

note
	description: "[
			Convert a FEED to STRING_32 representation. 
			Mostly for debug output!
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_TO_STRING_32_DEBUG_VISITOR

inherit
	FEED_VISITOR

create
	make

feature {NONE} -- Initialization

	make (a_buffer: STRING_32)
		do
			buffer := a_buffer
			create indentation.make_empty
		end

	buffer: STRING_32

feature -- Visitor

	visit_feed (a_feed: FEED)
		do
			if attached a_feed.id as l_id then
				append_text ("#")
				append (l_id)
				append_new_line
			end
			if attached a_feed.date as dt then
				append_text ("date:")
				append (dt.out)
				append_new_line
			end

			append_text (a_feed.title)
			append_new_line
			indent
			if attached a_feed.description as l_desc then
				append_text (l_desc)
				append_new_line
			end

			across
				a_feed.links as ic
			loop
				ic.item.accept (Current)
				append_new_line
			end

			append_new_line

			across
				a_feed.items as ic
			loop
				exdent
				append_text (create {STRING_32}.make_filled ('-', 40))
				append_new_line
				indent
				ic.item.accept (Current)
				append_new_line
			end
		end

	visit_item (a_entry: FEED_ITEM)
		do
			if attached a_entry.id as l_id then
				append_text ("#")
				append (l_id)
				append_new_line
			end
			if attached a_entry.date as dt then
				append_text ("date:")
				append (dt.out)
				append_new_line
			end
			append_text (a_entry.title)
			append_new_line
			indent
			if attached a_entry.author as l_author then
				l_author.accept (Current)
				append_new_line
			end
			if attached a_entry.categories as cats then
				append_text ("Categories: ")
				from
					cats.start
				until
					cats.after
				loop
					if not cats.isfirst then
						append (", ")
					end
					append (cats.item)
					cats.forth
				end
				append_new_line
			end
			if attached a_entry.description as l_summary then
				append_text (l_summary)
				append_new_line
			end

			across
				a_entry.links as ic
			loop
				ic.item.accept (Current)
				append_new_line
			end

			if attached a_entry.content as l_content then
				append_text (l_content)
				append_new_line
			end
			exdent
		end

	visit_link (a_link: FEED_LINK)
		local
			s: STRING_32
		do
			create s.make_empty
			s.append_string_general ("@")
			s.append_string (a_link.relation)
			s.append_string (" -> ")
			s.append_string_general (a_link.href)
			append_text (s)
		end

	visit_author (a_author: FEED_AUTHOR)
		local
			s: STRING_32
		do
			create s.make_empty
			s.append_string_general ("by ")
			s.append_string (a_author.name)
			if attached a_author.email as l_email then
				s.append_character (' ')
				s.append_character ('(')
				s.append_string_general (l_email)
				s.append_character (')')
			end
			append_text (s)
		end

feature -- Helper

	indentation: STRING_32

	indent
		do
			indentation.append ("  ")
		end

	exdent
		do
			indentation.remove_tail (2)
		end

	append_new_line
		do
			append ("%N")
		end

	append_text (s: READABLE_STRING_GENERAL)
		local
			lst: LIST [READABLE_STRING_GENERAL]
		do
			if indentation.is_empty then
				append (s)
			else
				lst := s.split ('%N')
				from
					lst.start
				until
					lst.after
				loop
					append (indentation)
					append (lst.item)
					if not lst.islast then
						append ("%N")
					end
					lst.forth
				end
			end
		end

	append (s: READABLE_STRING_GENERAL)
		do
			buffer.append_string_general (s)
		end

end

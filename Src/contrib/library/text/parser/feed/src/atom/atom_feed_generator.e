note
	description: "Convert a FEED into an ATOM content."
	date: "$Date$"
	revision: "$Revision$"

class
	ATOM_FEED_GENERATOR

inherit
	FEED_VISITOR

	FEED_GENERATOR
		rename
			process_feed as visit_feed
		end

create
	make

feature -- Visitor

	visit_feed (a_feed: FEED)
		do
			buffer.append ("[
					<?xml version="1.0" encoding="utf-8"?>
					<feed xmlns="http://www.w3.org/2005/Atom">
				]")
			buffer.append_character ('%N')
			indent
			append_content_tag_to ("title", Void, a_feed.title, buffer)
			append_content_tag_to ("subtitle", Void, a_feed.description, buffer)
			if attached a_feed.id as l_id then
				append_content_tag_to ("id", Void, l_id, buffer)
			else
				append_content_tag_to ("id", Void, "urn:uuid:" + new_uuid, buffer)
			end

			across
				a_feed.links as tb
			loop
				tb.item.accept (Current)
			end
			if attached a_feed.date as dt then
				append_content_tag_to ("updated", Void, date_to_string (dt), buffer)
			end
			across
				a_feed.items as ic
			loop
				ic.item.accept (Current)
			end

			exdent
			buffer.append ("</feed>")
		end

	visit_item (a_entry: FEED_ITEM)
		do
			buffer.append (indentation)
			buffer.append ("<entry>%N")
			indent
			append_content_tag_to ("title", Void, a_entry.title, buffer)
			across
				a_entry.links as tb
			loop
				tb.item.accept (Current)
			end
			if attached a_entry.id as l_id then
				append_content_tag_to ("id", Void, l_id, buffer)
			else
				append_content_tag_to ("id", Void, "urn:uuid:" + new_uuid, buffer)
			end
			if attached a_entry.date as dt then
				append_content_tag_to ("updated", Void, date_to_string (dt), buffer)
			end

			append_content_tag_to ("summary", Void, a_entry.description, buffer)
			if attached a_entry.content as l_content then
				if attached a_entry.content_type_or_default ("xhtml").is_case_insensitive_equal_general ("xhtml") then
--					if l_content.has_substring ("<div xmlns=%"http://www.w3.org/1999/xhtml%">") then
						append_content_tag_to ("content", <<["type", "xhtml"]>>, l_content, buffer)
--					else
--						append_content_tag_to ("content", <<["type", "xhtml"]>>, {STRING_32} "<div xmlns=%"http://www.w3.org/1999/xhtml%">" + l_content + {STRING_32} "</div>", buffer)
--					end
				else
					append_content_tag_to ("content", <<["type", a_entry.content_type]>>, a_entry.content, buffer)
				end
			end

			if attached a_entry.author as u then
				u.accept (Current)
			end
			exdent
			buffer.append (indentation)
			buffer.append ("</entry>%N")
		end

	visit_link (a_link: FEED_LINK)
		local
			attr: detachable ARRAYED_LIST [TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_32]]
			tu: TUPLE [name: READABLE_STRING_8; value: READABLE_STRING_32]
		do
			create attr.make (2)
			if attached a_link.relation as rel and then not rel.is_whitespace then
				tu := ["rel", rel]
				attr.force (tu)
			end
			if attached a_link.type as t and then not t.is_whitespace then
				tu := ["type", t.as_string_32]
				attr.force (tu)
			end
			tu := ["href", a_link.href.as_string_32]
			attr.force (tu)
			if attr.is_empty then
				attr := Void
			end
			append_content_tag_to ("link", attr, Void, buffer)
		end

	visit_author (a_author: FEED_AUTHOR)
		do
			buffer.append (indentation)
			buffer.append ("<author>%N")
			indent
			append_content_tag_to ("name", Void, a_author.name, buffer)
			append_content_tag_to ("email", Void, a_author.email, buffer)
			exdent
			buffer.append (indentation)
			buffer.append ("</author>%N")
		end

feature {NONE} -- Helpers

	new_uuid: STRING
		local
			gen: UUID_GENERATOR
		do
			create gen
			Result := gen.generate_uuid.out.as_lower
		end

	date_to_string (dt: DATE_TIME): STRING
		do
			Result := date_to_rfc3339_string (dt)
		end

	date_to_rfc3339_string (d: DATE_TIME): STRING
			-- 2003-12-13T18:30:02Z
		local
			i: INTEGER
		do
			create Result.make_empty
			Result.append_integer (d.year)
			Result.append_character ('-')
			i := d.month
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character ('-')
			i := d.day
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character ('T')
			i := d.hour
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character (':')
			i := d.minute
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character (':')
			i := d.second
			if i < 10 then
				Result.append_integer (0)
			end
			Result.append_integer (i)
			Result.append_character ('Z')
		end

end

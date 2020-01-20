note
	description: "Convert a FEED into an RSS 2.0 content."
	date: "$Date$"
	revision: "$Revision$"

class
	RSS_2_FEED_GENERATOR

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
				<?xml version="1.0" encoding="UTF-8"?>
				<rss 
					xmlns:content="http://purl.org/rss/1.0/modules/content/" 
					xmlns:dc="http://purl.org/dc/elements/1.1/"
					version="2.0">
					<channel>
				]")
			buffer.append_character ('%N')
			indent
			indent
			append_content_tag_to ("title", Void, a_feed.title, buffer)
			if attached a_feed.description as desc then
				append_content_tag_to ("description", Void, desc, buffer)
			else
				append_content_tag_to ("description", Void, a_feed.title, buffer)
			end
			across
				a_feed.links as tb
			loop
				tb.item.accept (Current)
			end
			if attached a_feed.date as dt then
				append_content_tag_to ("lastBuildDate", Void, date_to_string (dt), buffer)
			end
			across
				a_feed.items as ic
			loop
				ic.item.accept (Current)
			end
			exdent
			exdent
			buffer.append ("[
					</channel>
				</rss>
				]")
		end

	visit_item (a_item: FEED_ITEM)
		do
			buffer.append (indentation)
			buffer.append ("<item>%N")
			indent
			append_content_tag_to ("title", Void, a_item.title, buffer)
			if attached a_item.date as dt then
				append_content_tag_to ("pubDate", Void, date_to_string (dt), buffer)
			end
			across
				a_item.links as tb
			loop
				tb.item.accept (Current)
			end
			if attached a_item.author as u then
				u.accept (Current)
			end
			if attached a_item.categories as cats then
				across
					cats as ic
				loop
					append_content_tag_to ("category", Void, ic.item, buffer)
				end
			end
			append_content_tag_to ("guid", Void, a_item.id, buffer)
			append_content_tag_to ("description", Void, a_item.description, buffer)
			append_cdata_content_tag_to ("content:encoded", Void, a_item.content, buffer)

			exdent
			buffer.append (indentation)
			buffer.append ("</item>%N")
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
			if attr.is_empty then
				attr := Void
			end
			append_content_tag_to ("link", attr, a_link.href, buffer)
		end

	visit_author (a_author: FEED_AUTHOR)
		do
			append_content_tag_to ("dc:creator", Void, a_author.name, buffer)
		end

feature {NONE} -- Helpers

	date_to_string (dt: DATE_TIME): STRING
		local
			htdate: HTTP_DATE
		do
			create htdate.make_from_date_time (dt)
			Result := htdate.rfc1123_string
		end

end

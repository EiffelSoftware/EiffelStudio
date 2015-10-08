note
	description: "FEED interface, could be RSS, ATOM, ..."
	date: "$Date$"
	revision: "$Revision$"

class
	FEED

inherit
	FEED_HELPERS

	ITERABLE [FEED_ITEM]

create
	make

feature {NONE} -- Initialization	

	make (a_title: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (a_title)
			create items.make (1)
			create links.make (1)
		end

feature -- Access

	title: IMMUTABLE_STRING_32
			-- Title of the feed/channel.

	description: detachable IMMUTABLE_STRING_32
			-- Associated description/subtitle.

	description_content_type: detachable READABLE_STRING_8
			-- Optional content type for `description'.
			-- By default, this should be text/plain.

	id: detachable IMMUTABLE_STRING_32
			-- Id associated with Current feed if any.

	date: detachable DATE_TIME
			-- Build date.

	links: STRING_TABLE [FEED_LINK]
			-- Url indexed by relation

	items: ARRAYED_LIST [FEED_ITEM]
			-- List of feed items.

feature -- Access

	new_cursor: ITERATION_CURSOR [FEED_ITEM]
			-- <Precursor>
		do
			Result := items.new_cursor
		end

feature -- Element change	

	set_description (a_description: detachable READABLE_STRING_GENERAL; a_description_content_type: like description_content_type)
			-- Set `description' with `a_description' and optional content type `text:$a_description_content_type'.
		do
			if a_description = Void then
				description := Void
				description_content_type := Void
			else
				create description.make_from_string_general (a_description)
				description_content_type := a_description_content_type
			end
		end

	set_id (a_id: detachable READABLE_STRING_GENERAL)
		do
			if a_id = Void then
				id := Void
			else
				create id.make_from_string_general (a_id)
			end
		end

	set_updated_date_with_text (a_date_text: detachable READABLE_STRING_32)
			-- Set `date' from date string representation `a_date_text'.
		do
			if a_date_text = Void then
				date := Void
			else
				date := date_time (a_date_text)
			end
		end

	extend (a_item: FEED_ITEM)
			-- Add item `a_item' to feed `items'.
		do
			items.force (a_item)
		end

	extended alias "+" (a_feed: FEED): FEED
			-- New feed object made from Current merged with a_feed.
		local
			l_title: STRING_32
		do
			create l_title.make (title.count + a_feed.title.count)
			l_title.append_character ('(')
			l_title.append (title)
			l_title.append_character (')')
			l_title.append_character ('+')
			l_title.append_character ('(')
			l_title.append (a_feed.title)
			l_title.append_character (')')
			create Result.make (l_title)
			Result.items.append (items)
			across
				a_feed.items as ic
			loop
					-- FIXME jfiat [2015/10/07] : check there is no duplication! (same id, or link, ...)
				Result.extend (ic.item)
			end
			Result.sort
		end

	sort
			-- Sort `items', (recent first).
		local
			s: QUICK_SORTER [FEED_ITEM]
			comp: COMPARABLE_COMPARATOR [FEED_ITEM]
		do
			create comp
			create s.make (comp)
			s.reverse_sort (items)
		end

feature -- Visitor

	accept (vis: FEED_VISITOR)
		do
			vis.visit_feed (Current)
		end

end

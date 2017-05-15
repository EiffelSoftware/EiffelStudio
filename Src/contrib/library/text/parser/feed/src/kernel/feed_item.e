note
	description: "[
			A feed contains a list of items.
			This FEED_ITEM interface provides
				- title, description, content, id, date, ...
				- could be compared with other item to sort by date+title.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_ITEM

inherit
	FEED_HELPERS
		undefine
			is_equal
		end

	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_title: READABLE_STRING_GENERAL)
		do
			create title.make_from_string_general (a_title)
			create links.make (1)
		end

feature -- Access

	title: IMMUTABLE_STRING_32
			-- Title of associated feed item.

	description: detachable IMMUTABLE_STRING_32
			-- Optional description (or summary).

	content: detachable IMMUTABLE_STRING_32
			-- Content of Current feed item.

	content_type: detachable READABLE_STRING_8
			-- Optional content type for `content'.
			-- By default, this should be text/html.

	content_type_or_default (dft: READABLE_STRING_8): READABLE_STRING_8
			-- Associated content type, and if none, return given value `dft'.
		do
			if attached content_type as l_type then
				Result := l_type
			else
				Result := dft
			end
		end

	id: detachable IMMUTABLE_STRING_32
			-- Identifier of current feed item, if any/

	date: detachable DATE_TIME
			-- Publishing date.

	link: detachable FEED_LINK
			-- Main link for the entry, if any.
		do
			if attached links as l_links then
				Result := l_links.item ("")
				across
					l_links as ic
				until
					Result /= Void
				loop
					Result := ic.item
				end
			end
		end

	links: STRING_TABLE [FEED_LINK]
			-- Url indexed by relation

	categories: detachable LIST [READABLE_STRING_32]
			-- Categories

	author: detachable FEED_AUTHOR
			-- Author information.

feature -- Status report

	has_category (cat: READABLE_STRING_GENERAL): BOOLEAN
			-- Has category `cat'?
			--| note: case insensitive.
		do
			if attached categories as cats then
				Result := across cats as ic some cat.is_case_insensitive_equal (ic.item) end
			end
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		local
			d1,d2: like date
		do
			d1 := date
			d2 := other.date
			if d1 = Void and d2 = Void then
				Result := title < other.title
			elseif d1 = Void then
				Result := True
			elseif d2 = Void then
				Result := False
			else
				if d1 ~ d2 then
					Result := title < other.title
				else
					Result := d1 < d2
				end
			end
		end

feature -- Element change	

	set_id (a_id: detachable READABLE_STRING_GENERAL)
		do
			if a_id = Void then
				id := Void
			else
				create id.make_from_string_general (a_id)
			end
		end

	set_description (a_description: detachable READABLE_STRING_GENERAL)
		do
			if a_description = Void then
				description := Void
			else
				create description.make_from_string_general (a_description)
			end
		end

	set_content (a_content: detachable READABLE_STRING_GENERAL; a_type: detachable READABLE_STRING_GENERAL)
		do
			if a_content = Void then
				content := Void
				content_type := Void
			else
				create content.make_from_string_general (a_content)
				if a_type = Void then
					content_type := Void
				else
					content_type := a_type.as_string_8
				end
			end
		end

	set_updated_date_with_text (a_date_text: detachable READABLE_STRING_32)
			-- Set `date' from date string representation `a_date_text'.
		obsolete
			"Use set_date_with_text [2017-05-31]"
		do
			set_date_with_text (a_date_text)
		end

	set_date_with_text (a_date_text: detachable READABLE_STRING_32)
			-- Set `date' from date string representation `a_date_text'.
		do
			if a_date_text = Void then
				set_date (Void)
			else
				set_date (date_time (a_date_text))
			end
		end

	set_date (a_date: detachable DATE_TIME)
			-- Set `date' from `a_date'.
		do
			date := a_date
		end

	set_author (a_author: detachable FEED_AUTHOR)
		do
			author := a_author
		end

	set_category (cat: READABLE_STRING_GENERAL)
		local
			cats: like categories
		do
			cats := categories
			if cats = Void then
				create {ARRAYED_LIST [READABLE_STRING_32]} cats.make (1)
				categories := cats
			end
			cats.force (cat.as_string_32)
		ensure
			cat_set: has_category (cat)
		end

feature -- Visitor

	accept (vis: FEED_VISITOR)
		do
			vis.visit_item (Current)
		end

end

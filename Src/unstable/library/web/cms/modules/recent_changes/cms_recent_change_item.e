note
	description: "Information related to change event."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_RECENT_CHANGE_ITEM

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_source: READABLE_STRING_8; lnk: CMS_LOCAL_LINK; a_date_time: DATE_TIME)
		do
			source := a_source
			link := lnk
			date := a_date_time
		end

feature -- Access

	id: detachable READABLE_STRING_32
			-- Optional id, expected to be unique.

	link: CMS_LOCAL_LINK
			-- Local link associated with the resource.

	date: DATE_TIME
			-- Time of the event item.

	author_name: detachable READABLE_STRING_32
			-- Optional author name.
			-- It is possible to have author_name /= Void and author = Void.

	author: detachable CMS_USER
			-- Optional author.

	source: READABLE_STRING_8
			-- Source of Current event.

	categories: detachable LIST [READABLE_STRING_GENERAL]
			-- Optional categories (tags, terms) related to associated content.

	summary: detachable READABLE_STRING_32
			-- Optional summary related to associated content.		

	information: detachable READABLE_STRING_8
			-- Optional information related to Current event.
			--| For instance: creation, trashed, modified, ...

feature -- Element change

	set_id (a_id: detachable READABLE_STRING_GENERAL)
			-- Set `id` to `a_id`.
		do
			if a_id = Void then
				id := Void
			else
				id := a_id.as_string_32
			end
		end

	set_author_name (n: like author_name)
			-- Set `author_name' to `n'.
		do
			author_name := n
		end

	set_author (u: like author)
			-- Set `author' to `u'.
		do
			author := u
			if u /= Void and author_name = Void then
				set_author_name (u.name)
			end
		end

	set_summary (a_summary: like summary)
			-- Set `summary' to `a_summary'.
		do
			summary := a_summary
		end

	set_information (a_info: like information)
			-- Set `information' to `a_info'.
		do
			information := a_info
		end

	add_category (a_cat: READABLE_STRING_GENERAL)
		local
			cats: like categories
		do
			cats := categories
			if cats = Void then
				create {ARRAYED_LIST [READABLE_STRING_GENERAL]} cats.make (1)
				categories := cats
			end
			cats.force (a_cat)
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- <Precursor>
		do
			Result := date < other.date
		end

end

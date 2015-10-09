note
	description: "[
			Convert a FEED to XHTML representation.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_TO_XHTML_VISITOR

inherit
	FEED_VISITOR

	SHARED_HTML_ENCODER

create
	make

feature {NONE} -- Initialization

	make (a_buffer: STRING_8)
		do
			buffer := a_buffer
			create today.make_now_utc
			description_enabled := False
			limit := -1
		end

	buffer: STRING_8
			-- Output buffer.

	today: DATE_TIME
			-- Current date.

feature -- Access

	header: detachable READABLE_STRING_8
			-- Optional header.

	footer: detachable READABLE_STRING_8
			-- Optional footer.

feature -- Settings

	limit: INTEGER
			-- Number of item to include in XHTML generation.
			-- Default: -1 => No limit

	description_enabled: BOOLEAN
			-- Generate description?
			-- Default: False

feature -- Element change

	set_limit (nb: INTEGER)
			-- Set `limit' to `nb'.
		do
			limit := nb
		end

	set_description_enabled (b: BOOLEAN)
			-- Set `description_enabled' to `b'.
		do
			description_enabled := b
		end

	set_header (h: like header)
		do
			header := h
		end

	set_footer (f: like footer)
		do
			footer := f
		end

feature -- Visitor

	visit_feed (a_feed: FEED)
		local
			nb: INTEGER
		do
			append ("<div class=%"feed%">")
			if attached header as h then
				append (h)
				append ("%N")
			end
			if attached a_feed.date as dt then
				append ("<!-- date:")
				append (dt.out)
				append (" -->%N")
			end

			append ("<ul>%N")
			if
				description_enabled and then
				attached a_feed.description as l_desc and then
				l_desc.is_valid_as_string_8
			then
				append ("<div class=%"description%">")
				append (l_desc.to_string_8)
				append ("</div>")
			end

			nb := limit
			across
				a_feed as ic
			until
				nb = 0
			loop
				ic.item.accept (Current)
				nb := nb - 1
			end

			if attached footer as f then
				append (f)
				append ("%N")
			end
			append ("</ul>%N")
		end

	visit_item (a_entry: FEED_ITEM)
		local
			lnk: detachable FEED_LINK
		do
			append ("<li>%N")
			lnk := a_entry.link

			if attached a_entry.date as dt then
				append ("<div class=%"date%">")
				append_date_time_to (dt, today.date, buffer)
				append ("</div>%N")
			end
			if lnk /= Void then
				append ("<a href=%"" + lnk.href + "%">")
			else
				check has_link: False end
				append ("<a href=%"#%">")
			end
			append_as_html_encoded (a_entry.title)
			append ("</a>%N")
			debug
				if attached a_entry.categories as l_categories and then not l_categories.is_empty then
					append ("<div class=%"category%">")
					across
						l_categories as cats_ic
					loop
						append_as_html_encoded (cats_ic.item)
						append (" ")
					end
					append ("</div>%N")
				end
			end
			if
				description_enabled and then
				attached a_entry.description as l_entry_desc
			then
				if l_entry_desc.is_valid_as_string_8 then
					append ("<div class=%"description%">")
					append (l_entry_desc.as_string_8)
					append ("</div>%N")
				else
					check is_html: False end
				end
			end
			append ("</li>%N")
		end

	visit_link (a_link: FEED_LINK)
		do
			append ("<a href=%"" + a_link.href + "%">")
			append_as_html_encoded (a_link.relation)
			append ("</a>%N")
		end

	visit_author (a_author: FEED_AUTHOR)
		do
		end

feature -- Helper

	append_as_html_encoded (s: READABLE_STRING_GENERAL)
		do
			buffer.append (html_encoder.general_encoded_string (s))
		end

	append (s: READABLE_STRING_8)
		do
			buffer.append (s)
		end

	append_date_time_to (dt: DATE_TIME; a_today: DATE; a_output: STRING_GENERAL)
		do
			if dt.year /= a_today.year then
				a_output.append (dt.year.out)
				a_output.append (",")
			end
			a_output.append (" ")
			append_month_mmm_to (dt.month, a_output)
			a_output.append (" ")
			if dt.day < 10 then
				a_output.append ("0")
			end
			a_output.append (dt.day.out)
		end

	append_month_mmm_to (m: INTEGER; s: STRING_GENERAL)
		require
			1 <= m and m <= 12
		do
			inspect m
			when 1 then s.append ("Jan")
			when 2 then s.append ("Feb")
			when 3 then s.append ("Mar")
			when 4 then s.append ("Apr")
			when 5 then s.append ("May")
			when 6 then s.append ("Jun")
			when 7 then s.append ("Jul")
			when 8 then s.append ("Aug")
			when 9 then s.append ("Sep")
			when 10 then s.append ("Oct")
			when 11 then s.append ("Nov")
			when 12 then s.append ("Dec")
			else
				-- Error				
			end
		end

end

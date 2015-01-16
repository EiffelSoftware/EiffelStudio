note
	description: "Summary description for {WDOCS_TIMELINE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_TIMELINE

inherit
	ITERABLE [WDOCS_TIMELINE_EVENT]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create items.make (nb)
		end

feature -- Access

	items: ARRAYED_LIST [WDOCS_TIMELINE_EVENT]

	new_cursor: ITERATION_CURSOR [WDOCS_TIMELINE_EVENT]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

	authors: STRING_TABLE [READABLE_STRING_8]
		do
			create Result.make (10)
			across
				items as ic
			loop
				if
					attached {WDOCS_TIMELINE_PAGE_EVENT} ic.item as pg_event and then
					attached pg_event.revision.author as l_author
				then
					Result.force (l_author, l_author)
				end
			end
		end

feature -- Element change

	put (a_event: WDOCS_TIMELINE_EVENT)
		do
			items.force (a_event)
		end

	sort
		local
			l_sorter: QUICK_SORTER [WDOCS_TIMELINE_EVENT]
		do
			create l_sorter.make (create {COMPARABLE_COMPARATOR [WDOCS_TIMELINE_EVENT]})
			l_sorter.sort (items)
		end

	load (dir: PATH; a_name: READABLE_STRING_GENERAL)
		local
			fn: PATH
			f: FILE
			sed: SED_STORABLE_FACILITIES
		do
			fn := dir.extended (a_name).appended_with_extension ("data")
			create {RAW_FILE} f.make_with_path (fn)
			if f.exists and then f.is_readable then
				f.open_read
				create sed
				if attached {like Current} sed.retrieved_from_medium (f) as d then
					items := d.items
				end
				f.close
			end
		end

	save (dir: PATH; a_name: READABLE_STRING_GENERAL)
		local
			sed: SED_STORABLE_FACILITIES
			fn: PATH
			f: FILE
			utf: UTF_CONVERTER
			l_last_p, p: detachable PATH
		do
			fn := dir.extended (a_name).appended_with_extension ("data")
			create {RAW_FILE} f.make_with_path (fn)
			if not f.exists or else f.is_writable then
				f.open_write
				create sed
				sed.store_in_medium (Current, f)
				f.close
			end

			fn := dir.extended (a_name).appended_with_extension ("txt")
			create {PLAIN_TEXT_FILE} f.make_with_path (fn)
			if not f.exists or else f.is_writable then
				f.open_write
				f.put_string (items.count.out + " events.%N%N")
				across
					items as ic
				loop
					if attached {WDOCS_TIMELINE_PAGE_EVENT} ic.item as pg_event then
						p := pg_event.location
					else
						p := Void
					end
					f.put_string ("[")
					f.put_string (ic.item.date.out)
					f.put_string ("]")
					if
						p /= Void and then
						l_last_p /= Void and then
						l_last_p.same_as (p)
					then
						f.put_string ("~")
					else
						f.put_string (" ")
					end
					f.put_string (utf.escaped_utf_32_string_to_utf_8_string_8 (ic.item.event_summary))
					f.put_new_line
					if attached {WDOCS_TIMELINE_PAGE_EVENT} ic.item as pg_event then
						f.put_character ('%T')
						f.put_string (utf.escaped_utf_32_string_to_utf_8_string_8 (pg_event.relative_path))
						f.put_new_line
					end
					l_last_p := p
				end
				f.close
			end
		end

end

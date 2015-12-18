note
	description: "Summary description for {WDOCS_REVISION_INFO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_REVISION_INFO

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (p: PATH)
		do
			location := p
			get_id
		end

	get_id
		local
			l_entry: detachable PATH
			n: STRING_32
		do
			l_entry := location.entry
			if l_entry = Void then
				l_entry := location
			end
			n := l_entry.name
			if attached l_entry.extension as ext then
				n.remove_tail (1 + ext.count)
			end
			if n.is_integer then
				id := n.to_integer
			end
		end

feature -- Access		

	id: INTEGER

	location: PATH

	data: detachable WDOCS_METADATA

	data_string_8_item (k: READABLE_STRING_GENERAL): detachable READABLE_STRING_8
		local
			utf: UTF_CONVERTER
		do
			if
				attached data as d and then
				attached d.item (k) as s32
			then
				Result := utf.escaped_utf_32_string_to_utf_8_string_8 (s32)
			end
		end

feature -- Query		

	log: detachable READABLE_STRING_8
		do
			Result := data_string_8_item ("revision_log")
		end

	author: detachable READABLE_STRING_8
		do
			Result := data_string_8_item ("revision_author")
		end

	title: detachable READABLE_STRING_8
		do
			Result := data_string_8_item ("title")
		end

	link_title: detachable READABLE_STRING_8
		do
			Result := data_string_8_item ("link-title")
		end

	uri: detachable READABLE_STRING_8
		do
			Result := data_string_8_item ("path")
		end

	uuid: detachable READABLE_STRING_8
		do
			Result := data_string_8_item ("uuid")
		end

	weight: detachable READABLE_STRING_8
		do
			Result := data_string_8_item ("weight")
		end

feature -- Status report

	is_author (a_name: detachable READABLE_STRING_8): BOOLEAN
		do
			if a_name = Void then
				Result := author = Void
			else
				Result := attached author as l_author and then
							a_name.is_case_insensitive_equal (l_author)
			end
		end

feature -- Storage

	save_new_metadata_to (p: PATH)
		local
			f: RAW_FILE
		do
			create f.make_with_path (p)
			if not f.exists or else f.is_access_writable then
				f.open_write
				if attached title as s then
					f.put_string ("title=")
					f.put_string (s)
					f.put_new_line
				end
				if attached link_title as s then
					f.put_string ("link-title=")
					f.put_string (s)
					f.put_new_line
				end
				if attached weight as s then
					f.put_string ("weight=")
					f.put_string (s)
					f.put_new_line
				end
				if attached uuid as s then
					f.put_string ("uuid=")
					f.put_string (s)
					f.put_new_line
				end

				if attached author as s then
					f.put_string ("author=")
					f.put_string (s)
					f.put_new_line
				end
				if attached uri as s then
					f.put_string ("path=")
					f.put_string (s)
					f.put_new_line
				end

				f.close
			end
		end

	save_new_metadata_to_wiki (a_wiki_file: PATH)
			-- Save new metadata to wiki file `a_wiki_file'.
		require
			wiki_exists: (create {FILE_UTILITIES}).file_path_exists (a_wiki_file)
		local
			md: WDOCS_METADATA_WIKI
			f: RAW_FILE
			src: STRING
			props: STRING
			utf: UTF_CONVERTER
		do
			create f.make_with_path (a_wiki_file)
			if f.exists and then f.is_access_readable then
				create src.make (f.count)
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1_024)
					src.append (f.last_string)
				end
				f.close

				create {WDOCS_METADATA_WIKI_FILE} md.make_with_path (a_wiki_file)
				if md.end_position_of_properties_area > 0 then
					src.remove_head (md.end_position_of_properties_area)
				end
				md.get_all_items

				if attached title as s then
					md.force (s, "title")
				end
				if attached link_title as s then
					md.force (s, "link_title")
				end
				if attached weight as s then
					md.force (s, "weight")
				end
				if attached uuid as s then
					md.force (s, "uuid")
				end
				create props.make_empty
				across
					md as ic
				loop
					props.append ("[[Property:")
					props.append (utf.escaped_utf_32_string_to_utf_8_string_8 (ic.key))
					props.append_character ('|')
					props.append (utf.escaped_utf_32_string_to_utf_8_string_8 (ic.item))
					props.append ("]]%N")
				end
				f.open_write
				f.put_string (props)
				f.put_string (src)
				f.close
			end
		end

feature -- Element change

	set_data (d: like data)
		do
			data := d
		end

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is current object less than `other'?
		do
			Result := id < other.id
		end


end

note
	description: "Summary description for {WDOCS_METADATA_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_METADATA_FILE

inherit
	WDOCS_METADATA

create
	make_with_path

feature {NONE} -- Initialization

	make_with_path (p: PATH)
		do
			path := p
		end

	path: PATH

feature -- Element change

	get_only_items_named_as (a_names: ITERABLE [READABLE_STRING_GENERAL])
		local
			l_items: like items
		do
			create l_items.make_caseless (0)
			internal_items := l_items
			parse (l_items, a_names)
		end

	get_all_items
		local
			l_items: like items
		do
			create l_items.make_caseless (0)
			internal_items := l_items
			parse (l_items, Void)
		end

	reset
		do
			internal_items := Void
		end

	force (a_value: READABLE_STRING_32; a_key: READABLE_STRING_GENERAL)
		do
			items.force (a_value, a_key)
		end

feature -- Access

	item (a_key: READABLE_STRING_GENERAL): detachable STRING_32
			-- <Precursor>
		do
			Result := items.item (a_key)
		end

	count: INTEGER
			-- <Precursor>
		do
			Result := items.count
		end

feature -- Access

	new_cursor: TABLE_ITERATION_CURSOR [READABLE_STRING_32, READABLE_STRING_GENERAL]
			-- Fresh cursor associated with current structure
		do
			Result := items.new_cursor
		end

feature -- Status report

	exists: BOOLEAN
			-- Is metadata file exists?
		do
			Result := (create {FILE_UTILITIES}).file_path_exists (path)
		end

feature {NONE} -- Implementation

	items: STRING_TABLE [STRING_32]
		local
			l_items: like internal_items
		do
			l_items := internal_items
			if l_items = Void then
				get_all_items
				l_items := internal_items
				if l_items = Void then
					create l_items.make_caseless (0)
				end
				internal_items := l_items
			end
			Result := l_items
		end

	internal_items: detachable like items

	parse (a_items: STRING_TABLE [READABLE_STRING_32]; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL])
		local
			utf: UTF_CONVERTER
			f: RAW_FILE
			k: STRING_8
			l_line: STRING_8
			i: INTEGER
		do
			create f.make_with_path (path)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_line_thread_aware
					l_line := f.last_string
					i := l_line.index_of ('=', 1)
					if i > 0 then
						k := utf.utf_32_string_to_utf_8_string_8 (l_line.head (i - 1))
						k.left_adjust
						k.right_adjust
						if
							a_restricted_names = Void
							or else across a_restricted_names as ic some k.same_string_general (ic.item)  end
						then
							l_line.remove_head (i)
							l_line.left_adjust
							l_line.right_adjust
							a_items.force (utf.utf_8_string_8_to_string_32 (l_line), k)
						end
					end
				end
				f.close
			end
		end

end

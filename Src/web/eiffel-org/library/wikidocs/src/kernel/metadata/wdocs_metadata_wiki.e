note
	description: "Summary description for {WDOCS_METADATA_WIKI}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WDOCS_METADATA_WIKI

inherit
	WDOCS_METADATA


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
			end_position_of_properties_area := 0
			internal_items := Void
		end

feature -- Access

	item (a_key: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- <Precursor>
		do
			Result := items.item (a_key)
		end

	count: INTEGER
			-- <Precursor>
		do
			Result := items.count
		end

	end_position_of_properties_area: INTEGER
			-- the end position of the properties area, if any.

feature -- Element change

	force (a_value: READABLE_STRING_32; a_key: READABLE_STRING_GENERAL)
		do
			items.force (a_value, a_key)
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
		deferred
		end

	has_metadata: BOOLEAN
			-- Does current wiki file contains metadata as property?
		do
			if internal_items = Void then
				get_all_items
			end
			Result := end_position_of_properties_area > 0
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

	is_parsing_done: BOOLEAN
			-- Is parsing done?

	parse (a_items: STRING_TABLE [READABLE_STRING_32]; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL])			
		deferred
		end

	parse_line (a_line: READABLE_STRING_8; a_items: STRING_TABLE [READABLE_STRING_32]; a_restricted_names: detachable ITERABLE [READABLE_STRING_GENERAL])
		local
			utf: UTF_CONVERTER
			n,v: detachable STRING_8
			i,j,k: INTEGER
			prop: WIKI_PROPERTY
		do
			if not a_line.is_whitespace then
				i := a_line.substring_index ("[[", 1)
				if i = 0 then
					is_parsing_done := True
				else
					if a_line.same_caseless_characters_general ("Property:", 1, 8, i + 2) then
						j := i
						i := i + 2 + 8
						k := a_line.substring_index ("]]", i)
						if k > 0 then
							create prop.make (a_line.substring (j, k + 1))
							end_position_of_properties_area := k + 1
							n := prop.name
							v := prop.text.text
							if
								a_restricted_names = Void
								or else across a_restricted_names as ic some n.same_string_general (ic.item)  end
							then
								a_items.force (utf.utf_8_string_8_to_string_32 (v), n)
							end
						else
							is_parsing_done := True
						end
					else
						is_parsing_done := True
					end
				end
			end
		end

end

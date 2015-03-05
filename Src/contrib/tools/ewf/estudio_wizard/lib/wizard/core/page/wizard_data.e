note
	description: "Summary description for {WIZARD_DATA}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_DATA

inherit
	TABLE_ITERABLE [WIZARD_PAGE_DATA, READABLE_STRING_GENERAL]

create
	make

feature {NONE} -- Initialization

	make (nb: INTEGER)
		do
			create page_data_items.make_caseless (nb)
		end

feature -- Access

	page_data (k: READABLE_STRING_GENERAL): detachable WIZARD_PAGE_DATA
		do
			Result := page_data_items.item (k)
		end

	item (a_nested_identifier: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
			-- Data related to `a_nested_identifier'
			-- following convention "$page_id:$field_id"
		local
			p: INTEGER
			pid,fid: READABLE_STRING_GENERAL
			s: STRING_32
		do
			p := a_nested_identifier.index_of (':', 1)
			if p > 0 then
				pid := a_nested_identifier.head (p - 1)
				fid := a_nested_identifier.substring (p + 1, a_nested_identifier.count)

				if attached page_data (pid) as d then
					Result := d.item (fid)
				end
			else
					-- Search in all records
				across
					page_data_items as ic
				until
					Result /= Void
				loop
					create s.make_from_string_general (ic.key)
					s.append_character (':')
					s.append_string_general (a_nested_identifier)
					Result := item (s)
				end
			end
		end

	boolean_item (a_nested_identifier: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached item (a_nested_identifier) as v then
				Result := v.is_case_insensitive_equal_general ("yes") or
						v.is_case_insensitive_equal_general ("true") or
						v.is_case_insensitive_equal_general ("on")
			end
		end

	new_cursor: HASH_TABLE_ITERATION_CURSOR [WIZARD_PAGE_DATA, READABLE_STRING_GENERAL]
			-- <Precursor>
		do
			Result := page_data_items.new_cursor
		end

feature -- Change

	record_page_data (v: WIZARD_PAGE_DATA; k: READABLE_STRING_GENERAL)
		do
			page_data_items.force (v, k)
		end

feature {NONE} -- Implementation

	page_data_items: STRING_TABLE [WIZARD_PAGE_DATA]

end

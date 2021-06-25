note
	description: "[
			Objects that contains all the information relative to any header.
			Headers can only have email addresses informations.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David s"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER

create
	make, make_with_entries

feature {NONE} -- Initialization

	make (item: READABLE_STRING_8)
			-- Initialize the header with one 'item'.
		do
			create entries.make (1)
			entries.extend (item)
		end

	make_with_entries (list: ITERABLE [READABLE_STRING_8])
			-- Initialize the header with a 'list' of entries.
		do
			create entries.make (1)
			add_entries (list)
		end

feature -- Access

	entries: ARRAYED_LIST [READABLE_STRING_8]
			-- Multiple entries.

feature -- Status report

	multiple_entries: BOOLEAN
			-- Has the header multiple entries.

	unique_entry: READABLE_STRING_8
			-- Entry,
			-- Useful if not multiple entries.
		require
			has_unique_entry: not multiple_entries
		do
			Result := entries.first
		end

feature -- Status setting

	enable_multiple_entries
			-- Enable multiple entries.
		do
			multiple_entries := True
		end

feature -- Basic operations

	add_entry (s: READABLE_STRING_8)
			-- Add a new entry 's' to the header.
		do
			if not multiple_entries and entries.count > 0 then
				enable_multiple_entries
			end
			entries.extend (s)
		ensure
			has_multiple_entries: multiple_entries
			entry_inserted: entries.has (s)
		end

	add_entries (list: ITERABLE [READABLE_STRING_8])
			-- Add multiple entries at once.
		require
			entries_exist: entries /= Void
		do
			⟳ e: list ¦ entries.force (e) ⟲
			if entries.count > 1 then
				enable_multiple_entries
			end
		end

	remove_entry (entry: READABLE_STRING_8)
			-- Remove 'entry'
		require
			has_entry: entries.has (entry)
		do
			entries.prune (entry)
		end

	remove_i_th_entry (i: INTEGER)
			-- Remove 'i'-th entry.
		require
			valid_index: entries.valid_cursor_index (i)
		do
			entries.prune (entries [i])
		end

feature {NONE} -- Implementation

	from_array_to_entries (src: ARRAY [READABLE_STRING_8])
			-- Convert 'array' into entries.
		require
			entries_exists: entries /= Void
		do
			⟳ e: src ¦ entries.extend (e) ⟲
		end

note
	copyright: "Copyright (c) 1984-2021, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end

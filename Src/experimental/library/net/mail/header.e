note
	description: "Objects that contains all the information relative to any header.%
				  % Headers can only have email addresses informations."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "David s"
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER

create
	make, make_with_entries

feature -- Initialization

	make (item: STRING)
			-- Initialize the header with one 'item'.
		do
			create entries.make (1)
			entries.extend (item)
		end

	make_with_entries (list: ARRAY [STRING])
			-- Initialize the header with a 'list' of entries.
		do
			create entries.make (list.count)
			from_array_to_entries (list)
			if entries.count > 1 then
				enable_multiple_entries
			end
		end

feature -- Access

	entries: ARRAYED_LIST [STRING]
		-- Multiple entries.

feature -- Status report

	multiple_entries: BOOLEAN
		-- Has the header multiple entries.

	unique_entry: STRING
			-- Entry,
			-- Useful if not multiple entries.
		require
			has_unique_entry: not multiple_entries
		do
			Result:= entries.first
		end

feature -- Status setting

	enable_multiple_entries
			-- Enable multiple entries.
		do
			multiple_entries:= True
		end

	enable_contains_addresses
		do
			contains_addresses:= True
		end

feature -- Basic operations

	add_entry (s: STRING)
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

	add_entries (list: ARRAY [STRING])
			-- Add multiple entries at once.
		require
			entries_exist: entries /= Void
		do
			from_array_to_entries (list)
			if entries.count > 1 then
				enable_multiple_entries
			end
		end

	remove_entry (entry: STRING)
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
			entries.prune (entries.i_th (i))
		end

feature {NONE} -- Implementation

	contains_addresses: BOOLEAN
			-- Does header contain addresses?

	from_array_to_entries (src: ARRAY [STRING])
			-- Convert 'array' into entries.
		require
			entries_exists: entries /= Void
		local
			lin_array: LINEAR [STRING]
		do
			lin_array:= src.linear_representation
			from
				lin_array.start
			until
				lin_array.after
			loop
				entries.extend (lin_array.item)
				lin_array.forth
			end
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class HEADER


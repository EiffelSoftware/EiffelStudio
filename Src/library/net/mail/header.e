indexing
	description: "Objects that contains all the information relative to any header.%
				  % Headers can only have email adresses informations."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	HEADER

create
	make_with_entry, make_with_entries

feature -- Initialization

	make_with_entry (item: STRING) is
			-- Initialize the header with one entry.
		do
			create entries.make (1, 1)
			entries.put (item, 1)
		end

	make_with_entries (list: ARRAY [STRING]) is
			-- Initialize the header with multiple entries.
		do
			create entries.make_from_array (list)
			enable_multiple_entries
		end

feature -- Access

	first_entry: STRING is
		do
			Result:= entries.item (1)
		end
		-- Entry.

	entries: ARRAY [STRING]
		-- Multiple entries.

feature -- Status report

	multiple_entries: BOOLEAN
		-- Has the header multiple entries.

feature -- Status setting

	enable_multiple_entries is
			-- Enable multiple entries.
		do
			multiple_entries:= True
		end

	set_entries (list: ARRAY [STRING]) is
			-- Set entries.
		do
			entries:= list
		end

feature -- Miscellaneous

feature -- Basic operations

	add_entry (s: STRING) is
			-- Add a new entry to the header.
		do
			if not multiple_entries then
				enable_multiple_entries
			end
			entries.force (s, entries.count + 1)
		ensure
			has_mulltiple_entries: multiple_entries
			entry_inserted: entries.has (s)
		end

	is_valid: BOOLEAN is
		-- Check if the header is valid.
		do

		end

feature {NONE} -- Implementation

end -- class HEADER

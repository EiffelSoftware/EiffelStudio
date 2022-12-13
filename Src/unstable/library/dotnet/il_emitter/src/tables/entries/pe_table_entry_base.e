note
	description: "Base class for the metadata tables"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_TABLE_ENTRY_BASE

inherit

	PE_META_BASE

feature -- Access

	table_index: INTEGER
		deferred
		end

feature -- Operations

	render (a_sizes: ARRAY [NATURAL_64]; a_dest: ARRAY [NATURAL_8]): NATURAL_64
			-- Write the Current table entry to the given destination buffer `a_dest`.
			-- and returns the number of bytes written to the buffer.
		deferred

		end

	get (a_sizes: ARRAY [NATURAL_64]; a_bytes: ARRAY [NATURAL_8]): NATURAL_64
		deferred
		end
end

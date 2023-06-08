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

feature -- Status

	token_searching_supported: BOOLEAN
			-- Is token searching supported?
			--| note: used to know if duplicated entries should be rejected?
		deferred
		end

	token_from_table (tb: MD_TABLE): NATURAL_64
			-- If Current was already defined in `tb` return the associated token.
			-- It may not be implemented, this is mainly used to avoid duplicated entries.
		require
			token_searching_supported
		local
			n: NATURAL_64
		do
			n := 0
			across
				tb as i
			until
				Result /= {NATURAL_64} 0
			loop
				n := n + 1
				if
					attached {like Current} i as e and then
					same_as (e)
				then
					Result := n
				end
			end
		end

	same_as (e: like Current): BOOLEAN
			-- Is `e` same as `Current`?
			-- note: used to detect if an entry is already recorded.
		do
			Result := (e = Current)
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

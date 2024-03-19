note
	description: "Base class for the metadata tables"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	PE_TABLE_ENTRY_BASE

inherit
	PE_META_BASE

	MD_VISITABLE

feature -- Access

	table_index: NATURAL_32
		deferred
		end

feature -- Status

	token_from_table (tb: MD_TABLE): NATURAL_32
			-- If Current was already defined in `tb` return the associated token.
			-- It may not be implemented, this is mainly used to avoid duplicated entries.
		local
			n: NATURAL_32
		do
			n := 0
			across
				tb as i
			until
				Result /= {NATURAL_32} 0
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

	render (a_sizes: SPECIAL [NATURAL_32]; a_dest: ARRAY [NATURAL_8]): NATURAL_32
			-- Write the Current table entry to the given destination buffer `a_dest`.
			-- and returns the number of bytes written to the buffer.
		deferred

		end

	rendering_size (a_sizes: SPECIAL [NATURAL_32]): NATURAL_32
			-- Bytes needed to `render` Current using the global information on MD table sizes `a_sizes`.
		deferred
		end

feature -- Visitor

	accepts (vis: MD_VISITOR)
		do
			vis.visit_table_entry (Current)
		end

end

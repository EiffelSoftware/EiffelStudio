indexing
	description: "Representation of a section header for a method."
	date: "$Date$"
	revision: "$Revision$"

class
	MD_METHOD_SECTION_HEADER

inherit
	MD_METHOD_HEADER

create
	make
	
feature {NONE} -- Creation

	make is
			-- Create fat method section header.
		do
		ensure
			not_is_fat: not is_fat
			no_clauses: clause_count = 0
		end

feature -- Initialization

	reset is
			-- Reset all data to default values.
		do
			is_fat := False
			clause_count := 0
		ensure
			not_is_fat: not is_fat
			no_clauses: clause_count = 0
		end

feature -- Access

	count: INTEGER is 4
			-- Size of header in bytes once emitted.

	is_fat: BOOLEAN
			-- Is current header a fat one?

feature -- Modification

	register_exception_clause (clause: MD_EXCEPTION_CLAUSE) is
			-- Update current header information to reflect exception `clause' in section.
		require
			clause_not_void: clause /= Void
			clause_is_defined: clause.is_defined
		do
			clause_count := clause_count + 1
			if clause.is_fat or else clause_count >= 21 then
					-- The exception clause is fat or there are too many exception clauses.
					-- Small format allows less than (256 - count) // 12 clauses, i.e. less than 21 clauses.
				is_fat := True
			end
		ensure
			is_fat_enforced: clause.is_fat implies is_fat
			clause_count_incremented: clause_count = old clause_count + 1
		end

feature -- Saving

	write_to_stream (m: MANAGED_POINTER; pos: INTEGER) is
			-- Write to stream `m' at position `pos'.
		local
			kind: INTEGER_8
			size: INTEGER
		do
			if is_fat then
				kind := {MD_METHOD_CONSTANTS}.Section_ehtable |
					{MD_METHOD_CONSTANTS}.Section_fat_format
				size := clause_count * 24 + count
			else
				kind := {MD_METHOD_CONSTANTS}.Section_ehtable
				size := clause_count * 12 + count
			end
			m.put_integer_8 (kind, pos)
			m.put_integer_8 (size.to_integer_8, pos + 1)
			m.put_integer_8 ((size |>> 8).to_integer_8, pos + 2)
			m.put_integer_8 ((size |>> 16).to_integer_8, pos + 3)
		end

feature {NONE} -- Internal data

	clause_count: INTEGER
			-- Number of registered exception clauses

end -- class MD_METHOD_SECTION_HEADER

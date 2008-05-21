indexing

	description: "[
		Properties of the memory management mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class MEM_INFO inherit

	MEM_CONST

create

	make

feature -- Initialization

	make, update (memory: INTEGER) is
			-- Update Current for `memory' type.
		do
			mem_stat (memory)
			type := memory
				-- Not implemented.
			total64 := 0
			used64 := 0
			overhead64 := 0
			chunk := 0
		ensure
			Type_updated: type = memory
		end

feature -- Access

	type: INTEGER
			-- Memory type (Total, Eiffel, C)

feature -- Measurement

	total: INTEGER is
			-- Total number of bytes allocated for `type'
			-- before last call to `update'
		do
			Result := total64.as_integer_32
		end

	used: INTEGER is
			-- Number of bytes used for `type'
			-- before last call to `update'
		do
			Result := used64.as_integer_32
		end

	free: INTEGER is
			-- Number of bytes still free for `type'
			-- before last call to `update'
		do
			Result := total - used - overhead
		ensure
			Computed: Result = total - used - overhead
		end

	overhead: INTEGER is
			-- Number of bytes used by memory management
			-- scheme for `type' before last call to `update'
		do
			Result := overhead64.as_integer_32
		end

	chunk: INTEGER
			-- Number of allocated memory chunks.

feature -- Extended measurement

	total64: NATURAL_64
			-- Total number of bytes allocated for `type'
			-- before last call to `update'

	used64: NATURAL_64
			-- Number of bytes used for `type'
			-- before last call to `update'

	free64: NATURAL_64 is
			-- Number of bytes still free for `type'
			-- before last call to `update'
		do
			Result := total64 - used64 - overhead64
		end

	overhead64: NATURAL_64
			-- Number of bytes used by memory management
			-- scheme for `type' before last call to `update'

feature {NONE} -- Implementation

	mem_stat (mem: INTEGER) is
			-- Retrieve the statistics.
		do
		end

invariant
	consistent_memory: total64 = free64 + used64 + overhead64

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class MEM_INFO




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
			total := mem_info (1)
			used := mem_info (2)
			overhead := mem_info (3)
			chunk := mem_info (4)
		ensure
			Type_updated: type = memory
		end

feature -- Access

	type: INTEGER
			-- Memory type (Total, Eiffel, C)

feature -- Measurement

	total: INTEGER
			-- Total number of bytes allocated for `type'
			-- before last call to `update'

	used: INTEGER
			-- Number of bytes used for `type'
			-- before last call to `update'

	free: INTEGER is
			-- Number of bytes still free for `type'
			-- before last call to `update'
		do
			Result := total - used - overhead
		ensure
			Computed: Result = total - used - overhead
		end

	overhead: INTEGER
			-- Number of bytes used by memory management
			-- scheme for `type' before last call to `update'

	chunk: INTEGER
			-- Number of allocated memory chunks.

feature {NONE} -- Implementation

	mem_stat (mem: INTEGER) is
			-- Initialize run-time buffer used by mem_info to retrieve the
			-- statistics frozen at the time of this call.
		do
			check
				False
			end
		end

	mem_info (field: INTEGER): INTEGER is
			-- Read memory accounting structure, field by field.
		do
			check
				False
			end
		end

invariant

	consistent_memory: total = free + used + overhead

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




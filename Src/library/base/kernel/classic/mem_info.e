indexing

	description: "[
		Properties of the memory management mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"

	status: "See notice at end of class"
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


feature {NONE} -- Implementation

	mem_stat (mem: INTEGER) is
			-- Initialize run-time buffer used by mem_info to retrieve the
			-- statistics frozen at the time of this call.
		external
			"C | %"eif_memory.h%""
		end

	mem_info (field: INTEGER): INTEGER is
			-- Read memory accounting structure, field by field.
		external
			"C | %"eif_memory.h%""
		end

invariant

	consistent_memory: total = free + used + overhead

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class MEM_INFO




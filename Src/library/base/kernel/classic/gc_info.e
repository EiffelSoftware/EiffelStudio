indexing

	description: "[
			Garbage collector statistics.
			This class may be used as ancestor by classes needing its facilities.
			Time accounting is relevant only if `enable_time_accounting' 
			(from MEMORY) has been called.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class GC_INFO inherit

	MEM_CONST

create

	make

feature -- Initialization

	make, update (memory: INTEGER) is
			-- Fill in statistics for `memory' type
		do
			gc_stat (memory)
			cycle_count := gc_info (0)
			memory_used := gc_info (1)
			collected := gc_info (2)
			collected_average := gc_info (3)
			real_time := gc_info (4)
			real_time_average := gc_info (5)
			real_interval_time := gc_info (6)
			real_interval_time_average := gc_info (7)
			cpu_time := gc_infod (8)
			cpu_time_average := gc_infod (9)
			cpu_interval_time := gc_infod (10)
			cpu_interval_time_average := gc_infod (11)
			sys_time := gc_infod (12)
			sys_time_average := gc_infod (13)
			sys_interval_time := gc_infod (14)
			sys_interval_time_average := gc_infod (15)
		end

feature -- Access

	type: INTEGER
			-- Collector type (Full, Collect),
			-- for `type' before last call to `update'

	cycle_count: INTEGER
			-- Number of collection cycles for `type'
			-- before last call to `update'

	memory_used: INTEGER
			-- Total number of bytes used (counting overhead)
			-- after last cycle for `type' before last
			-- call to `update'

	collected: INTEGER
			-- Number of bytes collected by the last cycle,
			-- for `type' before last call to `update'

	collected_average: INTEGER
			-- Average number of bytes collected by a cycle,
			-- for `type' before last call to `update'

	real_time: INTEGER
			-- Real time in centi-seconds used by last cycle
			-- for `type', before last call to `update';
			-- this may not be accurate on systems which do not
			-- provide a sub-second accuracy clock (typically
			-- provided on BSD).

	real_time_average: INTEGER
			-- Average amount of real time, in centi-seconds,
			-- spent in collection cycle,
			-- for `type' before last call to `update'

	real_interval_time: INTEGER
			-- Real interval time (as opposed to CPU time) between
			-- two automatically raised cycles, in centi-seconds,
			-- for `type' before last call to `update'

	real_interval_time_average: INTEGER
			-- Average real interval time between two automatic
			-- cycles, in centi-seconds,
			-- for `type' before last call to `update'

	cpu_time: DOUBLE
			-- Amount of CPU time, in seconds, spent in cycle,
			-- for `type' before last call to `update'

	cpu_time_average: DOUBLE
			-- Average amount of CPU time spent in cycle,
			-- in seconds, for `type' before last call to `update'

	cpu_interval_time: DOUBLE
			-- Amount of CPU time elapsed since between last
			-- and penultimate cycles for `type' before
			-- last call to `update'

	cpu_interval_time_average: DOUBLE
			-- Average amount of CPU time between two cycles,
			-- for `type' before last call to `update'

	sys_time: DOUBLE
			-- Amount of kernel time, in seconds, spent in cycle,
			-- for `type' before last call to `update'

	sys_time_average: DOUBLE
			-- Average amount of kernel time spent in cycle,
			-- for `type' before last call to `update'

	sys_interval_time: DOUBLE
			-- Amount of kernel time elapsed since between
			-- the last and the penultimate cycle,
			-- for `type' before last call to `update'

	sys_interval_time_average: DOUBLE
			-- Average amount of kernel time between two cycles,
			-- for `type' before last call to `update'

feature {NONE} -- Implementation

	gc_stat (mem: INTEGER) is
			-- Initialize run-time buffer used by gc_info to retrieve the
			-- statistics frozen at the time of this call.
		external
			"C | %"eif_memory.h%""
		end

	gc_info (field: INTEGER): INTEGER is
			-- Read GC accounting structure, field by field.
		external
			"C | %"eif_memory.h%""
		end

	gc_infod (field: INTEGER): DOUBLE is
			-- Read GC accounting structure, field by field.
		external
			"C | %"eif_memory.h%""
		end

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

end -- class GC_INFO




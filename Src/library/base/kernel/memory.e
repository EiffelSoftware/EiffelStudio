indexing

	description: "[
		Facilities for tuning up the garbage collection mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class MEMORY inherit

	MEM_CONST

feature -- Measurement

	memory_statistics (memory_type: INTEGER): MEM_INFO is
			-- Memory usage information for `memory_type'
		require
			type_ok:
				memory_type = Total_memory or
				memory_type = Eiffel_memory or
				memory_type = C_memory
		do
			create Result.make (memory_type)
		end

	gc_statistics (collector_type: INTEGER): GC_INFO is
			-- Garbage collection information for `collector_type'.
		require
			type_ok:
				collector_type = Full_collector or
				collector_type = Incremental_collector
		do
			create Result.make (collector_type)
		end

feature -- Status report

	is_in_final_collect: BOOLEAN is
			-- Is GC currently performing final collection
			-- after execution of current program?
			-- Safe to use in `dispose'.
		external
			"C macro use %"eif_memory.h%""
		alias
			"eif_is_in_final_collect"
		end

	memory_threshold: INTEGER is
			-- Minimum amount of bytes to be allocated before
			-- starting an automatic garbage collection.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_tget"
		end

	collection_period: INTEGER is
			-- Period of full collection.
			-- If the environment variable EIF_FULL_COLLECTION_PERIOD   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
			-- If null, no full collection is launched.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_pget"
		end

	coalesce_period: INTEGER is
			-- Period of full coalesce (in number of collections)
			-- If the environment variable EIF_FULL_COALESCE_PERIOD   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
			-- If null, no full coalescing is launched.
		external
			"C | %"eif_memory.h%""
		alias
			"eif_coalesce_period"
		end
			
	collecting: BOOLEAN is
			-- Is garbage collection enabled?
		external
			"C | %"eif_memory.h%""
		alias
			"gc_ison"
		end

	largest_coalesced_block: INTEGER is
			-- Size of largest coalesced block since last call to
			-- `largest_coalesced'; 0 if none.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_largest"
		end

	max_mem: INTEGER is
			-- Maximum amount of bytes the run-time can allocate.
		external
			"C | %"eif_memory.h%""
		alias
			"eif_get_max_mem"
		end

	chunk_size: INTEGER is
			-- Minimal size of a memory chunk. The run-time always
			-- allocates a multiple of this size.
			-- If the environment variable EIF_MEMORY_CHUNK   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
		external
			"C | %"eif_memory.h%""
		alias
			"eif_get_chunk_size"
		end

	tenure: INTEGER is
			-- Maximum age of object before being considered
			-- as old (old objects are not scanned during 
			-- partial collection).
			-- If the environment variable EIF_TENURE_MAX   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
		external
			"C | %"eif_memory.h%""
		alias
			"eif_tenure"
		end
			
	generation_object_limit: INTEGER is
			-- Maximum size of object in generational scavenge zone.
			-- If the environment variable EIF_GS_LIMIT   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
		external
			"C | %"eif_memory.h%""
		alias
			"eif_generation_object_limit"
		end
	
	scavenge_zone_size: INTEGER is
			-- Size of generational scavenge zone.
			-- If the environment variable EIF_MEMORY_SCAVENGE   
			-- is defined, it is set to the closest reasonable 
			-- value from it.

		external
			"C | %"eif_memory.h%""
		alias
			"eif_scavenge_zone_size"
		end

feature -- Status report

	referers (an_object: ANY): ARRAY [ANY] is
			-- Objects that refer to `an_object'.
		local
			a: ANY
		do
			create Result.make (0, 200)
			a := Result.area
			find_referers ($an_object, $a, Result.count)
		end

feature -- Status setting

	collection_off is
			-- Disable garbage collection.
		external
			"C | %"eif_garcol.h%""
		alias
			"gc_stop"
		end

	collection_on is
			-- Enable garbage collection.
		external
			"C | %"eif_garcol.h%""
		alias
			"gc_run"
		end

	allocate_fast is
			-- Enter ``speed'' mode: will optimize speed of memory
			-- allocation rather than memory usage.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_speed"
		end

	allocate_compact is
			-- Enter ``memory'' mode: will try to compact memory
			-- before requesting more from the operating system.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_slow"
		end

	allocate_tiny is
			-- Enter ``tiny'' mode: will enter ``memory'' mode
			-- after having freed as much memory as possible.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_tiny"
		end

	enable_time_accounting is
			-- Enable GC time accouting, accessible in `gc_statistics'.
		do
			gc_monitoring (True)
		end

	disable_time_accounting is
			-- Disable GC time accounting (default).
		do
			gc_monitoring (False)
		end

	set_memory_threshold (value: INTEGER) is
			-- Set a new `memory_threshold' in bytes. Whenever the memory 
			-- allocated for Eiffel reaches this value, an automatic
			-- collection is performed.
		require
			positive_value: value > 0
		external
			"C | %"eif_memory.h%""
		alias
			"mem_tset"
		end

	set_collection_period (value: INTEGER) is
			-- Set `collection_period'. Every `value' collection,
			-- the Garbage collector will perform a collection
			-- on the whole memory (full collection), otherwise 
			-- a simple partial collection is done.
		require
			positive_value: value >= 0
		external
			"C | %"eif_memory.h%""
		alias
			"mem_pset"
		end

	set_coalesce_period (value: INTEGER) is
			-- Set `coalesce_period'. Every `value' collection,
			-- the Garbage Collector will coalesce
			-- the whole memory. 
		require
			positive_value: value >= 0
		external
			"C | %"eif_memory.h%""
		alias
			"eif_set_coalesce_period"
		end

	set_max_mem (value: INTEGER) is
			-- Set the maximum amount of memory the run-time can allocate.
		require
			positive_value: value > 0
		external
			"C | %"eif_memory.h%""
		alias
			"eif_set_max_mem"
		end

feature -- Removal

	dispose is
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Default version does nothing; redefine in descendants
			-- to perform specific dispose actions. Those actions
			-- should only take care of freeing external resources;
			-- they should not perform remote calls on other objects
			-- since these may also be dead and reclaimed.
		do
		end

	free (object: ANY) is
			-- Free `object', by-passing garbage collection.
			-- Erratic behavior will result if the object is still
			-- referenced.
		do
			mem_free ($object)
		end

	mem_free (addr: POINTER) is
			-- Free memory of object at `addr'.
			-- (Preferred interface is `free'.)
		external
			"C | %"eif_memory.h%""
		end

	full_coalesce is
			-- Coalesce the whole memory: merge adjacent free
			-- blocks to reduce fragmentation. Useful, when
			-- a lot of memory is allocated with garbage collector off.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_coalesc"
		end

	collect is
			-- Force a partial collection cycle if garbage
			-- collection is enabled; do nothing otherwise.
		external
			"C | %"eif_eiffel.h%""
		end

	full_collect is
			-- Force a full collection cycle if garbage
			-- collection is enabled; do nothing otherwise.
		external
			"C | %"eif_garcol.h%""
		alias
			"plsc"
		end

feature {NONE} -- Implementation

	gc_monitoring (flag: BOOLEAN) is
			-- Set up GC monitoring according to `flag'
		external
			"C | %"eif_memory.h%""
		alias
			"gc_mon"
		end
	
	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER) is
		external
			"C | %"eif_traverse.h%""
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

end -- class MEMORY




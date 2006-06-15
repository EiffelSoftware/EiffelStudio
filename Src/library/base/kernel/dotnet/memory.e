indexing

	description: "[
		Facilities for tuning up the garbage collection mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	MEMORY

inherit
	DISPOSABLE

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

	memory_threshold: INTEGER is
			-- Minimum amount of bytes to be allocated before
			-- starting an automatic garbage collection.
		do
			check
				False
			end
		end

	collection_period: INTEGER is
			-- Period of full collection.
			-- If the environment variable EIF_FULL_COLLECTION_PERIOD   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
			-- If null, no full collection is launched.
		do
			check
				False
			end
		end

	coalesce_period: INTEGER is
			-- Period of full coalesce (in number of collections)
			-- If the environment variable EIF_FULL_COALESCE_PERIOD   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
			-- If null, no full coalescing is launched.
		do
			check
				False
			end
		end
			
	collecting: BOOLEAN is
			-- Is garbage collection enabled?
		do
			Result := True
		end

	largest_coalesced_block: INTEGER is
			-- Size of largest coalesced block since last call to
			-- `largest_coalesced'; 0 if none.
		do
			check
				False
			end
		end

	max_mem: INTEGER is
			-- Maximum amount of bytes the run-time can allocate.
		do
			check
				False
			end
		end

	chunk_size: INTEGER is
			-- Minimal size of a memory chunk. The run-time always
			-- allocates a multiple of this size.
			-- If the environment variable EIF_MEMORY_CHUNK   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
		do
			check
				False
			end
		end

	tenure: INTEGER is
			-- Maximum age of object before being considered
			-- as old (old objects are not scanned during 
			-- partial collection).
			-- If the environment variable EIF_TENURE_MAX   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
		do
			check
				False
			end
		end
			
	generation_object_limit: INTEGER is
			-- Maximum size of object in generational scavenge zone.
			-- If the environment variable EIF_GS_LIMIT   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
		do
			check
				False
			end
		end
	
	scavenge_zone_size: INTEGER is
			-- Size of generational scavenge zone.
			-- If the environment variable EIF_MEMORY_SCAVENGE   
			-- is defined, it is set to the closest reasonable 
			-- value from it.
		do
			check
				False
			end
		end

feature -- Status report

	referers (an_object: ANY): SPECIAL [ANY] is
			-- Objects that refer to `an_object'.
		do
			check
				False
			end
		end
		
	objects_instance_of (an_object: ANY): SPECIAL [ANY] is
			-- Objects that have same dynamic type as `an_object'.
		do
			check
				False
			end
		end

	memory_map: HASH_TABLE [ARRAYED_LIST [ANY], INTEGER] is
			-- Retrieves all object in system as a table indexed by dynamic type
			-- where elements are all instances of a given data type.
		do
			check
				False
			end
		end

	memory_count_map: HASH_TABLE [INTEGER, INTEGER] is
			-- Number of instances per dynamic type present in system.
			-- Same as `memory_map' except that no references on the objects themselves
			-- is kept.
		do
			check
				False
			end
		end

feature -- Status setting

	collection_off is
			-- Disable garbage collection.
		do
		end

	collection_on is
			-- Enable garbage collection.
		do
		end

	allocate_fast is
			-- Enter ``speed'' mode: will optimize speed of memory
			-- allocation rather than memory usage.
		do
			check
				False
			end
		end

	allocate_compact is
			-- Enter ``memory'' mode: will try to compact memory
			-- before requesting more from the operating system.
		do
			check
				False
			end
		end

	allocate_tiny is
			-- Enter ``tiny'' mode: will enter ``memory'' mode
			-- after having freed as much memory as possible.
		do
			check
				False
			end
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
		do
			check
				False
			end
		end

	set_collection_period (value: INTEGER) is
			-- Set `collection_period'. Every `value' collection,
			-- the Garbage collector will perform a collection
			-- on the whole memory (full collection), otherwise 
			-- a simple partial collection is done.
		require
			positive_value: value >= 0
		do
			check
				False
			end
		end

	set_coalesce_period (value: INTEGER) is
			-- Set `coalesce_period'. Every `value' collection,
			-- the Garbage Collector will coalesce
			-- the whole memory. 
		require
			positive_value: value >= 0
		do
			check
				False
			end
		end

	set_max_mem (value: INTEGER) is
			-- Set the maximum amount of memory the run-time can allocate.
		require
			positive_value: value > 0
		do
			check
				False
			end
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
			check
				False
			end
		end

	mem_free (addr: POINTER) is
			-- Free memory of object at `addr'.
			-- (Preferred interface is `free'.)
		do
			check
				False
			end
		end

	full_coalesce is
			-- Coalesce the whole memory: merge adjacent free
			-- blocks to reduce fragmentation. Useful, when
			-- a lot of memory is allocated with garbage collector off.
		do
			check
				False
			end
		end

	collect is
			-- Force a partial collection cycle if garbage
			-- collection is enabled; do nothing otherwise.
		do
			{GC}.collect (0)
		end

	full_collect is
			-- Force a full collection cycle if garbage
			-- collection is enabled; do nothing otherwise.
		do
			{GC}.collect
		end

feature {NONE} -- Implementation

	gc_monitoring (flag: BOOLEAN) is
			-- Set up GC monitoring according to `flag'
		do
			check
				False
			end
		end
	
	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER) is
		do
			check
				False
			end
		end

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



end -- class MEMORY




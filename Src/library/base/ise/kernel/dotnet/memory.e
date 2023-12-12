note

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

	memory_statistics (memory_type: INTEGER): MEM_INFO
			-- Memory usage information for `memory_type'
		require
			type_ok:
				memory_type = Total_memory or
				memory_type = Eiffel_memory or
				memory_type = C_memory
		do
			create Result.make (memory_type)
		end

	gc_statistics (collector_type: INTEGER): GC_INFO
			-- Garbage collection information for `collector_type'.
		require
			type_ok:
				collector_type = Full_collector or
				collector_type = Incremental_collector
		do
			create Result.make (collector_type)
		end

feature -- Status report

	memory_threshold: INTEGER
			-- Minimum amount of bytes to be allocated before
			-- starting an automatic garbage collection.
		do
		end

	collection_period: INTEGER
			-- Period of full collection.
			-- If the environment variable EIF_FULL_COLLECTION_PERIOD
			-- is defined, it is set to the closest reasonable
			-- value from it.
			-- If null, no full collection is launched.
		do
		end

	coalesce_period: INTEGER
			-- Period of full coalesce (in number of collections)
			-- If the environment variable EIF_FULL_COALESCE_PERIOD
			-- is defined, it is set to the closest reasonable
			-- value from it.
			-- If null, no full coalescing is launched.
		do
		end

	collecting: BOOLEAN
			-- Is garbage collection enabled?
		do
			Result := True
		end

	largest_coalesced_block: INTEGER
			-- Size of largest coalesced block since last call to
			-- `largest_coalesced'; 0 if none.
		do
		end

	max_mem: INTEGER
			-- Maximum amount of bytes the run-time can allocate.
		do
		end

	chunk_size: INTEGER
			-- Minimal size of a memory chunk. The run-time always
			-- allocates a multiple of this size.
			-- If the environment variable EIF_MEMORY_CHUNK
			-- is defined, it is set to the closest reasonable
			-- value from it.
		do
		end

	tenure: INTEGER
			-- Maximum age of object before being considered
			-- as old (old objects are not scanned during
			-- partial collection).
			-- If the environment variable EIF_TENURE_MAX
			-- is defined, it is set to the closest reasonable
			-- value from it.
		do
		end

	generation_object_limit: INTEGER
			-- Maximum size of object in generational scavenge zone.
			-- If the environment variable EIF_GS_LIMIT
			-- is defined, it is set to the closest reasonable
			-- value from it.
		do
		end

	scavenge_zone_size: INTEGER
			-- Size of generational scavenge zone.
			-- If the environment variable EIF_MEMORY_SCAVENGE
			-- is defined, it is set to the closest reasonable
			-- value from it.
		do
		end

feature -- Status report

	referers (an_object: ANY): SPECIAL [ANY]
			-- Objects that refer to `an_object'.
		do
			create Result.make_empty (0)
		end

	objects_instance_of (an_object: ANY): SPECIAL [ANY]
			-- Objects that have same dynamic type as `an_object'.
		do
			create Result.make_empty (0)
		end

	objects_instance_of_type (a_type_id: INTEGER): SPECIAL [ANY]
			-- Objects that have same dynamic type as `an_object'.
		do
			create Result.make_empty (0)
		end

	memory_map: HASH_TABLE [ARRAYED_LIST [ANY], INTEGER]
			-- Retrieves all object in system as a table indexed by dynamic type
			-- where elements are all instances of a given data type.
		do
			create Result.make (0)
		end

	memory_count_map: HASH_TABLE [INTEGER, INTEGER]
			-- Number of instances per dynamic type present in system.
			-- Same as `memory_map' except that no references on the objects themselves
			-- is kept.
		do
			create Result.make (0)
		end

feature -- Status setting

	execute_without_collection (a_action: PROCEDURE)
			-- Execute `a_action' with the garbage collector disabled.
			-- If `a_action' modifies the status of `collecting', we restore
			-- it no matter what at the end.
		require
			a_action_not_void: a_action /= Void
		local
			l_is_collecting: like collecting
			retried: BOOLEAN
		do
			if not retried then
				l_is_collecting := collecting
				if l_is_collecting then
					collection_off
					a_action.call (Void)
					collection_on
				else
					a_action.call (Void)
					collection_off
				end
			else
				if l_is_collecting then
					collection_on
				else
					collection_off
				end
			end
		ensure
			collection_status_preserved: collecting = old collecting
		rescue
			retried := True
			retry
		end

	collection_off
			-- Disable garbage collection.
		do
		end

	collection_on
			-- Enable garbage collection.
		do
		end

	allocate_fast
			-- Enter `speed' mode: will optimize speed of memory
			-- allocation rather than memory usage.
		do
		end

	allocate_compact
			-- Enter `memory' mode: will try to compact memory
			-- before requesting more from the operating system.
		do
		end

	allocate_tiny
			-- Enter `tiny' mode: will enter `memory' mode
			-- after having freed as much memory as possible.
		do
		end

	enable_time_accounting
			-- Enable GC time accouting, accessible in `gc_statistics'.
		do
			gc_monitoring (True)
		end

	disable_time_accounting
			-- Disable GC time accounting (default).
		do
			gc_monitoring (False)
		end

	set_memory_threshold (value: INTEGER)
			-- Set a new `memory_threshold' in bytes. Whenever the memory
			-- allocated for Eiffel reaches this value, an automatic
			-- collection is performed.
		require
			positive_value: value > 0
		do
		end

	set_collection_period (value: INTEGER)
			-- Set `collection_period'. Every `value' collection,
			-- the Garbage collector will perform a collection
			-- on the whole memory (full collection), otherwise
			-- a simple partial collection is done.
		require
			positive_value: value >= 0
		do
		end

	set_coalesce_period (value: INTEGER)
			-- Set `coalesce_period'. Every `value' collection,
			-- the Garbage Collector will coalesce
			-- the whole memory.
		require
			positive_value: value >= 0
		do
		end

	set_max_mem (value: INTEGER)
			-- Set the maximum amount of memory the run-time can allocate.
		require
			positive_value: value > 0
		do
		end

feature -- Removal

	dispose
			-- Action to be executed just before garbage collection
			-- reclaims an object.
			-- Default version does nothing; redefine in descendants
			-- to perform specific dispose actions. Those actions
			-- should only take care of freeing external resources;
			-- they should not perform remote calls on other objects
			-- since these may also be dead and reclaimed.
		do
		end

	free (object: ANY)
			-- Free `object', by-passing garbage collection.
			-- Erratic behavior will result if the object is still
			-- referenced.
		do
		end

	full_coalesce
			-- Coalesce the whole memory: merge adjacent free
			-- blocks to reduce fragmentation. Useful, when
			-- a lot of memory is allocated with garbage collector off.
		do
				-- Perform a collection for now.
			{GC}.collect (0)
		ensure
			class
		end

	collect
			-- Force a partial collection cycle if garbage
			-- collection is enabled; do nothing otherwise.
		do
			{GC}.collect (0)
		ensure
			class
		end

	full_collect
			-- Force a full collection cycle if garbage
			-- collection is enabled; do nothing otherwise.
		do
			{GC}.collect
		ensure
			class
		end

feature {NONE} -- Implementation

	gc_monitoring (flag: BOOLEAN)
			-- Set up GC monitoring according to `flag'
		do
		end

	find_referers (target: POINTER; esult: POINTER; result_size: INTEGER)
		do
		end

note
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




indexing

	description:
		"Facilities for tuning up the garbage collection mechanism. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
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
			!! Result.make (memory_type);
		end;

	gc_statistics (collector_type: INTEGER): GC_INFO is
			-- Garbage collection information for `collector_type'.
		require
			type_ok:
				collector_type = Full_collector or
				collector_type = Incremental_collector
		do
			!! Result.make (collector_type);
		end;

feature -- Status report

	memory_threshold: INTEGER is
			-- Minimum amount of bytes to be allocated before
			-- starting an automatic garbage collection.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_tget"
		end;

	collection_period: INTEGER is
			-- Period of full collection.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_pget"
		end;

	collecting: BOOLEAN is
			-- Is garbage collection enabled?
		external
			"C | %"eif_memory.h%""
		alias
			"gc_ison"
		end;

	largest_coalesced_block: INTEGER is
			-- Size of largest coalesced block since last call to
			-- `largest_coalesced'; 0 if none.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_largest"
		end;

	max_mem: INTEGER is
			-- Maximum amount of bytes the run-time can allocate.
		external
			"C | %"eif_memory.h%""
		alias
			"eif_get_max_mem"
		end;

	chunk_size: INTEGER is
			-- Minimal size of a memory chunk. The run-time always
			-- allocates a multiple of this size.
		external
			"C | %"eif_memory.h%""
		alias
			"eif_get_chunk_size"
		end;

feature -- Status setting

	collection_off is
			-- Disable garbage collection.
		external
			"C | %"eif_garcol.h%""
		alias
			"gc_stop"
		end;

	collection_on is
			-- Enable garbage collection.
		external
			"C | %"eif_garcol.h%""
		alias
			"gc_run"
		end;

	allocate_fast is
			-- Enter ``speed'' mode: will optimize speed of memory
			-- allocation rather than memory usage.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_speed"
		end;

	allocate_compact is
			-- Enter ``memory'' mode: will try to compact memory
			-- before requesting more from the operating system.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_slow"
		end;

	allocate_tiny is
			-- Enter ``tiny'' mode: will enter ``memory'' mode
			-- after having freed as much memory as possible.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_tiny"
		end;

	enable_time_accounting is
			-- Enable GC time accouting, accessible in `gc_statistics'.
		do
			gc_monitoring (true);
		end;

	disable_time_accounting is
			-- Disable GC time accounting (default).
		do
			gc_monitoring (false);
		end;

	set_memory_threshold (value: INTEGER) is
			-- Set a new `memory_threshold' in bytes. Whenever the memory 
			-- allocated for Eiffel reaches this value, an automatic
			-- collection is performed.
		require
			positive_value: value > 0;
		external
			"C | %"eif_memory.h%""
		alias
			"mem_tset"
		end;

	set_collection_period (value: INTEGER) is
			-- Set `collection_period'. Every `value' collection,
			-- the Garbage collector will performed a collection
			-- on the whole memory, otherwise a simple partial
			-- collction is done.
			
		require
			positive_value: value > 0;
		external
			"C | %"eif_memory.h%""
		alias
			"mem_pset"
		end;

	set_max_mem (value: INTEGER) is
			-- Set the maximum amount of memory the run-time can allocate.
		require
			positive_value: value > 0;
		external
			"C | %"eif_memory.h%""
		alias
			"eif_set_max_mem"
		end;

	set_chunk_size (value: INTEGER) is
			-- Set the minimal size of a memory chunk. 
			-- A chunk is an Eiffel memory unit.
		require
			positive_value: value > 0;
		external
			"C | <memory.h>"
		alias
			"eif_set_chunk_size"
		end;

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
		end;

	free (object: ANY) is
			-- Free `object', by-passing garbage collection.
			-- Erratic behavior will result if the object is still
			-- referenced.
		do
			mem_free ($object)
		end;

	mem_free (addr: POINTER) is
			-- Free memory of object at `addr'.
			-- (Preferred interface is `free'.)
		external
			"C | %"eif_memory.h%""
		end;

	full_coalesce is
			-- Coalesce the whole memory: merge adjacent free
			-- blocks to reduce fragmentation.
		external
			"C | %"eif_memory.h%""
		alias
			"mem_coalesc"
		end;

	collect is
			-- Force a partial collection cycle if garbage
			-- collection is enabled; do nothing otherwise.
		external
			"C | %"eif_eiffel.h%""
		end;

	full_collect is
			-- Force a full collection cycle if garbage
			-- collection is enabled; do nothing otherwise.
		external
			"C | %"eif_garcol.h%""
		alias
			"plsc"
		end;

feature {NONE} -- Implementation

	gc_monitoring (flag: BOOLEAN) is
			-- Set up GC monitoring according to `flag'
		external
			"C | %"eif_memory.h%""
		alias
			"gc_mon"
		end;

end -- class MEMORY


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------


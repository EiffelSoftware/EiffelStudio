--|---------------------------------------------------------------
--|   Copyright (C) Interactive Software Engineering, Inc.	--
--|	270 Storke Road, Suite 7 Goleta, California 93117	--
--|				   (805) 685-1006		--
--| All rights reserved. Duplication or distribution prohibited --
--|---------------------------------------------------------------

-- Memory management control

indexing

	date: "$Date$";
	revision: "$Revision$"

class MEMORY

inherit

	MEM_CONST

feature

	collect is
			-- Force a partial collection cycle if the garbage collector is
			-- enabled; do nothing otherwise.
		external
			"C"
		end;
	
	full_collect is
			-- Force a full collection cycle if the garbage collector is
			-- enabled; do nothing otherwise.
		external
			"C"
		alias
			"plsc"
		end;
	
	collection_off is
			-- Disable the garbage collector.
		external
			"C"
		alias
			"gc_stop"
		end;
	
	collection_on is
			-- Enable the garbage collector.
		external
			"C"
		alias
			"gc_run"
		end;

	collecting: BOOLEAN is
			-- Is the garbage collector running?
		external
			"C"
		alias
			"gc_ison"
		end;

	memory_statistics (memory_type: INTEGER): MEM_INFO is
			-- Memory usage information for `memory_type'
			-- (`memory_type' is one of the memory types defined in class
			-- MEM_CONST)
		require
			type_ok:
				memory_type = Total_memory or
				memory_type = Eiffel_memory or 
				memory_type = C_memory
		do
			!! Result.make (memory_type);
		end;

	gc_statistics (collector_type: INTEGER): GC_INFO is
			-- Garbage collector information for `collector_type'.
			-- (`collector_type' is one of the collector types defined in
			-- class MEM_CONST)
		do
			!! Result.make (collector_type);
		end;

	allocate_fast is
			-- Enter speed mode: Optimize memory allocation speed at the
			-- expense of memory usage
		external
			"C"
		alias
			"mem_speed"
		end;
	
	allocate_compact is
			-- Enter slow mode: Try to compact memory before requesting for
			-- more from the operating system.
		external
			"C"
		alias
			"mem_slow"
		end;
	
	allocate_tiny is
			-- Enter tiny mode: Enter slow mode after having freed as much
			-- memory as possible.
		external
			"C"
		alias
			"mem_tiny"
		end;

	full_coalesce is
			-- Coalesce the whole memory, merge adjacent free blocks
			-- together so as to reduce fragmentation.
		external
			"C"
		alias
			"mem_coalesc"
		end;

	largest_coalesced_block: INTEGER is
			-- Size of largest coalesced block since last call to
			-- `largest_coalesced'; 0 if none
		external
			"C"
		alias
			"mem_largest"
		end;

	memory_threshold: INTEGER is
			-- Minimum amount of bytes to be allocated before an
			-- automatic garbage collection is raised.
		external
			"C"
		alias
			"mem_tget"
		end;

	set_memory_threshold (value: INTEGER) is
			-- Set a new `memory_threshold'.
		require
			positive_value: value > 0;
		external
			"C"
		alias
			"mem_tset"
		end;

	collection_period: INTEGER is
			-- Period of full collection.
		external
			"C"
		alias
			"mem_pget"
		end;

	set_collection_period (value: INTEGER) is
			-- Set `collection_period'.
		require
			positive_value: value > 0;
		external
			"C"
		alias
			"mem_pset"
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

	dispose is
			-- Called when the garbage collector reclaims the object.
			-- This is only intended to enable cleaning of external resources.
			-- The object should not do remote calls on other objects since
			-- those may also be dead and have already been reclaimed. Once the
			-- final instruction of dispose has been reached, the object is
			-- freed.
		do
		end

feature {NONE}

	gc_monitoring (flag: BOOLEAN) is
			-- Set up GC monitoring according to `flag'
		external
			"C"
		alias
			"gc_mon"
		end;

end

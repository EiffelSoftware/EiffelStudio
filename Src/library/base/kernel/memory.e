indexing

	description:
		"Facilities for tuning up the garbage collection mechanism. %
		%This class may be used as ancestor by classes needing its facilities.";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class MEMORY inherit

	MEM_CONST

feature -- Measurement

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

feature -- Status report

	memory_threshold: INTEGER is
			-- Minimum amount of bytes to be allocated before an
			-- automatic garbage collection is raised.
		external
			"C"
		alias
			"mem_tget"
		end;

	collection_period: INTEGER is
			-- Period of full collection.
		external
			"C"
		alias
			"mem_pget"
		end;	

	collecting: BOOLEAN is
			-- Is the garbage collector running?
		external
			"C"
		alias
			"gc_ison"
		end;

	largest_coalesced_block: INTEGER is
			-- Size of largest coalesced block since last call to
			-- `largest_coalesced'; 0 if none
		external
			"C"
		alias
			"mem_largest"
		end;

feature -- Status setting

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
			-- Set a new `memory_threshold'.
		require
			positive_value: value > 0;
		external
			"C"
		alias
			"mem_tset"
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


feature -- Removal

	dispose is
			-- Action to be executed just before the garbage collector
			-- reclaims an object.
			-- Default version does nothing; redefine in descendants
			-- to perform specific dispose actions. 
			-- Those actions should only take care of cleaning external resources.
			-- They should not perform remote calls on other objects since
			-- these may also be dead and have already been reclaimed.
		do
		end;

	free (object: ANY) is
			-- Free `object', by-passing the garbage collector.
			-- Erratic behavior will result if the object is still
			-- referenced.
		do
			mem_free ($object)
		end;

	mem_free (addr: ANY) is
			-- Free memory of object at `addr'.
			-- (Preferred interface is `free'.)
		external
			"C"
		end;

	full_coalesce is
			-- Coalesce the whole memory, merge adjacent free blocks
			-- together so as to reduce fragmentation.
		external
			"C"
		alias
			"mem_coalesc"
		end;

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

	
feature {NONE} -- Implementation

	gc_monitoring (flag: BOOLEAN) is
			-- Set up GC monitoring according to `flag'
		external
			"C"
		alias
			"gc_mon"
		end;

end -- class MEMORY


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

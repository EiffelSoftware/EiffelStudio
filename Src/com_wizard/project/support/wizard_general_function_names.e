indexing
	description: "Feature names of class GENERAL and MEMORY"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_GENERAL_FUNCTION_NAMES

feature -- Access

	generated_type_routine: STRING is "generating_type"

	generator_routine: STRING is "generator"

	deep_equal_routine: STRING is "deep_equal"

	equal_routine: STRING is "equal"

	is_equal_routine: STRING is "is_equal"

	standard_equal_routine: STRING is "standard_equal"

	standard_is_equal_routine: STRING is "standard_is_equal"

	conforms_to_routine: STRING is "conforms_to"

	same_type_routine: STRING is "same_type"

	clone_routine: STRING is "clone"

	copy_routine: STRING is "copy"

	deep_clone_routine: STRING is "deep_clone"

	deep_copy_routine: STRING is "deep_copy"

	standard_clone_routine: STRING is "standard_clone"

	standard_copy_routine: STRING is "standard_copy"

	default_routine: STRING is "default"

	default_create_routine: STRING is " default_create"

	default_pointer_routine:STRING is "default_pointer"

	default_rescue_routine: STRING is "default_rescue"

	do_nothing_routine: STRING is "do_nothing"

	io_routine: STRING is "io"

	out_routine: STRING is "out"

	print_routine: STRING is "print"

	tagged_out_routine: STRING is "tagged_out"

	allocate_compact_routine: STRING is "allocate_compact"

	allocate_fast_routine: STRING is "allocate_fast"

	allocate_tiny_routine: STRING is "allocate_tiny"

	chunk_size_routine: STRING is "chunk_size"

	coalesce_period_routine: STRING is "coalesce_period"

	collect_routine: STRING is "collect"

	collecting_routine: STRING is "collecting"

	collection_off_routine: STRING is "collection_off"

	collection_on_routine: STRING is "collection_on"

	collection_period_routine: STRING is "collection_period"

	disable_time_accounting_routine: STRING is "disable_time_accounting"

	dispose_routine: STRING is "dispose"

	enable_time_accounting_routine: STRING is "enable_time_accounting"

	free_routine: STRING is "free"

	full_coalesce_routine: STRING is "full_coalesce"

	full_collect_routine: STRING is "full_collect"

	gc_monitoring_routine: STRING is "gc_monitoring"

	gc_statistics_routine: STRING is "gc_statistics"

	generation_object_limit_routine: STRING is "generation_object_limit"

	largest_coalesced_block_routine: STRING is "largest_coalesced_block"

	max_mem_routine: STRING is "max_mem"

	mem_free_routine: STRING is "mem_free"

	memory_statistics_routine: STRING is "memory_statistics"

	memory_threshold_routine: STRING is "memory_threshold"

	scavenge_zone_size_routine: STRING is "scavenge_zone_size"

	set_coalesce_period_routine: STRING is "set_coalesce_period"

	set_collection_period_routine: STRING is "set_collection_period"

	set_max_mem_routine: STRING is "set_max_mem"

	set_memory_threshold_routine: STRING is "set_memory_threshold"

	tenure_routine: STRING is "tenure"

	exists_routine: STRING is "exists"

end -- class WIZARD_GENERAL_FUNCTION_NAMES

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

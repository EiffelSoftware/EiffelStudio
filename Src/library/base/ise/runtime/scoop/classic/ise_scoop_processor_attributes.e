note
	description: "Class defining SCOOP Processor attributes."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ISE_SCOOP_PROCESSOR_ATTRIBUTES

inherit
	MEMORY_STRUCTURE
		redefine
			default_create
		end

create {ISE_SCOOP_MANAGER}
	default_create

feature {NONE} -- Initialization

	default_create
			-- Set default values for SCOOP Processor Attributes.
		do
			make
			c_set_priority (item, default_priority)
			c_set_stack_size (item, 10)
		end

feature {NONE} -- Implementation

	default_priority: INTEGER
			-- Get default thread priority for the current architecture.
		external
			"C use %"eif_threads.h%""
		alias
			"eif_thr_default_priority"
		end

	c_set_priority (p: POINTER; v: like default_priority)
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
			#ifdef EIF_THREADS
				((EIF_THR_ATTR_TYPE *) $p)->priority = $v;
			#endif
			]"
		end

	c_set_stack_size (p: POINTER; v: INTEGER)
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
			#ifdef EIF_THREADS
				((EIF_THR_ATTR_TYPE *) $p)->stack_size = $v;
			#endif
			]"
		end

	structure_size: INTEGER
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"[
			#ifdef EIF_THREADS
				return sizeof(EIF_THR_ATTR_TYPE);
			#else
				return 1L;
			#endif
			]"

		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end



indexing

	description: "[
		Properties of the memory management mechanism.
		This class may be used as ancestor by classes needing its facilities.
		]"
	legal: "See notice at end of class."

	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class MEM_INFO

inherit
	MEMORY_STRUCTURE
		rename
			make as structure_make
		export
			{NONE} make_by_pointer, structure_make, item, shared
		end
	
	MEM_CONST

create
	make

feature -- Initialization

	make (memory: INTEGER) is
			-- Update Current for `memory' type.
		require
			memory_valid: memory = Total_memory or memory = Eiffel_memory or memory = C_memory
		do
			structure_make
			update (memory)
		ensure
			type_set: type = memory
		end

	update (memory: INTEGER) is
			-- Update Current for `memory' type.
		require
			memory_valid: memory = Total_memory or memory = Eiffel_memory or memory = C_memory
		do
			mem_stat (item, memory)
			type := memory
		ensure
			type_set: type = memory
		end

feature -- Access

	type: INTEGER
			-- Memory type (Total, Eiffel, C)

feature -- Measurement

	total: INTEGER is
			-- Total number of bytes allocated for `type'
			-- before last call to `update'
		do
			Result := c_ml_total (item)
		end

	used: INTEGER is
			-- Number of bytes used for `type'
			-- before last call to `update'
		do
			Result := c_ml_used (item)
		end

	free: INTEGER is
			-- Number of bytes still free for `type'
			-- before last call to `update'
		do
			Result := total - used - overhead
		ensure
			Computed: Result = total - used - overhead
		end

	overhead: INTEGER is
			-- Number of bytes used by memory management
			-- scheme for `type' before last call to `update'
		do
			Result := c_ml_over (item)
		end

	chunk: INTEGER is
			-- Number of allocated memory chunks
		do
			Result := c_ml_chunk (item)
		end

feature {NONE} -- Implementation

	mem_stat (a_ptr: POINTER; mem: INTEGER) is
			-- Initialize `a_ptr' used by MEM_INFO to retrieve the
			-- statistics frozen at the time of this call.
		external
			"C use %"eif_memory.h%""
		end

	structure_size: INTEGER is
			-- Size of underlying C structure.
		do
			Result := c_sizeof_emallinfo
		end
		
feature {NONE} -- C externals

	c_ml_total (a_ptr: POINTER): INTEGER is
			-- Access `ml_total' data member of `a_ptr' struct.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((struct emallinfo *) $a_ptr)->ml_total"
		end

	c_ml_used (a_ptr: POINTER): INTEGER is
			-- Access `ml_used' data member of `a_ptr' struct.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((struct emallinfo *) $a_ptr)->ml_used"
		end

	c_ml_over (a_ptr: POINTER): INTEGER is
			-- Access `ml_over' data member of `a_ptr' struct.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((struct emallinfo *) $a_ptr)->ml_over"
		end

	c_ml_chunk (a_ptr: POINTER): INTEGER is
			-- Access `ml_chunk' data member of `a_ptr' struct.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((struct emallinfo *) $a_ptr)->ml_chunk"
		end

	c_sizeof_emallinfo: INTEGER is
			-- Size of struct `emallinfo'.
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"sizeof(struct emallinfo)"
		end

invariant

	consistent_memory: total = free + used + overhead

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







end -- class MEM_INFO




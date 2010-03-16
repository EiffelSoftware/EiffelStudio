note

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

	make (memory: INTEGER)
			-- Update Current for `memory' type.
		require
			memory_valid: memory = Total_memory or memory = Eiffel_memory or memory = C_memory
		do
			structure_make
			update (memory)
		ensure
			type_set: type = memory
		end

	update (memory: INTEGER)
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

	total: INTEGER
			-- Total number of bytes allocated for `type'
			-- before last call to `update'
		do
			Result := c_ml_total (item)
		end

	used: INTEGER
			-- Number of bytes used for `type'
			-- before last call to `update'
		do
			Result := c_ml_used (item)
		end

	free: INTEGER
			-- Number of bytes still free for `type'
			-- before last call to `update'
		do
			Result := total - used - overhead
		ensure
			Computed: Result = total - used - overhead
		end

	overhead: INTEGER
			-- Number of bytes used by memory management
			-- scheme for `type' before last call to `update'
		do
			Result := c_ml_over (item)
		end

	chunk: INTEGER
			-- Number of allocated memory chunks
		do
			Result := c_ml_chunk (item)
		end

feature {NONE} -- Implementation

	mem_stat (a_ptr: POINTER; mem: INTEGER)
			-- Initialize `a_ptr' used by MEM_INFO to retrieve the
			-- statistics frozen at the time of this call.
		external
			"C use %"eif_memory.h%""
		alias
			"eif_mem_stat"
		end

	structure_size: INTEGER
			-- Size of underlying C structure.
		do
			Result := c_sizeof_emallinfo
		end

feature {NONE} -- C externals

	c_ml_total (a_ptr: POINTER): INTEGER
			-- Access `ml_total' data member of `a_ptr' struct.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((struct emallinfo *) $a_ptr)->ml_total"
		end

	c_ml_used (a_ptr: POINTER): INTEGER
			-- Access `ml_used' data member of `a_ptr' struct.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((struct emallinfo *) $a_ptr)->ml_used"
		end

	c_ml_over (a_ptr: POINTER): INTEGER
			-- Access `ml_over' data member of `a_ptr' struct.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((struct emallinfo *) $a_ptr)->ml_over"
		end

	c_ml_chunk (a_ptr: POINTER): INTEGER
			-- Access `ml_chunk' data member of `a_ptr' struct.
		external
			"C inline use %"eif_eiffel.h%""
		alias
			"((struct emallinfo *) $a_ptr)->ml_chunk"
		end

	c_sizeof_emallinfo: INTEGER
			-- Size of struct `emallinfo'.
		external
			"C macro use %"eif_eiffel.h%""
		alias
			"sizeof(struct emallinfo)"
		end

invariant

	consistent_memory: total = free + used + overhead

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







end -- class MEM_INFO




indexing

	description: "Externals for managing the object id stack (see identified.e)"
	legal: "See notice at end of class."
    status: "See notice at end of class."
    date: "$Date$"
    revision: "$Revision$"


class IDENTIFIED_CONTROLLER
 
feature -- Measurement
 
	object_id_stack_size: INTEGER is
			-- Size of the object_id stack in chunks
			--| a chunk contains 1000 elements
		external
			"C | %"eif_object_id.h%""
		alias
			"eif_object_id_stack_size"
		end

feature -- Status setting
 
	extend_object_id_stack (nb_chunks: INTEGER) is
			-- Extend the object_id stack by `nb_chunks' chunks.
			--| a chunk contains 1000 elements
		require
			positive_nb: nb_chunks > 0 
		external
			"C | %"eif_object_id.h%""
		alias
			"eif_extend_object_id_stack"
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







end -- class IDENTIFIED_CONTROLLER



indexing

	description: "Externals for managing the object id stack (see identified.e)"
    status: "See notice at end of class"
    date: "$Date$"
    revision: "$Revision$"


class IDENTIFIED_CONTROLLER
 
feature -- Measurement
 
	object_id_stack_size: INTEGER is
			-- Size of the object_id stack in chunks
			--| a chunk contains 1000 elements
		do
			Result := (create {IDENTIFIED}).reference_list.capacity // 1000 + 1
		end

feature -- Status setting
 
	extend_object_id_stack (nb_chunks: INTEGER) is
			-- Extend the object_id stack by `nb_chunks' chunks.
			--| a chunk contains 1000 elements
		require
			positive_nb: nb_chunks > 0
		local
			tmp: ARRAY [CLI_CELL [WEAK_REFERENCE]]
		do
			tmp := (create {IDENTIFIED}).reference_list
			tmp.grow (tmp.capacity + 1000 * nb_chunks)
		end

indexing

	library: "[
			EiffelBase: Library of reusable components for Eiffel.
			]"

	status: "[
			Copyright 1986-2001 Interactive Software Engineering (ISE).
			For ISE customers the original versions are an ISE product
			covered by the ISE Eiffel license and support agreements.
			]"

	license: "[
			EiffelBase may now be used by anyone as FREE SOFTWARE to
			develop any product, public-domain or commercial, without
			payment to ISE, under the terms of the ISE Free Eiffel Library
			License (IFELL) at http://eiffel.com/products/base/license.html.
			]"

	source: "[
			Interactive Software Engineering Inc.
			ISE Building
			360 Storke Road, Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Electronic mail <info@eiffel.com>
			Customer support http://support.eiffel.com
			]"

	info: "[
			For latest info see award-winning pages: http://eiffel.com
			]"

end -- class IDENTIFIED_CONTROLLER



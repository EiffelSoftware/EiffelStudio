indexing
	description: "Objects identified, uniquely during any session, by an integer"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class IDENTIFIED

inherit
	ANY
		redefine
			is_equal, copy
		end

	MEMORY
		export
			{NONE} all
		redefine
			dispose, is_equal, copy
		end

feature -- Access

	frozen object_id: INTEGER is
			-- Unique for current object in any given session
		do
			if internal_id = 0 then
				reference_list.extend (
					create {CLI_CELL [WEAK_REFERENCE]}.put (create {WEAK_REFERENCE}.make (Current)))
				internal_id := reference_list.count
			end
			Result := internal_id
		ensure
			valid_id: id_object (Result) = Current
		end

	frozen id_object (an_id: INTEGER): IDENTIFIED is
			-- Object associated with `an_id' (void if no such object)
		local
			wr: WEAK_REFERENCE
		do
			if reference_list.valid_index (an_id) then
				wr := reference_list.i_th (an_id).item
				if wr /= Void then
					Result ?= wr.get_target
				end
			end
		ensure
			consistent: Result = Void or else Result.object_id = an_id
		end

feature -- Status report

	frozen id_freed: BOOLEAN is
			-- Has `Current' been removed from the table?
		do
			Result := id_object (internal_id) = Void
		end

feature -- Removal

	frozen free_id is
			-- Free the entry associated with `object_id' if any
			--| the `object_id' is not reset because of uniqueness:
			--| another call shouldn't give a new id
		do
			if reference_list.valid_index (internal_id) then
				reference_list.put_i_th (Void, internal_id)
			end
		ensure
			object_freed: id_freed
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
			--| `object_id' is not taken into consideration
		local
			int_id: INTEGER
		do
			int_id := internal_id
			internal_id := other.internal_id
			Result := standard_is_equal (other)
			internal_id := int_id
		end

feature -- Duplication

	copy (other: like Current) is
			-- Update current object using fields of object attached
			-- to `other', so as to yield equal objects.
			--| `object_id' will return a different value for the two
			--| objects
		local
			int_id: INTEGER
		do
			int_id := internal_id
			standard_copy (other)
			internal_id := int_id
		end

feature {NONE} -- Removal

	dispose is
			-- Free the entry associated with `object_id' if any
			--| If `dispose' is redefined, the redefinition has to
			--| call `free_id'
		do
			free_id
		ensure then
			object_freed: id_freed
		end

feature {IDENTIFIED} -- Implementation

	internal_id: INTEGER
			-- Internal representation of `object_id'

feature {IDENTIFIED_CONTROLLER} -- Implementation

	reference_list: ARRAYED_LIST [CLI_CELL [WEAK_REFERENCE]] is
			-- List of weak references used. Id's correspond to indices in this list.
		once
			create Result.make (50)
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

end -- class IDENTIFIED



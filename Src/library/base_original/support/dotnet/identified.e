indexing
	description: "Objects identified, uniquely during any session, by an integer"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class IDENTIFIED

inherit
	DISPOSABLE
		redefine
			is_equal, copy
		end

feature -- Access

	frozen object_id: INTEGER is
			-- Unique for current object in any given session
		do
			if internal_id = 0 then
				reference_list.extend (create {WEAK_REFERENCE}.make_from_target (Current))
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
				wr := reference_list.i_th (an_id)
				if wr /= Void then
					Result ?= wr.target
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

	reference_list: ARRAYED_LIST [WEAK_REFERENCE] is
			-- List of weak references used. Id's correspond to indices in this list.
		once
			create Result.make (50)
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



end -- class IDENTIFIED


